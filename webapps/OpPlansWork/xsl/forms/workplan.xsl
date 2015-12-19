<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../layout.xsl"/>

    <xsl:template match="/request">
        <xsl:call-template name="layout"/>
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
            <form name="proposal">
                <fieldset class="fieldset">
                    <div class="form-group">
                        <div class="control-label">
                            <xsl:value-of select="//captions/name/@caption"/>
                        </div>
                        <div class="controls">
                            <div class="col-lg-6">
                                <input type="text" name="name" value="{//fields/name}" class="form-control"/>
                            </div>
                        </div>
                    </div>
                </fieldset>

                <input type="hidden" name="type" value="save"/>
                <input type="hidden" name="id" value="{/request/@id}"/>
                <input type="hidden" name="doctype" value="{document/@doctype}"/>
                <input type="hidden" name="key" value="{document/@docid}"/>
                <input type="hidden" name="ddbid" value="{document/@id}"/>
            </form>
        </section>
    </xsl:template>

</xsl:stylesheet>
