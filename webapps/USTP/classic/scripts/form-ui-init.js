$(function() {
    $('[data-action=save_and_close]').click(SaveFormJquery);

    $('[data-role="side-tree-toggle"]').click(function() {
        $(this).parent().toggleClass('side-tree-collapse');
    });

    var uiLang = $.cookie('lang');
    $('input[type=date]').datepicker({
        dateFormat: 'yy-mm-dd',
        showOn: 'button',
        buttonImage: '/SharedResources/img/iconset/calendar.png',
        buttonImageOnly: true,
        regional:['ru'],
        showAnim: '',
        monthNames: calendarStrings[uiLang].monthNames,
        monthNamesShort: calendarStrings[uiLang].monthNamesShort,
        dayNames: calendarStrings[uiLang].dayNames,
        dayNamesShort: calendarStrings[uiLang].dayNamesShort,
        dayNamesMin: calendarStrings[uiLang].dayNamesMin,
        weekHeader: calendarStrings[uiLang].weekHeader,
        yearSuffix: calendarStrings[uiLang].yearSuffix,
    });
});
