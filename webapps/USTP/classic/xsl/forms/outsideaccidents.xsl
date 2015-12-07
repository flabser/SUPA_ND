<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../layout.xsl"/>

    <xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>

    <xsl:variable name="doctype" select="request/document/fields/title"/>
    <xsl:variable name="path" select="/request/@skin"/>
    <xsl:variable name="editmode" select="/request/document/@editmode"/>
    <xsl:variable name="status" select="/request/document/@status"/>
    <xsl:variable name="userid" select="/request/@userid"/>
    <xsl:variable name="threaddocid" select="document/@granddocid"/>

    <xsl:template match="/request">
        <xsl:call-template name="layout">
            <xsl:with-param name="include">
                <script type="text/javascript" src="classic/scripts/form.js"></script>
                <script type="text/javascript" src="classic/scripts/dialogs.js"></script>
                <script type="text/javascript" src="/SharedResources/jquery/js/TimePicki/TimePicki-master/js/timepicki.js"></script>
                <link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/TimePicki/TimePicki-master/css/timepicki.css"/>
                <script>
                    $(function(){
                        $("#tabs").tabs();
                        $('.timepicker').timepicki({
                            show_meridian:false,
                            min_hour_value:0,
                            max_hour_value:23,
                            step_size_minutes:1,
                            overflow_minutes:true,
                            increase_direction:'up',
                            disable_keyboard_mobile: false
                        });
                    });
                </script>
                <xsl:if test="$editmode = 'edit'">
                    <script>
                        var _calendarLang = "<xsl:value-of select="/request/@lang"/>";
                        $(function() {
                        $('#f1n5, #f1n16, #f1n18, #f1n42, #f1n43').datepicker({
                        showOn: 'button',
                        buttonImage: '/SharedResources/img/iconset/calendar.png',
                        buttonImageOnly: true,
                        regional:['ru'],
                        showAnim: '',
                        monthNames: calendarStrings[_calendarLang].monthNames,
                        monthNamesShort: calendarStrings[_calendarLang].monthNamesShort,
                        dayNames: calendarStrings[_calendarLang].dayNames,
                        dayNamesShort: calendarStrings[_calendarLang].dayNamesShort,
                        dayNamesMin: calendarStrings[_calendarLang].dayNamesMin,
                        weekHeader: calendarStrings[_calendarLang].weekHeader,
                        yearSuffix: calendarStrings[_calendarLang].yearSuffix,
                        });
                        });
                    </script>
                </xsl:if>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="_content">
        <xsl:variable name="filename" select="document/fields/pdocrtfcontent"/>

        <header class="form-header">
            <h1 class="header-title">
                <xsl:value-of select="document/fields/title"/>
            </h1>
            <xsl:apply-templates select="//actionbar">
                <xsl:with-param name="fixed_top" select="''"/>
            </xsl:apply-templates>
        </header>

        <section class="form-content">

            <div id="tabs">
                <ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-1">Информация</a>
                    </li>
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-2">Последствия ЧС</a>
                    </li>
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-3">Описание и реагирование на ЧС</a>
                    </li>
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-4">Ликвидация ЧС</a>
                    </li>
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-5">Характеристика объекта</a>
                    </li>
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-6">Итоговая справка</a>
                    </li>
                    <span style="float:right; font-size:11px; font-weight:normal;">
                        <b class="text"><xsl:value-of select="document/captions/author/@caption"/>:
                        </b>
                        <font class="text" style="padding-right:7px;">
                            <xsl:value-of select="document/fields/author"/>
                        </font>
                        <xsl:if test="$status != 'new'">
                            <img id="edsimg"
                                 style="max-width:14px; margin-right:5px; margin-left:2px; visibility:hidden"
                                 title="Документ подписан ЭЦП - Подпись верна"/>
                        </xsl:if>
                        <xsl:if test="document/fields/isold = '1'">
                            <font class="text">
                                Устаревший
                            </font>
                        </xsl:if>
                    </span>
                </ul>
                <form action="Provider" name="frm" method="post" id="frm"
                      enctype="application/x-www-form-urlencoded">
                    <div class="ui-tabs-panel" id="tabs-1">
                        <br/>
                        <table width="100%" border="0">
                            <tr>
                                <td class="fc">
                                    <font style="vertical-align:top">
                                        Номер карточки :
                                    </font>
                                </td>
                                <td>
                                   <input type="text" name="cardnumber" maxlength="10" class="td_editable" style="width:90px;" value="{document/fields/cardnumber}"/>
                                </td>
                            </tr>
                            <!-- Дата карточки -->
                            <tr>
                                <td class="fc">
                                    Дата карточки :
                                </td>
                                <td>
                                    <input type="text" name="carddate" id="carddate" maxlength="10" class="td_editable" style="width:90px;" value="{document/fields/carddate}"/>
                                </td>
                            </tr>
                            <!-- Код ЧС -->
                            <tr>
                                <td class="fc">
                                    Код ЧС :
                                </td>
                                <td>
                                    <input type="text" name="escode" maxlength="10" class="td_editable" style="width:90px;" value="{document/fields/escode}"/>
                                </td>
                            </tr>
                            <!-- Группа  ЧС -->
                            <tr>
                                <td class="fc">
                                    Группа ЧС :
                                </td>
                                <td>
                                    <select size="1" name="esgroup" style="width:612px;" class="select_editable" autocomplete="off">
                                        <xsl:variable name="esgroup" select="document/fields/esgroup"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="01">
                                            <xsl:if test="$esgroup = '01'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 01
                                        </option>
                                        <option value="02">
                                            <xsl:if test="$esgroup = '02'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 02
                                        </option>
                                        <option value="03">
                                            <xsl:if test="$esgroup = '03'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 03
                                        </option>
                                        <option value="04">
                                            <xsl:if test="$esgroup = '04'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 04
                                        </option>
                                        <option value="05">
                                            <xsl:if test="$esgroup = '05'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 05
                                        </option>
                                        <option value="06">
                                            <xsl:if test="$esgroup = '06'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 06
                                        </option>
                                        <option value="07">
                                            <xsl:if test="$esgroup = '07'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 07
                                        </option>
                                        <option value="08">
                                            <xsl:if test="$esgroup = '08'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 08
                                        </option>
                                        <option value="09">
                                            <xsl:if test="$esgroup = '09'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 09
                                        </option>
                                        <option value="10">
                                            <xsl:if test="$esgroup = '10'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 10
                                        </option>
                                        <option value="11">
                                            <xsl:if test="$esgroup = '11'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 11
                                        </option>
                                        <option value="12">
                                            <xsl:if test="$esgroup = '12'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 12
                                        </option>
                                        <option value="13">
                                            <xsl:if test="$esgroup = '13'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 13
                                        </option>
                                        <option value="14">
                                            <xsl:if test="$esgroup = '14'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 14
                                        </option>
                                        <option value="15">
                                            <xsl:if test="$esgroup = '15'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 15
                                        </option>
                                        <option value="16">
                                            <xsl:if test="$esgroup = '16'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 16
                                        </option>
                                        <option value="17">
                                            <xsl:if test="$esgroup = '17'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 17
                                        </option>
                                        <option value="18">
                                            <xsl:if test="$esgroup = '18'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 18
                                        </option>
                                        <option value="19">
                                            <xsl:if test="$esgroup = '19'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Группа 19
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <!-- Вид  ЧС -->
                            <tr>
                                <td class="fc">
                                    Вид ЧС :
                                </td>
                                <td>
                                    <select size="1" name="essubtype" style="width:612px;"
                                            class="select_editable" autocomplete="off">
                                        <xsl:variable name="essubtype" select="document/fields/essubtype/@attrval"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/essubtype/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/essubtype"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/essubtype/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$essubtype = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </td>
                            </tr>
                            <!-- поле "Краткое описание происшествия" -->
                            <tr>
                                <td class="fc" style="padding-top:5px">
                                    Краткое описание происшествия :
                                </td>
                                <td style="padding-top:5px">
                                    <div>
                                        <textarea name="esbriefcontent" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                            <xsl:if test="$editmode !='edit'">
                                                <xsl:attribute name="readonly">readonly</xsl:attribute>
                                                <xsl:attribute name="class">textarea_noteditable
                                                </xsl:attribute>
                                            </xsl:if>
                                            <xsl:if test="$editmode = 'edit'">
                                                <xsl:attribute name="onfocus">fieldOnFocus(this)
                                                </xsl:attribute>
                                                <xsl:attribute name="onblur">fieldOnBlur(this)
                                                </xsl:attribute>
                                            </xsl:if>
                                            <xsl:value-of select="document/fields/esbriefcontent"/>
                                        </textarea>
                                    </div>
                                </td>
                            </tr>
                            <!-- Дата возникновения ЧС -->
                            <tr>
                                <td class="fc">
                                    Дата возникновения ЧС :
                                </td>
                                <td>
                                    <input type="text" name="esdate" id="f1n5" maxlength="10" class="td_editable" style="width:100px;" value="{document/fields/esdate}"/>
                                </td>
                            </tr>
                            <!-- Наименование государства -->
                            <tr>
                                <td class="fc">
                                    Наименование государства :
                                </td>
                                <td>
                                    <input type="text" name="esland"  class="td_editable" style="width:400px;" value="{document/fields/esland}"/>
                                </td>
                            </tr>
                            <!-- Наименование область -->
                            <tr>
                                <td class="fc">
                                    Регион :
                                </td>
                                <td>
                                    <input type="text" name="esregion"  class="td_editable" style="width:400px;" value="{document/fields/esregion}"/>
                                </td>
                            </tr>
                            <!-- Наименование область -->
                            <tr>
                                <td class="fc">
                                    Населенный пункт :
                                </td>
                                <td>
                                    <input type="text" name="escity"  class="td_editable" style="width:400px;" value="{document/fields/escity}"/>
                                </td>
                            </tr>

                            <!-- Расстояние от видимых ориентиров   -->
                            <tr>
                                <td class="fc">

                                </td>
                                <td style="padding-left:5px">
                                    <table style="padding:0px">
                                        <tr>
                                            <td style="width:200px"> Ориентир </td>
                                            <td style="width:120px"> Расстояние (км) </td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Видимые ориентиры :
                                </td>
                                <td>
                                    <table style="padding:0px">
                                        <tr>
                                            <td style="width:200px; padding:0">
                                                <input type="text" name="referencepoint" class="td_editable" style="width:195px;" value="{document/fields/referencepoint}"/>
                                            </td>
                                            <td style="width:120px; padding:0">
                                                <input type="text" name="distance" class="td_editable" style="width:120px;" value="{document/fields/distance}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Географические координаты   -->
                            <tr>
                                <td class="fc">
                                    Географические координаты :
                                </td>
                                <td>
                                    <input type="text" name="coordinats" class="td_editable" style="width:320px;" value="{document/fields/coordinats}"/>
                                </td>
                            </tr>
                            <!-- дороги (значение) -->
                            <tr>
                                <td class="fc">
                                    Дороги (значение) :
                                </td>
                                <td>
                                    <select size="1" name="roadtype" style="width:612px;"
                                            class="select_editable" autocomplete="off">
                                        <xsl:variable name="roadtype" select="document/fields/roadtype"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/roadtype/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/roadtype"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/roadtype/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$roadtype = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </td>
                            </tr>
                            <!-- Автовокзал -->
                            <tr>
                                <td class="fc">
                                    Автовокзал :
                                </td>
                                <td>
                                    <select size="1" name="busstation" style="width:412px;" class="select_editable" autocomplete="off">
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="document/fields/busstation = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Вокзальное здание
                                        </option>
                                        <option value="2">
                                            <xsl:if test="document/fields/busstation = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Перрон для посадки
                                        </option>
                                        <option value="3">
                                            <xsl:if test="document/fields/busstation = '3'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Перрон для высадки
                                        </option>
                                        <option value="4">
                                            <xsl:if test="document/fields/busstation = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Стоянка подвижного состава
                                        </option>
                                        <option value="5">
                                            <xsl:if test="document/fields/busstation = '5'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Устройство для мойки автобусов
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <!-- Железнодорожные пути -->
                            <tr>
                                <td class="fc">
                                    Железнодорожные пути :
                                </td>
                                <td>
                                    <select size="1" name="railways" style="width:412px;" class="select_editable" autocomplete="off">
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="document/fields/railways = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Железная дорога
                                        </option>
                                        <option value="2">
                                            <xsl:if test="document/fields/railways = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Внеклассовый вокзал
                                        </option>
                                        <option value="3">
                                            <xsl:if test="document/fields/railways = '3'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Вокзал 1го класса
                                        </option>
                                        <option value="4">
                                            <xsl:if test="document/fields/railways = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Вокзал 2го класса
                                        </option>
                                        <option value="5">
                                            <xsl:if test="document/fields/railways = '5'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Вокзал 3го класса
                                        </option>
                                        <option value="6">
                                            <xsl:if test="document/fields/railways = '6'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Станция
                                        </option>
                                        <option value="7">
                                            <xsl:if test="document/fields/railways = '7'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Перрон
                                        </option>
                                        <option value="8">
                                            <xsl:if test="document/fields/railways = '8'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Платформа
                                        </option>
                                        <option value="9">
                                            <xsl:if test="document/fields/railways = '9'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Перегон
                                        </option>
                                        <option value="10">
                                            <xsl:if test="document/fields/railways = '10'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Разъезд
                                        </option>
                                        <option value="11">
                                            <xsl:if test="document/fields/railways = '11'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Тупик
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <!-- Аэровокзальный комплекс -->
                            <tr>
                                <td class="fc">
                                    Аэровокзальный комплекс :
                                </td>
                                <td>
                                    <select size="1" name="airterminal" style="width:412px;" class="select_editable" autocomplete="off">
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="document/fields/airterminal = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Аэродром
                                        </option>
                                        <option value="2">
                                            <xsl:if test="document/fields/airterminal = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - взлетно-посадочная полоса
                                        </option>
                                        <option value="3">
                                            <xsl:if test="document/fields/airterminal = '3'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - рулежные дорожки
                                        </option>
                                        <option value="4">
                                            <xsl:if test="document/fields/airterminal = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - перрон
                                        </option>
                                        <option value="5">
                                            <xsl:if test="document/fields/airterminal = '5'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - место стоянки
                                        </option>
                                        <option value="6">
                                            <xsl:if test="document/fields/airterminal = '6'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - место заправки
                                        </option>
                                        <option value="7">
                                            <xsl:if test="document/fields/airterminal = '7'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - комплекс управления воздушным движением
                                        </option>
                                        <option value="8">
                                            <xsl:if test="document/fields/airterminal = '8'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            аэровокзалы
                                        </option>
                                        <option value="9">
                                            <xsl:if test="document/fields/airterminal = '9'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - внеклассовые
                                        </option>
                                        <option value="10">
                                            <xsl:if test="document/fields/airterminal = '10'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - 1 класса
                                        </option>
                                        <option value="11">
                                            <xsl:if test="document/fields/airterminal = '11'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - 2 класса
                                        </option>
                                        <option value="12">
                                            <xsl:if test="document/fields/airterminal = '12'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - 3 класса
                                        </option>
                                        <option value="13">
                                            <xsl:if test="document/fields/airterminal = '13'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - 4 класса
                                        </option>
                                        <option value="14">
                                            <xsl:if test="document/fields/airterminal = '14'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - 5 класса
                                        </option>
                                        <option value="15">
                                            <xsl:if test="document/fields/airterminal = '15'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - неклассифицированные
                                        </option>
                                        <option value="16">
                                            <xsl:if test="document/fields/airterminal = '16'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Грузовой комплекс
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <!-- Порты -->
                            <tr>
                                <td class="fc">
                                    Порты :
                                </td>
                                <td>
                                    <select size="1" name="seaport" style="width:412px;" class="select_editable" autocomplete="off">
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="document/fields/seaport = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            морские
                                        </option>
                                        <option value="2">
                                            <xsl:if test="document/fields/seaport = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            военно-морские базы
                                        </option>
                                        <option value="4">
                                            <xsl:if test="document/fields/seaport = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            речные
                                        </option>
                                        <option value="5">
                                            <xsl:if test="document/fields/seaport = '5'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            пассажирские
                                        </option>
                                        <option value="6">
                                            <xsl:if test="document/fields/seaport = '6'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            торговые
                                        </option>
                                        <option value="7">
                                            <xsl:if test="document/fields/seaport = '7'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            рыбные
                                        </option>
                                        <option value="1">
                                            <xsl:if test="document/fields/seaport = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            причалы
                                        </option>
                                        <option value="8">
                                            <xsl:if test="document/fields/seaport = '8'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            вокзалы
                                        </option>
                                        <option value="9">
                                            <xsl:if test="document/fields/seaport = '9'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            терминалы
                                        </option>
                                        <option value="10">
                                            <xsl:if test="document/fields/seaport = '10'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            переправа
                                        </option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2">
                        <br/>
                        <table width="100%" border="0">
                            <!-- Общее количество людей находившихся в зоне ЧС (чел.) -->
                            <tr>
                                <td class="fc">
                                    Общее количество людей находившихся в зоне ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n22" class="td_editable" style="width:120px;" value="{document/fields/f1n22}"/>
                                </td>
                            </tr>
                            <!-- Количество разрушенных объектов -->
                            <tr>
                                <td class="fc">
                                    Количество разрушенных объектов :
                                </td>
                                <td>
                                    <input type="text" name="f1n22_2" class="td_editable" style="width:120px;" value="{document/fields/f1n22_2}"/>
                                </td>
                            </tr>
                            <!-- Количество граждан Республики Казахстан находящихся в зоне ЧС -->
                            <tr>
                                <td class="fc">
                                    Количество граждан РК находящихся в зоне ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n22_3" class="td_editable" style="width:120px;" value="{document/fields/f1n22_3}"/>
                                </td>
                            </tr>
                            <!-- Количество пострадавших (чел.) -->
                            <tr>
                                <td class="fc">
                                    Количество пострадавших граждан РК (чел.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n23" class="td_editable"  style="width:120px; margin-right:5px" value="{document/fields/f1n23}"/>
                                    Детей :  <input type="text" name="f1n23_5" maxlength="10" class="td_editable" style="width:120px; margin-left:5px" value="{document/fields/f1n213_5}"/>
                                </td>
                            </tr>
                            <!-- ФИО, Пол, Возраст -->
                            <tr>
                                <td class="fc">

                                </td>
                                <td>
                                    <table style="padding:0px">
                                        <tr>
                                            <td style="width:250px">ФИО</td>
                                            <td style="width:100px">Пол</td>
                                            <td style="width:60px">Возраст</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n23_2" maxlength="10" class="td_editable" style="width:250px;  margin-right:5px" value="{document/fields/f1n23_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n23_3" maxlength="10" class="td_editable"  style="width:100px; margin-right:5px;" value="{document/fields/f1n23_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n23_4" maxlength="10" class="td_editable"  style="width:60px;" value="{document/fields/f1n23_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Количество Погибших (чел.) -->
                            <tr>
                                <td class="fc">
                                    Количество погибших граждан РК (чел.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n24" class="td_editable" style="width:120px;" value="{document/fields/f1n24}"/>
                                    Детей : <input type="text" name="f1n24_5" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n24_5}"/>
                                </td>
                            </tr>
                            <!-- ФИО, Пол, Возраст -->
                            <tr>
                                <td class="fc">

                                </td>
                                <td>
                                    <table style="padding:0px">
                                        <tr>
                                            <td style="width:250px">ФИО</td>
                                            <td style="width:100px">Пол</td>
                                            <td style="width:60px">Возраст</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n24_2"  class="td_editable" style="width:250px;  margin-right:5px" value="{document/fields/f1n24_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n24_3"  class="td_editable" style="width:100px; margin-right:5px;" value="{document/fields/f1n24_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n24_4" class="td_editable" style="width:60px; ; margin-left:5px;" value="{document/fields/f1n24_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Количество людей пропавших без вести (чел.) -->
                            <tr>
                                <td class="fc">
                                    Количество пропавших без вести граждан РК (чел.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n25" class="td_editable" style="width:120px;" value="{document/fields/f1n25}"/>
                                    Детей : <input type="text" name="f1n25_5" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n25_5}"/>
                                </td>
                            </tr>
                            <!-- ФИО, Пол, Возраст -->
                            <tr>
                                <td class="fc">

                                </td>
                                <td>
                                    <table style="padding:0px">
                                        <tr>
                                            <td style="width:250px">ФИО</td>
                                            <td style="width:100px">Пол</td>
                                            <td style="width:60px">Возраст</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n25_2" class="td_editable" style="width:250px;  margin-right:5px" value="{document/fields/f1n25_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n25_3"  class="td_editable" style="width:100px; margin-right:5px;" value="{document/fields/f1n25_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n25_4" class="td_editable" style="width:60px; margin-left:5px; " value="{document/fields/f1n25_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <!-- Количество спасенных (чел.) -->
                            <tr>
                                <td class="fc">
                                    Количество спасенных граждан РК (чел.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n26" class="td_editable" style="width:120px;" value="{document/fields/f1n26}"/>
                                    Детей : <input type="text" name="f1n26_5" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n26_5}"/>
                                </td>
                            </tr>
                            <!-- ФИО, Пол, Возраст -->
                            <tr>
                                <td class="fc">

                                </td>
                                <td>
                                    <table style="padding:0px">
                                        <tr>
                                            <td style="width:250px">ФИО</td>
                                            <td style="width:100px">Пол</td>
                                            <td style="width:60px">Возраст</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n26_2" class="td_editable" style="width:250px; margin-right:5px" value="{document/fields/f1n26_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n26_3" class="td_editable" style="width:100px; margin-right:5px;" value="{document/fields/f1n26_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n26_4" class="td_editable" style="width:60px;  margin-left:5px; " value="{document/fields/f1n26_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <!-- Обнаруженно людей в ходе проведения поисково - спасательных работ -->
                            <tr>
                                <td class="fc">
                                    Обнаруженно граждан РК в ходе проведения поисково - спасательных работ :
                                </td>
                                <td>
                                    <input type="text" name="f1n27"  class="td_editable" style="width:120px;" value="{document/fields/f1n27}"/>
                                </td>
                            </tr>
                            <!-- Спасены и доставлены в мед. учреждения -->
                            <tr>
                                <td class="fc">
                                    Спасены и доставлены в мед. учреждения :
                                </td>
                                <td>
                                    <input type="text" name="f1n27_2" class="td_editable" style="width:120px;" value="{document/fields/f1n27_2}"/>
                                </td>
                            </tr>
                            <!-- ФИО, Пол, Возраст -->
                            <tr>
                                <td class="fc">

                                </td>
                                <td>
                                    <table style="padding:0px">
                                        <tr>
                                            <td style="width:250px">ФИО</td>
                                            <td style="width:100px">Пол</td>
                                            <td style="width:60px">Возраст</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n27_3" class="td_editable" style="width:250px;  margin-right:5px" value="{document/fields/f1n27_3}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n27_4" class="td_editable" style="width:100px; margin-right:5px;" value="{document/fields/f1n27_4}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n27_5" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/f1n27_5}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Общее количество людей требующих эвакуации (чел.) -->
                            <tr>
                                <td class="fc">
                                    Общее количество граждан РК требующих эвакуации :
                                </td>
                                <td>
                                    <input type="text" name="f1n28" class="td_editable" style="width:120px;" value="{document/fields/f1n28}"/>
                                </td>
                            </tr>
                            <!-- Количество эвакуированных  -->
                            <tr>
                                <td class="fc">
                                    Количество эвакуированных граждан РК :
                                </td>
                                <td>
                                    <input type="text" name="f1n29" class="td_editable" style="width:120px;" value="{document/fields/f1n29}"/>
                                    Детей : <input type="text" name="f1n29_5" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n29_5}"/>
                                </td>
                            </tr>
                            <!-- ФИО, Пол, Возраст -->
                            <tr>
                                <td class="fc">

                                </td>
                                <td>
                                    <table style="padding:0px">
                                        <tr>
                                            <td style="width:250px">ФИО</td>
                                            <td style="width:100px">Пол</td>
                                            <td style="width:60px">Возраст</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n29_2" class="td_editable" style="width:250px;  margin-right:5px" value="{document/fields/f1n29_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n29_3" class="td_editable" style="width:100px; margin-right:5px;" value="{document/fields/f1n29_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n29_4" class="td_editable"  style="width:60px;  margin-left:5px; " value="{document/fields/f1n29_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Оказана первая медицинская помощь  -->
                            <tr>
                                <td class="fc">
                                    Оказана первая медицинская помощь :
                                </td>
                                <td>
                                    <input type="text" name="f1n30"  class="td_editable" style="width:120px;" value="{document/fields/f1n30}"/>
                                    Детей : <input type="text" name="f1n30_5" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n30_5}"/>
                                </td>
                            </tr>
                            <!-- ФИО, Пол, Возраст -->
                            <tr>
                                <td class="fc">

                                </td>
                                <td>
                                    <table style="padding:0px">
                                        <tr>
                                            <td style="width:250px">ФИО</td>
                                            <td style="width:100px">Пол</td>
                                            <td style="width:60px">Возраст</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n30_2" class="td_editable" style="width:250px;  margin-right:5px" value="{document/fields/f1n30_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n30_3" class="td_editable" style="width:100px; margin-right:5px;" value="{document/fields/f1n30_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n30_4" class="td_editable"  style="width:60px; margin-left:5px; " value="{document/fields/f1n30_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Наименование организаций, юридический адрес, реквизиты, оказывавших первую помощь  -->
                            <tr>
                                <td class="fc">
                                    Наименование организаций, юридический адрес, реквизиты, оказывавших первую помощь :
                                </td>
                                <td>
                                    <input type="text" name="f1n31" class="td_editable" style="width:600px;" value="{document/fields/f1n31}"/>
                                </td>
                            </tr>

                            <!-- Госпитализировано людей  -->
                            <tr>
                                <td class="fc">
                                    Госпитализировано граждан РК :
                                </td>
                                <td>
                                    <input type="text" name="f1n32" class="td_editable" style="width:120px;" value="{document/fields/f1n32}"/>
                                    Детей : <input type="text" name="f1n32_5" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n32_5}"/>
                                </td>
                            </tr>
                            <!-- ФИО, Пол, Возраст -->
                            <tr>
                                <td class="fc">

                                </td>
                                <td>
                                    <table style="padding:0px">
                                        <tr>
                                            <td style="width:250px">ФИО</td>
                                            <td style="width:100px">Пол</td>
                                            <td style="width:60px">Возраст</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n32_2"  class="td_editable" style="width:250px;  margin-right:5px" value="{document/fields/f1n32_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n32_3" class="td_editable" style="width:100px; margin-right:5px;" value="{document/fields/f1n32_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n32_4" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/f1n32_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Материальный ущерб (предварительный) тенге -->
                            <tr>
                                <td class="fc">
                                    Материальный ущерб (предварительный) тенге :
                                </td>
                                <td>
                                    <input type="text" name="f1n36" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n36}"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-3">
                        <br/>
                        <table width="100%" border="0">
                            <!-- Время -->
                            <tr>
                                <td class="fc">
                                    Время :
                                </td>
                                <td>
                                </td>
                            </tr>
                            <!-- Время возникновения ЧС-->
                            <tr>
                                <td class="fc">
                                    Возникновения ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_2" id="f1n37_2" class="td_editable timepicker" style="width:120px;"
                                           value="{document/fields/f1n37_2}"/>
                                </td>
                            </tr>
                            <!-- Время обнаружения  ЧС-->
                            <tr>
                                <td class="fc">
                                    обнаружения ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_3" id="f1n37_3" class="td_editable timepicker" style="width:120px;"
                                           value="{document/fields/f1n37_3}"/>
                                </td>
                            </tr>
                            <!-- Время сообщения о ЧС-->
                            <tr>
                                <td class="fc">
                                    сообщения о ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_4" id="f1n37_4" class="td_editable timepicker" style="width:120px;"
                                           value="{document/fields/f1n37_4}"/>
                                </td>
                            </tr>
                            <!-- Время выезда подразделений -->
                            <tr>
                                <td class="fc">
                                    Выезда подразделений :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_5" id="f1n37_5" class="td_editable timepicker" style="width:120px;"
                                           value="{document/fields/f1n37_5}"/>
                                </td>
                            </tr>
                            <!-- Время прибытия первых подразделений -->
                            <tr>
                                <td class="fc">
                                    Время прибытия первых подразделений :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_6" id="f1n37_6" class="td_editable timepicker" style="width:120px;"
                                           value="{document/fields/f1n37_6}"/>
                                </td>
                            </tr>
                            <!--Расстояние от места аварии до близлежащих населенных пунктов-->
                            <tr>
                                <td class="fc">
                                    Расстояние объекта до близлежащих населенных пунктов :
                                </td>
                                <td>
                                    <input type="text" name="f1n38" class="td_editable" style="width:120px;" value="{document/fields/f1n38}"/>
                                </td>
                            </tr>
                            <!--Охват населения своевременным оповещением об угрозе и возникновении ЧС (%)-->
                            <tr>
                                <td class="fc">
                                    Охват населения своевременным оповещением об угрозе и возникновении ЧС
                                    (%) :
                                </td>
                                <td>
                                    <input type="text" name="f1n39" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n39}"/>
                                </td>
                            </tr>
                            <!--Время оповещения -->
                            <tr>
                                <td class="fc">
                                    Количество населенных пунктов попавших в зону ЧС (ед.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n40" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n40}"/>
                                </td>
                            </tr>
                            <!-- Дежурный дежурно-диспетчерских служб области, города, района (ФИО, телефон, факс) -->
                            <tr>
                                <td class="fc">
                                    Дежурный дежурно-диспетчерских служб области, города, района (ФИО,
                                    телефон, факс) :
                                </td>
                                <td>
                                    <textarea name="f1n41" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n41"/>
                                    </textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-4">
                        <br/>
                        <table width="100%" border="0">
                            <!-- Дата  локализации ЧС -->
                            <tr>
                                <td class="fc">
                                    Дата локализации ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n42"  id="f1n42" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n42}"/>
                                </td>
                            </tr>
                            <!-- время локализации ЧС -->
                            <tr>
                                <td class="fc">
                                    Время локализации ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n42_2" class="td_editable timepicker"
                                           style="width:120px;" value="{document/fields/f1n42_2}"/>
                                </td>
                            </tr>
                            <!--Дата ликвидации ЧС-->
                            <tr>
                                <td class="fc">
                                    Дата ликвидации ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n43" id="f1n43" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n43}"/>
                                </td>
                            </tr>
                            <!--Время ликвидации ЧС-->
                            <tr>
                                <td class="fc">
                                    Время ликвидации ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n43_2" class="td_editable timepicker"
                                           style="width:120px;" value="{document/fields/f1n43_2}"/>
                                </td>
                            </tr>
                            <!--Было задействовано в ликвидации-->
                            <tr>
                                <td class="fc">
                                    Было задействовано в ликвидации :
                                </td>
                                <td>
                                    <input type="text" name="f1n44" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n44}"/>
                                </td>
                            </tr>
                            <!-- в том числе -->
                            <tr>
                                <td class="fc">
                                    в том числе :
                                </td>
                                <td>
                                    <input type="text" name="f1n45" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n45}"/>
                                </td>
                            </tr>
                            <!-- Штаб ликвидации аварии -->
                            <tr>
                                <td class="fc">
                                    Штаб ликвидации аварии :
                                </td>
                                <td>
                                    <input type="text" name="f1n46" class="td_editable"
                                           style="width:500px;" value="{document/fields/f1n46}"/>
                                </td>
                            </tr>
                            <!-- Руководитель ликвидации ЧС (ФИО, должность, место работы) -->
                            <tr>
                                <td class="fc">
                                    Руководитель ликвидации ЧС (ФИО, должность, место работы) :
                                </td>
                                <td>
                                    <textarea name="f1n47" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                            <xsl:value-of select="document/fields/f1n47"/>
                                        </xsl:if>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Виновное лицо (ФИО, возраст) -->
                            <tr>
                                <td class="fc">
                                    Виновное лицо (ФИО, возраст) :
                                </td>
                                <td>
                                    <input type="text" name="f1n48" class="td_editable"
                                           style="width:500px;" value="{document/fields/f1n48}"/>
                                </td>
                            </tr>
                            <!-- Состояние виновного -->
                            <tr>
                                <td class="fc">
                                    Состояние виновного :
                                </td>
                                <td>
                                    <input type="text" name="f1n48_2" class="td_editable"
                                           style="width:500px;" value="{document/fields/f1n48_2}"/>
                                </td>
                            </tr>
                            <!-- Вид ответственности виновного -->
                            <tr>
                                <td class="fc">
                                    Вид ответственности виновного :
                                </td>
                                <td>
                                    <input type="text" name="f1n48_3"  class="td_editable"
                                           style="width:500px;" value="{document/fields/f1n48_3}"/>
                                </td>
                            </tr>
                            <!-- Затраты на ликвидацию ЧС, тенге -->
                            <tr>
                                <td class="fc">
                                    Затраты на ликвидацию ЧС, тенге :
                                </td>
                                <td>
                                    <input type="text" name="f1n49" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n49}"/>
                                </td>
                            </tr>
                            <!-- Сведения о создании Правительственной комиссии по расследованию аварии -->
                            <tr>
                                <td class="fc">
                                    Сведения о создании Межведомственной или Правительственной комиссии по расследованию ЧС :
                                </td>
                                <td>
                                    <textarea name="f1n50" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n50"/>
                                    </textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-5">
                        <br/>
                        <table width="100%" border="0">
                            <tr>
                                <td class="fc">
                                    Вид разрушений в зоне ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n51" class="td_editable"
                                           style="width:200px;" value="{document/fields/f1n51}"/>
                                </td>
                            </tr>
                            <!-- Наименование объекта -->
                            <tr>
                                <td class="fc">
                                   Наименование объекта :
                                </td>
                                <td>
                                    <textarea name="f1n52_2" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n52_2"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!--Государственный номер автомобиля-(ей) -->
                            <tr>
                                <td class="fc">
                                    Отраслевая принадлежность :
                                </td>
                                <td>
                                    <input type="text" name="f1n52_3" class="td_editable"
                                           style="width:300px;" value="{document/fields/f1n52_3}"/>
                                </td>
                            </tr>
                            <!-- Наличие системы -->
                            <tr>
                                <td class="fc">
                                    Юридические реквизиты :
                                </td>
                                <td>
                                    <textarea name="f1n60" rows="3" tabindex="3" style="width:500px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n60"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Объект аварии -->
                            <tr>
                                <td class="fc">
                                    Объект аварии :
                                </td>
                                <td>
                                    <input type="text" name="f1n53" class="td_editable"
                                           style="width:300px;" value="{document/fields/f1n53}"/>
                                </td>
                            </tr>
                            <!-- Назначение объекта -->
                            <tr>
                                <td class="fc">
                                    Назначение объекта :
                                </td>
                                <td>
                                    <input type="text" name="f1n53_3" class="td_editable"
                                           style="width:300px;" value="{document/fields/f1n53_3}"/>
                                </td>
                            </tr>
                            <!-- Площадь территории объекта (м2) -->
                            <tr>
                                <td class="fc">
                                    Площадь территории объекта (м2) :
                                </td>
                                <td>
                                    <input type="text" name="f1n54" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n54}"/>
                                </td>
                            </tr>
                            <!-- Обстоятельства и причины, приведшие к ЧС (описание) -->
                            <tr>
                                <td class="fc">
                                    Обстоятельства и причины, приведшие к ЧС (описание) :
                                </td>
                                <td>
                                    <select size="1" name="f1n65" style="width:412px;" class="select_editable" autocomplete="off">
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="document/fields/f1n65 = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Человеческий фактор
                                        </option>
                                        <option value="2">
                                            <xsl:if test="document/fields/f1n65 = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - террористический акт
                                        </option>
                                        <option value="3">
                                            <xsl:if test="document/fields/f1n65 = '3'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - хулиганство
                                        </option>
                                        <option value="4">
                                            <xsl:if test="document/fields/f1n65 = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - халатность
                                        </option>
                                        <option value="5">
                                            <xsl:if test="document/fields/f1n65 = '5'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - состояние алкогольного опьянения
                                        </option>
                                        <option value="6">
                                            <xsl:if test="document/fields/f1n65 = '6'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - состояние наркотического, психотропного опьянения
                                        </option>
                                        <option value="7">
                                            <xsl:if test="document/fields/f1n65 = '7'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - несчастный случай
                                        </option>
                                        <option value="8">
                                            <xsl:if test="document/fields/f1n65 = '8'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - нарушение технологического процесса
                                        </option>
                                        <option value="9">
                                            <xsl:if test="document/fields/f1n65 = '9'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - поджог
                                        </option>
                                        <option value="10">
                                            <xsl:if test="document/fields/f1n65 = '10'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - кража
                                        </option>
                                        <option value="11">
                                            <xsl:if test="document/fields/f1n65 = '11'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - нарушение правил техники безопасности
                                        </option>
                                        <option value="12">
                                            <xsl:if test="document/fields/f1n65 = '12'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - превышение скорости движения транспорта
                                        </option>
                                        <option value="13">
                                            <xsl:if test="document/fields/f1n65 = '13'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - несоблюдение правил дорожного движения
                                        </option>
                                        <option value="14">
                                            <xsl:if test="document/fields/f1n65 = '14'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - несоблюдение правил перевозок на железнодорожном транспорте
                                        </option>
                                        <option value="15">
                                            <xsl:if test="document/fields/f1n65 = '15'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - несоблюдение правил навигации
                                        </option>
                                        <option value="16">
                                            <xsl:if test="document/fields/f1n65 = '16'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - несоблюдение правил полетов
                                        </option>
                                        <option value="17">
                                            <xsl:if test="document/fields/f1n65 = '17'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - несоблюдение правил перевозки опасных грузов
                                        </option>
                                        <option value="18">
                                            <xsl:if test="document/fields/f1n65 = '18'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - неправильная эксплуатация
                                        </option>
                                        <option value="19">
                                            <xsl:if test="document/fields/f1n65 = '19'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - неправильное хранение
                                        </option>
                                        <option value="20">
                                            <xsl:if test="document/fields/f1n65 = '20'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - несвоевременное выполнение технического осмотра
                                        </option>
                                        <option value="21">
                                            <xsl:if test="document/fields/f1n65 = '21'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - нарушение правил эксплуатации транспорта, машин, механизмов
                                        </option>
                                        <option value="22">
                                            <xsl:if test="document/fields/f1n65 = '22'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - прочее
                                        </option>
                                        <option value="23">
                                            <xsl:if test="document/fields/f1n65 = '23'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            технический фактор
                                        </option>
                                        <option value="24">
                                            <xsl:if test="document/fields/f1n65 = '24'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - замыкание
                                        </option>
                                        <option value="25">
                                            <xsl:if test="document/fields/f1n65 = '25'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - пожар
                                        </option>
                                        <option value="26">
                                            <xsl:if test="document/fields/f1n65 = '26'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - сбой
                                        </option>
                                        <option value="27">
                                            <xsl:if test="document/fields/f1n65 = '27'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - взрыв
                                        </option>
                                        <option value="28">
                                            <xsl:if test="document/fields/f1n65 = '28'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - неисправность транспортного средства
                                        </option>
                                        <option value="29">
                                            <xsl:if test="document/fields/f1n65 = '29'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - износ оборудования
                                        </option>
                                        <option value="30">
                                            <xsl:if test="document/fields/f1n65 = '30'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - неисправность оборудования транспортного средства
                                        </option>
                                        <option value="31">
                                            <xsl:if test="document/fields/f1n65 = '31'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - неисправность железнодорожного, автодорожного полотна
                                        </option>
                                        <option value="32">
                                            <xsl:if test="document/fields/f1n65 = '32'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - дефекты, допущенные при проектировании транспорта
                                        </option>
                                        <option value="33">
                                            <xsl:if test="document/fields/f1n65 = '33'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - прекращение эксплуатации транспортного средства
                                        </option>
                                        <option value="34">
                                            <xsl:if test="document/fields/f1n65 = '34'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - недостаточное количество питания, электроэнергии
                                        </option>
                                        <option value="35">
                                            <xsl:if test="document/fields/f1n65 = '35'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - ошибки, допущенные при монтаже
                                        </option>
                                        <option value="36">
                                            <xsl:if test="document/fields/f1n65 = '36'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - прочее
                                        </option>
                                        <option value="37">
                                            <xsl:if test="document/fields/f1n65 = '37'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            природный фактор
                                        </option>
                                        <option value="38">
                                            <xsl:if test="document/fields/f1n65 = '38'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - землетрясение
                                        </option>
                                        <option value="39">
                                            <xsl:if test="document/fields/f1n65 = '39'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - ураган
                                        </option>
                                        <option value="40">
                                            <xsl:if test="document/fields/f1n65 = '40'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - буря
                                        </option>
                                        <option value="41">
                                            <xsl:if test="document/fields/f1n65 = '41'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - шторм
                                        </option>
                                        <option value="42">
                                            <xsl:if test="document/fields/f1n65 = '42'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - наводнение
                                        </option>
                                        <option value="43">
                                            <xsl:if test="document/fields/f1n65 = '43'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - оползень
                                        </option>
                                        <option value="44">
                                            <xsl:if test="document/fields/f1n65 = '44'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - сель
                                        </option>
                                        <option value="45">
                                            <xsl:if test="document/fields/f1n65 = '45'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - обвал
                                        </option>
                                        <option value="46">
                                            <xsl:if test="document/fields/f1n65 = '46'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - туман
                                        </option>
                                        <option value="47">
                                            <xsl:if test="document/fields/f1n65 = '47'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - снегопад
                                        </option>
                                        <option value="48">
                                            <xsl:if test="document/fields/f1n65 = '48'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - гололед
                                        </option>
                                        <option value="49">
                                            <xsl:if test="document/fields/f1n65 = '49'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - просадка (провал) земной поверхности
                                        </option>
                                        <option value="50">
                                            <xsl:if test="document/fields/f1n65 = '50'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - мороз
                                        </option>
                                        <option value="51">
                                            <xsl:if test="document/fields/f1n65 = '51'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - лавина
                                        </option>
                                        <option value="52">
                                            <xsl:if test="document/fields/f1n65 = '52'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - метель
                                        </option>
                                        <option value="53">
                                            <xsl:if test="document/fields/f1n65 = '53'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - засуха
                                        </option>
                                        <option value="54">
                                            <xsl:if test="document/fields/f1n65 = '54'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - жара
                                        </option>
                                        <option value="55">
                                            <xsl:if test="document/fields/f1n65 = '55'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - гроза
                                        </option>
                                        <option value="56">
                                            <xsl:if test="document/fields/f1n65 = '56'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - град
                                        </option>
                                        <option value="57">
                                            <xsl:if test="document/fields/f1n65 = '57'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - молния
                                        </option>
                                        <option value="58">
                                            <xsl:if test="document/fields/f1n65 = '58'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            - прочее
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <!-- Количество транспорта, попавшего в аварию -->
                            <tr>
                                <td class="fc">
                                    Количество транспорта, попавшего в аварию :
                                </td>
                                <td>
                                    <input type="text" name="f1n66" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n66}"/>
                                </td>
                            </tr>
                            <!-- Скорость движения транспортных средств -->
                            <tr>
                                <td class="fc">
                                    Скорость движения транспортных средств :
                                </td>
                                <td>
                                    <input type="text" name="f1n67" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n67}"/>
                                </td>
                            </tr>
                            <!-- Количество объектов попавших в зону ЧС -->
                            <tr>
                                <td class="fc">
                                    Количество объектов попавших в зону ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n69" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n69}"/>
                                </td>
                            </tr>
                            <!--населенных пунктов -->
                            <tr>
                                <td class="fc">
                                    населенных пунктов (ед.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n69_2" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n69_2}"/>
                                </td>
                            </tr>
                            <!--водных акваторий (площадь, км) -->
                            <tr>
                                <td class="fc">
                                    водных акваторий (площадь, км) :
                                </td>
                                <td>
                                    <input type="text" name="f1n69_3" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n69_3}"/>
                                </td>
                            </tr>
                            <!-- дорог (км) -->
                            <tr>
                                <td class="fc">
                                    дорог (км) :
                                </td>
                                <td>
                                    <input type="text" name="f1n69_4" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n69_4}"/>
                                </td>
                            </tr>
                            <!-- ЛЭП (км) -->
                            <tr>
                                <td class="fc">
                                    ЛЭП (км) :
                                </td>
                                <td>
                                    <input type="text" name="f1n69_5" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n69_5}"/>
                                </td>
                            </tr>
                            <!-- Природные и климатические условия (описание) -->
                            <tr>
                                <td class="fc">
                                    Природные и климатические условия (описание) :
                                </td>
                                <td>
                                    <input type="text" name="f1n70"  class="td_editable"
                                           style="width:500px;" value="{document/fields/f1n70}"/>
                                </td>
                            </tr>
                            <!-- скорость ветра, м/с -->
                            <tr>
                                <td class="fc">
                                    скорость ветра, м/с :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_2" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n70_2}"/>
                                </td>
                            </tr>
                            <!-- направление ветра -->
                            <tr>
                                <td class="fc">
                                    направление ветра :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_3" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n70_3}"/>
                                </td>
                            </tr>
                            <!-- температура воздуха, С -->
                            <tr>
                                <td class="fc">
                                    температура воздуха, С :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_4" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n70_4}"/>
                                </td>
                            </tr>
                            <!-- атмосферное давление, р.с.-->
                            <tr>
                                <td class="fc">
                                    атмосферное давление, р.с. :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_5" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n70_5}"/>
                                </td>
                            </tr>
                            <!-- влажность воздуха-->
                            <tr>
                                <td class="fc">
                                    влажность воздуха :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_6" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n70_6}"/>
                                </td>
                            </tr>
                            <!-- количество осадков -->
                            <tr>
                                <td class="fc">
                                    количество осадков :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_7" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n70_7}"/>
                                </td>
                            </tr>
                            <!-- Наличие и характер разрушений, загрязнения окружающей среды (характеристики, описание) -->
                            <tr>
                                <td class="fc">
                                    Наличие и характер разрушений, загрязнения окружающей среды
                                    (характеристики, описание) :
                                </td>
                                <td>
                                    <textarea name="f1n71" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n71"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Площадь распространения ЧС, км -->
                            <tr>
                                <td class="fc">
                                    Площадь распространения ЧС, км :
                                </td>
                                <td>
                                    <input type="text" name="f1n72" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n72}"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-6">
                        <br/>
                        <table width="100%" border="0">
                            <!-- Описание происшедшего ЧС-->
                            <tr>
                                <td class="fc">
                                    Описание происшедшего ЧС :
                                </td>
                                <td>
                                    <textarea name="f1n73" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n73"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Условия, способствовавшие развитию происшествия -->
                            <tr>
                                <td class="fc">
                                    Условия, способствовавшие развитию происшествия :
                                </td>
                                <td>
                                    <textarea name="f1n74" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n74"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Обстоятельства возникновения происшествия -->
                            <tr>
                                <td class="fc">
                                    Обстоятельства возникновения происшествия :
                                </td>
                                <td>
                                    <textarea name="f1n75" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n75"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Особенности происшествия -->
                            <tr>
                                <td class="fc">
                                    Особенности происшествия :
                                </td>
                                <td>
                                    <textarea name="f1n76" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n76"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Анализ возможных причин возникновения ЧС -->
                            <tr>
                                <td class="fc">
                                    Анализ возможных причин возникновения ЧС :
                                </td>
                                <td>
                                    <textarea name="f1n77" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n77"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Принятые меры по обеспечению техники безопасности -->
                            <tr>
                                <td class="fc">
                                    Принятые меры по обеспечению техники безопасности :
                                </td>
                                <td>
                                    <textarea name="f1n78" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n78"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Условия, способствовавшие получению травм и гибели людей -->
                            <tr>
                                <td class="fc">
                                    Условия, способствовавшие получению травм и гибели людей :
                                </td>
                                <td>
                                    <textarea name="f1n79" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n79"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Выделение финансовых средств на мероприятия по ликвидации последствий ЧС из -->
                            <tr>
                                <td class="fc">
                                    Выделение финансовых средств на мероприятия по ликвидации последствий ЧС
                                    из :
                                </td>
                                <td>
                                    <textarea name="f1n80" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n80"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- О проведенных мероприятиях по предупреждению и снижению тяжести случившегося ЧС -->
                            <tr>
                                <td class="fc">
                                    О проведенных мероприятиях по предупреждению и снижению тяжести
                                    случившегося ЧС :
                                </td>
                                <td>
                                    <textarea name="f1n81" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n81"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Положительные стороны и недостатки при ликвидации ЧС -->
                            <tr>
                                <td class="fc">
                                    Положительные стороны и недостатки при ликвидации ЧС :
                                </td>
                                <td>
                                    <textarea name="f1n82" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n82"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Выводы, предложения, меры -->
                            <tr>
                                <td class="fc">
                                    Выводы, предложения, меры :
                                </td>

                                <td>
                                    <textarea name="f1n83" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n83"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Ответственный по заполнению (ФИО, должность, тел.) -->
                            <tr>
                                <td class="fc">
                                    Ответственный по заполнению (ФИО, должность, тел.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n84"  class="td_editable" style="width:500px;" value="{document/fields/f1n84}"/>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <!-- Скрытые поля -->
                    <input type="hidden" name="type" value="save"/>
                    <input type="hidden" name="id" value="{/request/@id}"/>
                    <input type="hidden" name="author" value="{document/fields/author/@attrval}"/>
                    <input type="hidden" name="doctype" value="{document/@doctype}"/>
                    <input type="hidden" name="key" value="{document/@docid}"/>
                    <input type="hidden" id="currentuserid" value="{@userid}"/>
                    <input type="hidden" id="localusername" value="{@username}"/>
                </form>
            </div>

        </section>
    </xsl:template>

</xsl:stylesheet>
