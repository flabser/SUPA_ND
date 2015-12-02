<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/request">
        <xsl:call-template name="_content"/>
    </xsl:template>

    <xsl:template name="_content">
        <div class="view">
            <div class="view-content">
                <div class="entries">
                    <xsl:apply-templates select="//view_content//employer" mode="view-table-body"/>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="employer" mode="view-table-body">
        <div class="entry-wrap">
            <div data-ddbid="{@id}" class="entry document">
                <label class="entry-select">
                    <input type="checkbox" name="userid" id="{@id}" value="{userid}"/>
                </label>
                <a href="#" class="entry-link">
                    <div class="entry-fields">
                        <span class="entry-field">
                            <xsl:value-of select="fullname"/>
                        </span>
                    </div>
                </a>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>
