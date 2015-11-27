var app = app || {};

app.humanController = {

};

$(function(){
    $('[data-action=add_people]').click(function(){
        var $tableEl = $(this).parents('table');
        var field = $(this).data('field');
        var fio = $tableEl.find('input[name=' + field + '_fio]').val();
        var sex = $tableEl.find('select[name=' + field + '_sex]').val();
        var age = $tableEl.find('input[name=' + field + '_age]').val();
        var tr = '<tr><td>' + fio + '</td><td>' + sex + '</td><td>' + age + '</td>';
        $tableEl.append(tr);
    });

    $('select[data-action=add-animal-count]').change(function(){
        if(!$(this).val()){
            return;
        }
        var $list = $(this).parents('.controls').find('.list');
        var it = '<div><span style="display:inline-block" class=span4>' + $(this).val() + '</span><input type="number" class=span1 /></div>';
        $list.append(it);
    });
});
