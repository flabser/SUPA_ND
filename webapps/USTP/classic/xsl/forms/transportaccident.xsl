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
                                   <input type="text" name="f1n1" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/f1n1}"/>
                                </td>
                            </tr>
                            <!-- Дата карточки -->
                            <tr>
                                <td class="fc">
                                    Дата карточки :
                                </td>
                                <td>
                                    <input type="text" name="carddate" id="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
                                </td>
                            </tr>
                            <!-- Код ЧС -->
                            <tr>
                                <td class="fc">
                                    Код ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n2" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/f1n2}"/>
                                </td>
                            </tr>
                            <!-- Вид  ЧС -->
                            <tr>
                                <td class="fc">
                                    Вид ЧС :
                                </td>
                                <td>
                                    <select size="1" name="f1n3" style="width:612px;"
                                            class="select_editable" autocomplete="off">
                                        <xsl:variable name="essubtype" select="document/fields/essubtype"/>
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
                                        <textarea name="f1n4" rows="3" tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
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
                                    <input type="text" name="f1n5" id="f1n5" maxlength="10" class="td_editable" style="width:100px;" value="{document/fields/f1n5}"/>
                                </td>
                            </tr>
                            <!-- Наименование области -->
                            <tr>
                                <td class="fc">
                                    Наименование области :
                                </td>
                                <td>
                                    <select size="1" name="region" style="width:612px;" class="select_editable" autocomplete="off">
                                        <xsl:variable name="region" select="document/fields/region"/>
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
                                        <xsl:variable name="respcity" select="document/fields/respcity"/>
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
                                        <xsl:variable name="city" select="document/fields/respcity"/>
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
                                                <input type="text" name="f1n7" class="td_editable" style="width:195px;" value="{document/fields/f1n7}"/>
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
                                    <input type="text" name="f1n8" class="td_editable" style="width:320px;"
                                           value="{document/fields/f1n8}"/>
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
                                    <select size="1" name="busstation" style="width:612px;"
                                            class="select_editable" autocomplete="off">
                                        <xsl:variable name="busstation"
                                                      select="document/fields/busstation"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/road/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/busstation"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/busstation/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$busstation = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </td>
                            </tr>
                            <!-- Железнодорожные пути -->
                            <tr>
                                <td class="fc">
                                    Железнодорожные пути :
                                </td>
                                <td>
                                    <select size="1" name="railways" style="width:612px;"
                                            class="select_editable" autocomplete="off">
                                        <xsl:variable name="railways" select="document/fields/railways"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/railways/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/railways"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/railways/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$railways = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </td>
                            </tr>
                            <!-- Аэровокзальный комплекс -->
                            <tr>
                                <td class="fc">
                                    Аэровокзальный комплекс :
                                </td>
                                <td>
                                    <select size="1" name="airterminal" style="width:612px;"
                                            class="select_editable" autocomplete="off">
                                        <xsl:variable name="airterminal"
                                                      select="document/fields/airterminal"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/airterminal/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/airterminal"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/airterminal/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$airterminal = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </td>
                            </tr>
                            <!-- Порты -->
                            <tr>
                                <td class="fc">
                                    Порты :
                                </td>
                                <td>
                                    <select size="1" name="seaport" style="width:612px;"
                                            class="select_editable" autocomplete="off">
                                        <xsl:variable name="seaport" select="document/fields/seaport"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/seaport/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/seaport"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/seaport/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$seaport = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </td>
                            </tr>
                            <!-- Маршрут передвижения   -->
                            <tr>
                                <td class="fc">
                                    Маршрут передвижения (направление, сообщение):
                                </td>
                                <td>
                                    <input type="text" name="f1n14" class="td_editable" style="width:500px;"
                                           value="{document/fields/f1n14}"/>
                                </td>
                            </tr>
                            <!-- Пункт направления (назначения)  -->
                            <tr>
                                <td class="fc">
                                    Пункт направления (назначения):
                                </td>
                                <td>
                                    <input type="text" name="f1n15" class="td_editable"
                                           style="width:500px; margin-right:5px"
                                           value="{document/fields/f1n15}"/>
                                    Отправления
                                    <br/>
                                    <input type="text" name="f1n15_2" class="td_editable"
                                           style="width:500px; margin-right:5px"
                                           value="{document/fields/f1n15_2}"/>
                                    Прибытия
                                </td>
                            </tr>
                            <!-- Дата отправления   -->
                            <tr>
                                <td class="fc">
                                    Дата отправления :
                                </td>
                                <td>
                                    <input type="text" name="f1n16" id="f1n16" class="td_editable"
                                           style="width:100px;" value="{document/fields/f1n16}"/>
                                </td>
                            </tr>
                            <!-- Время отправления   -->
                            <tr>
                                <td class="fc">
                                    Время отправления :
                                </td>
                                <td>
                                    <input type="text" name="f1n17" class="td_editable" style="width:100px;"
                                           value="{document/fields/f1n17}"/>
                                </td>
                            </tr>
                            <!-- Дата прибытия    -->
                            <tr>
                                <td class="fc">
                                    Дата прибытия :
                                </td>
                                <td>
                                    <input type="text" name="f1n18" id="f1n18" class="td_editable"
                                           style="width:100px;" value="{document/fields/f1n18}"/>
                                </td>
                            </tr>
                            <!-- Время прибытия    -->
                            <tr>
                                <td class="fc">
                                    Время прибытия :
                                </td>
                                <td>
                                    <input type="text" name="f1n19" class="td_editable" style="width:100px;"
                                           value="{document/fields/f1n19}"/>
                                </td>
                            </tr>
                            <!-- Задержка движения транспорта  -->
                            <tr>
                                <td class="fc">
                                    Задержка движения транспорта :
                                </td>
                                <td>
                                    <input type="text" name="f1n20" class="td_editable" style="width:100px;"
                                           value="{document/fields/f1n20}"/>
                                </td>
                            </tr>
                            <!-- Количество пассажиров  -->
                            <tr>
                                <td class="fc">
                                    Количество пассажиров (человек) :
                                </td>
                                <td>
                                    <input type="text" name="f1n21" class="td_editable"
                                           style="width:160px; margin-right:5px"
                                           value="{document/fields/f1n21}"/>
                                    Взрослых
                                    <br/>
                                    <input type="text" name="f1n21_2" class="td_editable"
                                           style="width:160px; margin-right:5px"
                                           value="{document/fields/f1n21_2}"/>
                                    Детей
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
                                    <input type="text" name="f1n22" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n22}"/>
                                </td>
                            </tr>
                            <!-- Количество пострадавших (чел.) -->
                            <tr>
                                <td class="fc">
                                    Количество пострадавших (чел.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n23" maxlength="10" class="td_editable"  style="width:120px; margin-right:5px" value="{document/fields/f1n23}"/>
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
                                                <input type="text" name="f1n23_3" maxlength="10" class="td_editable"
                                                       style="width:100px; margin-right:5px;"
                                                       value="{document/fields/f1n23_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n23_4" maxlength="10" class="td_editable"
                                                        style="width:60px;"
                                                        value="{document/fields/f1n23_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Количество Погибших (чел.) -->
                            <tr>
                                <td class="fc">
                                    Количество погибших (чел.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n24" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n24}"/>
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
                                                <input type="text" name="f1n24_2" maxlength="10" class="td_editable" style="width:250px;  margin-right:5px" value="{document/fields/f1n24_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n24_3" maxlength="10" class="td_editable"
                                                       style="width:100px; margin-right:5px;"
                                                       value="{document/fields/f1n24_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n24_4" maxlength="10" class="td_editable"
                                                       style="width:60px; ; margin-left:5px; "
                                                       value="{document/fields/f1n24_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Количество людей пропавших без вести (чел.) -->
                            <tr>
                                <td class="fc">
                                    Количество пропавших без вести (чел.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n25" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n25}"/>
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
                                                <input type="text" name="f1n25_2" maxlength="10" class="td_editable"
                                                       style="width:250px;  margin-right:5px"
                                                       value="{document/fields/f1n25_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n25_3" maxlength="10" class="td_editable"
                                                       style="width:100px; margin-right:5px;"
                                                       value="{document/fields/f1n25_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n25_4" maxlength="10" class="td_editable"
                                                       style="width:60px; ; margin-left:5px; "
                                                       value="{document/fields/f1n25_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <!-- Количество спасенных (чел.) -->
                            <tr>
                                <td class="fc">
                                    Количество спасенных (чел.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n26" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n26}"/>
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
                                                <input type="text" name="f1n26_2" maxlength="10" class="td_editable"
                                                       style="width:250px;  margin-right:5px"
                                                       value="{document/fields/f1n26_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n26_3" maxlength="10" class="td_editable"
                                                       style="width:100px; margin-right:5px;"
                                                       value="{document/fields/f1n26_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n26_4" maxlength="10" class="td_editable"
                                                       style="width:60px; ; margin-left:5px; "
                                                       value="{document/fields/f1n26_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <!-- Обнаруженно людей в ходе проведения поисково - спасательных работ -->
                            <tr>
                                <td class="fc">
                                    Обнаруженно людей в ходе проведения поисково - спасательных работ :
                                </td>
                                <td>
                                    <input type="text" name="f1n27" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n27}"/>
                                </td>
                            </tr>
                            <!-- Спасены и доставлены в мед. учреждения -->
                            <tr>
                                <td class="fc">
                                    Спасены и доставлены в мед. учреждения :
                                </td>
                                <td>
                                    <input type="text" name="f1n27_2" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n27_2}"/>
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
                                                <input type="text" name="f1n27_3" maxlength="10" class="td_editable"
                                                       style="width:250px;  margin-right:5px"
                                                       value="{document/fields/f1n27_3}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n27_4" maxlength="10" class="td_editable"
                                                       style="width:100px; margin-right:5px;"
                                                       value="{document/fields/f1n27_4}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n27_5" maxlength="10" class="td_editable"
                                                       style="width:60px; ; margin-left:5px; "
                                                       value="{document/fields/f1n27_5}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Общее количество людей требующих эвакуации (чел.) -->
                            <tr>
                                <td class="fc">
                                    Общее количество людей требующих эвакуации :
                                </td>
                                <td>
                                    <input type="text" name="f1n28" maxlength="10" class="td_editable"
                                           style="width:120px;" value="{document/fields/f1n28}"/>
                                </td>
                            </tr>
                            <!-- Количество эвакуированных  -->
                            <tr>
                                <td class="fc">
                                    Количество эвакуированных :
                                </td>
                                <td>
                                    <input type="text" name="f1n29" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n29}"/>
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
                                                <input type="text" name="f1n29_2" maxlength="10" class="td_editable"
                                                       style="width:250px;  margin-right:5px"
                                                       value="{document/fields/f1n29_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n29_3" maxlength="10" class="td_editable"
                                                       style="width:100px; margin-right:5px;"
                                                       value="{document/fields/f1n29_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n29_4" maxlength="10" class="td_editable"
                                                       style="width:60px; ; margin-left:5px; "
                                                       value="{document/fields/f1n29_4}"/>
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
                                    <input type="text" name="f1n30" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n30}"/>
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
                                                <input type="text" name="f1n30_2" maxlength="10" class="td_editable"
                                                       style="width:250px;  margin-right:5px"
                                                       value="{document/fields/f1n30_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n30_3" maxlength="10" class="td_editable"
                                                       style="width:100px; margin-right:5px;"
                                                       value="{document/fields/f1n30_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n30_4" maxlength="10" class="td_editable"
                                                       style="width:60px; ; margin-left:5px; "
                                                       value="{document/fields/f1n30_4}"/>
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
                                    <input type="text" name="f1n31" maxlength="10" class="td_editable"
                                           style="width:600px;" value="{document/fields/f1n31}"/>
                                </td>
                            </tr>

                            <!-- Госпитализировано людей  111-->
                            <tr>
                                <td class="fc">
                                    Госпитализировано людей :
                                </td>
                                <td>
                                    <input type="text" name="f1n32" maxlength="10" class="td_editable" style="width:120px;" value="{document/fields/f1n32}"/>
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
                                                <input type="text" name="f1n32_2" maxlength="10" class="td_editable"
                                                       style="width:250px;  margin-right:5px"
                                                       value="{document/fields/f1n32_2}"/>
                                            </td>
                                            <td style="padding:0px">
                                                <input type="text" name="f1n32_3" maxlength="10" class="td_editable"
                                                       style="width:100px; margin-right:5px;"
                                                       value="{document/fields/f1n32_3}"/>
                                            </td>
                                            <td  style="padding:0px">
                                                <input type="text" name="f1n32_4" maxlength="10" class="td_editable"
                                                       style="width:60px; ; margin-left:5px; "
                                                       value="{document/fields/f1n32_4}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- Повреждено -->
                            <tr>
                                <td class="fc">
                                    Повреждено :
                                </td>
                                <td>
                                    <input type="text" name="f1n33" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n33}"/>
                                </td>
                            </tr>
                            <!-- Техники транспорт (ед.) -->
                            <tr>
                                <td class="fc">
                                    Техники транспорт (ед.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n33_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n33_2}"/>
                                </td>
                            </tr>
                            <!-- Уничтожено -->
                            <tr>
                                <td class="fc">
                                    Уничтожено :
                                </td>
                                <td>
                                    <input type="text" name="f1n34" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n34}"/>
                                </td>
                            </tr>
                            <!-- Техники транспорт (ед.) -->
                            <tr>
                                <td class="fc">
                                    Техники транспорт (ед.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n34_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n34_2}"/>
                                </td>
                            </tr>
                            <!-- Спасено материальных ценностей тенге всего -->
                            <tr>
                                <td class="fc">
                                    Спасено материальных ценностей тенге всего :
                                </td>
                                <td>
                                    <input type="text" name="f1n35" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n35}"/>
                                </td>
                            </tr>
                            <!-- Имущества -->
                            <tr>
                                <td class="fc">
                                    Имущества :
                                </td>
                                <td>
                                    <input type="text" name="f1n35_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n35_2}"/>
                                </td>
                            </tr>
                            <!-- Техники -->
                            <tr>
                                <td class="fc">
                                    Техники :
                                </td>
                                <td>
                                    <input type="text" name="f1n35_3" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n35_3}"/>
                                </td>
                            </tr>
                            <!-- Материальный ущерб (предварительный) тенге -->
                            <tr>
                                <td class="fc">
                                    Материальный ущерб (предварительный) тенге :
                                </td>
                                <td>
                                    <input type="text" name="f1n36" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n36}"/>
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
                                    <input type="text" name="f1n37_2" id="f1n37_2" maxlength="10"
                                           class="td_editable" style="width:80px;"
                                           value="{document/fields/f1n37_2}"/>
                                </td>
                            </tr>
                            <!-- Время обнаружения  ЧС-->
                            <tr>
                                <td class="fc">
                                    обнаружения ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_3" id="f1n37_3" maxlength="10"
                                           class="td_editable" style="width:80px;"
                                           value="{document/fields/f1n37_3}"/>
                                </td>
                            </tr>
                            <!-- Время сообщения о ЧС-->
                            <tr>
                                <td class="fc">
                                    сообщения о ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_4" id="f1n37_4" maxlength="10"
                                           class="td_editable" style="width:80px;"
                                           value="{document/fields/f1n37_4}"/>
                                </td>
                            </tr>
                            <!-- Время выезда подразделений -->
                            <tr>
                                <td class="fc">
                                    Выезда подразделений :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_5" id="f1n37_5" maxlength="10"
                                           class="td_editable" style="width:80px;"
                                           value="{document/fields/f1n37_5}"/>
                                </td>
                            </tr>
                            <!-- Время прибытия первых подразделений -->
                            <tr>
                                <td class="fc">
                                    Время прибытия первых подразделений :
                                </td>
                                <td>
                                    <input type="text" name="f1n37_6" id="f1n37_6" maxlength="10"
                                           class="td_editable" style="width:80px;"
                                           value="{document/fields/f1n37_6}"/>
                                </td>
                            </tr>
                            <!--Расстояние от места аварии до близлежащих населенных пунктов-->
                            <tr>
                                <td class="fc">
                                    Расстояние от места аварии до близлежащих населенных пунктов :
                                </td>
                                <td>
                                    <input type="text" name="f1n38" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n38}"/>
                                </td>
                            </tr>
                            <!--Охват населения своевременным оповещением об угрозе и возникновении ЧС (%)-->
                            <tr>
                                <td class="fc">
                                    Охват населения своевременным оповещением об угрозе и возникновении ЧС
                                    (%) :
                                </td>
                                <td>
                                    <input type="text" name="f1n39" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n39}"/>
                                </td>
                            </tr>
                            <!--Время оповещения -->
                            <tr>
                                <td class="fc">
                                    Время оповещения :
                                </td>
                                <td>
                                    <input type="text" name="f1n40" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n40}"/>
                                </td>
                            </tr>
                            <!-- Дежурный дежурно-диспетчерских служб области, города, района (ФИО, телефон, факс) -->
                            <tr>
                                <td class="fc">
                                    Дежурный дежурно-диспетчерских служб области, города, района (ФИО,
                                    телефон, факс) :
                                </td>
                                <td>
                                    <input type="text" name="f1n41" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n41}"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-4">
                        <br/>
                        <table width="100%" border="0">
                            <!-- Дата и время локализации ЧС -->
                            <tr>
                                <td class="fc">
                                    Дата и время локализации ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n42" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n42}"/>
                                </td>
                            </tr>
                            <!--Дата и время ликвидации ЧС-->
                            <tr>
                                <td class="fc">
                                    Дата и время ликвидации ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n43" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n43}"/>
                                </td>
                            </tr>
                            <!--Было задействовано в ликвидации-->
                            <tr>
                                <td class="fc">
                                    Было задействовано в ликвидации :
                                </td>
                                <td>
                                    <input type="text" name="f1n44" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n44}"/>
                                </td>
                            </tr>
                            <!-- в том числе -->
                            <tr>
                                <td class="fc">
                                    в том числе :
                                </td>
                                <td>
                                    <input type="text" name="f1n45" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n45}"/>
                                </td>
                            </tr>
                            <!-- Штаб ликвидации аварии -->
                            <tr>
                                <td class="fc">
                                    Штаб ликвидации аварии :
                                </td>
                                <td>
                                    <input type="text" name="f1n46" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n46}"/>
                                </td>
                            </tr>
                            <!-- Руководитель ликвидации ЧС (ФИО, должность, место работы) -->
                            <tr>
                                <td class="fc">
                                    Руководитель ликвидации ЧС (ФИО, должность, место работы) :
                                </td>
                                <td>
                                    <input type="text" name="f1n47" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n47}"/>
                                </td>
                            </tr>
                            <!-- Виновное лицо (ФИО, возраст) -->
                            <tr>
                                <td class="fc">
                                    Виновное лицо (ФИО, возраст) :
                                </td>
                                <td>
                                    <input type="text" name="f1n48" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n48}"/>
                                </td>
                            </tr>
                            <!-- Состояние виновного -->
                            <tr>
                                <td class="fc">
                                    Состояние виновного :
                                </td>
                                <td>
                                    <input type="text" name="f1n48_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n48_2}"/>
                                </td>
                            </tr>
                            <!-- Вид ответственности виновного -->
                            <tr>
                                <td class="fc">
                                    Вид ответственности виновного :
                                </td>
                                <td>
                                    <input type="text" name="f1n48_3" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n48_3}"/>
                                </td>
                            </tr>
                            <!-- Затраты на ликвидацию ЧС, тенге -->
                            <tr>
                                <td class="fc">
                                    Затраты на ликвидацию ЧС, тенге :
                                </td>
                                <td>
                                    <input type="text" name="f1n49" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n49}"/>
                                </td>
                            </tr>
                            <!-- Сведения о создании Правительственной комиссии по расследованию аварии -->
                            <tr>
                                <td class="fc">
                                    Сведения о создании Правительственной комиссии по расследованию аварии :
                                </td>
                                <td>
                                    <input type="text" name="f1n50" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n50}"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-5">
                        <br/>
                        <table width="100%" border="0">
                            <!-- Характеристика автомобильного транспорта -->
                            <tr>
                                <td class="fc">
                                    Характеристика автомобильного транспорта :
                                </td>
                                <td>
                                    <input type="text" name="f1n51" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n51}"/>
                                </td>
                            </tr>
                            <!-- Марка транспортного средства -->
                            <tr>
                                <td class="fc">
                                    Вид транспорта :
                                </td>
                                <td>
                                    <input type="text" name="f1n52" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n52}"/>
                                </td>
                            </tr>
                            <!-- Марка транспортного средства -->
                            <tr>
                                <td class="fc">
                                    Марка транспортного средства :
                                </td>
                                <td>
                                    <input type="text" name="f1n52_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n52_2}"/>
                                </td>
                            </tr>
                            <!--Государственный номер автомобиля-(ей) -->
                            <tr>
                                <td class="fc">
                                    Государственный номер автомобиля-(ей) :
                                </td>
                                <td>
                                    <input type="text" name="f1n52_3" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n52_3}"/>
                                </td>
                            </tr>
                            <!-- Характеристика железнодорожного транспорта -->
                            <tr>
                                <td class="fc">
                                    Характеристика железнодорожного транспорта :
                                </td>
                                <td>
                                    <input type="text" name="f1n53" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n53}"/>
                                </td>
                            </tr>
                            <!-- Виды поезда (-ов) -->
                            <tr>
                                <td class="fc">
                                    Виды поезда (-ов) :
                                </td>
                                <td>
                                    <input type="text" name="f1n53_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n53_2}"/>
                                </td>
                            </tr>
                            <!-- № поезда-(ов) -->
                            <tr>
                                <td class="fc">
                                    № поезда (-ов) :
                                </td>
                                <td>
                                    <input type="text" name="f1n53_3" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n53_3}"/>
                                </td>
                            </tr>
                            <!-- Характеристика морского транспорта -->
                            <tr>
                                <td class="fc">
                                    Характеристика морского транспорта :
                                </td>
                                <td>
                                    <input type="text" name="f1n54" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n54}"/>
                                </td>
                            </tr>
                            <!-- Вид транспорта -->
                            <tr>
                                <td class="fc">
                                    Вид транспорта :
                                </td>
                                <td>
                                    <input type="text" name="f1n54_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n54_2}"/>
                                </td>
                            </tr>
                            <!-- Модель транспортного средства -->
                            <tr>
                                <td class="fc">
                                    Модель транспортного средства :
                                </td>
                                <td>
                                    <input type="text" name="f1n54_3" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n54_3}"/>
                                </td>
                            </tr>
                            <!-- Характеристика авиатранспорта -->
                            <tr>
                                <td class="fc">
                                    Характеристика авиатранспорта :
                                </td>
                                <td>
                                    <input type="text" name="f1n55" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n55}"/>
                                </td>
                            </tr>
                            <!-- Вид авиатранспорта -->
                            <tr>
                                <td class="fc">
                                    Вид авиатранспорта :
                                </td>
                                <td>
                                    <input type="text" name="f1n55_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n55_2}"/>
                                </td>
                            </tr>
                            <!-- марка -->
                            <tr>
                                <td class="fc">
                                    марка :
                                </td>
                                <td>
                                    <input type="text" name="f1n55_3" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n55_3}"/>
                                </td>
                            </tr>
                            <!-- № рейса -->
                            <tr>
                                <td class="fc">
                                    № рейса :
                                </td>
                                <td>
                                    <input type="text" name="f1n55_4" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n55_4}"/>
                                </td>
                            </tr>
                            <!-- Общие характеристики -->
                            <tr>
                                <td class="fc">
                                    Общие характеристики :
                                </td>
                                <td>
                                </td>
                            </tr>
                            <!-- год выпуска транспортного средства -->
                            <tr>
                                <td class="fc">
                                    год выпуска транспортного средства :
                                </td>
                                <td>
                                    <input type="text" name="f1n56_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n56_2}"/>
                                </td>
                            </tr>
                            <!-- вместительность каждого транспортного средства -->
                            <tr>
                                <td class="fc">
                                    вместительность каждого транспортного средства :
                                </td>
                                <td>
                                    <input type="text" name="f1n56_3" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n56_3}"/>
                                </td>
                            </tr>
                            <!-- грузоподъемность каждого транспортного средства -->
                            <tr>
                                <td class="fc">
                                    грузоподъемность каждого транспортного средства :
                                </td>
                                <td>
                                    <input type="text" name="f1n56_4" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n56_4}"/>
                                </td>
                            </tr>
                            <!-- дата последнего технического обслуживания (освидетельствования, ремонта) -->
                            <tr>
                                <td class="fc">
                                    дата последнего технического обслуживания (освидетельствования, ремонта)
                                    :
                                </td>
                                <td>
                                    <input type="text" name="f1n56_5" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n56_5}"/>
                                </td>
                            </tr>
                            <!-- срок службы транспортного средства -->
                            <tr>
                                <td class="fc">
                                    срок службы транспортного средства :
                                </td>
                                <td>
                                    <input type="text" name="f1n56_6" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n56_6}"/>
                                </td>
                            </tr>
                            <!-- эксплуатационный ресурс -->
                            <tr>
                                <td class="fc">
                                    эксплуатационный ресурс :
                                </td>
                                <td>
                                    <input type="text" name="f1n56_7" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n56_7}"/>
                                </td>
                            </tr>
                            <!-- ресурс для списания -->
                            <tr>
                                <td class="fc">
                                    ресурс для списания :
                                </td>
                                <td>
                                    <input type="text" name="f1n56_8" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n56_8}"/>
                                </td>
                            </tr>
                            <!-- рабочий ресурс -->
                            <tr>
                                <td class="fc">
                                    рабочий ресурс :
                                </td>
                                <td>
                                    <input type="text" name="f1n56_9" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n56_9}"/>
                                </td>
                            </tr>
                            <!-- Форма собственности -->
                            <tr>
                                <td class="fc">
                                    Форма собственности :
                                </td>
                                <td>
                                    <input type="text" name="f1n57" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n57}"/>
                                </td>
                            </tr>
                            <!-- Принадлежность каждого транспорта -->
                            <tr>
                                <td class="fc">
                                    Принадлежность каждого транспорта :
                                </td>
                                <td>
                                    <input type="text" name="f1n58" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n58}"/>
                                </td>
                            </tr>
                            <!-- Информация о владельце (полный почтовый адрес, телефон, факс и e-mail организации, ФИО руководителей) -->
                            <tr>
                                <td class="fc">
                                    Информация о владельце (полный почтовый адрес, телефон, факс и e-mail
                                    организации, ФИО руководителей) :
                                </td>
                                <td>
                                    <input type="text" name="f1n59" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n59}"/>
                                </td>
                            </tr>
                            <!-- Наличие системы -->
                            <tr>
                                <td class="fc">
                                    Юридические реквизиты :
                                </td>
                                <td>
                                    <input type="text" name="f1n60" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n60}"/>
                                </td>
                            </tr>
                            <!-- Наличие системы -->
                            <tr>
                                <td class="fc">
                                    Наличие системы :
                                </td>
                                <td>
                                    <input type="text" name="f1n61" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n61}"/>
                                </td>
                            </tr>
                            <!-- Наличие аварийно-спасательных служб и формирований -->
                            <tr>
                                <td class="fc">
                                    Наличие аварийно-спасательных служб и формирований :
                                </td>
                                <td>
                                    <input type="text" name="f1n62" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n62}"/>
                                </td>
                            </tr>
                            <!-- Наличие финансовых и материальных ресурсов для ликвидации аварии -->
                            <tr>
                                <td class="fc">
                                    Наличие финансовых и материальных ресурсов для ликвидации аварии :
                                </td>
                                <td>
                                    <input type="text" name="f1n63" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n63}"/>
                                </td>
                            </tr>
                            <!-- Характер происшествия -->
                            <tr>
                                <td class="fc">
                                    Характер происшествия :
                                </td>
                                <td>
                                    <input type="text" name="f1n64" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n64}"/>
                                </td>
                            </tr>
                            <!-- Обстоятельства и причины, приведшие к ЧС (описание) -->
                            <tr>
                                <td class="fc">
                                    Обстоятельства и причины, приведшие к ЧС (описание) :
                                </td>
                                <td>
                                    <input type="text" name="f1n65" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n65}"/>
                                </td>
                            </tr>
                            <!-- Количество транспорта, попавшего в аварию -->
                            <tr>
                                <td class="fc">
                                    Количество транспорта, попавшего в аварию :
                                </td>
                                <td>
                                    <input type="text" name="f1n66" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n66}"/>
                                </td>
                            </tr>
                            <!-- Скорость движения транспортных средств -->
                            <tr>
                                <td class="fc">
                                    Скорость движения транспортных средств :
                                </td>
                                <td>
                                    <input type="text" name="f1n67" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n67}"/>
                                </td>
                            </tr>
                            <!-- Описание состояния транспортных магистралей, железнодорожного полотна, взлетной полосы и т.д. -->
                            <tr>
                                <td class="fc">
                                    Описание состояния транспортных магистралей, железнодорожного полотна,
                                    взлетной полосы и т.д. :
                                </td>
                                <td>
                                    <input type="text" name="f1n68" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n68}"/>
                                </td>
                            </tr>
                            <!-- Количество объектов попавших в зону ЧС -->
                            <tr>
                                <td class="fc">
                                    Количество объектов попавших в зону ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n69" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n69}"/>
                                </td>
                            </tr>
                            <!--населенных пунктов -->
                            <tr>
                                <td class="fc">
                                    населенных пунктов (ед.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n69_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n69_2}"/>
                                </td>
                            </tr>
                            <!--водных акваторий (площадь, км) -->
                            <tr>
                                <td class="fc">
                                    водных акваторий (площадь, км) :
                                </td>
                                <td>
                                    <input type="text" name="f1n69_3" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n69_3}"/>
                                </td>
                            </tr>
                            <!-- дорог (км) -->
                            <tr>
                                <td class="fc">
                                    дорог (км) :
                                </td>
                                <td>
                                    <input type="text" name="f1n69_4" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n69_4}"/>
                                </td>
                            </tr>
                            <!-- ЛЭП (км) -->
                            <tr>
                                <td class="fc">
                                    ЛЭП (км) :
                                </td>
                                <td>
                                    <input type="text" name="f1n69_5" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n69_5}"/>
                                </td>
                            </tr>
                            <!-- Природные и климатические условия (описание) -->
                            <tr>
                                <td class="fc">
                                    Природные и климатические условия (описание) :
                                </td>
                                <td>
                                    <input type="text" name="f1n70" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n70}"/>
                                </td>
                            </tr>
                            <!-- скорость ветра, м/с -->
                            <tr>
                                <td class="fc">
                                    скорость ветра, м/с :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_2" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n70_2}"/>
                                </td>
                            </tr>
                            <!-- направление ветра -->
                            <tr>
                                <td class="fc">
                                    направление ветра :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_3" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n70_3}"/>
                                </td>
                            </tr>
                            <!-- температура воздуха, С -->
                            <tr>
                                <td class="fc">
                                    температура воздуха, С :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_4" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n70_4}"/>
                                </td>
                            </tr>
                            <!-- атмосферное давление, р.с.-->
                            <tr>
                                <td class="fc">
                                    атмосферное давление, р.с. :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_5" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n70_5}"/>
                                </td>
                            </tr>
                            <!-- влажность воздуха-->
                            <tr>
                                <td class="fc">
                                    влажность воздуха :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_6" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n70_6}"/>
                                </td>
                            </tr>
                            <!-- количество осадков -->
                            <tr>
                                <td class="fc">
                                    количество осадков :
                                </td>
                                <td>
                                    <input type="text" name="f1n70_7" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n70_7}"/>
                                </td>
                            </tr>
                            <!-- Наличие и характер разрушений, загрязнения окружающей среды (характеристики, описание) -->
                            <tr>
                                <td class="fc">
                                    Наличие и характер разрушений, загрязнения окружающей среды
                                    (характеристики, описание) :
                                </td>
                                <td>
                                    <input type="text" name="f1n71" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n71}"/>
                                </td>
                            </tr>
                            <!-- Площадь распространения ЧС, км -->
                            <tr>
                                <td class="fc">
                                    Площадь распространения ЧС, км :
                                </td>
                                <td>
                                    <input type="text" name="f1n72" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n72}"/>
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
                                    <input type="text" name="f1n73" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n73}"/>
                                </td>
                            </tr>
                            <!-- Условия, способствовавшие развитию происшествия -->
                            <tr>
                                <td class="fc">
                                    Условия, способствовавшие развитию происшествия :
                                </td>
                                <td>
                                    <input type="text" name="f1n74" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n74}"/>
                                </td>
                            </tr>
                            <!-- Обстоятельства возникновения происшествия -->
                            <tr>
                                <td class="fc">
                                    Обстоятельства возникновения происшествия :
                                </td>
                                <td>
                                    <input type="text" name="f1n75" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n75}"/>
                                </td>
                            </tr>
                            <!-- Особенности происшествия -->
                            <tr>
                                <td class="fc">
                                    Особенности происшествия :
                                </td>
                                <td>
                                    <input type="text" name="f1n76" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n76}"/>
                                </td>
                            </tr>
                            <!-- Анализ возможных причин возникновения ЧС -->
                            <tr>
                                <td class="fc">
                                    Анализ возможных причин возникновения ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n77" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n77}"/>
                                </td>
                            </tr>
                            <!-- Принятые меры по обеспечению техники безопасности -->
                            <tr>
                                <td class="fc">
                                    Принятые меры по обеспечению техники безопасности :
                                </td>
                                <td>
                                    <input type="text" name="f1n78" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n78}"/>
                                </td>
                            </tr>
                            <!-- Условия, способствовавшие получению травм и гибели людей -->
                            <tr>
                                <td class="fc">
                                    Условия, способствовавшие получению травм и гибели людей :
                                </td>
                                <td>
                                    <input type="text" name="f1n79" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n79}"/>
                                </td>
                            </tr>
                            <!-- Выделение финансовых средств на мероприятия по ликвидации последствий ЧС из -->
                            <tr>
                                <td class="fc">
                                    Выделение финансовых средств на мероприятия по ликвидации последствий ЧС
                                    из :
                                </td>
                                <td>
                                    <input type="text" name="f1n80" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n80}"/>
                                </td>
                            </tr>
                            <!-- О проведенных мероприятиях по предупреждению и снижению тяжести случившегося ЧС -->
                            <tr>
                                <td class="fc">
                                    О проведенных мероприятиях по предупреждению и снижению тяжести
                                    случившегося ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n81" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n81}"/>
                                </td>
                            </tr>
                            <!-- Положительные стороны и недостатки при ликвидации ЧС -->
                            <tr>
                                <td class="fc">
                                    Положительные стороны и недостатки при ликвидации ЧС :
                                </td>
                                <td>
                                    <input type="text" name="f1n82" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n82}"/>
                                </td>
                            </tr>
                            <!-- Выводы, предложения, меры -->
                            <tr>
                                <td class="fc">
                                    Выводы, предложения, меры :
                                </td>
                                <td>
                                    <input type="text" name="f1n83" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n83}"/>
                                </td>
                            </tr>
                            <!-- Ответственный по заполнению (ФИО, должность, тел.) -->
                            <tr>
                                <td class="fc">
                                    Ответственный по заполнению (ФИО, должность, тел.) :
                                </td>
                                <td>
                                    <input type="text" name="f1n84" maxlength="10" class="td_editable"
                                           style="width:80px;" value="{document/fields/f1n84}"/>
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
