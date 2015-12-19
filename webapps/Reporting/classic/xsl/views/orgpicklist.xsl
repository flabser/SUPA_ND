<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="doctype">structure</xsl:variable>
	<xsl:output method="html" encoding="utf-8"/>	
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request/history"/>
	<xsl:template match="/request/query/entry">
		<div style="display:block; width:100%; text-align:left" name="itemStruct">
			<xsl:attribute name="onmouseover">javascript:entryOver(this)</xsl:attribute>
			<xsl:attribute name="onmouseout">javascript:entryOut(this)</xsl:attribute>
			<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="concat(@doctype,@docid)"/>')</xsl:attribute>
			<xsl:attribute name="style">cursor:pointer; text-align:left</xsl:attribute>
			<input type="checkbox" name="chbox" class="{@doctype}~{@docid}" id="{@doctype}{@docid}" value="{@viewtext}"/>
			<font class="font" title="{userid}" style="font-family:verdana; font-weight:bold; font-size:14px; margin-left:2px">
				<xsl:if test="userid =''">
					<xsl:attribute name="color" select="'gray'"/>
				</xsl:if>
				<xsl:value-of select="@viewtext"/>
			</font>
		</div>
		<xsl:apply-templates select="responses"/>
	</xsl:template>
	
	<xsl:template match="/request/query/entry/responses">
		<xsl:for-each select="descendant::entry">
			<div style="display:block; width:100%; cursor:pointer; text-align:left" name="itemStruct">
				<xsl:attribute name="onmouseover">javascript:entryOver(this)</xsl:attribute>
				<xsl:attribute name="onmouseout">javascript:entryOut(this)</xsl:attribute>
				<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="concat(@doctype,@docid)"/>')</xsl:attribute>
				<input class='chbox' type='hidden' name='chbox' id="{userid}" value="{@viewtext}"/>
				<input type="checkbox" name="chbox" class="{@doctype}~{@docid}" id="{@doctype}{@docid}" value="{@viewtext}"/>
				<font class="font" title="{userid}" style="font-family:verdana; font-size:13px; margin-left:2px">
					<xsl:value-of select="@viewtext"/>
				</font>
			</div>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>