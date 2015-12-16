window.app = window.app || {};

app.DueDate = function(params) {
    this.$el = params.el;
    this.$dueDateType = params.dueDateType;
    this.$dueDate = params.dueDate;
    this.$dueDatePlanId = params.dueDatePlanId;

    this.type = this.$dueDateType.value || 'month';

    var pv = [(new Date()).getFullYear(), (new Date()).getMonth()];
    if ((this.type !== 'plan-doc') && this.$dueDate.value) {
        pv = this.$dueDate.value.split('-');
    }

    this.year = +pv[0];
    this.part = +pv[1];
    this.monthCount = 1;

    var self = this;

    $('body').on('click', function() {
        $('.due-date.open').removeClass('open');
    });

    $(this.$el).on('click', function(e) {
        e.stopPropagation();
    });

    $('.due-date-text', this.$el).on('click', function() {
        $(self.$el).toggleClass('open');
    });

    $('.due-date-type', this.$el).on('change', function() {
        self.type = this.value;
        self.part = 1;
        self.render();
    });

    $('.btn-apply', this.$el).click(function() {
        self.apply();
    });

    $('.btn-cancel', this.$el).click(function() {
        self.cancel();
    });

    this.render();
    this.renderText();
};

app.DueDate.prototype.types = {
    'month': 12,
    'quarter': 4,
    'half-year': 2,
    'plan-doc': 0
};

app.DueDate.prototype.monthNames = ['январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь'];

app.DueDate.prototype.plusMonth = function() {
    this.monthCount++;
    this.render();
};

app.DueDate.prototype.minusMonth = function() {
    this.monthCount--;
    this.render();
};

app.DueDate.prototype.apply = function() {
    this.write();
    $(this.$el).toggleClass('open');
};

app.DueDate.prototype.cancel = function() {
    $(this.$el).toggleClass('open');
};

app.DueDate.prototype.write = function() {
    switch (this.type) {
        case 'month':
        case 'quarter':
        case 'half-year':
            this.$dueDate.value = this.year + '-' + this.part;
            break;
        case 'plan-doc':
            this.$dueDate.value = '';
            break;
    }

    this.$dueDateType.value = this.type;
    //
    this.renderText();
};

app.DueDate.prototype.renderText = function() {
    var dt = this.$el.querySelector('.due-date-text');
    switch (this.type) {
        case 'month':
            dt.innerHTML = this.type + ':' + this.year + '-' + this.monthNames[this.part - 1];
            break;
        case 'quarter':
            dt.innerHTML = this.part + ' квартал ' + this.year + 'г.';
            break;
        case 'half-year':
            dt.innerHTML = this.part + ' полугодие ' + this.year + 'г.';
            break;
        case 'plan-doc':
            dt.innerHTML = 'plan-doc';
            break;
    }
};

app.DueDate.prototype.render = function() {
    var self = this;
    var $duePart = this.$el.querySelector('.due-date-part');
    var $part = document.createDocumentFragment();

    switch (this.type) {
        case 'month':
            var $row;
            for (var m = 1; m <= this.monthCount; m++) {
                $row = document.createElement('li');
                var $input = document.createElement('input');
                $input.type = 'number';
                $input.min = (new Date()).getFullYear();
                $input.max = (new Date()).getFullYear() + 5;
                $input.value = this.year;
                $input.onblur = function() {
                    self.year = this.value;
                };
                $row.appendChild($input);
                //
                var $partSelect = document.createElement('select');
                for (var i = 1; i <= this.types[this.type]; i++) {
                    var op = document.createElement('option');
                    op.value = i;
                    op.textContent = i + ') ' + this.monthNames[i - 1];
                    $partSelect.appendChild(op);
                }
                $partSelect.onchange = function() {
                    self.part = this.value;
                };
                $partSelect.value = m;
                $row.appendChild($partSelect);
                $part.appendChild($row);
            }
            //
            $row = document.createElement('li');
            var plusMonthBtn = document.createElement('button');
            plusMonthBtn.className = 'btn btn-sm';
            plusMonthBtn.type = 'button';
            plusMonthBtn.innerHTML = '+';
            plusMonthBtn.onclick = function() {
                self.plusMonth();
            };
            $row.appendChild(plusMonthBtn);
            $part.appendChild($row);
            break;
        case 'quarter':
        case 'half-year':
            var $row = document.createElement('li');
            var $input = document.createElement('input');
            $input.type = 'number';
            $input.min = (new Date()).getFullYear();
            $input.max = (new Date()).getFullYear() + 5;
            $input.value = this.year;
            $input.onblur = function() {
                self.year = this.value;
            };
            $row.appendChild($input);
            //
            var $partSelect = document.createElement('select');
            for (var i = 1; i <= this.types[this.type]; i++) {
                var op = document.createElement('option');
                op.value = i;
                op.textContent = i;
                $partSelect.appendChild(op);
            }
            $partSelect.onchange = function() {
                self.part = this.value;
            };
            $partSelect.value = this.part;
            $row.appendChild($partSelect);
            $part.appendChild($row);
            break;
        case 'plan-doc':
            break;
    }

    this.$el.querySelector('.due-date-type').value = this.type;
    $duePart.innerHTML = '';
    $duePart.appendChild($part);
};
