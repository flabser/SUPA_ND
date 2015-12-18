/**
 * @author Medet
 */

'use strict';

var nb = {
    APP_NAME: location.hostname,
    LANG_ID: 'RUS',
    debug: true,
    strings: {
        'yes': 'Да',
        'no': 'Нет',
        ok: 'Ok',
        cancel: 'Отмена',
        select: 'Выбрать',
        dialog_select_value: 'Вы не сделали выбор'
    },
    form: {},
    dialog: {},
    utils: {},
    xhr: {}
};

var nbApp = { /* local application namespace */ };

/**
 * ajax
 */
nb.ajax = function(options) {

    var deferred = $.ajax(options);

    // error
    deferred.error(function(xhr) {
        console.error('nb.ajax : error', xhr);

        if (xhr.status == 400) {
            nb.dialog.error({
                title: nb.getText('error_xhr', 'Ошибка запроса'),
                message: xhr.responseText
            });
        }

        return xhr;
    });

    return deferred;
};

/**
 * getText
 */
nb.getText = function(stringKey, defaultText, langId) {
    if (nbStrings[langId || this.LANG_ID][stringKey]) {
        return nbStrings[langId || this.LANG_ID][stringKey];
    } else {
        return (defaultText !== undefined) ? defaultText : stringKey;
    }
};

/**
 * openXML
 */
nb.openXML = function() {
    window.location.href = window.location + '&onlyxml';
};

/**
 * setValues
 */
nb.form.setValues = function(currentNode) {

    var $dlgw = $(currentNode).parents('[role=dialog]');
    var $dlgWgt = $('[data-role=nb-dialog]', $dlgw);

    var form = nb.utils.getForm($dlgWgt[0].dialogOptions.targetForm);
    var fieldName = $dlgWgt[0].dialogOptions.fieldName;

    var nodeList; // коллекция выбранных
    var isMulti = false;
    var itemSeparate = '';
    var displaySeparate = '<br/>'; // отобразить мульти значения разделителем

    if (!form) {
        nb.dialog.warn({
            title: 'Error',
            message: 'Error nb.form.setValues > form is not found: ' + form
        });
        return false;
    }

    nodeList = $('[data-type=select]:checked', $dlgWgt[0]);
    if (nodeList.length > 0) {
        isMulti = nodeList.length > 1;
        if (!isMulti) {
            itemSeparate = '';
        }

        return _writeValues(nodeList);
    } else {
        if ($dlgWgt[0].dialogOptions.effect) {
            $dlgw.stop();
            $dlgw.effect($dlgWgt[0].dialogOptions.effect, {
                times: 2
            }, 300);
        }

        if ($('.js-no-selected-value', $dlgw[0]).length === 0) {
            (function() {
                var $_html = $('<div class="alert alert-danger js-no-selected-value" style="border-radius:2px;bottom:80px;left:4%;right:4%;position:absolute;">' + $dlgWgt[0].dialogOptions.errorMessage + '</div>');
                $dlgWgt.after($_html);
                setTimeout(function() {
                    $_html.fadeOut({
                        always: function() {
                            $_html.remove();
                        }
                    });
                }, 800);
            })();
        }

        return false;
    }

    // write values to form
    function _writeValues() {
        if (isMulti) {
            $('[name=' + fieldName + ']', form).remove();
            var htm = [];
            nodeList.each(function(index, node) {
                $('<input type="hidden" name="' + fieldName + '" value="' + node.value + '" />').appendTo(form);
                htm.push('<li>' + $(node).data('text') + '</li>');
            });
            $('[data-input=' + fieldName + ']').html(htm.join(''));
        } else {
            var $fieldNode = $('[name=' + fieldName + ']', form);
            if ($fieldNode.length === 0) {
                $fieldNode = $('<input type="hidden" name="' + fieldName + '" />');
                $(form).append($fieldNode[0]);
            }

            $fieldNode.val(nodeList[0].value);
            $('[data-input=' + fieldName + ']').html('<li>' + nodeList.attr('data-text') + '</li>');
        }

        return true;
    }
};

/**
 * clearField
 */
nb.utils.clearField = function(fieldName, context) {
    $('[name=' + fieldName + ']').val('');
    $('[data-input=' + fieldName + ']').html('');
};

/**
 * getForm
 */
nb.utils.getForm = function(el) {
    if (el === null || el === undefined) {
        return el;
    }

    if (typeof(el) === 'string' && (document[el] && document[el].nodeName === 'FORM')) {
        return document[el];
    }

    return el.form || el;
};

