<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="utf-8" indent="no"/>
    <xsl:variable name="input-name" select="//query/@ruleid"/>

    <xsl:template match="/request">
        <xsl:apply-templates select="query/entry" mode="org"/>
    </xsl:template>

    <xsl:template match="entry" mode="org">
        <xsl:if test="responses/entry">
            <ul class="tree org-tree">
                <li>
                    <header>
                        <xsl:value-of select="viewtext"/>
                    </header>
                    <ul>
                        <xsl:apply-templates select="responses/entry" mode="response"/>
                    </ul>
                </li>
            </ul>
        </xsl:if>
    </xsl:template>

    <xsl:template match="entry" mode="response">
        <li>
            <xsl:choose>
                <xsl:when test="userid != ''">
                    <label ondblclick="nb.dialog.execute(this)">
                        <input type="radio" name="{$input-name}" value="{userid}" data-type="select"
                               data-text="{@viewtext}"/>
                        <span class="input-label">
                            <xsl:value-of select="@viewtext"/>
                        </span>
                    </label>
                </xsl:when>
                <xsl:otherwise>
                    <header>
                        <xsl:value-of select="viewtext"/>
                    </header>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="./entry">
                <ul>
                    <xsl:apply-templates select="entry" mode="response"/>
                </ul>
            </xsl:if>
        </li>
    </xsl:template>

</xsl:stylesheet>
