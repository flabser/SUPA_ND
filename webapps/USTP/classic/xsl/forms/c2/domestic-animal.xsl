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
            <form class="human-form" action="Provider" method="post" enctype="application/x-www-form-urlencoded">
                <fieldset class="fieldset">
                    <div class="form-group">
                        <label>
                            <xsl:value-of select="//captions/animal_type/@caption"/>
                        </label>
                        <select name="animalType">
                            <option value=""></option>
                            <option value="крупного рогатого скота">крупного рогатого скота</option>
                            <option value="мелкого рогатого скота">мелкого рогатого скота</option>
                            <option value="лошадей">лошадей</option>
                            <option value="птицы">птицы</option>
                            <option value="водных организмов (гидробионтов)">водных организмов
                                (гидробионтов)
                            </option>
                            <option value="прочие">прочие</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>
                            <xsl:value-of select="//captions/dead_count/@caption"/>
                        </label>
                        <input type="text" name="deadCount" value="{//fields/deadCount}"/>
                    </div>
                    <div class="form-group">
                        <label>
                            <xsl:value-of select="//captions/evacuees_count/@caption"/>
                        </label>
                        <input type="text" name="evacueesCount" value="{//fields/evacueesCount}"/>
                    </div>
                </fieldset>
                <input type="hidden" name="type" value="save"/>
                <input type="hidden" name="id" value="domestic-animal"/>
                <input type="hidden" name="key" value="{document/@docid}"/>
            </form>
        </section>
    </xsl:template>

</xsl:stylesheet>
