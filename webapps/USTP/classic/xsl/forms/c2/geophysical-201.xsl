<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../layout.xsl"/>

    <xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>

    <xsl:variable name="doctype" select="request/document/fields/title"/>
    <xsl:variable name="path" select="/request/@skin"/>
    <xsl:variable name="editmode" select="/request/document/@editmode"/>
    <xsl:variable name="status" select="/request/document/@status"/>
    <xsl:variable name="userid" select="/request/@userid"/>

    <xsl:template match="/request">
        <xsl:call-template name="layout">
            <xsl:with-param name="include">
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
        <xsl:variable name="filename" select="//fields/pdocrtfcontent"/>

        <header class="form-header">
            <h1 class="header-title">
                <xsl:value-of select="//fields/title"/>
                <div class="card-group pull-right">201</div>
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
                        <b class="text"><xsl:value-of select="//captions/author/@caption"/>:
                        </b>
                        <font class="text" style="padding-right:7px;">
                            <xsl:value-of select="//fields/author"/>
                        </font>
                    </span>
                </ul>
                <form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
                    <fieldset class="fieldset">

                        <div class="ui-tabs-panel" id="tabs-1">
                            <div class="control-group">
                                <div class="control-label">Номер карточки</div>
                                <div class="controls">
                                    <input type="text" name="card_number" value="{//fields/card_number}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Дата карточки</div>
                                <div class="controls">
                                    <input type="date" name="card_date" value="{//fields/card_date}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Код ЧС</div>
                                <div class="controls">
                                    <input type="number" name="emergency_code" value="{//fields/emergency_code}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Вид ЧС</div>
                                <div class="controls">
                                    <select name="emergency_type" autocomplete="off">
                                        <xsl:variable name="type" select="//fields/emergency_type"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/project/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/type"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/type/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$type = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Краткое описание происшествия</div>
                                <div class="controls">
                                    <textarea name="emergency_short_description" rows="3" autocomplete="off">
                                        <xsl:value-of select="//fields/emergency_short_description"/>
                                    </textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Дата возникновения ЧС</div>
                                <div class="controls">
                                    <input type="date" name="emergency_date" value="{//fields/emergency_date}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Наименование области</div>
                                <div class="controls">
                                    <select name="region" autocomplete="off">
                                        <xsl:variable name="region" select="//fields/region"/>
                                        <xsl:if test="$editmode ='edit'">
                                            <option value=" ">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                &#xA0;
                                            </option>
                                        </xsl:if>
                                        <xsl:if test="$editmode !='edit'">
                                            <xsl:attribute name="disabled"/>
                                            <xsl:attribute name="class">select_noteditable</xsl:attribute>
                                            <option value="{document/fields/project/@attrval}">
                                                <xsl:attribute name="selected">selected</xsl:attribute>
                                                <xsl:value-of select="document/fields/type"/>
                                            </option>
                                        </xsl:if>
                                        <xsl:for-each select="document/glossaries/type/query/entry">
                                            <option value="{@docid}">
                                                <xsl:if test="$region = @docid">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="viewcontent/viewtext1"/>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Город</div>
                                <div class="controls">
                                    <input type="text" name="city" value="{//fields/city}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Район</div>
                                <div class="controls">
                                    <input type="text" name="district" value="{//fields/district}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Сельский округ</div>
                                <div class="controls">
                                    <input type="text" name="village_district" value="{//fields/village_district}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Поселок</div>
                                <div class="controls">
                                    <input type="text" name="settlement" value="{//fields/settlement}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Село</div>
                                <div class="controls">
                                    <input type="text" name="village" value="{//fields/village}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Аул</div>
                                <div class="controls">
                                    <input type="text" name="aul" value="{//fields/aul}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Географические координаты</div>
                                <div class="controls">
                                    Азимут
                                    <input type="text" name="coordinates_az" value="{//fields/coordinates_az}"
                                           class="span2"/>
                                    Квадрат
                                    <input type="text" name="coordinates_kv" value="{//fields/coordinates_kv}"
                                           class="span2"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">Расстояние от видимых ориентиров</div>
                                <div class="controls">
                                    Ориентир
                                    <input type="text" name="visible_landmarks" value="{//fields/visible_landmarks}"/>
                                    Расстояние
                                    <input type="text" name="distance_from_visible_landmarks"
                                           value="{//fields/distance_from_visible_landmarks}"/>
                                    км
                                </div>
                            </div>
                        </div>
                        <div id="tabs-2">
                            <div class="control-group">
                                <div class="control-label">Общее количество людей находившихся в зоне ЧС</div>
                                <div class="controls">
                                    <input type="number" name="total_count_people_in_zone_emergency"
                                           value="{//fields/total_count_people_in_zone_emergency}"/>
                                </div>
                            </div>

                            <!-- пострадавших -->
                            <div class="control-group">
                                <div class="control-label">Количество пострадавших</div>
                                <div class="controls">
                                    <input type="number" name="affected_count" value="{//fields/affected_count}"/>
                                    <div class="control-group">
                                        ФИО
                                        <input type="text" name="affected_fio" value="{//fields/affected_fio}"/>
                                        Пол
                                        <input type="text" name="affected_sex" value="{//fields/affected_sex}"/>
                                        Возраст
                                        <input type="number" name="affected_age" value="{//fields/affected_age}"/>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">В том числе детей</div>
                                <div class="controls">
                                    <input type="number" name="affected_count_children" value="{//fields/affected_count_children}"/>
                                    <div class="control-group">
                                        ФИО
                                        <input type="text" name="affected_children_fio" value="{//fields/affected_children_fio}"/>
                                        Пол
                                        <input type="text" name="affected_children_sex" value="{//fields/affected_children_sex}"/>
                                        Возраст
                                        <input type="number" name="affected_children_age" value="{//fields/affected_children_age}"/>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">в том числе сотрудников КЧС МВД РК</div>
                                <div class="controls">
                                    <input type="number" name="affected_count_personnel_k4s_mvd_rk" value="{//fields/affected_count_personnel_k4s_mvd_rk}"/>
                                </div>
                            </div>

                            <!-- погибших -->
                            <div class="control-group">
                                <div class="control-label">Количество погибших</div>
                                <div class="controls">
                                    <input type="number" name="dead_count" value="{//fields/dead_count}"/>
                                    <div class="control-group">
                                        ФИО
                                        <input type="text" name="dead_fio" value="{//fields/dead_fio}"/>
                                        Пол
                                        <input type="text" name="dead_sex" value="{//fields/dead_sex}"/>
                                        Возраст
                                        <input type="number" name="dead_age" value="{//fields/dead_age}"/>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">В том числе детей</div>
                                <div class="controls">
                                    <input type="number" name="dead_count_children" value="{//fields/dead_count_children}"/>
                                    <div class="control-group">
                                        ФИО
                                        <input type="text" name="dead_children_fio" value="{//fields/dead_children_fio}"/>
                                        Пол
                                        <input type="text" name="dead_children_sex" value="{//fields/dead_children_sex}"/>
                                        Возраст
                                        <input type="number" name="dead_children_age" value="{//fields/dead_children_age}"/>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">в том числе сотрудников КЧС МВД РК</div>
                                <div class="controls">
                                    <input type="number" name="dead_count_personnel_k4s_mvd_rk" value="{//fields/dead_count_personnel_k4s_mvd_rk}"/>
                                </div>
                            </div>

                            <!-- спасенных -->
                            <div class="control-group">
                                <div class="control-label">Количество спасенных</div>
                                <div class="controls">
                                    <input type="number" name="rescued_count" value="{//fields/rescued_count}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="control-label">В том числе детей</div>
                                <div class="controls">
                                    <input type="number" name="rescued_children" value="{//fields/rescued_children}"/>
                                    <div class="control-group">
                                        ФИО
                                        <input type="text" name="rescued_children_fio" value="{//fields/rescued_children_fio}"/>
                                        Пол
                                        <input type="text" name="rescued_children_sex" value="{//fields/rescued_children_sex}"/>
                                        Возраст
                                        <input type="number" name="rescued_children_age" value="{//fields/rescued_children_age}"/>
                                    </div>
                                </div>
                            </div>

                            <!-- Количество людей пропавших без вести (чел.) -->
                            <div class="control-group">
                                <div class="control-label"></div>
                                <div class="controls"></div>
                            </div>
                            <div class="control-group">
                                <div class="control-label"></div>
                                <div class="controls"></div>
                            </div>
                            <div class="control-group">
                                <div class="control-label"></div>
                                <div class="controls"></div>
                            </div>

                            <br/>
                            <table width="100%" border="0">

                                <!-- Количество людей пропавших без вести (чел.) -->
                                <tr>
                                    <td class="fc">
                                        Количество пропавших без вести (чел.) :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n25" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n25}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n25_2" maxlength="10" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n25_2}"/>
                                        Пол :
                                        <input type="text" name="f1n25_3" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n25_3}"/>
                                        Возраст :
                                        <input type="text" name="f1n25_4" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n25_4}"/>
                                    </td>
                                </tr>
                                <!-- В том числе детей (чел.) -->
                                <tr>
                                    <td class="fc">
                                        В том числе детей (чел.) :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n25_5" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n25_5}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n25_6" maxlength="10" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n25_6}"/>
                                        Пол :
                                        <input type="text" name="f1n25_7" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n25_7}"/>
                                        Возраст :
                                        <input type="text" name="f1n25_8" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n25_8}"/>
                                    </td>
                                </tr>
                                <!-- Количество спасенных (чел.) -->
                                <tr>
                                    <td class="fc">
                                        Количество спасенных (чел.) :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n26" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n26}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n26_2" maxlength="10" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n26_2}"/>
                                        Пол :
                                        <input type="text" name="f1n26_3" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n26_3}"/>
                                        Возраст :
                                        <input type="text" name="f1n26_4" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n26_4}"/>
                                    </td>
                                </tr>
                                <!-- В том числе детей (чел.) -->
                                <tr>
                                    <td class="fc">
                                        В том числе детей (чел.) :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n26_5" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n26_5}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n26_6" maxlength="10" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n26_6}"/>
                                        Пол :
                                        <input type="text" name="f1n26_7" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n26_7}"/>
                                        Возраст :
                                        <input type="text" name="f1n26_8" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n26_8}"/>
                                    </td>
                                </tr>
                                <!-- Обнаруженно людей в ходе проведения поисково - спасательных работ -->
                                <tr>
                                    <td class="fc">
                                        Обнаруженно людей в ходе проведения поисково - спасательных работ :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n27" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n27}"/>
                                    </td>
                                </tr>
                                <!-- Спасены и доставлены в мед. учреждения -->
                                <tr>
                                    <td class="fc">
                                        Спасены и доставлены в мед. учреждения :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n27_2" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n27_2}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n27_3" maxlength="10" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n27_3}"/>
                                        Пол :
                                        <input type="text" name="f1n27_4" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n27_4}"/>
                                        Возраст :
                                        <input type="text" name="f1n27_5" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n27_5}"/>
                                    </td>
                                </tr>
                                <!-- Общее количество людей требующих эвакуации (чел.) -->
                                <tr>
                                    <td class="fc">
                                        Общее количество людей требующих эвакуации :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n28" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n28}"/>
                                    </td>
                                </tr>
                                <!-- Количество эвакуированных  -->
                                <tr>
                                    <td class="fc">
                                        Количество эвакуированных :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n29" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n29}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n29_2" maxlength="10" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n29_2}"/>
                                        Пол :
                                        <input type="text" name="f1n29_3" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n29_3}"/>
                                        Возраст :
                                        <input type="text" name="f1n29_4" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n29_4}"/>
                                    </td>
                                </tr>
                                <!-- В том числе детей (чел.) -->
                                <tr>
                                    <td class="fc">
                                        В том числе детей (чел.) :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n29_5" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n29_5}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n29_6" maxlength="10" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n29_6}"/>
                                        Пол :
                                        <input type="text" name="f1n29_7" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n29_7}"/>
                                        Возраст :
                                        <input type="text" name="f1n29_8" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n29_8}"/>
                                    </td>
                                </tr>
                                <!-- Оказана первая медицинская помощь  -->
                                <tr>
                                    <td class="fc">
                                        Оказана первая медицинская помощь :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n30" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n30}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n30_2" maxlength="10" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n30_2}"/>
                                        Пол :
                                        <input type="text" name="f1n30_3" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n30_3}"/>
                                        Возраст :
                                        <input type="text" name="f1n30_4" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n30_4}"/>
                                    </td>
                                </tr>
                                <!-- В том числе детей (чел.) -->
                                <tr>
                                    <td class="fc">
                                        В том числе детей (чел.) :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n30_5" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n30_5}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n30_6" maxlength="10" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n30_6}"/>
                                        Пол :
                                        <input type="text" name="f1n30_7" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n30_7}"/>
                                        Возраст :
                                        <input type="text" name="f1n30_8" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n30_8}"/>
                                    </td>
                                </tr>
                                <!-- Наименование организаций, юридический адрес, реквизиты, оказывавших первую помощь  -->
                                <tr>
                                    <td class="fc">
                                        Наименование организаций, юридический адрес, реквизиты, оказывавших
                                        первую помощь :
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
                                        <input type="text" name="f1n32" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n32}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n32_2" maxlength="10" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n32_2}"/>
                                        Пол :
                                        <input type="text" name="f1n32_3" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n32_3}"/>
                                        Возраст :
                                        <input type="text" name="f1n32_4" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n32_4}"/>
                                    </td>
                                </tr>
                                <!-- В том числе детей (чел.) -->
                                <tr>
                                    <td class="fc">
                                        В том числе детей (чел.) :
                                    </td>
                                    <td>
                                        <input type="text" name="f1n32_5" maxlength="10" class="td_editable"
                                               style="width:80px;" value="{document/fields/f1n32_5}"/>
                                    </td>
                                </tr>
                                <!-- ФИО, Пол, Возраст -->
                                <tr>
                                    <td class="fc">

                                    </td>
                                    <td>
                                        ФИО :
                                        <input type="text" name="f1n32_6" class="td_editable"
                                               style="width:200px; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n32_6}"/>
                                        Пол :
                                        <input type="text" name="f1n32_7" maxlength="10" class="td_editable"
                                               style="width:100px; ; margin-left:5px; margin-right:5px"
                                               value="{document/fields/f1n32_7}"/>
                                        Возраст :
                                        <input type="text" name="f1n32_8" maxlength="10" class="td_editable"
                                               style="width:60px; ; margin-left:5px; "
                                               value="{document/fields/f1n32_8}"/>
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
                    </fieldset>
                </form>
            </div>

        </section>
    </xsl:template>

</xsl:stylesheet>
