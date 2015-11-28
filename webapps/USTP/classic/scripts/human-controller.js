var app = app || {};

app.human = {
    getHumans: function(eventId) {
        $.get('Provider?type=page&id=humans&event_id=' + eventId).then(function(result){
            $('#human-table').html(result);
        });
    },

    addHuman: function(el) {
        var parentdocddbid = $('input[name=ddbid]').val();
        // var hedform = $('form');
        // var data = hedform.serialize();

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

$(function() {
    app.human.getHumans();

    $('[data-action=add_people]').click(function() {
        /*var $tableEl = $(this).parents('table');
        var field = $(this).data('field');
        var fio = $tableEl.find('input[name=' + field + '_fio]').val();
        var sex = $tableEl.find('select[name=' + field + '_sex]').val();
        var age = $tableEl.find('input[name=' + field + '_age]').val();
        var tr = '<tr><td>' + fio + '</td><td>' + sex + '</td><td>' + age + '</td>';
        $tableEl.append(tr);*/
        app.human.addHuman(this);
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
