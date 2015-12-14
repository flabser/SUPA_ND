var app = app || {};

app.plansWork = {
    init: function() {
        $('[name=_dueDateType]').val($('[name=dueDateType]').val());
        this.dueDateTypeToggle();
    },

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

    actions: {
        save: function(el, msg) {
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
                success: function(result) {
                    noty.remove(3000);
                    nb.utils.notify({
                        message: 'saved'
                    }).show().remove(2000);
                    // close
                    $('[data-action=close]')[0].click();
                    //
                    return result;
                }
            });
        },

        coordStart: function(el) {
            return this.save(el, 'coord_start');
        },

        coordAgree: function(el) {
            return this.save(el, 'coord_agree');
        },

        coordRevision: function(el) {
            return this.save(el, 'coord_revision');
        },

        coordReject: function(el) {
            return this.save(el, 'coord_reject');
        },

        dialogSelectDueDateLink: function() {
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

        dialogSelectAssignees: function(el, fieldName, isMulti) {
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

$(function() {
    app.plansWork.init();

    $('[data-action=save]').click(function() {
        app.plansWork.actions.save(this);
    });

    $('[data-action=coord_start]').click(function() {
        var _this = this;
        var dlg = nb.dialog.show({
            title: _this.title,
            message: nb.getText('send_to_coordination', 'Отправить на согласование?'),
            buttons: {
                'reject': {
                    text: 'Отправить',
                    click: function() {
                        dlg.dialog('close');
                        app.plansWork.actions.coordStart(_this);
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
    });

    $('[data-action=coord_agree]').click(function() {
        app.plansWork.actions.coordAgree(this);
    });

    $('[data-action=coord_revision]').click(function() {
        var _this = this;
        var html = '<h4>Отправить на доработку?</h4><div>Комментарий</div><textarea></textarea>';
        var dlg = nb.dialog.show({
            title: _this.title,
            message: html,
            buttons: {
                'revision': {
                    text: 'Отправить',
                    click: function() {
                        var comment = dlg.find('textarea').val();
                        if (comment) {
                            dlg.dialog('close');
                            var form = $('form[name=proposal]')[0];
                            form.coordination_comment.value = comment;
                            app.plansWork.actions.coordRevision(_this);
                        }
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
    });

    $('[data-action=coord_reject]').click(function() {
        app.plansWork.actions.coordReject(this);
    });

    $('[data-action=select-assignees]').click(function() {
        app.plansWork.actions.dialogSelectAssignees(this, 'assignee', false);
    });

    $('[data-action=due-date-link]').click(function() {
        app.plansWork.actions.dialogSelectDueDateLink();
    });

    $('body').on('change', '[name=_dueDateType]', function(e) {
        app.plansWork.dueDateTypeToggle();
    });
    $('body').on('change', '[name=_dueDate]', function(e) {
        $('[name=dueDate]').val($('[name=_dueDate]').val());
    });
});
