<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../layout.xsl"/>

    <xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>

    <xsl:variable name="userid" select="/request/@userid"/>

    <xsl:template match="/request">
        <xsl:call-template name="layout">
            <xsl:with-param name="include">
                <script type="text/javascript" src="js/proposal-controller.js"></script>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="_content">
        <header class="content-header">
            <h1 class="header-title">
                <xsl:value-of select="//captions/title/@caption"/>
            </h1>
            <div class="content-actions">
                <xsl:apply-templates select="//actionbar"/>
            </div>
        </header>
        <section class="content-body">
            <form action="Provider" name="proposal" class="proposal" method="post"
                  enctype="application/x-www-form-urlencoded">
                <fieldset class="fieldset">
                    <div class="form-group">
                        <div class="control-label">
                            <xsl:value-of select="//captions/description/@caption"/>
                        </div>
                        <div class="controls">
                            <textarea name="description">
                                <xsl:value-of select="//fields/description"/>
                            </textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="control-label">
                            <xsl:value-of select="//captions/assignee/@caption"/>
                        </div>
                        <div class="controls">
                            <span data-input="assignee" id="assigneetbl">
                                <xsl:value-of select="//fields/assignee"/>
                            </span>
                            <button type="button" class="btn select-assignees" data-action="select-assignees">
                                выбрать
                            </button>
                            <input type="hidden" name="assignee" value="{//fields/assignee/@attrval}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="control-label">
                            <xsl:value-of select="//captions/due_date/@caption"/>
                        </div>
                        <div class="controls">
                            <div class="due-date">
                                <select name="_dueDateType">
                                    <option value="month">
                                        <xsl:value-of select="//captions/month/@caption"/>
                                    </option>
                                    <option value="quarter">
                                        <xsl:value-of select="//captions/quarter/@caption"/>
                                    </option>
                                    <option value="half-year">
                                        <xsl:value-of select="//captions/half_year/@caption"/>
                                    </option>
                                    <option value="plan-link">
                                        <xsl:value-of select="//captions/plan_link/@caption"/>
                                    </option>
                                </select>
                                <select name="_dueDate"></select>
                                <div class="js-due-date-link">
                                    <span data-link="due-date-link"></span>
                                    <button type="button" class="btn due-date-link" data-action="due-date-link">
                                        выбрать
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="control-label">
                            <xsl:value-of select="//captions/send_mark/@caption"/>
                        </div>
                        <div class="controls">
                            <select name="sendMark">
                                <option value=""></option>
                                <option value="revision">Отправка на доработку</option>
                                <option value="exclusion">Исключение</option>
                                <option value="coordinated">Согласовано</option>
                            </select>
                        </div>
                    </div>
                </fieldset>

                <input type="hidden" name="dueDateType" value="{//fields/dueDateType}"/>
                <input type="hidden" name="dueDate" value="{//fields/dueDate}"/>

                <input type="hidden" name="type" value="save"/>
                <input type="hidden" name="id" value="{/request/@id}"/>
                <input type="hidden" name="doctype" value="{document/@doctype}"/>
                <input type="hidden" name="key" value="{document/@docid}"/>
                <input type="hidden" name="ddbid" value="{document/@id}"/>
                <input type="hidden" name="_action" value=""/>
            </form>
        </section>
    </xsl:template>

</xsl:stylesheet>
