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
                            <xsl:value-of select="//captions/fio/@caption"/>
                        </label>
                        <input type="text" name="fio" value="{//fields/fio}"/>
                    </div>
                    <div class="form-group">
                        <label>
                            <xsl:value-of select="//captions/sex/@caption"/>
                        </label>
                        <select name="sex">
                            <option value="m">м</option>
                            <option value="w">ж</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>
                            <xsl:value-of select="//captions/age/@caption"/>
                        </label>
                        <input type="number" name="age" value="{//fields/age}"/>
                    </div>
                    <div class="human-states">
                        <label>
                            <input type="checkbox" name="isChildren" value="1">
                                <xsl:if test="//fields/isChildren eq '1'">
                                    <xsl:attribute name="checked" select="'checked'"/>
                                </xsl:if>
                            </input>
                            <xsl:value-of select="//captions/is_children/@caption"/>
                        </label>
                        <label>
                            <input type="checkbox" name="isAffected" value="1">
                                <xsl:if test="//fields/isAffected eq '1'">
                                    <xsl:attribute name="checked" select="'checked'"/>
                                </xsl:if>
                            </input>
                            <xsl:value-of select="//captions/is_affected/@caption"/>
                        </label>
                        <label>
                            <input type="checkbox" name="isDead" value="1">
                                <xsl:if test="//fields/isDead eq '1'">
                                    <xsl:attribute name="checked" select="'checked'"/>
                                </xsl:if>
                            </input>
                            <xsl:value-of select="//captions/is_dead/@caption"/>
                        </label>
                        <label>
                            <input type="checkbox" name="isRescued" value="1">
                                <xsl:if test="//fields/isRescued eq '1'">
                                    <xsl:attribute name="checked" select="'checked'"/>
                                </xsl:if>
                            </input>
                            <xsl:value-of select="//captions/is_rescued/@caption"/>
                        </label>
                        <label>
                            <input type="checkbox" name="isMissing" value="1">
                                <xsl:if test="//fields/isMissing eq '1'">
                                    <xsl:attribute name="checked" select="'checked'"/>
                                </xsl:if>
                            </input>
                            <xsl:value-of select="//captions/is_missing/@caption"/>
                        </label>
                        <label>
                            <input type="checkbox" name="isFoundBySearchRescue" value="1">
                                <xsl:if test="//fields/isFoundBySearchRescue eq '1'">
                                    <xsl:attribute name="checked" select="'checked'"/>
                                </xsl:if>
                            </input>
                            <xsl:value-of select="//captions/is_found_by_search_rescue/@caption"/>
                        </label>
                        <label>
                            <input type="checkbox" name="isEvacuated" value="1">
                                <xsl:if test="//fields/isEvacuated eq '1'">
                                    <xsl:attribute name="checked" select="'checked'"/>
                                </xsl:if>
                            </input>
                            <xsl:value-of select="//captions/is_evacuated/@caption"/>
                        </label>
                        <label>
                            <input type="checkbox" name="isFirstAid" value="1">
                                <xsl:if test="//fields/isFirstAid eq '1'">
                                    <xsl:attribute name="checked" select="'checked'"/>
                                </xsl:if>
                            </input>
                            <xsl:value-of select="//captions/is_first_aid/@caption"/>
                        </label>
                        <label>
                            <input type="checkbox" name="isHomeless" value="1">
                                <xsl:if test="//fields/isHomeless eq '1'">
                                    <xsl:attribute name="checked" select="'checked'"/>
                                </xsl:if>
                            </input>
                            <xsl:value-of select="//captions/is_homeless/@caption"/>
                        </label>
                    </div>
                </fieldset>
                <input type="hidden" name="type" value="save"/>
                <input type="hidden" name="id" value="human"/>
                <input type="hidden" name="key" value="{document/@docid}"/>
            </form>
        </section>
    </xsl:template>

</xsl:stylesheet>
