<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="utf-8" indent="no"/>

    <xsl:template match="/request">
        <xsl:call-template name="timeline"/>
    </xsl:template>

    <xsl:template name="timeline">
        <ul class="timeline timeline-event">
            <xsl:apply-templates select="//view_content//query/entry">
                <xsl:sort select="position()" data-type="number" order="descending"/>
            </xsl:apply-templates>
        </ul>
    </xsl:template>

    <xsl:template match="entry">
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
    </xsl:template>

</xsl:stylesheet>
