<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../layout.xsl"/>

    <xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>

    <xsl:template match="/request">
        <xsl:call-template name="_content"/>
    </xsl:template>

    <xsl:template name="_content">
        <header class="form-header">
            <h1 class="header-title">
                <xsl:value-of select="//fields/title"/>
            </h1>
        </header>

        <section class="form-content">
            <form action="Provider" method="post" enctype="application/x-www-form-urlencoded">
                <fieldset class="fieldset">
                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="//captions/type/@caption"/>type
                        </div>
                        <div class="controls">
                            <input type="text" name="type" value="{//fields/type}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="//captions/name/@caption"/>name
                        </div>
                        <div class="controls">
                            <input type="text" name="name" value="{//fields/name}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="//captions/location/@caption"/>location
                        </div>
                        <div class="controls">
                            <input type="text" name="location" value="{//fields/location}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="//captions/appointment/@caption"/>appointment
                        </div>
                        <div class="controls">
                            <input type="text" name="appointment" value="{//fields/appointment}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="//captions/zone_responsibility/@caption"/>zone_responsibility
                        </div>
                        <div class="controls">
                            <input type="text" name="zoneResponsibility" value="{//fields/zoneResponsibility}"/>
                        </div>
                    </div>
                </fieldset>
                <input type="hidden" name="type" value="save"/>
                <input type="hidden" name="id" value="post-of-monitoring-warning"/>
                <input type="hidden" name="key" value="{document/@docid}"/>
            </form>
        </section>
    </xsl:template>

</xsl:stylesheet>