/**
 * blockUI
 */
nb.utils.blockUI = function() {
    var $el = $('#nb-block-ui');
    if ($el.length === 0) {
        $el = $('<div id="nb-block-ui" style="background:rgba(0,0,0,0.1);position:fixed;top:0;left:0;bottom:0;right:0;z-index:999;"/>');
        $el.appendTo('body');
    }

    $el.css('display', 'block');
};

/**
 * unblockUI
 */
nb.utils.unblockUI = function() {
    $('#nb-block-ui').css('display', 'none');
};

/**
 * notify
 */
nb.utils.notify = function(opt) {

    var $nwrap = $('#nb-notify-wrapper');
    if (!$nwrap.length) {
        $nwrap = $('<div id=nb-notify-wrapper class=nb-notify></div>').appendTo('body');
    }
    var $el = $('<div class=nb-notify-entry-' + (opt.type || 'info') + '>' + opt.message + '</div>').appendTo($nwrap);

    return {
        show: function(timeout) {
            $el.css('display', 'block');
            if (timeout && timeout > 0) {
                this.remove(timeout);
                return;
            }
            return this;
        },
        hide: function() {
            $el.css('display', 'none');
            return this;
        },
        set: function(opt) {
            for (var key in opt) {
                if (key === 'text') {
                    $el.text(opt[key]);
                } else if (key === 'type') {
                    $el.attr('class', 'nb-notify-entry-' + opt[key]);
                }
            }
            return this;
        },
        remove: function(timeout, callback) {
            if ($el === null) {
                return;
            }

            if (timeout && timeout > 0) {
                var _this = this;
                setTimeout(function() {
                    $el.remove();
                    $el = null;
                    callback && callback();
                }, timeout);
            } else {
                $el.remove();
                $el = null;
                callback && callback();
            }
        }
    };
};

$(document).ready(function() {
    nb.LANG_ID = $.cookie('lang') || 'RUS';

    $(':checkbox').bind('click', function() {
        var $checkbox = $(this);

        if (!$checkbox.data('toggle')) {
            return true;
        }

        var name = this.name || $checkbox.data('toggle');
        var $el = $('[name=' + name + ']:checkbox:visible');

        if ($checkbox.is(':checked')) {
            $el.each(function() {
                this.checked = true;
            });
        } else {
            $el.each(function() {
                this.checked = false;
            });
        }
    });
});

/**
 * dialog
 */
