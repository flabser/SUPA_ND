<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/request">
        <xsl:call-template name="_content"/>
    </xsl:template>

    <xsl:template name="_content">
        <div class="view view_accounts">
            <div class="view-content">
                <div class="entries">
                    <xsl:apply-templates select="//view_content//query/entry" mode="view-table-body"/>
                </div>
            </div>
            <input type="hidden" name="page_id" id="page_id" value="{@id}"/>
        </div>
    </xsl:template>

    <xsl:template match="entry" mode="view-table-body">
        <div class="entry-wrap">
            <div data-ddbid="{@id}" class="entry document js-swipe-entry">
                <label class="entry-select">
                    <input type="checkbox" name="docid" id="{@id}" value="{@doctype}"/>
                </label>
                <span class="entry-link">
                    <div class="entry-fields">
                        <span class="entry-field vaccount-name">
                            <xsl:value-of select="viewcontent/viewtext"/>
                        </span>
                        <span class="entry-field vaccount-user">
                            <xsl:value-of select="viewcontent/viewtext1"/>
                        </span>
                        <span class="entry-field vaccount-observers">
                            <xsl:value-of select="viewcontent/viewtext2"/>
                        </span>
                    </div>
                </span>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>
