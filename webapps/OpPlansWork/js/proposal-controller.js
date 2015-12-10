var app = app || {};

app.oper_plans_work = {
    init: function() {
        $('[name=_dueDateType]').val($('[name=dueDateType]').val());
        this.dueDateTypeToggle();
    },

    actions: {},

    dueDateTypeToggle: function() {
        var $dueDateType = $('[name=_dueDateType]');
        $('[name=dueDateType]').val($dueDateType.val());

        var selectData = {};
        var multi = false;
        switch ($dueDateType.val()) {
            case 'month':
                multi = true;
                selectData = {
                    '1': 'январь',
                    '2': 'февраль',
                    '3': 'март',
                    '4': 'апрель',
                    '5': 'май',
                    '6': 'июнь',
                    '7': 'июль',
                    '8': 'август',
                    '9': 'сентябрь',
                    '10': 'октябрь',
                    '11': 'ноябрь',
                    '12': 'декабрь',
                };
                break;
            case 'quarter':
                selectData = {
                    '1': '1',
                    '2': '2',
                    '3': '3',
                    '4': '4'
                };
                break;
            case 'half-year':
                selectData = {
                    '1': '1',
                    '2': '2'
                };
                break;
            case 'link':
                break;
        }

        var html = [];
        for (var key in selectData) {
            html.push('<option value=' + key + '>' + selectData[key] + '</option>');
        }
        if (html.length) {
            $('select[name=_dueDate]').html(html.join('')).attr('multiple', multi).show();
            $('[name=_dueDate]').val($('[name=dueDate]').val());
            $('.js-due-date-link').hide();
        } else {
            $('select[name=_dueDate]').hide();
            $('.js-due-date-link').show();
        }
    },

    dialog: {
        selectDueDateLink: function() {
            var dlg = nb.dialog.show({
                title: 'selectDueDateLink',
                href: 'Provider?type=page&id=proposals-list',
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
        },

        selectAssignees: function(el, fieldName, isMulti) {
            var form = $('form[name=proposal]');
            var dlg = nb.dialog.show({
                targetForm: form,
                fieldName: fieldName,
                dialogFilterListItem: '.tree-entry',
                title: el.title,
                maxHeight: 500,
                minHeight: 440,
                width: 500,
                href: 'Provider?type=view&id=dialog-structure&page=1&fieldName=' + fieldName + '&isMulti=' + isMulti,
                onLoad: function() {
                    if (isMulti === false) {
                        $('[type=checkbox][data-type=select]', dlg[0]).attr('type', 'radio');
                    }
                },
                buttons: {
                    'select': {
                        text: nb.getText('select'),
                        click: function() {
                            dlg[0].dialogOptions.onExecute();
                        }
                    },
                    'cancel': {
                        text: nb.getText('cancel'),
                        click: function() {
                            dlg.dialog('close');
                        }
                    }
                }
            });
        }
    }
};

app.oper_plans_work.actions.save = function(el, msg) {
    $('[name=_action]').val(msg);
    var form = $('form[name=proposal]')[0];
    var data = $(form).serialize();

    var noty = nb.utils.notify({
        message: 'action ' + msg
    }).show();

    return $.ajax({
        method: 'POST',
        datatype: 'html',
        url: 'Provider',
        data: data,
        success: function() {
            noty.remove(3000);
            nb.utils.notify({
                message: 'saved'
            }).show().remove(2000);
            $('[data-action=close]')[0].click();
        }
    });
};

app.oper_plans_work.actions.coordination = function(el) {
    app.oper_plans_work.actions.save(el, 'coordination');
};

app.oper_plans_work.actions.agree = function(el) {
    app.oper_plans_work.actions.save(el, 'coord_agree');
};

app.oper_plans_work.actions.exclusion = function(el) {
    app.oper_plans_work.actions.save(el, 'coord_reject');
};

app.oper_plans_work.actions.revision = function(el) {
    app.oper_plans_work.actions.save(el, 'coord_revision');
};

app.oper_plans_work.actions.reject = function(el) {
    var dlg = nb.dialog.show({
        title: el.title,
        message: '',
        buttons: {
            'exclusion': {
                text: 'Исключить',
                click: function() {
                    nb.utils.notify({
                        message: 'action Исключить'
                    }).show().remove(2000);
                    dlg.dialog('close');

                    app.oper_plans_work.actions.revision(el);
                }
            },
            'revision': {
                text: 'Отправка на доработку',
                click: function() {
                    nb.utils.notify({
                        message: 'action Отправка на доработку'
                    }).show().remove(2000);
                    dlg.dialog('close');

                    app.oper_plans_work.actions.revision(el);
                }
            },
            'cancel': {
                text: nb.getText('cancel'),
                click: function() {
                    dlg.dialog('close');
                }
            }
        }
    });
};

$(function() {
    app.oper_plans_work.init();

    $('[data-action=save]').click(function() {
        app.oper_plans_work.actions.save(this);
    });
    $('[data-action=coordination]').click(function() {
        app.oper_plans_work.actions.coordination(this);
    });
    $('[data-action=agree]').click(function() {
        app.oper_plans_work.actions.agree(this);
    });
    $('[data-action=reject]').click(function() {
        app.oper_plans_work.actions.reject(this);
    });

    $('[data-action=select-assignees]').click(function() {
        app.oper_plans_work.dialog.selectAssignees(this, 'assignee');
    });

    $('[data-action=due-date-link]').click(function() {
        app.oper_plans_work.dialog.selectDueDateLink();
    });

    $('body').on('change', '[name=_dueDateType]', function(e) {
        app.oper_plans_work.dueDateTypeToggle();
    });
    $('body').on('change', '[name=_dueDate]', function(e) {
        $('[name=dueDate]').val($('[name=_dueDate]').val());
    });
});