nb.dialog = {
    _props: {
        title: nb.APP_NAME
    },
    info: function(opt) {
        opt.className = 'dialog-info';
        opt.width = opt.width || '360';
        opt.height = opt.height || '210';
        opt.buttons = opt.buttons || {
            'Ok': function() {
                $(this).dialog('close');
            }
        };

        return this.show(opt);
    },
    warn: function(opt) {
        opt.className = 'dialog-warn';
        opt.width = opt.width || '360';
        opt.height = opt.height || '210';
        opt.buttons = opt.buttons || {
            'Ok': function() {
                $(this).dialog('close');
            }
        };

        return this.show(opt);
    },
    error: function(opt) {
        opt.className = 'dialog-error';
        opt.width = opt.width || '360';
        opt.height = opt.height || '210';
        opt.buttons = opt.buttons || {
            'Ok': function() {
                $(this).dialog('close');
            }
        };

        return this.show(opt);
    },
    execute: function(dlgInnerNode) {
        var $dlgw = $(dlgInnerNode).parents('[role=dialog]');
        var $dlgWgt = $('[data-role=nb-dialog]', $dlgw);

        $dlgWgt[0].dialogOptions.onExecute(arguments);
    },
    show: function(options) {
        var $dialog;

        options.id = options.id || null;
        options.title = options.title || this._props.title;
        options.href = options.href || null;
        options.className = options.className || '';
        options.message = options.message || null;
        options.filter = options.filter;
        options.dialogFilterListItem = options.dialogFilterListItem || 'li';
        options.buttons = options.buttons || null;
        options.dialogClass = 'nb-dialog ' + (options.dialogClass ? options.dialogClass : '');
        options.errorMessage = options.errorMessage || nb.strings.dialog_select_value;

        options.onLoad = options.onLoad || null;
        options.onExecute = options.onExecute || function() {
            if (nb.form.setValues($dialog, null)) {
                $dialog.dialog('close');
            }
        };

        options.autoOpen = true;
        if (options.modal === false) {
            options.modal = false;
        } else {
            options.modal = true;
        }
        options.width = options.width || '360';
        // options.height = options.height || '420';
        options.position = options.position || 'center';
        options.resizable = options.resizable || false;
        options.draggable = options.draggable || false;

        if (options.id === null && options.href) {
            options.id = 'dlg_' + options.href.replace(/[^a-z0-9]/gi, '');

            $dialog = $('#' + options.id);
            if ($dialog[0]) {
                if ($dialog.dialog('isOpen') === true) {
                    return;
                } else {
                    $dialog.dialog('open');
                    return;
                }
            }
        } else if (options.id !== null) {
            $dialog = $('#' + options.id);
            if ($dialog[0]) {
                if ($dialog.dialog('isOpen') === true) {
                    return;
                } else {
                    $dialog.dialog('open');
                    return;
                }
            }
        }

        if (options.id === null) {
            options.close = options.close || function() {
                $dialog.dialog('destroy');
                $dialog.remove();
            };
        }

        var $dlgContainer;

        if (options.href) {
            $dlgContainer = $('<div data-role="nb-dialog" id="' + options.id + '" class="nb-dialog-container ' + options.className + '"><div class="loading-state"></div></div>');
        } else {
            if (options.id) {
                $dlgContainer = $('<div data-role="nb-dialog" id="' + options.id + '" class="nb-dialog-container ' + options.className + '">' + options.message + '</div>');
            } else {
                $dlgContainer = $('<div data-role="nb-dialog" class="nb-dialog-container ' + options.className + '">' + options.message + '</div>');
            }
        }

        if (options.href) {
            $dialog = $dlgContainer.load(options.href, '', function(response, status, xhr) {
                if (status === 'error') {
                    $dlgContainer.html('<div class="alert alert-danger">' + status + '</div>');

                    if (nb.debug === true) {
                        console.log('nb.dialog : load callback', xhr);
                    }
                } else {
                    try {
                        if (options.onLoad !== null) {
                            options.onLoad(response, status, xhr);
                        }
                    } catch (e) {
                        console.log('nb.dialog', e);
                    }

                    try {
                        if (options.filter !== false) {
                            new nb.dialog.Filter($dlgContainer, options.dialogFilterListItem, 13);
                        }
                    } catch (e) {
                        console.log('nb.dialog', e);
                    }
                }
            }).dialog(options);

            $dialog.on('click', 'a', function(e) {
                e.preventDefault();
                $dlgContainer.load(this.href);
            });

            $dialog.on('change', 'select', function(e) {
                e.preventDefault();
                $dlgContainer.load(this.href);
            });
        } else {
            $dialog = $dlgContainer.dialog(options);
        }

        $dialog[0].dialogOptions = options;

        if (nb.debug === true) {
            console.log('nb.dialog: ', options);
        }

        return $dialog;
    }
};

/**
 * nb.dialog.Filter
 */
nb.dialog.Filter = function(_containerNode, _filterNode, _initCount, _triggerLen) {

    var $inputEl = null;
    var initCount = _initCount || 13;
    var triggerLen = _triggerLen || 2;
    var timeout = 300;
    var to = null;
    var enabledViewSearch = false;
    var filterNode = _filterNode || '.item';
    var $containerNode = _containerNode;
    var $dlgw = $containerNode.parents('[role=dialog]');
    var $collection;

    init();

    function init() {
        $collection = $(filterNode, $containerNode[0]);

        var isHierarchical = $('.toggle-response', $containerNode[0]).length > 0;
        if ($collection.length < initCount) {
            if (!isHierarchical) {
                return;
            }
        }

        if ($('.dialog-filter', $dlgw).length === 0) {
            $containerNode.before('<div class=dialog-filter></div>');
        }

        $('.dialog-filter', $dlgw).append('<input type=text name=keyword data-role=search placeholder="' + nb.getText('filter', 'Фильтр') + '" />');

        $inputEl = $('.dialog-filter input[data-role=search]', $dlgw);
        $inputEl.on('keyup', function(e) {
            try {
                clearTimeout(to);
                if (e.keyCode === 13) {
                    return;
                }
            } catch (ex) {
                console.log(ex);
            }

            to = setTimeout(function() {
                $collection = $(filterNode, $containerNode[0]);
                filter(e.target.value);
            }, timeout);
        });
    }

    function filter(value) {
        try {
            if (value.length >= triggerLen) {
                var hiddenCount = 0;
                var re = new RegExp(value, 'gim');
                $collection.attr('style', '');

                $collection.each(function(index, node) {
                    if (!re.test(node.textContent) && node.textContent.indexOf(value) == -1) {
                        if ($(':checked', node).length === 0) {
                            node.style.display = 'none';
                            hiddenCount++;
                        }
                    }
                });

                if ($collection.length > hiddenCount) {
                    $inputEl.attr('title', 'By keyword [' + value + '] filtered ' + ($collection.length - hiddenCount));
                } else {
                    $inputEl.attr('title', nb.getText('filter_no_results', 'Не найдено'));
                }
            } else {
                $collection.attr('style', '');
                $inputEl.attr('title', '');
            }
        } catch (e) {
            console.log(e);
        }
    }
};

