<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../layout.xsl"/>

    <xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>

    <xsl:variable name="doctype" select="request/document/captions/name/@caption"/>
    <xsl:variable name="editmode" select="/request/document/@editmode"/>
    <xsl:variable name="status" select="/request/document/@status"/>

    <xsl:template match="/request">
        <xsl:call-template name="layout">
            <xsl:with-param name="include">
                <script type="text/javascript" src="classic/scripts/form.js"></script>
                <script type="text/javascript" src="classic/scripts/dialogs.js"></script>
                <script>
                    $(function(){
                    $("#tabs").tabs();
                    $('[data-action=save_and_close]').click(SaveFormJquery);
                    $("button").button();
                    });
                </script>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="_content">
        <header class="form-header">
            <h1 class="header-title">
                <xsl:value-of select="concat($doctype,' - ', document/fields/name)"/>
            </h1>
            <xsl:apply-templates select="//actionbar">
                <xsl:with-param name="fixed_top" select="''"/>
            </xsl:apply-templates>
        </header>

        <section class="form-content">
            <form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
                <fieldset class="fieldset">
                    <xsl:if test="$editmode != 'edit'">
                        <xsl:attribute name="disabled">disabled</xsl:attribute>
                    </xsl:if>

                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="document/captions/name/@caption"/>
                        </div>
                        <div class="controls">
                            <input type="text" name="name" value="{document/fields/name}" size="30"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">
                            <xsl:value-of select="document/captions/code/@caption"/>
                        </div>
                        <div class="controls">
                            <input type="number" name="code" id="code" value="{document/fields/code}" size="10"/>
                        </div>
                    </div>
                </fieldset>
                <input type="hidden" name="type" value="save"/>
                <input type="hidden" name="id" value="roadtype"/>
                <input type="hidden" name="key" value="{document/@docid}"/>
            </form>
        </section>
    </xsl:template>

</xsl:stylesheet>
