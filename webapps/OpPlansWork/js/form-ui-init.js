$(function() {

    $('[data-action=save_and_close]').click(function() {
        SaveFormJquery();
    });

    $('[data-role="side-tree-toggle"]').click(function() {
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