/**
 * windowOpen
 */
nb.windowOpen = function(url, id, callbacks) {
    var features, width = 800,
        height = 600;
    var top = (window.innerHeight - height) / 2,
        left = (window.innerWidth - width) / 2;
    if (top < 0) top = 0;
    if (left < 0) left = 0;
    features = 'top=' + top + ',left=' + left;
    features += ',height=' + height + ',width=' + width + ',resizable=yes,scrollbars=yes,status=no';

    var wid = 'window-' + (id || url.hashCode());

    var w = window.open('', wid, features);
    if ('about:blank' === w.document.URL || w.document.URL === '') {
        w = window.open(url, wid, features);

        if (callbacks && callbacks.onclose) {
            var timer = setInterval(function() {
                if (w.closed) {
                    clearInterval(timer);
                    callbacks.onclose();
                }
            }, 1000);
        }
    }
    w.focus();
};

/**
 * deleteDocument
 */
nb.xhr.deleteDocument = function(ck, typeDel) {

    if (nb.debug === true) {
        console.log('nb.xhr.deleteDocument: ', ck, typeDel);
    }

    return nb.ajax({
        type: 'POST',
        datatype: 'XML',
        url: 'Provider',
        data: {
            'type': 'delete',
            'ck': ck,
            'typedel': typeDel
        }
    });
};

/**
 * restoreDeletedDocument
 */
nb.xhr.restoreDeletedDocument = function(ck) {

    if (nb.debug === true) {
        console.log('nb.xhr.restoreDeletedDocument: ', ck);
    }

    return nb.ajax({
        type: 'POST',
        datatype: 'XML',
        url: 'Provider',
        data: {
            'type': 'undelete',
            'ck': ck
        }
    });
};

/**
 * addDocumentToFavorite
 */
nb.xhr.addDocumentToFavorite = function(docId, docType) {

    if (nb.debug === true) {
        console.log('nb.xhr.addDocumentToFavorite: ', docId, docType);
    }

    return nb.ajax({
        type: 'POST',
        datatype: 'XML',
        url: 'Provider',
        data: {
            'type': 'service',
            'operation': 'add_to_favourites',
            'doctype': docType,
            'key': docId
        }
    })
};

/**
 * removeDocumentFromFavorite
 */
nb.xhr.removeDocumentFromFavorite = function(docId, docType) {

    if (nb.debug === true) {
        console.log('nb.xhr.removeDocumentFromFavorite: ', docId, docType);
    }

    return nb.ajax({
        type: 'POST',
        datatype: 'XML',
        url: 'Provider',
        data: {
            'type': 'service',
            'operation': 'remove_from_favourites',
            'doctype': docType,
            'key': docId
        }
    });
};

/**
 * markDocumentAsRead
 */
nb.xhr.markDocumentAsRead = function(docId, docType) {

    if (nb.debug === true) {
        console.log('nb.xhr.markDocumentAsRead: ', docId, docType);
    }

    return nb.ajax({
        type: 'POST',
        datatype: 'XML',
        url: 'Provider',
        data: {
            'type': 'service',
            'operation': 'mark_as_read',
            'id': 'mark_as_read',
            'doctype': docType,
            'key': docId
        }
    });
};

/**
 * getUsersWichRead
 */
nb.xhr.getUsersWichRead = function(docId, docType) {

    if (nb.debug === true) {
        console.log('nb.xhr.getUsersWichRead: ', docId, docType);
    }

    return nb.ajax({
        type: 'GET',
        datatype: 'XML',
        url: 'Provider',
        data: {
            'type': 'service',
            'operation': 'users_which_read',
            'id': 'users_which_read',
            'doctype': docType,
            'key': docId
        }
    });
};

/**
 * saveDocument
 */
