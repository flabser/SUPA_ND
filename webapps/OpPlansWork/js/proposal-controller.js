var app = app || {};

app.proposal = {
    init: function() {
        nbStrings.RUS.action_coord_start = 'Отправлено на согласование';
        nbStrings.RUS.action_coord_agree = 'Согласен';
        nbStrings.RUS.action_coord_revision = 'Возврат на доработку';
        nbStrings.RUS.action_coord_reject = 'На исключение';
    },

    actions: {
        save: function(el, action) {
            $('[name=_action]').val(action);
            var form = $('form[name=proposal]')[0];
            var data = $(form).serialize();

            nb.utils.blockUI();

            var noty = nb.utils.notify({
                message: nb.getText('action_' + action)
            }).show();

            return $.ajax({
                method: 'POST',
                datatype: 'html',
                url: 'Provider',
                data: data,
                success: function(result) {
                    nb.utils.unblockUI();
                    noty.remove(3000);
                    nb.utils.notify({
                        message: nb.getText('saved', 'Сохранен')
                    }).show(2000);
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
                dialogFilterListItem: 'li',
                title: el.title,
                href: 'Provider?type=view&id=dialog-structure&page=1&fieldName=' + fieldName + '&isMulti=' + isMulti,
                onLoad: function() {
                    if (isMulti === false) {
                        $('[type=checkbox][data-type=select]', dlg[0]).attr('type', 'radio');
                    }
                },
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
                            dlg[0].dialogOptions.onExecute();
                        }
                    }
                }
            });
        }
    }
};

$(function() {
    app.proposal.init();

    $('[data-action=save]').click(function() {
        app.proposal.actions.save(this);
    });

    $('[data-action=coord_start]').click(function() {
        var _this = this;
        var dlg = nb.dialog.show({
            title: _this.title,
            message: nb.getText('send_to_coordination', 'Отправить на согласование?'),
            buttons: {
                'cancel': {
                    text: nb.getText('cancel'),
                    click: function() {
                        dlg.dialog('close');
                    }
                },
                'reject': {
                    text: 'Отправить',
                    click: function() {
                        dlg.dialog('close');
                        app.proposal.actions.coordStart(_this);
                    }
                }
            }
        });
    });

    $('[data-action=coord_agree]').click(function() {
        app.proposal.actions.coordAgree(this);
    });

    $('[data-action=coord_revision]').click(function() {
        var _this = this;
        var html = '<h4>Отправить на доработку?</h4><div>Комментарий</div><textarea></textarea>';
        var dlg = nb.dialog.show({
            title: _this.title,
            message: html,
            buttons: {
                'cancel': {
                    text: nb.getText('cancel'),
                    click: function() {
                        dlg.dialog('close');
                    }
                },
                'revision': {
                    text: 'Отправить',
                    click: function() {
                        var comment = dlg.find('textarea').val();
                        if (comment) {
                            dlg.dialog('close');
                            var form = $('form[name=proposal]')[0];
                            form.coordination_comment.value = comment;
                            app.proposal.actions.coordRevision(_this);
                        }
                    }
                }
            }
        });
    });

    $('[data-action=coord_reject]').click(function() {
        app.proposal.actions.coordReject(this);
    });

    $('[data-action=select-assignees]').click(function() {
        app.proposal.actions.dialogSelectAssignees(this, 'assignee', false);
    });

    $('[data-action=due-date-link]').click(function() {
        app.proposal.actions.dialogSelectDueDateLink();
    });

    // load history
    var ddbid = $('[name=ddbid]').val();
    if (ddbid) {
        $('#history').load('Provider?type=page&id=proposal-events&proposal_id=' + ddbid);
    }
});
