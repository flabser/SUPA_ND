var app = app || {};

app.oper_plans_work = {
    init: function() {
        this.dueDateTypeToggle();
    },

    actions: {},

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
        selectAssignees2: function() {
            var dlg = nb.dialog.show({
                title: 'selectDueDateLink',
                href: 'Provider?type=page&id=select-assignees',
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

        selectDueDateLink: function() {
            var dlg = nb.dialog.show({
                title: 'selectDueDateLink',
                href: 'Provider?type=page&id=suggestions-list',
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
            var dlg = nb.dialog.show({
                targetForm: el.form.name,
                fieldName: fieldName,
                dialogFilterListItem: '.tree-entry',
                title: el.title,
                maxHeight: 500,
                minHeight: 440,
                width: 500,
                href: 'Provider?type=view&id=bossandemppicklist-pl-wrk&page=1&fieldName=' + fieldName + '&isMulti=' + isMulti,
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
    var form = $('#frm');
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
        }
    });
};

app.oper_plans_work.actions.send = function(el) {
    app.oper_plans_work.actions.save(el, 'send');
};

app.oper_plans_work.actions.agree = function(el) {
    app.oper_plans_work.actions.save(el, 'agree');
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

                    app.oper_plans_work.actions.save(el, 'exclusion');
                }
            },
            'revision': {
                text: 'Отправка на доработку',
                click: function() {
                    nb.utils.notify({
                        message: 'action Отправка на доработку'
                    }).show().remove(2000);
                    dlg.dialog('close');

                    app.oper_plans_work.actions.save(el, 'revision');
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

    $('[data-action=send]').click(function() {
        app.oper_plans_work.actions.send(this);
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

    $('body').on('change', '[name=dueDateType]', function(e) {
        app.oper_plans_work.dueDateTypeToggle();
    });
});