nb.xhr.saveDocument = function(options) {

    options = options || {};
    var notify = nb.utils.notify({
        message: nb.getText('wait_while_document_save', 'Пожалуйста ждите... идет сохранение документа'),
        type: 'process'
    }).show();

    var xhrArgs = {
        cache: false,
        type: 'POST',
        datatype: 'XML',
        url: 'Provider',
        data: options.data || $('form').serialize(),
        beforeSend: function() {
            nb.utils.blockUI();
            $('.required, [required]', 'form').removeClass('required').removeAttr('required');
        },
        success: function(xml) {
            var jmsg = nb.utils.parseMessageToJson(xml);
            var msgText = jmsg.message[0];
            if (jmsg.status === 'ok') {
                notify.set({
                    'text': nb.getText('document_saved', 'Документ сохранен'),
                    'type': 'success'
                });
                //
                if (msgText.length > 0) {
                    nb.dialog.info({
                        message: msgText,
                        close: function() {
                            if (jmsg.redirect || options.redirect) {
                                window.location.href = jmsg.redirect || options.redirect;
                            }
                        }
                    });
                } else {
                    if (jmsg.redirect || options.redirect) {
                        setTimeout(function() {
                            window.location.href = jmsg.redirect || options.redirect;
                        }, 300);
                    }
                }
            } else {
                if (msgText.indexOf('require:') === 0) {
                    var fields = msgText.substr('require:'.length).split(',');
                    for (i = 0; i < fields.length; i++) {
                        $('#' + fields[i] + 'tbl').addClass('required');
                        $('[name=' + fields[i] + ']').attr('required', 'required').addClass('required');
                    }
                    notify.set({
                        'text': nb.getText('required_field_not_filled', 'Не заполнены обязательные поля'),
                        'type': 'error'
                    });
                } else {
                    notify.set({
                        'text': msgText,
                        'type': 'error'
                    });
                }
            }
        },
        error: function() {
            notify.set({
                'text': nb.getText('error_xhr', 'Ошибка при выполнении запроса'),
                'type': 'error'
            });
        }
    };

    var def = nb.ajax(xhrArgs);
    def.always(function() {
        nb.utils.unblockUI();
        notify.remove(2000);
    });

    return def;
};

/**
 * parseMessageToJson
 */
nb.utils.parseMessageToJson = function(xml) {

    var msg = {};
    $(xml).find('response').each(function(it) {
        msg.status = $(this).attr('status');
        msg.redirect = $('redirect', this).text();
        msg.message = [];
        $(this).find('message').each(function(it) {
            msg.message.push($(this).text());
        });
    });
    return msg;
};

/**
 * chooseFilter
 */
nb.xhr.chooseFilter = function(pageId, column, keyword) {

    if (nb.debug === true) {
        console.log('nb.xhr.chooseFilter: ', pageId, column, keyword);
    }

    return nb.ajax({
        type: 'GET',
        datatype: 'XML',
        url: 'Provider?param=filter_mode~on&param=filtered_column~' + column + '&param=key_word~' + keyword,
        cache: false,
        data: {
            'type': 'service',
            'operation': 'tune_session',
            'element': 'page',
            'id': pageId
        }
    });
};

/**
 * resetFilter
 */
nb.xhr.resetFilter = function(pageId) {

    if (nb.debug === true) {
        console.log('nb.xhr.resetFilter: ', pageId);
    }

    return nb.ajax({
        type: 'POST',
        datatype: 'XML',
        url: 'Provider',
        cache: false,
        data: {
            'type': 'service',
            'operation': 'tune_session',
            'element': 'page',
            'id': pageId,
            'param': 'filter_mode~reset_all'
        }
    });
};

/**
 * resetCurrentFilter
 */
nb.xhr.resetCurrentFilter = function(pageId, column) {

    if (nb.debug === true) {
        console.log('nb.xhr.resetCurrentFilter: ', pageId, column);
    }

    return nb.ajax({
        type: 'GET',
        datatype: 'XML',
        url: 'Provider?param=filter_mode~on&param=filtered_column~' + column,
        cache: false,
        data: {
            'type': 'service',
            'operation': 'tune_session',
            'element': 'page',
            'id': pageId
        }
    });
};

var nbStrings = {
    'RUS': {},
    'KAZ': {},
    'ENG': {},
    'CHN': {}
};

nbStrings.RUS = {
    'yes': 'Да',
    'no': 'Нет',
    ok: 'Ok',
    cancel: 'Отмена',
    select: 'Выбрать',
    dialog_select_value: 'Вы не сделали выбор'
};

/**
 * sendSortRequest
 */
