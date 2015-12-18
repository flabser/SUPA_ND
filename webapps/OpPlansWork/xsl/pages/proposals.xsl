<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../layout.xsl"/>

    <xsl:template match="/request">
        <xsl:call-template name="layout">
            <xsl:with-param name="body_class" select="'proposals'"/>
            <xsl:with-param name="include">
                <script type="text/javascript" src="js/proposal-controller.js"></script>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="_content">
        <div class="content-header">
            <xsl:call-template name="page-info"/>
        </div>
        <div class="content-body">
            <div class="view view_proposals">
                <xsl:call-template name="view-table"/>
            </div>
        </div>
        <input type="hidden" name="page_id" id="page_id" value="{@id}"/>
    </xsl:template>

    <xsl:template name="view-table">
        <header class="entries-head">
            <div class="head-wrap">
                <label class="entry-select">
                    <input type="checkbox" data-toggle="docid" class="all"/>
                </label>
                <div class="entry-captions">
                    <span class="proposal-description">
                        <xsl:value-of select="//captions/viewtext/@caption"/>
                    </span>
                    <span class="proposal-assignee">
                        <xsl:value-of select="//captions/viewtext1/@caption"/>
                    </span>
                    <span class="proposal-due-date">
                        <xsl:value-of select="//captions/viewtext3/@caption"/>
                    </span>
                </div>
            </div>
        </header>
        <div class="entries">
            <xsl:apply-templates select="//view_content//query/entry" mode="view-table-body"/>
        </div>
    </xsl:template>

    <xsl:template match="entry" mode="view-table-body">
        <div class="entry-wrap">
            <div data-ddbid="{@id}" class="entry">
                <label class="entry-select">
                    <input type="checkbox" name="docid" id="{@id}" value="{@doctype}"/>
                </label>
                <a href="{@url}" class="entry-link">
                    <div class="entry-fields">
                        <span class="proposal-description">
                            <xsl:value-of select="viewcontent/viewtext"/>
                        </span>
                        <span class="proposal-assignee">
                            <xsl:value-of select="viewcontent/viewtext1"/>
                        </span>
                        <span class="proposal-due-date">
                            <xsl:value-of select="viewcontent/viewtext3"/>
                            <div>
                                <xsl:value-of select="viewcontent/viewtext4"/>
                            </div>
                        </span>
                    </div>
                </a>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="page-info">
        <h1 class="header-title">
            <xsl:value-of select="//captions/title/@caption"/>

            <xsl:if test="//view_content//query/@count">
                <sup class="entry-count">
                    <small>
                        <xsl:value-of select="concat('(', //view_content//query/@count, ')')"/>
                    </small>
                </sup>
            </xsl:if>
        </h1>
        <div class="content-actions">
            <div class="pull-right">
                <xsl:apply-templates select="//view_content" mode="page-navigator"/>
            </div>
            <div class="on-desktop">
                <xsl:call-template name="actions"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="actions">
        <xsl:if test="//action/@id = 'add_proposal'">
            <xsl:apply-templates select="//action[@id = 'add_proposal']"/>
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

</xsl:stylesheet>
