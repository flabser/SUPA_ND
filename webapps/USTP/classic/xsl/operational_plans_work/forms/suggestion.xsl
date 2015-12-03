<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../layout.xsl"/>

    <xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>

    <xsl:variable name="doctype" select="request/document/fields/title"/>
    <xsl:variable name="userid" select="/request/@userid"/>

    <xsl:template match="/request">
        <xsl:call-template name="layout">
            <xsl:with-param name="include">
                <script type="text/javascript" src="classic/scripts/oper_plans_work/suggestion-controller.js"></script>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="_content">
        <header class="form-header">
            <h1 class="header-title">
                <xsl:value-of select="//captions/title/@caption"/>
            </h1>
            <xsl:apply-templates select="//actionbar">
                <xsl:with-param name="fixed_top" select="''"/>
            </xsl:apply-templates>
        </header>
        <section class="form-content suggestion">
            <form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
                <div class="tab-content">
                    <div class="control-group">
                        <div class="control-label">
                            Мероприятия, пути и средства достижения цели
                        </div>
                        <div class="controls">
                            <textarea name="description">
                                <xsl:value-of select="description"/>
                            </textarea>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">
                            Ответственный исполнитель
                        </div>
                        <div class="controls">
                            <span data-input="assignees" id="assigneestbl">
                                <xsl:value-of select="assignees"/>
                            </span>
                            <button type="button" class="btn btn-link select-assignees" data-action="select-assignees">
                                выбрать
                            </button>
                            <input type="hidden" name="assignees" value="{//fields/assignees}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">Срок исполнения</div>
                        <div class="controls">
                            <div class="due-date">
                                <select name="dueDateType">
                                    <option value="month">Месяц</option>
                                    <option value="quarter">Квартал</option>
                                    <option value="half-year">Полугодие</option>
                                    <option value="link">По плановому документу</option>
                                </select>
                                <select name="dueDateMonth" multiple="true">
                                    <option value="1">1 - январь</option>
                                    <option value="2">2 - февраль</option>
                                    <option value="3">3 - март</option>
                                    <option value="4">4 - апрель</option>
                                    <option value="5">5 - май</option>
                                    <option value="6">6 - июнь</option>
                                    <option value="7">7 - июль</option>
                                    <option value="8">8 - август</option>
                                    <option value="9">9 - сентябрь</option>
                                    <option value="10">10 - октябрь</option>
                                    <option value="11">11 - ноябрь</option>
                                    <option value="12">12 - декабрь</option>
                                </select>
                                <select name="dueDateQuarter">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                </select>
                                <select name="dueDateHalfYear">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                </select>
                                <button type="button" class="btn btn-link due-date-link" data-action="due-date-link">
                                    выбрать
                                </button>
                                <input type="hidden" name="dueDateLink" value="{//fields/dueDateLink}"/>
                            </div>
                            <input type="hidden" name="_dueDateType" value="{//fields/dueDateType}"/>
                            <input type="hidden" name="_dueDate" value="{//fields/dueDate}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">

                        </div>
                    </div>
                </div>

                <input type="hidden" name="type" value="save"/>
                <input type="hidden" name="id" value="{/request/@id}"/>
                <input type="hidden" name="doctype" value="{document/@doctype}"/>
                <input type="hidden" name="key" value="{document/@docid}"/>
                <input type="hidden" name="ddbid" value="{document/@id}"/>
            </form>
        </section>
    </xsl:template>

</xsl:stylesheet>
