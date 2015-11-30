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
                <script type="text/javascript" src="classic/scripts/form.js"></script>
                <script type="text/javascript" src="classic/scripts/dialogs.js"></script>
                <script type="text/javascript" src="classic/scripts/human-controller.js"></script>
                <script>
                    <![CDATA[
                    $(function(){
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
            <ul class="nav nav-tabs" role="tablist">
                <li class="active">
                    <a href="#tabs-1" role="tab" data-toggle="tab">Информация</a>
                </li>
                <li>
                    <a href="#tabs-2" role="tab" data-toggle="tab">Последствия</a>
                </li>
                <li>
                    <a href="#tabs-3" role="tab" data-toggle="tab">Описание и реагирование</a>
                </li>
                <li>
                    <a href="#tabs-4" role="tab" data-toggle="tab">Ликвидация</a>
                </li>
                <li>
                    <a href="#tabs-5" role="tab" data-toggle="tab">Характеристика объекта</a>
                </li>
                <li>
                    <a href="#tabs-6" role="tab" data-toggle="tab">Итоговая справка</a>
                </li>
            </ul>
            <form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="tabs-1">
                        <div class="control-group">
                            <div class="control-label">Карточка</div>
                            <div class="controls">
                                <input type="text" name="card_number" value="{//fields/card_number}"
                                       placeholder="Номер"/>
                                <input type="date" name="card_date" value="{//fields/card_date}" placeholder="Дата"/>
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
                                <textarea name="short_description" rows="3" autocomplete="off">
                                    <xsl:value-of select="//fields/short_description"/>
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
                            <div class="control-label">Место возникновения</div>
                            <div class="controls">
                                <button type="button" class="btn">
                                    <i class="fa fa-edit"></i>
                                </button>
                            </div>
                        </div>
                        <!--<div class="control-group">
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
                        </div>-->

                        <div class="control-group-separator"></div>

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

                    <div role="tabpanel" class="tab-pane" id="tabs-2">

                        <ul class="nav nav-tabs" role="tablist">
                            <li class="active">
                                <a href="#tabs-inner-2-section-human" role="tab" data-toggle="tab">Люди</a>
                            </li>
                            <li>
                                <a href="#tabs-inner-2-section-animal" role="tab" data-toggle="tab">Домашние
                                    животные
                                </a>
                            </li>
                            <li>
                                <a href="#tabs-inner-2-3" role="tab" data-toggle="tab">Разрушения</a>
                            </li>
                        </ul>

                        <div class="tab-content">
                            <section role="tabpanel" class="tab-pane active" id="tabs-inner-2-section-human">

                                <div class="container-fluid">
                                    <div class="row">
                                        <section class="consequences-count-section col-md-4">
                                            <label class="consequences-total">
                                                <span>Общее количество людей находившихся в зоне ЧС</span>
                                                <input type="number" name="people_in_zone_emergency_count"
                                                       value="{//fields/people_in_zone_emergency_count}"/>
                                            </label>

                                            <div class="consequences-count-table">
                                                <div class="consequences-count-gr consequences-count-caption">
                                                    <div></div>
                                                    <span>Всего</span>
                                                    <span>Детей</span>
                                                    <span>сотрудников КЧС МВД РК</span>
                                                </div>

                                                <!-- пострадавших -->
                                                <div class="consequences-count-gr">
                                                    <div>Пострадавших</div>
                                                    <span>
                                                        <input type="number" name="affected_count"
                                                               value="{//fields/affected_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="affected_children_count"
                                                               value="{//fields/affected_children_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="affected_personnel_k4s_mvd_rk_count"
                                                               value="{//fields/affected_personnel_k4s_mvd_rk_count}"/>
                                                    </span>
                                                </div>

                                                <!-- погибших -->
                                                <div class="consequences-count-gr">
                                                    <div>Погибших</div>
                                                    <span>
                                                        <input type="number" name="dead_count"
                                                               value="{//fields/dead_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="dead_children_count"
                                                               value="{//fields/dead_children_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="dead_personnel_k4s_mvd_rk_count"
                                                               value="{//fields/dead_personnel_k4s_mvd_rk_count}"/>
                                                    </span>
                                                </div>

                                                <!-- спасенных -->
                                                <div class="consequences-count-gr">
                                                    <div>Спасенных</div>
                                                    <span>
                                                        <input type="number" name="rescued_count"
                                                               value="{//fields/rescued_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="rescued_children_count"
                                                               value="{//fields/rescued_children_count}"/>
                                                    </span>
                                                </div>

                                                <!-- Количество людей пропавших без вести -->
                                                <div class="consequences-count-gr">
                                                    <div>Пропавших без вести</div>
                                                    <span>
                                                        <input type="number" name="missing_count"
                                                               value="{//fields/missing_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="missing_children_count"
                                                               value="{//fields/missing_children_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="missing_personnel_k4s_mvd_rk_count"
                                                               value="{//fields/missing_personnel_k4s_mvd_rk_count}"/>
                                                    </span>
                                                </div>

                                                <div class="control-group-separator"></div>

                                                <div class="consequences-count-gr consequences-count-caption">
                                                    <div></div>
                                                    <span>Всего</span>
                                                    <span>Доставлены в мед. учреждения</span>
                                                    <span>сотрудников КЧС МВД РК</span>
                                                </div>
                                                <!-- Обнаруженно людей в ходе проведения поисково - спасательных работ (чел.) -->
                                                <div class="consequences-count-gr">
                                                    <div>Обнаруженно людей в ходе проведения поисково - спасательных
                                                        работ
                                                    </div>
                                                    <span>
                                                        <input type="number" name="search_rescue_found_people_count"
                                                               value="{//fields/search_rescue_found_people_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="search_rescue_taken_medical_count"
                                                               value="{//fields/search_rescue_taken_medical_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number"
                                                               name="search_rescue_taken_medical_k4s_mvd_rk_count"
                                                               value="{//fields/search_rescue_taken_medical_k4s_mvd_rk_count}"/>
                                                    </span>
                                                </div>

                                                <div class="control-group-separator"></div>

                                                <!-- Требующих эвакуации -->
                                                <div class="consequences-count-gr consequences-count-caption">
                                                    <div></div>
                                                    <span>Всего</span>
                                                    <span>Эвакуировано</span>
                                                    <span>Эвак. детей</span>
                                                </div>

                                                <div class="consequences-count-gr">
                                                    <div>Требующих эвакуации</div>
                                                    <span>
                                                        <input type="number" name="requiring_evacuation_people_count"
                                                               value="{//fields/requiring_evacuation_people_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="evacuees_count"
                                                               value="{//fields/evacuees_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="evacuees_count_children"
                                                               value="{//fields/evacuees_children_count}"/>
                                                    </span>
                                                </div>

                                                <div class="control-group-separator"></div>

                                                <div class="consequences-count-gr consequences-count-caption">
                                                    <div></div>
                                                    <span>Всего</span>
                                                    <span>Детей</span>
                                                </div>

                                                <div class="consequences-count-gr">
                                                    <div>Оказана первая мед. помощь</div>
                                                    <span>
                                                        <input type="number" name="first_aid_count"
                                                               value="{//fields/first_aid_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="first_aid_count_children"
                                                               value="{//fields/first_aid_children_count}"/>
                                                    </span>
                                                </div>

                                                <div class="consequences-count-gr">
                                                    <div>Госпитализировано людей</div>
                                                    <span>
                                                        <input type="number" name="hospitalized_count"
                                                               value="{//fields/hospitalized_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="hospitalized_children_count"
                                                               value="{//fields/hospitalized_children_count}"/>
                                                    </span>
                                                </div>

                                                <div class="consequences-count-gr">
                                                    <div>Оставшихся без крова</div>
                                                    <span>
                                                        <input type="number" name="homeless_count"
                                                               value="{//fields/homeless_count}"/>
                                                    </span>
                                                    <span>
                                                        <input type="number" name="homeless_children_count"
                                                               value="{//fields/homeless_children_count}"/>
                                                    </span>
                                                </div>
                                            </div>
                                        </section>

                                        <section class="consequences-humans-section  col-md-8">
                                            <div class="fieldset">
                                                <div class="legend">Люди находившиеся в зоне ЧС</div>
                                                <div class="humans-table-container">
                                                    <table class="humans-table">
                                                        <tr>
                                                            <th>ФИО</th>
                                                            <th>Пол</th>
                                                            <th>Возраст</th>
                                                            <th>Children</th>
                                                            <th>Affected</th>
                                                            <th>Dead</th>
                                                            <th>Rescued</th>
                                                            <th>Missing</th>
                                                            <th>FoundBySearchRescue</th>
                                                            <th>Evacuated</th>
                                                            <th>FirstAid</th>
                                                            <th>Homeless</th>
                                                            <th>pType</th>
                                                            <th></th>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="text" name="human_fio"
                                                                       value="{//fields/human_fio}" class="span3"/>
                                                            </td>
                                                            <td>
                                                                <select name="human_sex">
                                                                    <option value="m">м</option>
                                                                    <option value="w">ж</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                                <input type="number" name="human_age"
                                                                       value="{//fields/human_age}" class="span1"/>
                                                            </td>
                                                            <td>
                                                                <input type="checkbox" name="isChildren" value="1"/>
                                                            </td>
                                                            <td>
                                                                <input type="checkbox" name="isAffected" value="1"/>
                                                            </td>
                                                            <td>
                                                                <input type="checkbox" name="isDead" value="1"/>
                                                            </td>
                                                            <td>
                                                                <input type="checkbox" name="isRescued" value="1"/>
                                                            </td>
                                                            <td>
                                                                <input type="checkbox" name="isMissing" value="1"/>
                                                            </td>
                                                            <td>
                                                                <input type="checkbox" name="isFoundBySearchRescue"
                                                                       value="1"/>
                                                            </td>
                                                            <td>
                                                                <input type="checkbox" name="isEvacuated" value="1"/>
                                                            </td>
                                                            <td>
                                                                <input type="checkbox" name="isFirstAid" value="1"/>
                                                            </td>
                                                            <td>
                                                                <input type="checkbox" name="isHomeless" value="1"/>
                                                            </td>
                                                            <td>
                                                                <select name="personnelType">
                                                                    <option value=""></option>
                                                                    <option value="k4s_mvd_rk">k4s_mvd_rk</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                                <button type="button" class="btn"
                                                                        data-action="add_people"
                                                                        data-field="evacuees">+
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <div id="human-table"></div>
                                                </div>
                                            </div>
                                        </section>
                                    </div>
                                </div>

                                <div class="control-group-separator"></div>

                                <section class="first-aider-section">
                                    <div class="control-group fieldset">
                                        <div class="legend">Наименование организаций, юридический адрес,
                                            реквизиты,
                                            оказывавших первую помощь
                                        </div>
                                        <div class="table-container">
                                            <table class="humans-table">
                                                <tr>
                                                    <th>Наименование</th>
                                                    <th>address</th>
                                                    <th>Телефон</th>
                                                    <th>Реквизиты</th>
                                                    <th></th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <input type="text" name="first-aider-name"/>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="first-aider-address"/>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="first-aider-phone"/>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="first-aider-details"/>
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn"
                                                                data-action="add_first_aider"
                                                                data-field="evacuees">+
                                                        </button>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="first-aider-table"></div>
                                        </div>
                                    </div>
                                </section>
                            </section>

                            <section role="tabpanel" class="tab-pane" id="tabs-inner-2-section-animal">

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
                                            <option value="крупного рогатого скота">крупного рогатого скота
                                            </option>
                                            <option value="мелкого рогатого скота">мелкого рогатого скота
                                            </option>
                                            <option value="лошадей">лошадей</option>
                                            <option value="птицы">птицы</option>
                                            <option value="водных организмов (гидробионтов)">водных организмов
                                                (гидробионтов)
                                            </option>
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
                                            <option value="крупного рогатого скота">крупного рогатого скота
                                            </option>
                                            <option value="мелкого рогатого скота">мелкого рогатого скота
                                            </option>
                                            <option value="лошадей">лошадей</option>
                                            <option value="птицы">птицы</option>
                                            <option value="водных организмов (гидробионтов)">водных организмов
                                                (гидробионтов)
                                            </option>
                                            <option value="прочие">прочие</option>
                                        </select>
                                    </div>
                                </div>

                            </section>

                            <section role="tabpanel" class="tab-pane" id="tabs-inner-2-3">
                                <div class="fieldset">
                                    <div class="fieldset-container">
                                        <div>
                                            <span>Количество постов, пунктов (станций),
                                                полигонов,
                                                маршрутов наблюдения и оповещения
                                                <input type="number" name="monitoring_warning_post_count"
                                                       value="{//fields/monitoring_warning_post_count}"/>
                                            </span>
                                        </div>

                                        <div class="control-group-separator"></div>

                                        <style>
                                            .section-destruction,
                                            .section-potential-risk {
                                            display: inline-block;
                                            min-width: 600px;
                                            width: 48%;
                                            }
                                            .section-destruction th, .section-destruction td,
                                            .section-potential-risk th, .section-potential-risk td {
                                            border: 1px solid #f2f2f2;
                                            padding: 4px;
                                            }
                                        </style>

                                        <div class="section-destruction fieldset">
                                            <div class="legend">Разрушеные обьекты</div>
                                            <div class="fieldset-container">
                                                <table class="table table-bordered">
                                                    <tr>
                                                        <th>Тип</th>
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
                                                        <td></td>
                                                    </tr>
                                                </table>
                                                <button type="button" class="btn"
                                                        data-action="add_post_monitoring_warning">+Добавить
                                                </button>
                                            </div>
                                        </div>

                                        <div class="section-potential-risk fieldset">
                                            <div class="legend">Возможные зоны риска</div>
                                            <div class="fieldset-container">
                                                <table class="table table-bordered">
                                                    <tr>
                                                        <th>наименование</th>
                                                        <th>место дислокации</th>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                                <button type="button" class="btn" data-action="add_risk_zone">
                                                    +Добавить
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>

                    <div role="tabpanel" class="tab-pane" id="tabs-3">
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

                    <div role="tabpanel" class="tab-pane" id="tabs-4">
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

                    <div role="tabpanel" class="tab-pane" id="tabs-5">
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

                    <div role="tabpanel" class="tab-pane" id="tabs-6">
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
                </div>

                <!-- Скрытые поля -->
                <input type="hidden" name="type" value="save"/>
                <input type="hidden" name="id" value="{/request/@id}"/>
                <input type="hidden" name="author" value="{document/fields/author/@attrval}"/>
                <input type="hidden" name="doctype" value="{document/@doctype}"/>
                <input type="hidden" name="key" value="{document/@docid}"/>
                <input type="hidden" name="ddbid" value="{document/@id}"/>
                <input type="hidden" id="currentuserid" value="{@userid}"/>
                <input type="hidden" id="localusername" value="{@username}"/>
            </form>
        </section>
    </xsl:template>

</xsl:stylesheet>
