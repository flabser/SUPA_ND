<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype" select="request/document/captions/name/@caption"/>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('4ms Structure - ',$doctype)"/>
				</title>
				<xsl:call-template name="cssandjs"/>	
				<script type="text/javascript">
					$(function(){
						$("#code").tipTip({'activation':'click',"field":"code","defaultPosition":"right","content":"Поле может содержать только числовые значения"});
					});
					$(document).ready(function(){hotkeysnav()})
   					<![CDATA[
   						function hotkeysnav() {
							$(document).bind('keydown', function(e){
			 					if (e.ctrlKey) {
			 						switch (e.keyCode) {
									   case 66:
									   		<!-- клавиша b -->
									     	e.preventDefault();
									     	$("#canceldoc").click();
									      	break;
									   case 83:
									   		<!-- клавиша s -->
									     	e.preventDefault();
									     	$("#btnsavedoc").click();
									      	break;
									   case 85:
									   		<!-- клавиша u -->
									     	e.preventDefault();
									     	window.location.href=$("#currentuser").attr("href")
									      	break;
									   case 81:
									   		<!-- клавиша q -->
									     	e.preventDefault();
									     	window.location.href=$("#logout").attr("href")
									      	break;
									   case 72:
									   		<!-- клавиша h -->
									     	e.preventDefault();
									     	window.location.href=$("#helpbtn").attr("href")
									      	break;
									   default:
									      	break;
									}
			   					}
							});
							$("#canceldoc").hotnav({keysource:function(e){ return "b"; }});
							$("#btnsavedoc").hotnav({keysource:function(e){ return "s"; }});
							$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
							$("#logout").hotnav({keysource:function(e){ return "q"; }});
							$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
						}
					]]>
				</script>
			</head>
			<body>
				<div id="docwrapper">
					<xsl:call-template name="documentheader"/>	
					<div class="formwrapper">
						<div  class="formtitle">
							<div class="title">
								 <xsl:call-template name="doctitleGlossary"/>		
							</div>
						</div>
						<div class="button_panel">
							<span style="float:left">
								<xsl:call-template name="showxml"/>
                                <xsl:call-template name="adminsave"/>
							</span>
							<span style="float:right; margin-right:5px">
								<xsl:call-template name="cancelwithjson"/>
							</span>
						</div>
			  		 	<div style="clear:both"/>
						<div style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-1">
										<xsl:value-of select="document/captions/properties/@caption"/>
									</a>
								</li> 
							</ul>
							<div class="ui-tabs-panel" id="tabs-1">
								<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
									<div display="block" id="property">
										<br/>
										<table width="80%" border="0">
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/name/@caption"/> :</td>
				            					<td>
					                                 <input type="text" name="name" size="30" class="td_editable" value="{document/fields/name}">
					                                 	<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
					                                 </input>
	                           					</td>   					
							  	 			</tr>
							       			<tr>
												<td class="fc"><xsl:value-of select="document/captions/code/@caption"/> :</td>
												<td>
					                                 <input type="text" name="code" id="code" size="10" class="td_editable" value="{document/fields/code}">
					                                 	<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
					                                 	 <xsl:attribute name="onkeydown">javascript:numericfield(this)</xsl:attribute>
					                                 </input>
	                           					</td> 
							       			</tr>
							       			<tr>
												<td class="fc"><xsl:value-of select="document/captions/rank/@caption"/> :</td>
												<td>
					                                 <input type="text" name="ranktext" size="10" class="td_editable" value="{document/fields/ranktext}">
					                                 	<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
					                                 </input>
	                           					</td> 
							       			</tr>
										</table>		
						       		</div>   
						       		<input type="hidden" name="type" value="save"/>
									<input type="hidden" name="id" value="Post"/>		
									<input type="hidden" name="key" value="{document/@docid}"/> 
			         	 		</form>
			          		</div>
			          	</div>
			          	<div style="height:10px"/>
			    	</div> 
			    </div>
				<xsl:call-template name="formoutline"/>		
			</body>	
		</html>
	</xsl:template>
</xsl:stylesheet>