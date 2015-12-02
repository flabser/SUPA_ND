var app = app || {};

app.oper_plans_work = {
    init: function() {
        this.dueDateTypeToggle();
    },

    dueDateTypeToggle: function() {
        var $dueDateType = $('[name=dueDateType]');
        switch ($dueDateType.val()) {
            case 'month':
                $('[name=dueDateMonth]').show();
                $('[name=dueDateQuarter]').hide();
                $('[name=dueDateHalfYear]').hide();
                $('.due-date-link').hide();
                break;
            case 'quarter':
                $('[name=dueDateMonth]').hide();
                $('[name=dueDateQuarter]').show();
                $('[name=dueDateHalfYear]').hide();
                $('.due-date-link').hide();
                break;
            case 'half-year':
                $('[name=dueDateMonth]').hide();
                $('[name=dueDateQuarter]').hide();
                $('[name=dueDateHalfYear]').show();
                $('.due-date-link').hide();
                break;
            case 'link':
                $('[name=dueDateMonth]').hide();
                $('[name=dueDateQuarter]').hide();
                $('[name=dueDateHalfYear]').hide();
                $('.due-date-link').show();
                break;
        }
    },

    dialog: {
        selectDueDateLink: function() {
            var dlg = nb.dialog.show({
                title: 'selectDueDateLink',
                href: '',
                buttons: {
                    'cancel': {
                        text: nb.getText('cancel'),
                        click: function() {
                            dlg.dialog('close');
                        }
                    },
                    'select': {
                        text: nb.getText('select'),
                        click: function() {

                        }
                    }
                }
            });
        }
    }
};

$(function() {
    app.oper_plans_work.init();

    $('[data-action=due-date-link]').click(function() {
        app.oper_plans_work.dialog.selectDueDateLink();
    });

    $('body').on('change', '[name=dueDateType]', function(e) {
        app.oper_plans_work.dueDateTypeToggle();
    });
});
