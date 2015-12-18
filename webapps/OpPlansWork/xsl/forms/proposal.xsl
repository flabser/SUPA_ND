<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../layout.xsl"/>

    <xsl:variable name="userid" select="/request/@userid"/>
    <xsl:variable name="hasCoordBlock" select="//fields/coordination/blocks"/>
    <xsl:variable name="canEdit" select="//action[@id = 'save']"/>

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
                <xsl:if test="//fields/status ne ''">
                    <span class="coord-status-label label label-primary">
                        <xsl:choose>
                            <xsl:when test="//fields/status eq 'draft'">
                                <xsl:value-of select="//captions/draft/@caption"/>
                            </xsl:when>
                            <xsl:when test="//fields/status eq 'coordination'">
                                <xsl:value-of select="//captions/coordination/@caption"/>
                            </xsl:when>
                            <xsl:when test="//fields/status eq 'revision'">
                                <xsl:value-of select="//captions/revision/@caption"/>
                            </xsl:when>
                            <xsl:when test="//fields/status eq 'reject'">
                                <xsl:value-of select="//captions/rejected/@caption"/>
                            </xsl:when>
                            <xsl:when test="//fields/status eq 'coordinated'">
                                <xsl:value-of select="//captions/coordinated/@caption"/>
                            </xsl:when>
                        </xsl:choose>
                    </span>
                </xsl:if>
            </h1>
            <div class="content-actions">
                <xsl:call-template name="actions"/>
            </div>
        </header>
        <section class="content-body">
            <div class="container-fluid">
                <form name="proposal">
                    <fieldset class="fieldset">
                        <xsl:if test="not($canEdit)">
                            <xsl:attribute name="disabled" select="'disabled'"/>
                        </xsl:if>
                        <div class="row">
                            <div class="form-group has-controls-label col-md-5">
                                <div class="control-label-icon">
                                    <i class="fa fa-user"></i>
                                </div>
                                <div class="controls">
                                    <label class="controls-label">
                                        <xsl:value-of select="//captions/assignee/@caption"/>
                                    </label>
                                    <div class="form-control" data-form-control="assignee">
                                        <button type="button" class="btn btn-assignees" data-action="select-assignees">
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
                                    <textarea name="description" class="form-control" data-form-control="description">
                                        <xsl:value-of select="//fields/description"/>
                                    </textarea>
                                </div>
                            </div>
                        </div>
                    </fieldset>

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
                            <div id="history"></div>
                        </div>
                    </div>
                </xsl:if>
            </div>
            <xsl:if test="//document/@status != 'new'">
                <footer class="about_created">
                    <span>
                        <xsl:value-of select="//captions/author/@caption"/>:
                    </span>
                    <span>
                        <xsl:value-of select="//fields/author"/>
                    </span>
                    <span>
                        <i class="fa fa-clock-o"></i>
                    </span>
                    <time pubdate="pubdate">
                        <xsl:value-of select="//fields/created_at"/>
                    </time>
                </footer>
            </xsl:if>
        </section>
    </xsl:template>

    <xsl:template name="due-date-template">
        <div class="due-date">
            <div class="due-date-text form-control" data-form-control="dueDate"></div>
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

    <xsl:template name="actions">
        <xsl:apply-templates select="//action[@id = 'close']"/>
        <xsl:if test="//action/@id = 'save'">
            <xsl:apply-templates select="//action[@id = 'save']"/>
        </xsl:if>
        <xsl:if test="//action/@id = 'coord_start'
                or //action/@id = 'coord_revision'
                or //action/@id = 'coord_reject'
                or //action/@id = 'coord_agree'">
            <div class="btn-group" role="group">
                <xsl:apply-templates select="//action[@id = 'coord_start']">
                    <xsl:with-param name="icon">
                        <i class="fa fa-play-circle-o"></i>
                    </xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="//action[@id = 'coord_revision']">
                    <xsl:with-param name="icon">
                        <i class="fa fa-reply"></i>
                    </xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="//action[@id = 'coord_reject']">
                    <xsl:with-param name="icon">
                        <i class="fa fa-ban"></i>
                    </xsl:with-param>
                </xsl:apply-templates>
                <xsl:apply-templates select="//action[@id = 'coord_agree']">
                    <xsl:with-param name="icon">
                        <i class="fa fa-check-circle-o"></i>
                    </xsl:with-param>
                </xsl:apply-templates>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="coordination">
        <xsl:choose>
            <xsl:when test="$hasCoordBlock">
                <ul class="coord-list coordination-direction {//fields/coordination_direction}">
                    <xsl:for-each select="//fields/coordination/blocks//coordinators/entry">
                        <xsl:sort select="position()" data-type="number" order="descending"/>
                        <li class="coord-iscurrent-{iscurrent}">
                            <header>
                                <xsl:choose>
                                    <xsl:when test="decision eq 'AGREE'">
                                        <i class="coord-icon coord-agree fa fa-check"></i>
                                    </xsl:when>
                                    <xsl:when test="decision eq 'DISAGREE'">
                                        <i class="coord-icon coord-disagree fa fa-close"></i>
                                    </xsl:when>
                                </xsl:choose>
                                <span class="timeline-user">
                                    <xsl:value-of select="employer/userid"/>
                                </span>
                                <time>
                                    <xsl:value-of select="decisiondate"/>
                                </time>
                            </header>
                            <xsl:if test="comment ne ''">
                                <p>
                                    <i class="fa fa-comment-o"></i>
                                    <xsl:value-of select="comment"/>
                                </p>
                            </xsl:if>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul class="timeline timeline-coordination">
                    <li>
                        <xsl:value-of select="//captions/coordination_not_started/@caption"/>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
