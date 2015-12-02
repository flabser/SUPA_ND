<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/request">
        <xsl:call-template name="_content"/>
    </xsl:template>

    <xsl:template name="_content">
        <div class="view view_accounts">
            <xsl:call-template name="view-table"/>
        </div>
    </xsl:template>

    <xsl:template name="view-table">
        <header class="entries-head">
            <div class="head-wrap">
                <div class="entry-captions">
                    <span class="vaccount-name">
                        <xsl:value-of select="//captions/viewtext1/@caption"/>
                    </span>
                    <span class="vaccount-user">
                        <xsl:value-of select="//captions/viewtext2/@caption"/>
                    </span>
                    <span class="vaccount-observers">
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
            <div data-ddbid="{@id}" class="entry document js-swipe-entry">
                <a href="{@url}" class="entry-link">
                    <div class="entry-fields">
                        <span class="entry-field vaccount-name">
                            <xsl:value-of select="viewcontent/viewtext1"/>
                        </span>
                        <span class="entry-field vaccount-user">
                            <xsl:value-of select="viewcontent/viewtext2"/>
                        </span>
                        <span class="entry-field vaccount-observers">
                            <xsl:value-of select="viewcontent/viewtext3"/>
                        </span>
                    </div>
                </a>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>
