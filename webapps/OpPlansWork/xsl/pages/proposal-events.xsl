<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="utf-8" indent="no"/>

    <xsl:template match="/request">
        <xsl:call-template name="timeline"/>
    </xsl:template>

    <xsl:template name="timeline">
        <ul class="timeline timeline-events">
            <xsl:apply-templates select="//view_content//query/entry">
                <xsl:sort select="position()" data-type="number" order="descending"/>
            </xsl:apply-templates>
        </ul>
    </xsl:template>

    <xsl:template match="entry">
        <li>
            <xsl:apply-templates select="viewcontent"/>
        </li>
    </xsl:template>

    <!--
        coord
        0 doc.setViewText(doc.getValueString("event"))
        1 doc.addViewText(session.user.fullName)
        2 doc.addViewText(text)
        3 doc.addViewText(decision)
    -->
    <xsl:template match="viewcontent[./viewtext = 'coordination']">
        <div class="timeline-coord coord-{viewtext3}">
            <header>
                <xsl:choose>
                    <xsl:when test="viewtext3 eq 'start'">
                        <i class="coord-icon coord-start fa fa-play"></i>
                        <span class="coord-text">
                            <xsl:value-of select="//captions/coord_start/@caption"/>
                        </span>
                    </xsl:when>
                    <xsl:when test="viewtext3 eq 'agree'">
                        <i class="coord-icon coord-agree fa fa-check"></i>
                        <span class="coord-text">
                            <xsl:value-of select="//captions/coord_agree/@caption"/>
                        </span>
                    </xsl:when>
                    <xsl:when test="viewtext3 eq 'revision'">
                        <i class="coord-icon coord-revision fa fa-reply"></i>
                        <span class="coord-text">
                            <xsl:value-of select="//captions/coord_revision/@caption"/>
                        </span>
                    </xsl:when>
                    <xsl:when test="viewtext3 eq 'reject'">
                        <i class="coord-icon coord-reject fa fa-close"></i>
                        <span class="coord-text">
                            <xsl:value-of select="//captions/coord_reject/@caption"/>
                        </span>
                    </xsl:when>
                </xsl:choose>
                <span class="timeline-user">
                    <xsl:value-of select="viewtext1"/>
                </span>
                <time>
                    <xsl:value-of select="viewdate"/>
                </time>
            </header>
            <xsl:if test="viewtext2 ne ''">
                <p>
                    <i class="fa fa-comment-o"></i>
                    <xsl:value-of select="viewtext2"/>
                </p>
            </xsl:if>
        </div>
    </xsl:template>

    <!--
        change
        doc.setViewText(doc.getValueString("event"))
        doc.addViewText(session.user.fullName)
        doc.addViewText(text)
    -->
    <xsl:template match="viewcontent[./viewtext = 'change']">
        <div class="timeline-change">
            <header>
                <span class="timeline-user">
                    <xsl:value-of select="viewtext1"/>
                </span>
                <time>
                    <xsl:value-of select="viewdate"/>
                </time>
            </header>
            <p>
                <span class="changed_label">
                    <xsl:value-of select="//captions/changed/@caption"/>:
                </span>
                <xsl:value-of select="viewtext2"/>
            </p>
        </div>
    </xsl:template>

    <!--
        comment
        doc.setViewText("comment")
        doc.addViewText(currentUser.getFullName())
        doc.addViewText(doc.getValueString("text"))
    -->
    <xsl:template match="viewcontent[./viewtext = 'comment']">
        <div class="timeline-comment">
            <header>
                <span class="timeline-user">
                    <xsl:value-of select="viewtext1"/>
                </span>
                <time>
                    <xsl:value-of select="viewdate"/>
                </time>
            </header>
            <p>
                <xsl:value-of select="viewtext2"/>
            </p>
        </div>
    </xsl:template>

</xsl:stylesheet>
