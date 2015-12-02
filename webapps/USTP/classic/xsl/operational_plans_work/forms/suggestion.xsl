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
                <script type="text/javascript" src="classic/scripts/form.js"></script>
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
        <section class="form-content">
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
                            <span data-input="assignee">
                                <xsl:value-of select="assignee"/>
                            </span>
                            <input type="hidden" name="assignee" value="{//fields/assignee}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">Срок исполнения</div>
                        <div class="controls">
                            <input type="date" name="dueDate" value="{//fields/dueDate}"/>
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
