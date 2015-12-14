<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../layout.xsl"/>

    <xsl:variable name="userid" select="/request/@userid"/>
    <xsl:variable name="hasCoordBlock" select="//fields/coordination/blocks"/>

    <xsl:template match="/request">
        <xsl:call-template name="layout">
            <xsl:with-param name="body_class" select="'proposal'"/>
            <xsl:with-param name="include">
                <script type="text/javascript" src="js/proposal-controller.js"></script>
                <script type="text/javascript" src="js/components/due-date.js"></script>
                <script>
                    <![CDATA[
                        $(function(){
                            new app.DueDate({
                                el: document.querySelector('.due-date'),
                                dueDateType: document.querySelector('[name=dueDateType]'),
                                dueDate: document.querySelector('[name=dueDate]')
                            });
                        });]]>
                </script>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="_content">
        <header class="content-header">
            <h1 class="header-title">
                <xsl:value-of select="//captions/title/@caption"/>
                <span class="coord-status-label label label-primary">
                    <xsl:value-of select="//fields/status"/>
                </span>
            </h1>
            <div class="content-actions">
                <xsl:apply-templates select="//actionbar"/>
            </div>
        </header>
        <section class="content-body">
            <div class="container-fluid">
                <form name="proposal">
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
                                    <button type="button" class="btn btn-select-assignees"
                                            data-action="select-assignees">
                                        <i class="fa fa-edit"></i>
                                    </button>
                                    <div data-input="assignee">
                                        <xsl:value-of select="//fields/assignee"/>
                                    </div>
                                    <div data-input="department_name">
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
                                <xsl:call-template name="due-date-template"/>
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

                    <input type="hidden" name="coordination_comment"/>
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
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="active">
                            <a href="#tab-coordination" role="tab" data-toggle="tab">
                                <xsl:value-of select="//captions/coordination/@caption"/>
                            </a>
                        </li>
                        <li>
                            <a href="#tab-history" role="tab" data-toggle="tab">
                                <xsl:value-of select="//captions/history/@caption"/>
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="tab-coordination">
                            <xsl:call-template name="coordination"/>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="tab-history">
                            <xsl:call-template name="history"/>
                        </div>
                    </div>
                </xsl:if>
            </div>
        </section>
    </xsl:template>

    <xsl:template name="due-date-template">
        <div class="due-date">
            <div class="due-date-text form-control"></div>
            <section class="due-date-edit">
                <select class="due-date-type">
                    <option value="month">
                        <xsl:value-of select="//captions/month/@caption"/>
                    </option>
                    <option value="quarter">
                        <xsl:value-of select="//captions/quarter/@caption"/>
                    </option>
                    <option value="half-year">
                        <xsl:value-of select="//captions/half_year/@caption"/>
                    </option>
                    <option value="plan-doc">
                        <xsl:value-of select="//captions/plan_doc/@caption"/>
                    </option>
                </select>
                <ul class="due-date-part"></ul>
                <div class="due-date-actions">
                    <button type="button" class="btn btn-sm btn-cancel">
                        <xsl:value-of select="//captions/cancel/@caption"/>
                    </button>
                    <button type="button" class="btn btn-sm btn-apply">
                        <xsl:value-of select="//captions/apply/@caption"/>
                    </button>
                </div>
            </section>
        </div>
    </xsl:template>

    <xsl:template name="coordination">
        <xsl:choose>
            <xsl:when test="$hasCoordBlock">
                <ul class="timeline timeline-coordination">
                    <xsl:for-each select="//fields/coordination/blocks//coordinators/entry">
                        <li>
                            <span>
                                <xsl:value-of select="employer/userid"/>
                            </span>
                            <span>iscurrent:<xsl:value-of select="iscurrent"/>
                            </span>
                            <span>decision:<xsl:value-of select="decision"/>
                            </span>
                            <span>comment:<xsl:value-of select="comment"/>
                            </span>
                            <span>decision_date:<xsl:value-of select="decisiondate"/>
                            </span>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                no coordination block
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="history">
        <ul class="timeline">
            <xsl:for-each select="//page[@id='proposal-events']/view_content//query/entry">
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
    </xsl:template>

</xsl:stylesheet>
