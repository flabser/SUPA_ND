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
                <script>
                    $(function(){
                    $("#tabs").tabs();
                    });
                </script>
                <xsl:if test="$editmode = 'edit'">
                    <script>
                        var _calendarLang = "<xsl:value-of select="/request/@lang"/>";
                        $(function() {
                        $('#f1n5, #f1n16, #f1n18').datepicker({
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
                        <a href="#tabs-2">Описание и порядок реагирования</a>
                    </li>
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-3">Характеристика объекта</a>
                    </li>
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-4">Характеристика ЧС</a>
                    </li>
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-5">Последствия ЧС</a>
                    </li>
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-6">Ликвидация ЧС</a>
                    </li>
                    <li class="ui-state-default ui-corner-top">
                        <a href="#tabs-7">Итоговая справка</a>
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
                            <!-- Наименование области -->
                            <tr>
                                <td class="fc">
                                    Наименование области :
                                </td>
                                <td>
                                    <select size="1" name="region" style="width:612px;" class="select_editable" autocomplete="off">
                                        <xsl:variable name="region" select="document/fields/region/@attrval"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/region/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/region"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/region/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$region = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </td>
                            </tr>
                            <!-- город республиканского значения  -->
                            <tr>
                                <td class="fc">
                                    Город республиканского значения :
                                </td>
                                <td>
                                    <select size="1" name="respcity" style="width:612px;" class="select_editable" autocomplete="off">
                                        <xsl:variable name="respcity" select="document/fields/respcity/@attrval"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/respcity/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/respcity"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/city/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$respcity = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </td>
                            </tr>
                            <!-- город областного значения  -->
                            <tr>
                                <td class="fc">
                                    Город областного значения :
                                </td>
                                <td>
                                    <select size="1" name="city" style="width:612px;" class="select_editable" autocomplete="off">
                                        <xsl:variable name="city" select="document/fields/respcity/@attrval"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/city/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/city"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/city/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$city = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </td>
                            </tr>
                            <!-- Район  -->
                            <tr>
                                <td class="fc">
                                    Район :
                                </td>
                                <td>
                                    <input type="text" name="district" class="td_editable"  style="width:500px;" value="{document/fields/district}"/>
                                </td>
                            </tr>
                            <!-- Сельский округ  -->
                            <tr>
                                <td class="fc">
                                    Сельский округ :
                                </td>
                                <td>
                                    <input type="text" name="villagedistrict" class="td_editable" style="width:500px;" value="{document/fields/villagedistrict}"/>
                                </td>
                            </tr>
                            <!-- Поселок  -->
                            <tr>
                                <td class="fc">
                                    Поселок :
                                </td>
                                <td>
                                    <input type="text" name="settlement" class="td_editable" style="width:500px;" value="{document/fields/settlement}"/>
                                </td>
                            </tr>
                            <!-- Село  -->
                            <tr>
                                <td class="fc">
                                    Село :
                                </td>
                                <td>
                                    <input type="text" name="village" class="td_editable"  style="width:500px;" value="{document/fields/village}"/>
                                </td>
                            </tr>
                            <!-- Аул  -->
                            <tr>
                                <td class="fc">
                                    Аул :
                                </td>
                                <td>
                                    <input type="text" name="aul" class="td_editable" style="width:500px;" value="{document/fields/aul}"/>
                                </td>
                            </tr>
                            <!-- Проспект  -->
                            <tr>
                                <td class="fc">
                                    Проспект :
                                </td>
                                <td>
                                    <input type="text" name="avenue" class="td_editable" style="width:500px;" value="{document/fields/avenue}"/>
                                </td>
                            </tr>
                            <!-- Улица   -->
                            <tr>
                                <td class="fc">
                                    Улица :
                                </td>
                                <td>
                                    <input type="text" name="street" class="td_editable" style="width:500px;" value="{document/fields/street}"/>
                                </td>
                            </tr>
                            <!-- Микрорайон   -->
                            <tr>
                                <td class="fc">
                                    Микрорайон :
                                </td>
                                <td>
                                    <input type="text" name="microdistrict" class="td_editable" style="width:500px;" value="{document/fields/microdistrict}"/>
                                </td>
                            </tr>
                            <!-- Переулок   -->
                            <tr>
                                <td class="fc">
                                    Переулок :
                                </td>
                                <td>
                                    <input type="text" name="lane" class="td_editable" style="width:500px;" value="{document/fields/lane}"/>
                                </td>
                            </tr>
                            <!-- дом   -->
                            <tr>
                                <td class="fc">
                                    Дом :
                                </td>
                                <td>
                                    <input type="text" name="house" class="td_editable" style="width:160px;" value="{document/fields/house}"/>
                                </td>
                            </tr>
                            <!-- Корпус   -->
                            <tr>
                                <td class="fc">
                                    Корпус :
                                </td>
                                <td>
                                    <input type="text" name="housing" class="td_editable" style="width:160px;" value="{document/fields/housing}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Участок автомобильной дороги (км) :
                                </td>
                                <td>
                                    <input type="text" name="roadstretch" class="td_editable" style="width:160px;" value="{document/fields/roadstretch}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Участок железной дороги (км) :
                                </td>
                                <td>
                                    <input type="text" name="railwaystretch" class="td_editable" style="width:160px;" value="{document/fields/railwaystretch}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Аэропорт  :
                                </td>
                                <td>
                                    <input type="text" name="airport" class="td_editable" style="width:160px;" value="{document/fields/airport}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Аэродром  :
                                </td>
                                <td>
                                    <input type="text" name="airdrome" class="td_editable" style="width:160px;" value="{document/fields/airdrome}"/>
                                </td>
                            </tr>
                            <!-- Источник информации -->
                            <tr>
                                <td class="fc">
                                    Источник информации :
                                </td>
                                <td>
                                    <select size="1" name="infosource" style="width:612px;" class="select_editable" autocomplete="off">
                                        <xsl:variable name="infosource" select="document/fields/infosource"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="$infosource = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            "Алтел"
                                        </option>
                                        <option value="2">
                                            <xsl:if test="$infosource = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            "Кар-Тел"
                                        </option>
                                        <option value="3">
                                            <xsl:if test="$infosource = '3'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            "Казпочта"
                                        </option>
                                        <option value="4">
                                            <xsl:if test="$infosource = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            "Ducat"
                                        </option>
                                        <option value="5">
                                            <xsl:if test="$infosource = '5'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            "GSM Казахстан"
                                        </option>
                                        <option value="6">
                                            <xsl:if test="$infosource = '6'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            "Katelco"
                                        </option>
                                        <option value="7">
                                            <xsl:if test="$infosource = '7'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            "KazTransCom"
                                        </option>
                                        <option value="1">
                                            <xsl:if test="$infosource = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            "Astel"
                                        </option>
                                        <option value="8">
                                            <xsl:if test="$infosource = '8'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            "Nursat"
                                        </option>
                                        <option value="9">
                                            <xsl:if test="$infosource = '9'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            "Transtelecom"
                                        </option>
                                        <option value="10">
                                            <xsl:if test="$infosource = '10'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            КНБ РК
                                        </option>
                                        <option value="11">
                                            <xsl:if test="$infosource = '11'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            МВД РК
                                        </option>
                                        <option value="12">
                                            <xsl:if test="$infosource = '12'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            МО РК
                                        </option>
                                        <option value="13">
                                            <xsl:if test="$infosource = '13'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            МИР РК
                                        </option>
                                        <option value="14">
                                            <xsl:if test="$infosource = '14'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            МСХ РК
                                        </option>
                                        <option value="15">
                                            <xsl:if test="$infosource = '15'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Гражданское население
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Реквизиты источника информации (ФИО, телефон, эл. почта)  :
                                </td>
                                <td>
                                    <input type="text" name="infosourcedetail" class="td_editable" style="width:160px;" value="{document/fields/infosourcedetail}"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2">
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
                                    <input type="text" name="f1n37_2" id="f1n37_2" class="td_editable" style="width:120px;"
                                           value="{document/fields/f1n37_2}"/>
                                </td>
                            </tr>
                            <!-- Время обнаружения  ЧС-->
                            <tr>
                                <td class="fc">
                                    обнаружения ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_3" id="f1n37_3" class="td_editable" style="width:120px;"
                                           value="{document/fields/f1n37_3}"/>
                                </td>
                            </tr>
                            <!-- Время сообщения о ЧС-->
                            <tr>
                                <td class="fc">
                                    сообщения о ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_4" id="f1n37_4" class="td_editable" style="width:120px;"
                                           value="{document/fields/f1n37_4}"/>
                                </td>
                            </tr>
                            <!-- Время выезда подразделений -->
                            <tr>
                                <td class="fc">
                                    Выезда подразделений :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_5" id="f1n37_5" class="td_editable" style="width:120px;"
                                           value="{document/fields/f1n37_5}"/>
                                </td>
                            </tr>
                            <!-- Время прибытия первых подразделений -->
                            <tr>
                                <td class="fc">
                                    Время прибытия первых подразделений :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_6" id="f1n37_6" class="td_editable" style="width:120px;"
                                           value="{document/fields/f1n37_6}"/>
                                </td>
                            </tr>
                            <!--Расстояние от места аварии до близлежащих населенных пунктов-->
                            <tr>
                                <td class="fc">
                                    Расстояние от места аварии до близлежащих населенных пунктов :
                                </td>
                                <td>
                                    <input type="text" name="f1n38" class="td_editable" style="width:120px;" value="{document/fields/f1n38}"/>
                                </td>
                            </tr>
                            <!--Время отключения связи-->
                            <tr>
                                <td class="fc">
                                    Время отключения связи :
                                </td>
                                <td>
                                    <input type="text" name="f1n39" class="td_editable"  style="width:120px;" value="{document/fields/f1n39}"/>
                                </td>
                            </tr>
                            <!--Время оповещения -->
                            <tr>
                                <td class="fc">
                                    Длительность отсутствия связи :
                                </td>
                                <td>
                                    <input type="text" name="f1n40" class="td_editable" style="width:120px;" value="{document/fields/f1n40}"/>
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
                                    Линии связи (каналы) :
                                </td>
                                <td>
                                    <select size="1" name="f2n20" style="width:412px;" class="select_editable" autocomplete="off">
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="document/fields/f2n20 = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Воздушные
                                        </option>
                                        <option value="2">
                                            <xsl:if test="document/fields/f2n20 = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Наземные
                                        </option>
                                        <option value="3">
                                            <xsl:if test="document/fields/f2n20 = '3'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Подводные
                                        </option>
                                        <option value="4">
                                            <xsl:if test="document/fields/f2n20 = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Подземные
                                        </option>
                                        <option value="5">
                                            <xsl:if test="document/fields/f2n20 = '5'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Спутниковые
                                        </option>
                                        <option value="6">
                                            <xsl:if test="document/fields/f2n20 = '6'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Радио
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Объекты связи :
                                </td>
                                <td>
                                    <select size="1" name="f2n21" style="width:412px;" class="select_editable" autocomplete="off">
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="document/fields/f2n21 = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Центральная междугородняя станция
                                        </option>
                                        <option value="2">
                                            <xsl:if test="document/fields/f2n21 = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Центр технического обслуживания (местных сетей)
                                        </option>
                                        <option value="3">
                                            <xsl:if test="document/fields/f2n21 = '3'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Центр технического обслуживания (внутризоновых сетей)
                                        </option>
                                        <option value="4">
                                            <xsl:if test="document/fields/f2n21 = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Центр технического эксплуатации
                                        </option>
                                        <option value="5">
                                            <xsl:if test="document/fields/f2n21 = '5'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Районный узел телекоммуникаций (РУТ)
                                        </option>
                                        <option value="6">
                                            <xsl:if test="document/fields/f2n21 = '6'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Центр космической связи
                                        </option>
                                        <option value="7">
                                            <xsl:if test="document/fields/f2n21 = '7'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Узловая станция операторов сотовой связи
                                        </option>
                                        <option value="8">
                                            <xsl:if test="document/fields/f2n21 = '8'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Узлы связи железнодорожных сетей
                                        </option>
                                        <option value="9">
                                            <xsl:if test="document/fields/f2n21 = '9'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            Центральное отделение почтовой связи (почтовые отделения)
                                        </option>

                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Сфера функционирования :
                                </td>
                                <td>
                                    <select size="1" name="f2n22" style="width:412px;" class="select_editable" autocomplete="off">
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="document/fields/f2n22 = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            сети телекоммуникаций общего пользования (СТОП)
                                        </option>
                                        <option value="2">
                                            <xsl:if test="document/fields/f2n22 = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            телевидение
                                        </option>
                                        <option value="3">
                                            <xsl:if test="document/fields/f2n22 = '3'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            радио
                                        </option>
                                        <option value="4">
                                            <xsl:if test="document/fields/f2n22 = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            сотовая связь
                                        </option>
                                        <option value="5">
                                            <xsl:if test="document/fields/f2n22 = '5'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            почта
                                        </option>
                                        <option value="6">
                                            <xsl:if test="document/fields/f2n22 = '6'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            радиопередающий центр
                                        </option>
                                        <option value="7">
                                            <xsl:if test="document/fields/f2n22 = '7'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            центр управления космической связи
                                        </option>
                                        <option value="8">
                                            <xsl:if test="document/fields/f2n22 = '8'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            центр обработки данных
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Форма собственности :
                                </td>
                                <td>
                                    <input type="text" name="f2n23"  class="td_editable" style="width:120px;"
                                           value="{document/fields/f2n23}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Информация о владельце (ФИО, телефон, факс) :
                                </td>
                                <td>
                                    <textarea name="f2n24" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f2n24"/>
                                    </textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Юридические реквизиты :
                                </td>
                                <td>
                                    <textarea name="f2n25" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f2n25"/>
                                    </textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    год ввода в эксплуатацию объекта:
                                </td>
                                <td>
                                    <input type="text" name="f2n26" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n26}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Дата последнего технического обслуживания :
                                </td>
                                <td>
                                    <input type="text" name="f2n27" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n27}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Срок службы :
                                </td>
                                <td>
                                    <input type="text" name="f2n28" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n28}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Эксплуатационный ресурс :
                                </td>
                                <td>
                                    <input type="text" name="f2n29" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n29}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Наличие аварийно-спасательных служб и формирований :
                                </td>
                                <td>
                                    <input type="text" name="f2n30" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n30}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Наличие финансовых и материальных ресурсов для ликвидации аварии :
                                </td>
                                <td>
                                    <input type="text" name="f2n31" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n31}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Количество поврежденного оборудования :
                                </td>
                                <td>
                                    <input type="text" name="f2n32" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n32}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - телекоммуникационное оборудование :
                                </td>
                                <td>
                                    <input type="text" name="f2n32_2" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n32_2}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - приемо-передающие устройства :
                                </td>
                                <td>
                                    <input type="text" name="f2n32_3" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n32_3}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - антенно – фидерные устройства :
                                </td>
                                <td>
                                    <input type="text" name="f2n32_4" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n32_4}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - серверное оборудование :
                                </td>
                                <td>
                                    <input type="text" name="f2n32_5" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n32_5}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - сетевое оборудование :
                                </td>
                                <td>
                                    <input type="text" name="f2n32_6" class="td_editable"
                                           style="width:500px;" value="{document/fields/f2n32_6}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - системы хранения данных :
                                </td>
                                <td>
                                    <input type="text" name="f2n32_7" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n32_7}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - оборудование резервного и бесперебойного энергообеспечения :
                                </td>
                                <td>
                                    <input type="text" name="f2n32_8" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n32_8}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - склады и хранилища имущества :
                                </td>
                                <td>
                                    <input type="text" name="f2n32_9" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n32_9}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - гермозоны :
                                </td>
                                <td>
                                    <input type="text" name="f2n32_10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n32_10}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Уровень сети связи :
                                </td>
                                <td>
                                    <select size="1" name="f2n33" style="width:412px;" class="select_editable" autocomplete="off">
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="document/fields/f2n33 = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            международный
                                        </option>
                                        <option value="2">
                                            <xsl:if test="document/fields/f2n33 = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            республиканский
                                        </option>
                                        <option value="3">
                                            <xsl:if test="document/fields/f2n33 = '3'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            областной
                                        </option>
                                        <option value="4">
                                            <xsl:if test="document/fields/f2n33 = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            городской
                                        </option>
                                        <option value="5">
                                            <xsl:if test="document/fields/f2n33 = '5'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            районный
                                        </option>
                                        <option value="6">
                                            <xsl:if test="document/fields/f2n33 = '6'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            сельский округ
                                        </option>
                                        <option value="7">
                                            <xsl:if test="document/fields/f2n33 = '7'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            населенный пункт
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Частотный диапазон радиосети :
                                </td>
                                <td>
                                    <select size="1" name="f2n34" style="width:412px;" class="select_editable" autocomplete="off">
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <option value="1">
                                            <xsl:if test="document/fields/f2n34 = '1'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            24 МГц – 80 МГц
                                        </option>
                                        <option value="2">
                                            <xsl:if test="document/fields/f2n34 = '2'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            118 МГц – 138 МГц (авиа)
                                        </option>
                                        <option value="3">
                                            <xsl:if test="document/fields/f2n34 = '3'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            140 МГц – 174 МГц
                                        </option>
                                        <option value="4">
                                            <xsl:if test="document/fields/f2n34 = '4'">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                            </xsl:if>
                                            400 МГц – 470 МГц
                                        </option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-4">
                        <br/>
                        <table width="100%" border="0">
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
                        </table>
                    </div>
                    <div id="tabs-5">
                        <br/>
                        <table width="100%" border="0">
                            <!--Дата и время ликвидации ЧС-->
                            <tr>
                                <td class="fc">
                                    Общее количество людей находившихся в зоне ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f2n36" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n36}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Количество пострадавших :
                                </td>
                                <td>
                                    <input type="text" name="f2n37" class="td_editable" style="width:120px;" value="{document/fields/f2n37}"/>
                                    Детей : <input type="text" name="f2n37_2" class="td_editable" style="width:120px;" value="{document/fields/f2n37_2}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Количество объектов оставшихся без связи и телекоммуникаций :
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - населенных пунктов :
                                </td>
                                <td>
                                    <input type="text" name="f2n38_2" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n38_2}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - жилых объектов :
                                </td>
                                <td>
                                    <input type="text" name="f2n38_3" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n38_3}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - промышленных объектов :
                                </td>
                                <td>
                                    <input type="text" name="f2n38_4" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n38_4}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    - социально-культурных объектов :
                                </td>
                                <td>
                                    <input type="text" name="f2n38_5" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n38_5}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Количество абонентов, оставшихся без связи и телекоммуникаций :
                                </td>
                                <td>
                                    <input type="text" name="f2n39" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n39}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Протяженность порыва линий связи (км.) :
                                </td>
                                <td>
                                    <input type="text" name="f2n40" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n40}"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="fc">
                                    Материальный ущерб (предварительный), тенге :
                                </td>
                                <td>
                                    <input type="text" name="f2n41" class="td_editable"
                                           style="width:120px;" value="{document/fields/f2n41}"/>
                                </td>
                            </tr>

                        </table>
                    </div>
                    <div id="tabs-6">
                        <br/>
                        <table width="100%" border="0">
                            <!--Дата и время ликвидации ЧС-->
                            <tr>
                                <td class="fc">
                                    Дата и время ликвидации ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n43" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n43}"/>
                                </td>
                            </tr>
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
                        </table>
                    </div>
                    <div id="tabs-7">
                        <br/>
                        <table width="100%" border="0">
                            <!-- Описание происшедшего ЧС-->
                            <tr>
                                <td class="fc">
                                    Причины возникновения аварии сетей телекоммуникации :
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
                                    Принятые меры по обеспечению техники безопасности  :
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
                                    Временной показатель отсутствия связи :
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
                            <tr>
                                <td class="fc">
                                    Выполненные мероприятия по восстановлению работоспособности систем телекоммуникаций :
                                </td>
                                <td>
                                    <textarea name="f1n75_2" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="readonly">readonly</xsl:attribute>
                                            <xsl:attribute name="class">textarea_noteditable
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="$editmode = 'edit'">
                                            <xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
                                            <xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="document/fields/f1n75_2"/>
                                    </textarea>
                                </td>
                            </tr>
                            <!-- Особенности происшествия -->
                            <tr>
                                <td class="fc">
                                    Положительные стороны и недостатки при ликвидации ЧС :
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
                                    Выводы и предложения :
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
