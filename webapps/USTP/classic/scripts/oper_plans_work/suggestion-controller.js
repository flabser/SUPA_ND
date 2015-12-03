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

app.oper_plans_work.actions.send = function() {
    nb.utils.notify({
        message: 'action send'
    }).show().remove(3000);
};

$(function() {
    app.oper_plans_work.init();

    $('[data-action=send]').click(function() {
        app.oper_plans_work.actions.send();
    });

    $('[data-action=select-assignees]').click(function() {
        app.oper_plans_work.dialog.selectAssignees(this, 'assignees');
    });

    $('[data-action=due-date-link]').click(function() {
        app.oper_plans_work.dialog.selectDueDateLink();
    });

    $('body').on('change', '[name=dueDateType]', function(e) {
        app.oper_plans_work.dueDateTypeToggle();
    });
});
