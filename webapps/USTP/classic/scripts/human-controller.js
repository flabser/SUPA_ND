var app = app || {};

app.human = {
    getAll: function(eventId) {
        return $.get('Provider?type=page&id=humans&event_id=' + eventId).then(function(result) {
            $('#human-table').html(result);
            return result;
        });
    },

    add: function(dlg) {
        var dlgForm = $('form', dlg[0]);

        return $.ajax({
            method: 'POST',
            datatype: 'html',
            url: 'Provider',
            data: $(dlgForm).serialize(),
            success: function() {
                app.human.getAll();
            }
        });
    },

    dialog: function(href) {
        var dlg = nb.dialog.show({
            title: 'human',
            href: href,
            maxHeight: 500,
            minHeight: 440,
            width: 500,
            buttons: {
                'cancel': {
                    text: nb.getText('cancel'),
                    click: function() {
                        dlg.dialog('close');
                    }
                },
                'save': {
                    text: nb.getText('save'),
                    click: function() {
                        app.human.add(dlg).then(function() {
                            dlg.dialog('close');
                        });
                    }
                }
            }
        });
    }
};

app.first_aider = {
    getAll: function(eventId) {
        return $.get('Provider?type=page&id=first-aider&event_id=' + eventId).then(function(result) {
            $('#first-aider-table').html(result);
            return result;
        });
    },

    add: function(dlg) {
        var dlgForm = $('form', dlg[0]);

        return $.ajax({
            method: 'POST',
            datatype: 'html',
            url: 'Provider',
            data: $(dlgForm).serialize(),
            success: function() {
                app.first_aider.getAll();
            }
        });
    },

    dialog: function(href) {
        var dlg = nb.dialog.show({
            title: 'first_aider',
            href: href,
            maxHeight: 500,
            minHeight: 440,
            width: 500,
            buttons: {
                'cancel': {
                    text: nb.getText('cancel'),
                    click: function() {
                        dlg.dialog('close');
                    }
                },
                'save': {
                    text: nb.getText('save'),
                    click: function() {
                        app.first_aider.add(dlg).then(function() {
                            dlg.dialog('close');
                        });
                    }
                }
            }
        });
    }
};

app.post_of_monitoring_warning = {
    getAll: function(eventId) {
        return $.get('Provider?type=page&id=posts-of-monitoring-warning&event_id=' + eventId).then(function(result) {
            $('#post_of_monitoring_warning-table').html(result);
            return result;
        });
    },

    add: function(dlg) {
        var dlgForm = $('form', dlg[0]);

        return $.ajax({
            method: 'POST',
            datatype: 'html',
            url: 'Provider',
            data: $(dlgForm).serialize(),
            success: function() {
                app.post_of_monitoring_warning.getAll();
            }
        });
    },

    dialog: function(href) {
        var dlg = nb.dialog.show({
            title: 'post_of_monitoring_warning',
            href: href,
            maxHeight: 500,
            minHeight: 440,
            width: 500,
            buttons: {
                'cancel': {
                    text: nb.getText('cancel'),
                    click: function() {
                        dlg.dialog('close');
                    }
                },
                'save': {
                    text: nb.getText('save'),
                    click: function() {
                        app.post_of_monitoring_warning.add(dlg).then(function() {
                            dlg.dialog('close');
                        });
                    }
                }
            }
        });
    }
};

app.risk_zone = {
    getAll: function(eventId) {
        return $.get('Provider?type=page&id=risk-zones&event_id=' + eventId).then(function(result) {
            $('#risk_zone-table').html(result);
            return result;
        });
    },

    add: function(dlg) {
        var dlgForm = $('form', dlg[0]);

        return $.ajax({
            method: 'POST',
            datatype: 'html',
            url: 'Provider',
            data: $(dlgForm).serialize(),
            success: function() {
                app.risk_zone.getAll();
            }
        });
    },

    dialog: function(href) {
        var dlg = nb.dialog.show({
            title: 'risk_zone',
            href: href,
            maxHeight: 500,
            minHeight: 440,
            width: 500,
            buttons: {
                'cancel': {
                    text: nb.getText('cancel'),
                    click: function() {
                        dlg.dialog('close');
                    }
                },
                'save': {
                    text: nb.getText('save'),
                    click: function() {
                        app.risk_zone.add(dlg).then(function() {
                            dlg.dialog('close');
                        });
                    }
                }
            }
        });
    }
};

app.domestic_animal = {
    getAll: function(eventId) {
        return $.get('Provider?type=page&id=domestic-animals&event_id=' + eventId).then(function(result) {
            $('#domestic_animal-table').html(result);
            return result;
        });
    },

    add: function(dlg) {
        var dlgForm = $('form', dlg[0]);

        return $.ajax({
            method: 'POST',
            datatype: 'html',
            url: 'Provider',
            data: $(dlgForm).serialize(),
            success: function() {
                app.domestic_animal.getAll();
            }
        });
    },

    dialog: function(href) {
        var dlg = nb.dialog.show({
            title: 'domestic_animal',
            href: href,
            maxHeight: 500,
            minHeight: 440,
            width: 500,
            buttons: {
                'cancel': {
                    text: nb.getText('cancel'),
                    click: function() {
                        dlg.dialog('close');
                    }
                },
                'save': {
                    text: nb.getText('save'),
                    click: function() {
                        app.domestic_animal.add(dlg).then(function() {
                            dlg.dialog('close');
                        });
                    }
                }
            }
        });
    }
};

$(function() {
    app.human.getAll();
    app.first_aider.getAll();
    app.post_of_monitoring_warning.getAll();
    app.risk_zone.getAll();
    app.domestic_animal.getAll();

    $('[data-action=add_human]').click(function() {
        app.human.dialog('Provider?type=edit&element=document&id=human&docid=');
    });

    $('[data-action=add_first_aider]').click(function() {
        app.first_aider.dialog('Provider?type=edit&element=document&id=first-aider&docid=');
    });

    $('[data-action=add_post_of_monitoring_warning]').click(function() {
        app.post_of_monitoring_warning.dialog('Provider?type=edit&element=document&id=post-of-monitoring-warning&docid=');
    });

    $('[data-action=add_risk_zone]').click(function() {
        app.risk_zone.dialog('Provider?type=edit&element=document&id=risk-zone&docid=');
    });

    $('[data-action=add_domestic_animal]').click(function() {
        app.domestic_animal.dialog('Provider?type=edit&element=document&id=domestic-animal&docid=');
    });

    $('body').on('click', 'a', function(e) {
        if (this.href.indexOf('id=human') != -1) {
            e.preventDefault();
            app.human.dialog(this.href);
        } else if (this.href.indexOf('id=first-aider') != -1) {
            e.preventDefault();
            app.first_aider.dialog(this.href);
        } else if (this.href.indexOf('id=post-of-monitoring-warning') != -1) {
            e.preventDefault();
            app.post_of_monitoring_warning.dialog(this.href);
        } else if (this.href.indexOf('id=risk-zone') != -1) {
            e.preventDefault();
            app.risk_zone.dialog(this.href);
        } else if (this.href.indexOf('id=domestic-animal') != -1) {
            e.preventDefault();
            app.domestic_animal.dialog(this.href);
        }

        return true;
    });
});

app.windowOpen = function(url, id, callbacks) {
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
