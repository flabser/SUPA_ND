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
            <div class="container-fluid">
                <form name="proposal" class="proposal">
                    <div class="row">
                        <div class="form-group has-controls-label col-md-5">
                            <div class="control-label-icon">
                                <i class="fa fa-user"></i>
                            </div>
                            <div class="controls">
                                <label class="controls-label">
                                    <xsl:value-of select="//captions/assignee/@caption"/>
                                </label>
                                <div class="form-control">
                                    <button type="button" class="btn btn-select-assignees pull-right"
                                            data-action="select-assignees">
                                        <i class="fa fa-edit"></i>
                                    </button>
                                    <div data-input="assignee" id="assigneetbl">
                                        <xsl:value-of select="//fields/assignee"/>
                                    </div>
                                    <div data-input="department_name" id="department_nametbl">
                                        <xsl:value-of select="//fields/department"/>
                                    </div>
                                </div>
                                <input type="hidden" name="assignee" value="{//fields/assignee/@attrval}"/>
                                <input type="hidden" name="department" value="{//fields/department/@attrval}"/>
                            </div>
                        </div>
                        <div class="form-group has-controls-label col-md-7">
                            <div class="control-label-icon">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <div class="controls">
                                <label class="controls-label">
                                    <xsl:value-of select="//captions/due_date/@caption"/>
                                </label>
                                <div class="due-date">
                                    <select name="_dueDateType" class="form-control">
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
                                    <select name="_dueDate" class="form-control"></select>
                                    <div class="js-due-date-link">
                                        <span data-link="due-date-link"></span>
                                        <button type="button" class="btn due-date-link"
                                                data-action="due-date-link">
                                            выбрать
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group form-group-last has-controls-label">
                            <div class="control-label-icon">
                                <i class="fa fa-file-text-o"></i>
                            </div>
                            <div class="controls">
                                <label class="controls-label">
                                    <xsl:value-of select="//captions/description/@caption"/>
                                </label>
                                <textarea name="description" class="form-control">
                                    <xsl:value-of select="//fields/description"/>
                                </textarea>
                            </div>
                        </div>
                    </div>

                    <input type="hidden" name="dueDateType" value="{//fields/dueDateType}"/>
                    <input type="hidden" name="dueDate" value="{//fields/dueDate}"/>

                    <input type="hidden" name="type" value="save"/>
                    <input type="hidden" name="id" value="{/request/@id}"/>
                    <input type="hidden" name="doctype" value="{document/@doctype}"/>
                    <input type="hidden" name="key" value="{document/@docid}"/>
                    <input type="hidden" name="ddbid" value="{document/@id}"/>
                    <input type="hidden" name="_action" value=""/>
                </form>
                <xsl:if test="//document/@status != 'new'">
                    <ul class="timeline">
                        <xsl:apply-templates select="//page[@id='proposal-events']/view_content//query"
                                             mode="proposal-events"/>
                        <li>
                            <i class="timeline-icon"></i>
                            <div class="timeline-event">
                                <xsl:value-of select="//fields/author"/>
                                <span class="timeline-user"></span>
                                <time pubdate="pubdate" class="timeline-time">
                                    <xsl:value-of select="//fields/created_at"/>
                                </time>
                            </div>
                        </li>
                    </ul>
                </xsl:if>
            </div>
        </section>
    </xsl:template>

    <xsl:template match="query" mode="proposal-events">
        <xsl:for-each select="entry">
            <xsl:sort select="position()" data-type="number" order="descending"/>
            <li>
                <span>
                    <xsl:value-of select="viewcontent/viewtext"/>
                </span>
                <span>
                    <xsl:value-of select="viewcontent/viewtext1"/>
                </span>
                <span>
                    <xsl:value-of select="viewcontent/viewtext2"/>
                </span>
                <span>
                    <xsl:value-of select="viewcontent/viewtext3"/>
                </span>
                <span>
                    <xsl:value-of select="viewcontent/viewtext4"/>
                </span>
                <span>
                    <xsl:value-of select="viewcontent/viewtext5"/>
                </span>
                <span>
                    <xsl:value-of select="viewcontent/viewtext6"/>
                </span>
                <span>
                    <xsl:value-of select="viewcontent/viewtext7"/>
                </span>
                <span>
                    <xsl:value-of select="viewcontent/viewnumber"/>
                </span>
                <span>
                    <xsl:value-of select="viewcontent/viewdate"/>
                </span>
            </li>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
