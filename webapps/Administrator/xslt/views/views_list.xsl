<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/view.xsl"/>
	<xsl:import href="../templates/action.xsl"/>
	<xsl:variable name="type">get_doc_list</xsl:variable>
	<xsl:variable name="doctype">rule</xsl:variable>
	<xsl:variable name="currentapp" select="currentview/@app"/>
	<xsl:variable name="currentview" select="currentview"/>
	<xsl:variable name="currentservice" select="currentview/@service"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>

	<xsl:template match="/request">
		<html>
			<head>
				<title>Administrator - Views list</title>
				<xsl:call-template name="view-html-head-jscss"/>
			</head>
			<body>
				<div class="wrapper">
					<div id="blockWindow" style="display:none"/>
					<xsl:call-template name="outline"/>
					<div class="layout-content">
						<div class="layout-content-container">
							<h4 class="view-header-title">
								<xsl:value-of select="query/@app"/> Views
							</h4>
							<div class="actionbar">
								<span class="action">
									<xsl:call-template name="refresh_action"/>
									<a style="margin-left:10px">
										<xsl:attribute name="href">javascript:resetRules('<xsl:value-of select="query/@app"/>');</xsl:attribute>
										<img src="img/force.gif"/>
										<font class="button">Reload rules</font>
									</a>
									<a style="margin-left:10px">
										<xsl:attribute name="href">javascript:delRule("view_rule");</xsl:attribute>
										<img src="img/delete.gif"/>
										<font class="button">Delete</font>
									</a>
								</span>
								<xsl:call-template name="viewstat"/>
							</div>
							<table class="viewtable">
								<tr class="th">
									<td width="22px" class="thcell">
										<input type="checkbox" id="allchbox" onClick="checkAll(this);"/>
									</td>
									<td width="20%" class="thcell">id</td>
									<td width="20%" class="thcell">source</td>
									<td width="35%" class="thcell">query</td>
									<td class="thcell">doctype</td>
									<td class="thcell"></td>
								</tr>
								<xsl:for-each select="query/entry">
									<tr onmouseover="javascript:elemBackground(this,'EEEEEE')" onmouseout="elemBackground(this,'FFFFFF')">
										<xsl:variable name="num" select="position()"/>
										<xsl:attribute name="bgcolor">#ffffff</xsl:attribute>
										<td style="border:1px solid #ccc; text-align:center">
											<input type="checkbox" name="chbox" id="chbox{@docid}" value="{@docid}"/>
										</td>
										<td style="border:1px solid #ccc; padding-left:5px;">
											<a class="doclink" title="{filename}">
												<xsl:attribute name="href">Provider?type=get_view&amp;id=<xsl:value-of select="@docid"/>&amp;app=<xsl:value-of select="app"/></xsl:attribute>
												<xsl:value-of select="@docid"/>
											</a>
										</td>
										<td class="title" style="border:1px solid #ccc; padding-left:5px;">
											<xsl:value-of select="querysource"/>
										</td>
										<td class="title" style="border:1px solid #ccc; padding-left:5px;">
											<xsl:value-of select="query"/>
										</td>
										<td class="title" style="border:1px solid #ccc; padding-left:5px;">
											<xsl:value-of select="doctype"/>
										</td>
										<td class="title" style="border:1px solid #ccc; text-align:center">
											<a style="margin-left:10" title="test query..." target="_blank">
												<xsl:attribute name="href">Provider?type=do_query&amp;id=<xsl:value-of select="rule/@id"/>&amp;app=<xsl:value-of select="rule/@app"/></xsl:attribute>
												<img src="img/force_small.gif" />
											</a>
										</td>
									</tr>
								</xsl:for-each>
							</table>
						</div>
					</div>
					<xsl:call-template name="footer"/>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>