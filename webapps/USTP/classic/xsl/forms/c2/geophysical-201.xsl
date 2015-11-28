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
                <style>
                    <![CDATA[
                    .count-section {
                        display: inline-block;
                        min-width: 600px;
                        vertical-align: top;
                        width:40%;
                    }
                    .humans-section {
                        display: inline-block;
                        min-width: 700px;
                        vertical-align: top;
                        width:58%;
                    }
                    .ib {
                        display: block;
                        margin-bottom: 1px;
                        vertical-align: top;
                    }
                    .ib .ib-label {
                        background: #f5f5f5;
                        display: inline-block;
                        padding: 1px;
                        width: 200px;
                    }
                    .ib .ib-col {
                        display: inline-block;
                        padding: 1px;
                        vertical-align: top;
                        width: 120px;
                    }]]>
                </style>
                <script type="text/javascript" src="classic/scripts/form.js"></script>
                <script type="text/javascript" src="classic/scripts/dialogs.js"></script>
                <script type="text/javascript" src="classic/scripts/human-controller.js"></script>
                <script>
                    <![CDATA[
                    $(function(){
                        $("#tabs").tabs();
                        $("#tabs-inner-2").tabs();
                        $('[data-action=save_and_close]').click(SaveFormJquery);
                    });]]>
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
                                <div class="control-label">Карточка</div>
                                <div class="controls">
                                    <input type="text" name="card_number"
                                           value="{//fields/card_number}"
                                           placeholder="Номер"/>
                                    <input type="date" name="card_date"
                                           value="{//fields/card_date}"
                                           placeholder="Дата"/>
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

                            <div id="tabs-inner-2">
                                <ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
                                    <li class="ui-state-default ui-corner-top">
                                        <a href="#tabs-inner-2-section-human">Люди</a>
                                    </li>
                                    <li class="ui-state-default ui-corner-top">
                                        <a href="#tabs-inner-2-section-animal">Домашние животные</a>
                                    </li>
                                    <li class="ui-state-default ui-corner-top">
                                        <a href="#tabs-inner-2-3">Разрушения</a>
                                    </li>
                                </ul>

                                <section id="tabs-inner-2-section-human">
                                    <section class="count-section">
                                        <div class="control-group">
                                            <span class="ibtl span5">Общее количество людей находившихся в зоне ЧС
                                            </span>
                                            <span class="span1">
                                                <input type="number" name="people_in_zone_emergency_count"
                                                       value="{//fields/people_in_zone_emergency_count}"/>
                                            </span>
                                        </div>

                                        <div class="ib">
                                            <div class="ib-label"></div>
                                            <span class="ib-col">Всего</span>
                                            <span class="ib-col">Детей</span>
                                            <span class="ib-col">сотрудников КЧС МВД РК</span>
                                        </div>

                                        <!-- пострадавших -->
                                        <div class="ib">
                                            <div class="ib-label">Пострадавших</div>
                                            <span class="ib-col">
                                                <input type="number" name="affected_count"
                                                       value="{//fields/affected_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="affected_children_count"
                                                       value="{//fields/affected_children_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="affected_personnel_k4s_mvd_rk_count"
                                                       value="{//fields/affected_personnel_k4s_mvd_rk_count}"/>
                                            </span>
                                        </div>

                                        <!-- погибших -->
                                        <div class="ib">
                                            <div class="ib-label">Погибших</div>
                                            <span class="ib-col">
                                                <input type="number" name="dead_count" value="{//fields/dead_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="dead_children_count"
                                                       value="{//fields/dead_children_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="dead_personnel_k4s_mvd_rk_count"
                                                       value="{//fields/dead_personnel_k4s_mvd_rk_count}"/>
                                            </span>
                                        </div>

                                        <!-- спасенных -->
                                        <div class="ib">
                                            <div class="ib-label">Спасенных</div>
                                            <span class="ib-col">
                                                <input type="number" name="rescued_count"
                                                       value="{//fields/rescued_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="rescued_children_count"
                                                       value="{//fields/rescued_children_count}"/>
                                            </span>
                                        </div>

                                        <!-- Количество людей пропавших без вести -->
                                        <div class="ib">
                                            <div class="ib-label">Пропавших без вести</div>
                                            <span class="ib-col">
                                                <input type="number" name="missing_count"
                                                       value="{//fields/missing_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="missing_children_count"
                                                       value="{//fields/missing_children_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="missing_personnel_k4s_mvd_rk_count"
                                                       value="{//fields/missing_personnel_k4s_mvd_rk_count}"/>
                                            </span>
                                        </div>

                                        <div class="control-group-separator"></div>

                                        <div class="ib">
                                            <div class="ib-label"></div>
                                            <span class="ib-col">Всего</span>
                                            <span class="ib-col">Доставлены в мед. учреждения</span>
                                            <span class="ib-col">сотрудников КЧС МВД РК</span>
                                        </div>
                                        <!-- Обнаруженно людей в ходе проведения поисково - спасательных работ (чел.) -->
                                        <div class="ib">
                                            <div class="ib-label">Обнаруженно людей в ходе проведения поисково -
                                                спасательных
                                                работ
                                            </div>
                                            <span class="ib-col">
                                                <input type="number" name="search_rescue_found_people_count"
                                                       value="{//fields/search_rescue_found_people_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="search_rescue_taken_medical_count"
                                                       value="{//fields/search_rescue_taken_medical_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="search_rescue_taken_medical_k4s_mvd_rk_count"
                                                       value="{//fields/search_rescue_taken_medical_k4s_mvd_rk_count}"/>
                                            </span>
                                        </div>

                                        <div class="control-group-separator"></div>

                                        <!-- Требующих эвакуации -->
                                        <div class="ib">
                                            <div class="ib-label"></div>
                                            <span class="ib-col">Всего</span>
                                            <span class="ib-col">Эвакуировано</span>
                                            <span class="ib-col">Эвак. детей</span>
                                        </div>
                                        <div class="ib">
                                            <div class="ib-label">Требующих эвакуации</div>
                                            <span class="ib-col">
                                                <input type="number" name="requiring_evacuation_people_count"
                                                       value="{//fields/requiring_evacuation_people_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="evacuees_count"
                                                       value="{//fields/evacuees_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="evacuees_count_children"
                                                       value="{//fields/evacuees_children_count}"/>
                                            </span>
                                        </div>

                                        <div class="control-group-separator"></div>

                                        <div class="ib">
                                            <div class="ib-label"></div>
                                            <span class="ib-col">Всего</span>
                                            <span class="ib-col">Детей</span>
                                        </div>

                                        <div class="ib">
                                            <div class="ib-label">Оказана первая мед. помощь</div>
                                            <span class="ib-col">
                                                <input type="number" name="first_aid_count"
                                                       value="{//fields/first_aid_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="first_aid_count_children"
                                                       value="{//fields/first_aid_children_count}"/>
                                            </span>
                                        </div>

                                        <div class="ib">
                                            <div class="ib-label">Госпитализировано людей</div>
                                            <span class="ib-col">
                                                <input type="number" name="hospitalized_count"
                                                       value="{//fields/hospitalized_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="hospitalized_children_count"
                                                       value="{//fields/hospitalized_children_count}"/>
                                            </span>
                                        </div>

                                        <div class="ib">
                                            <div class="ib-label">Оставшихся без крова</div>
                                            <span class="ib-col">
                                                <input type="number" name="homeless_count"
                                                       value="{//fields/homeless_count}"/>
                                            </span>
                                            <span class="ib-col">
                                                <input type="number" name="homeless_children_count"
                                                       value="{//fields/homeless_children_count}"/>
                                            </span>
                                        </div>
                                    </section>

                                    <section class="humans-section">
                                        <div class="control-group">
                                            <h4>Люди находившиеся в зоне ЧС</h4>
                                            <div>
                                                <table>
                                                    <tr>
                                                        <th>ФИО</th>
                                                        <th>Пол</th>
                                                        <th>Возраст</th>
                                                        <th></th>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="text" name="evacuees_fio"
                                                                   value="{//fields/evacuees_fio}" class="span5"/>
                                                        </td>
                                                        <td>
                                                            <select name="evacuees_sex">
                                                                <option value="m">муж</option>
                                                                <option value="w">жен</option>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input type="number" name="evacuees_age"
                                                                   value="{//fields/evacuees_age}" class="span1"/>
                                                        </td>
                                                        <td>
                                                            <button type="button" data-action="add_people"
                                                                    data-field="evacuees">+
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </section>

                                    <div class="control-group-separator"></div>

                                    <!-- Наименование организаций, юридический адрес, реквизиты, оказывавших первую помощь  -->
                                    <div class="control-group">
                                        <div class="control-label">Наименование организаций, юридический адрес,
                                            реквизиты,
                                            оказывавших первую помощь
                                        </div>
                                        <div class="controls">
                                            <input type="text" name="first_aider" value="{//fields/first_aider}"/>
                                        </div>
                                    </div>
                                </section>

                                <section id="tabs-inner-2-section-animal">

                                    <div class="control-group">
                                        <div class="control-label">Количество погибших домашних животных</div>
                                        <div class="controls">
                                            <input type="number" name="dead_domestic_animals_count"
                                                   value="{//fields/dead_domestic_animals_count}"/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <div class="control-label">В том числе</div>
                                        <div class="controls">
                                            <div class="list"></div>
                                            <select data-action="add-animal-count">
                                                <option value=""></option>
                                                <option value="крупного рогатого скота">крупного рогатого скота</option>
                                                <option value="мелкого рогатого скота">мелкого рогатого скота</option>
                                                <option value="лошадей">лошадей</option>
                                                <option value="птицы">птицы</option>
                                                <option value="водных организмов (гидробионтов)">водных организмов (гидробионтов)</option>
                                                <option value="прочие">прочие</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <div class="control-label">Количество эвакуированных домашних животных</div>
                                        <div class="controls">
                                            <input type="number" name="evacuees_domestic_animals_count"
                                                   value="{//fields/evacuees_domestic_animals_count}"/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <div class="control-label">В том числе</div>
                                        <div class="controls">
                                            <div class="list"></div>
                                            <select data-action="add-animal-count">
                                                <option value=""></option>
                                                <option value="крупного рогатого скота">крупного рогатого скота</option>
                                                <option value="мелкого рогатого скота">мелкого рогатого скота</option>
                                                <option value="лошадей">лошадей</option>
                                                <option value="птицы">птицы</option>
                                                <option value="водных организмов (гидробионтов)">водных организмов (гидробионтов)</option>
                                                <option value="прочие">прочие</option>
                                            </select>
                                        </div>
                                    </div>

                                </section>

                                <section id="tabs-inner-2-3">
                                    <div class="fieldset">
                                        <div class="legend">Характер разрушений</div>
                                        <div class="fieldset-container">
                                            <div class="control-group">
                                                <div class="control-label">Количество постов, пунктов (станций),
                                                    полигонов,
                                                    маршрутов наблюдения и оповещения
                                                </div>
                                                <div class="controls">
                                                    <input type="number" name="monitoring_warning_post_count"
                                                           value="{//fields/monitoring_warning_post_count}"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <div class="control-label">Центрально-диспетчерские пункты</div>
                                                <div class="controls">
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <th>наименование</th>
                                                            <th>место дислокации</th>
                                                            <th>назначение</th>
                                                            <th>зона ответственности (охват территории)</th>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                    <button type="button" class="btn">+Добавить</button>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <div class="control-label">Диспетчерские пункты</div>
                                                <div class="controls">
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <th>наименование</th>
                                                            <th>место дислокации</th>
                                                            <th>назначение</th>
                                                            <th>зона ответственности (охват территории)</th>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                    <button type="button" class="btn">+Добавить</button>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <div class="control-label">Станции наблюдения</div>
                                                <div class="controls">
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <th>наименование</th>
                                                            <th>место дислокации</th>
                                                            <th>назначение</th>
                                                            <th>зона ответственности (охват территории)</th>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                    <button type="button" class="btn">+Добавить</button>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <div class="control-label">посты наблюдения</div>
                                                <div class="controls">
                                                    круглогодичные
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <th>наименование</th>
                                                            <th>место дислокации</th>
                                                            <th>назначение</th>
                                                            <th>зона ответственности (охват территории)</th>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                    <button type="button" class="btn">+Добавить</button>

                                                    сезонные
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <th>наименование</th>
                                                            <th>место дислокации</th>
                                                            <th>назначение</th>
                                                            <th>зона ответственности (охват территории)</th>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                    <button type="button" class="btn">+Добавить</button>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <div class="control-label">линейные маршруты</div>
                                                <div class="controls">
                                                    водные
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <th>наименование</th>
                                                            <th>место дислокации</th>
                                                            <th>назначение</th>
                                                            <th>зона ответственности (охват территории)</th>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                    <button type="button" class="btn">+Добавить</button>

                                                    снегомерные
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <th>наименование</th>
                                                            <th>место дислокации</th>
                                                            <th>назначение</th>
                                                            <th>зона ответственности (охват территории)</th>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                    <button type="button" class="btn">+Добавить</button>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <div class="control-label">сейсмополигоны</div>
                                                <div class="controls">
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <th>наименование</th>
                                                            <th>место дислокации</th>
                                                            <th>назначение</th>
                                                            <th>зона ответственности (охват территории)</th>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                    <button type="button" class="btn">+Добавить</button>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <div class="control-label">сейсмостанции</div>
                                                <div class="controls">
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <th>наименование</th>
                                                            <th>место дислокации</th>
                                                            <th>назначение</th>
                                                            <th>зона ответственности (охват территории)</th>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                    <button type="button" class="btn">+Добавить</button>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <div class="control-label">Возможные зоны</div>
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
                                        </div>
                                    </div>
                                </section>
                            </div>
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