nb.xhr.sendSortRequest = function(pageId, column, direction) {

    if (nb.debug === true) {
        console.log('nb.xhr.sendSortRequest: ', pageId, column, direction);
    }

    return nb.ajax({
        type: 'POST',
        datatype: 'XML',
        url: 'Provider?param=sorting_mode~on&param=sorting_column~' + column.toLowerCase() + '&param=sorting_direction~' + direction.toLowerCase(),
        data: {
            'type': 'service',
            'operation': 'tune_session',
            'element': 'page',
            'id': pageId
        }
    });
};

$(function() {

    $('[data-action=save_and_close]').click(function() {
        SaveFormJquery();
    });

    $('[data-role=side-tree-toggle]').click(function() {
        $(this).parent().toggleClass('side-tree-collapse');
    });

    $(window).resize(function() {
        if (window.innerWidth <= 800) {
            $('body').addClass('phone');
        } else {
            $('body').removeClass('phone');
        }
    });

    if (window.innerWidth <= 800) {
        $('body').addClass('phone');
    }

    try {
        var uiLang = $.cookie('lang') || 'RUS';
        $('input[type=date]').datepicker({
            dateFormat: 'yy-mm-dd',
            showOn: 'button',
            buttonImage: '/SharedResources/img/iconset/calendar.png',
            buttonImageOnly: true,
            regional: ['ru'],
            showAnim: '',
            monthNames: calendarStrings[uiLang].monthNames,
            monthNamesShort: calendarStrings[uiLang].monthNamesShort,
            dayNames: calendarStrings[uiLang].dayNames,
            dayNamesShort: calendarStrings[uiLang].dayNamesShort,
            dayNamesMin: calendarStrings[uiLang].dayNamesMin,
            weekHeader: calendarStrings[uiLang].weekHeader,
            yearSuffix: calendarStrings[uiLang].yearSuffix,
        });
    } catch (e) {
        console.log(e);
    }
});

var app = app || {};

app.proposal = {
    init: function() {
        nbStrings.RUS.action_coord_start = 'Отправлено на согласование';
        nbStrings.RUS.action_coord_agree = 'Согласовать';
        nbStrings.RUS.action_coord_revision = 'Возврат на доработку';
        nbStrings.RUS.action_coord_reject = 'На исключение';
    },

    actions: {
        save: function(el, action) {
            $('[name=_action]').val(action);
            var form = $('form[name=proposal]')[0];
            var data = $(form).serialize();

            nb.utils.blockUI();

            var noty;
            if (action) {
                noty = nb.utils.notify({
                    message: nb.getText('action_' + action)
                }).show();
            }

            return $.ajax({
                method: 'POST',
                datatype: 'html',
                url: 'Provider',
                data: data,
                success: function(result) {
                    nb.utils.unblockUI();
                    if (noty) {
                        noty.remove(3000);
                    }
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
                    text: nb.getText('send', 'Отправить'),
                    click: function() {
                        dlg.dialog('close');
                        app.proposal.actions.coordStart(_this);
                    }
                }
            }
        });
    });

    $('[data-action=coord_agree]').click(function() {
        var _this = this;
        var dlg = nb.dialog.show({
            title: _this.title,
            message: nb.getText('confirm_action', 'Подтвердите действие') + ' "' + nb.getText('agree', 'Согласовать') + '"',
            buttons: {
                'cancel': {
                    text: nb.getText('cancel'),
                    click: function() {
                        dlg.dialog('close');
                    }
                },
                'reject': {
                    text: nb.getText('agree', 'Согласовать'),
                    click: function() {
                        dlg.dialog('close');
                        app.proposal.actions.coordAgree(this);
                    }
                }
            }
        });
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
        var _this = this;
        var dlg = nb.dialog.show({
            title: _this.title,
            message: nb.getText('confirm_action', 'Подтвердите действие') + ' "' + nb.getText('coord_reject', 'Исключить') + '"',
            buttons: {
                'cancel': {
                    text: nb.getText('cancel'),
                    click: function() {
                        dlg.dialog('close');
                    }
                },
                'reject': {
                    text: nb.getText('coord_reject', 'Исключить'),
                    click: function() {
                        dlg.dialog('close');
                        app.proposal.actions.coordReject(this);
                    }
                }
            }
        });
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

    //
    if ($('.view_proposals').length) {
        $('.action_coord_start,.action_coord_agree,.action_coord_revision,.action_coord_reject').addClass('disabled');
    }
});

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
                $input.onchange = function() {
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
            $input.onchange = function() {
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
