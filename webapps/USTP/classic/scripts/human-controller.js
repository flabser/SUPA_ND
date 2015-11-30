var app = app || {};

app.human = {
    getHumans: function(eventId) {
        $.get('Provider?type=page&id=humans&event_id=' + eventId).then(function(result){
            $('#human-table').html(result);
        });
    },

    addHuman: function(el) {
        var parentdocddbid = $('input[name=ddbid]').val();

        $.ajax({
            method : 'POST',
            datatype : 'html',
            url : 'Provider?type=save&element=document&id=human&docid=&parentdocddbid=' + parentdocddbid,
            data : {
                fio: $('input[name=human_fio]').val(),
                age: $('input[name=human_age]').val(),
                sex: $('select[name=human_sex]').val()
            },
            success: function() {
                app.human.getHumans(parentdocddbid);
            }
        });
    }
};

app.first_aider = {
    getAll: function(eventId) {
        $.get('Provider?type=page&id=first-aider&event_id=' + eventId).then(function(result){
            $('#first-aider-table').html(result);
        });
    },

    add: function(el) {
        var parentdocddbid = $('input[name=ddbid]').val();

        $.ajax({
            method : 'POST',
            datatype : 'html',
            url : 'Provider?type=save&element=document&id=first-aider&docid=&parentdocddbid=' + parentdocddbid,
            data : {
                name: $('input[name=first-aider-name]').val(),
                address: $('input[name=first-aider-address]').val(),
                phone: $('input[name=first-aider-phone]').val(),
                details: $('input[name=first-aider-details]').val()
            },
            success: function() {
                app.first_aider.getAll();
            }
        });
    }
};

$(function() {
    app.human.getHumans();
    app.first_aider.getAll();

    $('[data-action=add_people]').click(function() {
        app.human.addHuman(this);
    });

    $('[data-action=add_first_aider]').click(function() {
        app.first_aider.add(this);
    });

    $('select[data-action=add-animal-count]').change(function() {
        if(!$(this).val()){
            return;
        }
        var $list = $(this).parents('.controls').find('.list');
        var it = '<div><span style="display:inline-block" class=span4>' + $(this).val() + '</span><input type="number" class=span1 /></div>';
        $list.append(it);
    });
});
