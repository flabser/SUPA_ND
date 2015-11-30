<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../layout.xsl"/>

    <xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>

    <xsl:template match="/request">
        <xsl:call-template name="layout"/>
    </xsl:template>

    <xsl:template name="_content">
        <header class="form-header">
            <h1 class="header-title">
                <xsl:value-of select="//fields/title"/>
            </h1>
            <xsl:apply-templates select="//actionbar">
                <xsl:with-param name="fixed_top" select="''"/>
            </xsl:apply-templates>
        </header>

        <section class="form-content">
            <form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
                <fieldset class="fieldset">
                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="document/captions/name/@caption"/>
                        </div>
                        <div class="controls">
                            <input type="text" name="name" value="{document/fields/name}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="document/captions/address/@caption"/>
                        </div>
                        <div class="controls">
                            <input type="text" name="address" value="{document/fields/address}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="document/captions/phone/@caption"/>
                        </div>
                        <div class="controls">
                            <input type="text" name="phone" value="{document/fields/phone}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="document/captions/details/@caption"/>
                        </div>
                        <div class="controls">
                            <input type="text" name="details" value="{document/fields/details}"/>
                        </div>
                    </div>
                </fieldset>
                <input type="hidden" name="type" value="save"/>
                <input type="hidden" name="id" value="first-aider"/>
                <input type="hidden" name="key" value="{document/@docid}"/>
            </form>
        </section>
    </xsl:template>

</xsl:stylesheet>
