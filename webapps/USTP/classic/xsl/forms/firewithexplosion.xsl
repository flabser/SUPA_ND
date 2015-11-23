<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype" select="request/document/fields/title"/>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:variable name="userid" select="/request/@userid"/>
	<xsl:variable name="threaddocid" select="document/@granddocid"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request">
	<xsl:variable name="filename" select="document/fields/pdocrtfcontent"/>
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('Надзорная деятельность - Учет сведений о ЧС техногенного и природного характера - ',document/fields/title)"/>
				</title>
				<xsl:call-template name="cssandjs"/>
				<script type="text/javascript">
                    function AppletIsReady() {
                    <!--$.unblockUI();-->
                    $("#appstatus").text("Applet is ready!");
                    }
					$(document).ready(function(){
						$("#progressDiv a[href *= '<xsl:value-of select="document/@id"/>']").attr("style","font-weight:bold;")
						hotkeysnav()
					})
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
									   case 71:
									  		<!-- клавиша g -->
									     	e.preventDefault();
									     	$("#btngrantaccess").click();
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
									   case 73:
									   		<!-- клавиша i -->
									     	e.preventDefault();
									     	window.location.href=$("#helpbtn").attr("href")
									      	break;
									   default:
									      	break;
									}
			   					}
							});
							$("#canceldoc").hotnav({keysource:function(e){ return "b"; }});
							$("#btngrantaccess").hotnav({keysource:function(e){ return "g"; }});
							$("#btnsavedoc").hotnav({keysource:function(e){ return "s"; }});
							$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
							$("#logout").hotnav({keysource:function(e){ return "q"; }});
							$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
							$("#btnnewish").hotnav({keysource:function(e){ return "i"; }});
						}
					]]>
				</script>

			

				 <xsl:if test="$editmode = 'edit'">
					<xsl:call-template name="htmlareaeditor"/>
				</xsl:if>
				<xsl:call-template name="markisread"/>
			</head>
			<body>
				<div id="docwrapper">
                    <xsl:call-template name="documentheader"/>
					<div class="formwrapper">
						<div class="formtitle">
							<div style="float:left" class="title">
								<xsl:value-of select="document/fields/title"/> <span id="whichreadblock">Прочтен</span>
							</div>
						</div>
						<div class="button_panel">
							<span style=" vertical-align:12px; float:left">
								<xsl:call-template name="showxml"/>
								<xsl:call-template name="get_document_accesslist"/>
								<xsl:call-template name="save"/>
							</span>
							<span style="float:right" class="bar_right_panel">
								<xsl:call-template name="cancel"/>
							</span>
						</div>
						<div style="clear:both"/>
						<div style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
	                  			<li class="ui-state-default ui-corner-top">
	                  				<a href="#tabs-1">Информация</a>
	                  			</li>
	                  			<li class="ui-state-default ui-corner-top">
	                  				<a href="#tabs-2">Последствия ЧС</a>
	                  			</li>
	                  			<li class="ui-state-default ui-corner-top">
	                  				<a href="#tabs-3">Описание и реагирование на ЧС</a>
	                  			</li>
		                  		<li class="ui-state-default ui-corner-top">
									<a href="#tabs-4">Ликвидация ЧС</a>
								</li>
		                  		<li class="ui-state-default ui-corner-top">
									<a href="#tabs-5">Характеристика объекта</a>
								</li>
		                  		<li class="ui-state-default ui-corner-top">
									<a href="#tabs-6">Итоговая справка по результатам расследования, ликвидации ЧС</a>
								</li>
		                 		<span style="float:right; font-size:11px; font-weight:normal;">
									<b class="text"><xsl:value-of select="document/captions/author/@caption"/>: </b> 
									<font class="text" style="padding-right:7px;"><xsl:value-of select="document/fields/author"/> </font>
									<xsl:if test="$status != 'new'">
										<img id="edsimg" style="max-width:14px; margin-right:5px; margin-left:2px; visibility:hidden" title="Документ подписан ЭЦП - Подпись верна"/>
									</xsl:if>
									<xsl:if test="document/fields/isold = '1'">
										<font class="text">
											Устаревший
										</font>
									</xsl:if>
								</span>
              				</ul>
							<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
								<div class="ui-tabs-panel" id="tabs-1">
									<br/>
									<table width="100%" border="0">
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													Номер карточки :
												</font>
											</td>
											<td>
												<table>
													<tr>
														<td>
															<input type="text" name="cardnum" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/cardnum}"/>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<!-- Дата карточки -->
										<tr>
											<td class="fc">
												Дата карточки :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Код ЧС -->
										<tr>
											<td class="fc">
												Код ЧС :
											</td>
											<td>
												<input type="text" name="code" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/code}"/>
											</td>
										</tr>
										<!-- Вид  ЧС -->
										<tr>
											<td class="fc">
												Вид ЧС :
											</td>
											<td>
												<select size="1" name="type" style="width:612px;" class="select_editable" autocomplete="off">
													<xsl:variable name="type" select="document/fields/type"/>
													<xsl:if test="$editmode ='edit'">
														<option value=" ">
															<xsl:attribute name="selected">selected</xsl:attribute>
															&#xA0;
														</option>
													</xsl:if>
													<xsl:if test="$editmode !='edit'">
														<xsl:attribute name="disabled"/>
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<option value="{document/fields/project/@attrval}">
															<xsl:attribute name="selected">selected</xsl:attribute>
															<xsl:value-of select="document/fields/type"/>
														</option>
													</xsl:if>
													<xsl:for-each select="document/glossaries/type/query/entry">
														<option value="{@docid}">
															<xsl:if test="$type = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="viewcontent/viewtext1"/>
														</option>
													</xsl:for-each>
												</select>
											</td>
										</tr>
										<!-- поле "Краткое описание происшествия" -->
										<tr>
											 <td class="fc" style="padding-top:5px">
												Краткое описание происшествия :
											</td>
											<td style="padding-top:5px">
												<div>
													<textarea name="briefcontent" rows="3"  tabindex="3" style="width:750px" autocomplete="off" class="textarea_editable">
														<xsl:if test="$editmode !='edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
														</xsl:if>
														<xsl:if test="$editmode = 'edit'">
															<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
															<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
														</xsl:if>
													</textarea>
												</div>
											</td>
										</tr>
										<!-- Дата возникновения ЧС -->
										<tr>
											<td class="fc">
												Дата возникновения ЧС :
											</td>
											<td>
												<input type="text" name="esdate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/esdate}"/>
											</td>
										</tr>
										<!-- Наименование области -->
										<tr>
											<td class="fc">
												Наименование области :
											</td>
											<td>
												<select size="1" name="region" style="width:612px;" class="select_editable" autocomplete="off">
													<xsl:variable name="region" select="document/fields/region"/>
													<xsl:if test="$editmode ='edit'">
														<option value=" ">
															<xsl:attribute name="selected">selected</xsl:attribute>
															&#xA0;
														</option>
													</xsl:if>
													<xsl:if test="$editmode !='edit'">
														<xsl:attribute name="disabled"/>
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<option value="{document/fields/project/@attrval}">
															<xsl:attribute name="selected">selected</xsl:attribute>
															<xsl:value-of select="document/fields/type"/>
														</option>
													</xsl:if>
													<xsl:for-each select="document/glossaries/type/query/entry">
														<option value="{@docid}">
															<xsl:if test="$region = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="viewcontent/viewtext1"/>
														</option>
													</xsl:for-each>
												</select>
											</td>
										</tr>
										<!-- город республиканского значения  -->
										<tr>
											<td class="fc">
												Город республиканского значения :
											</td>
											<td>
												<input type="text" name="respcity" class="td_editable" style="width:160px;" value="{document/fields/respcity}"/>
											</td>
										</tr>
										<!-- город областного значения  -->
										<tr>
											<td class="fc">
												Город областного значения :
											</td>
											<td>
												<input type="text" name="regioncity" class="td_editable" style="width:160px;" value="{document/fields/regioncity}"/>
											</td>
										</tr>
										<!-- Район  -->
										<tr>
											<td class="fc">
												Район :
											</td>
											<td>
												<input type="text" name="district" class="td_editable" style="width:160px;" value="{document/fields/district}"/>
											</td>
										</tr>
										<!-- Сельский округ  -->
										<tr>
											<td class="fc">
												Сельский округ :
											</td>
											<td>
												<input type="text" name="villagedistrict" class="td_editable" style="width:160px;" value="{document/fields/villagedistrict}"/>
											</td>
										</tr>
										<!-- Поселок  -->
										<tr>
											<td class="fc">
												Поселок :
											</td>
											<td>
												<input type="text" name="settlement" class="td_editable" style="width:160px;" value="{document/fields/settlement}"/>
											</td>
										</tr>
										<!-- Село  -->
										<tr>
											<td class="fc">
												Село :
											</td>
											<td>
												<input type="text" name="village" class="td_editable" style="width:160px;" value="{document/fields/village}"/>
											</td>
										</tr>
										<!-- Аул  -->
										<tr>
											<td class="fc">
												Аул :
											</td>
											<td>
												<input type="text" name="aul" class="td_editable" style="width:160px;" value="{document/fields/aul}"/>
											</td>
										</tr>
										<!-- Проспект  -->
										<tr>
											<td class="fc">
												Проспект :
											</td>
											<td>
												<input type="text" name="avenue" class="td_editable" style="width:160px;" value="{document/fields/avenue}"/>
											</td>
										</tr>
										<!-- Улица   -->
										<tr>
											<td class="fc">
												Улица :
											</td>
											<td>
												<input type="text" name="street" class="td_editable" style="width:160px;" value="{document/fields/street}"/>
											</td>
										</tr>
										<!-- Микрорайон   -->
										<tr>
											<td class="fc">
												Микрорайон :
											</td>
											<td>
												<input type="text" name="microdistrict" class="td_editable" style="width:160px;" value="{document/fields/microdistrict}"/>
											</td>
										</tr>
										<!-- Переулок   -->
										<tr>
											<td class="fc">
												Переулок :
											</td>
											<td>
												<input type="text" name="lane" class="td_editable" style="width:160px;" value="{document/fields/lane}"/>
											</td>
										</tr>
										<!-- дом   -->
										<tr>
											<td class="fc">
												Дом :
											</td>
											<td>
												<input type="text" name="house" class="td_editable" style="width:160px;" value="{document/fields/house}"/>
											</td>
										</tr>
										<!-- Корпус   -->
										<tr>
											<td class="fc">
												Корпус :
											</td>
											<td>
												<input type="text" name="housing" class="td_editable" style="width:160px;" value="{document/fields/housing}"/>
											</td>
										</tr>
										<!-- Расстояние от видимых ориентиров   -->
										<tr>
											<td class="fc">
												Видимые ориентиры :
											</td>
											<td style="padding-left:5px">
												Ориентир : <input type="text" name="orientirs" class="td_editable" style="width:160px; margin-left:5px; margin-right:5px" value="{document/fields/orientirs}"/> Расстояние : <input type="text" name="distance" class="td_editable" style="width:60px; margin-left:5px;" value="{document/fields/distance}"/> км
											</td>
										</tr>
										<!-- Географические координаты   -->
										<tr>
											<td class="fc">
												Географические координаты :
											</td>
											<td>
												<input type="text" name="coordinats" class="td_editable" style="width:200px;" value="{document/fields/coordinats}"/>
											</td>
										</tr>
										<!-- дороги (значение) -->
										<tr>
											<td class="fc">
												Дороги (значение) :
											</td>
											<td>
												<select size="1" name="road" style="width:612px;" class="select_editable" autocomplete="off">
													<xsl:variable name="road" select="document/fields/road"/>
													<xsl:if test="$editmode ='edit'">
														<option value=" ">
															<xsl:attribute name="selected">selected</xsl:attribute>
															&#xA0;
														</option>
													</xsl:if>
													<xsl:if test="$editmode !='edit'">
														<xsl:attribute name="disabled"/>
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<option value="{document/fields/road/@attrval}">
															<xsl:attribute name="selected">selected</xsl:attribute>
															<xsl:value-of select="document/fields/type"/>
														</option>
													</xsl:if>
													<xsl:for-each select="document/glossaries/road/query/entry">
														<option value="{@docid}">
															<xsl:if test="$road = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="viewcontent/viewtext1"/>
														</option>
													</xsl:for-each>
												</select>
											</td>
										</tr>
										<!-- Автовокзал -->
										<tr>
											<td class="fc">
												Автовокзал :
											</td>
											<td>
												<select size="1" name="busstation" style="width:612px;" class="select_editable" autocomplete="off">
													<xsl:variable name="busstation" select="document/fields/busstation"/>
													<xsl:if test="$editmode ='edit'">
														<option value=" ">
															<xsl:attribute name="selected">selected</xsl:attribute>
															&#xA0;
														</option>
													</xsl:if>
													<xsl:if test="$editmode !='edit'">
														<xsl:attribute name="disabled"/>
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<option value="{document/fields/road/@attrval}">
															<xsl:attribute name="selected">selected</xsl:attribute>
															<xsl:value-of select="document/fields/busstation"/>
														</option>
													</xsl:if>
													<xsl:for-each select="document/glossaries/busstation/query/entry">
														<option value="{@docid}">
															<xsl:if test="$busstation = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="viewcontent/viewtext1"/>
														</option>
													</xsl:for-each>
												</select>
											</td>
										</tr>
										<!-- Железнодорожные пути -->
										<tr>
											<td class="fc">
												Железнодорожные пути :
											</td>
											<td>
												<select size="1" name="railways" style="width:612px;" class="select_editable" autocomplete="off">
													<xsl:variable name="railways" select="document/fields/railways"/>
													<xsl:if test="$editmode ='edit'">
														<option value=" ">
															<xsl:attribute name="selected">selected</xsl:attribute>
															&#xA0;
														</option>
													</xsl:if>
													<xsl:if test="$editmode !='edit'">
														<xsl:attribute name="disabled"/>
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<option value="{document/fields/railways/@attrval}">
															<xsl:attribute name="selected">selected</xsl:attribute>
															<xsl:value-of select="document/fields/railways"/>
														</option>
													</xsl:if>
													<xsl:for-each select="document/glossaries/railways/query/entry">
														<option value="{@docid}">
															<xsl:if test="$railways = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="viewcontent/viewtext1"/>
														</option>
													</xsl:for-each>
												</select>
											</td>
										</tr>
										<!-- Аэровокзальный комплекс -->
										<tr>
											<td class="fc">
												Аэровокзальный комплекс :
											</td>
											<td>
												<select size="1" name="airterminal" style="width:612px;" class="select_editable" autocomplete="off">
													<xsl:variable name="airterminal" select="document/fields/airterminal"/>
													<xsl:if test="$editmode ='edit'">
														<option value=" ">
															<xsl:attribute name="selected">selected</xsl:attribute>
															&#xA0;
														</option>
													</xsl:if>
													<xsl:if test="$editmode !='edit'">
														<xsl:attribute name="disabled"/>
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<option value="{document/fields/airterminal/@attrval}">
															<xsl:attribute name="selected">selected</xsl:attribute>
															<xsl:value-of select="document/fields/airterminal"/>
														</option>
													</xsl:if>
													<xsl:for-each select="document/glossaries/airterminal/query/entry">
														<option value="{@docid}">
															<xsl:if test="$airterminal = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="viewcontent/viewtext1"/>
														</option>
													</xsl:for-each>
												</select>
											</td>
										</tr>
										<!-- Порты -->
										<tr>
											<td class="fc">
												Порты :
											</td>
											<td>
												<select size="1" name="seaport" style="width:612px;" class="select_editable" autocomplete="off">
													<xsl:variable name="seaport" select="document/fields/seaport"/>
													<xsl:if test="$editmode ='edit'">
														<option value=" ">
															<xsl:attribute name="selected">selected</xsl:attribute>
															&#xA0;
														</option>
													</xsl:if>
													<xsl:if test="$editmode !='edit'">
														<xsl:attribute name="disabled"/>
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<option value="{document/fields/seaport/@attrval}">
															<xsl:attribute name="selected">selected</xsl:attribute>
															<xsl:value-of select="document/fields/seaport"/>
														</option>
													</xsl:if>
													<xsl:for-each select="document/glossaries/seaport/query/entry">
														<option value="{@docid}">
															<xsl:if test="$seaport = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="viewcontent/viewtext1"/>
														</option>
													</xsl:for-each>
												</select>
											</td>
										</tr>
										<!-- Маршрут передвижения   -->
										<tr>
											<td class="fc">
												Маршрут передвижения (направление, сообщение):
											</td>
											<td>
												<input type="text" name="housing" class="td_editable" style="width:160px;" value="{document/fields/housing}"/>
											</td>
										</tr>
										<!-- Пункт направления (назначения)  -->
										<tr>
											<td class="fc">
												Пункт направления (назначения):
											</td>
											<td>
												  <input type="text" name="housing" class="td_editable" style="width:160px; margin-right:5px" value="{document/fields/housing}"/> Отправления<br/>
												  <input type="text" name="housing" class="td_editable" style="width:160px; margin-right:5px" value="{document/fields/housing}"/> Прибытия
											</td>
										</tr>
										<!-- Дата отправления   -->
										<tr>
											<td class="fc">
												 Дата отправления :
											</td>
											<td>
												<input type="text" name="housing" class="td_editable" style="width:160px;" value="{document/fields/housing}"/>
											</td>
										</tr>
										<!-- Время отправления   -->
										<tr>
											<td class="fc">
												 Время отправления :
											</td>
											<td>
												<input type="text" name="housing" class="td_editable" style="width:160px;" value="{document/fields/housing}"/>
											</td>
										</tr>
										<!-- Дата прибытия    -->
										<tr>
											<td class="fc">
												 Дата прибытия :
											</td>
											<td>
												<input type="text" name="housing" class="td_editable" style="width:160px;" value="{document/fields/housing}"/>
											</td>
										</tr>
										<!-- Время прибытия    -->
										<tr>
											<td class="fc">
												 Время прибытия :
											</td>
											<td>
												<input type="text" name="housing" class="td_editable" style="width:160px;" value="{document/fields/housing}"/>
											</td>
										</tr>
										<!-- Задержка движения транспорта  -->
										<tr>
											<td class="fc">
												 Задержка движения транспорта :
											</td>
											<td>
												<input type="text" name="housing" class="td_editable" style="width:160px;" value="{document/fields/housing}"/>
											</td>
										</tr>
										<!-- Количество пассажиров  -->
										<tr>
											<td class="fc">
												 Количество пассажиров (человек) :
											</td>
											<td>
												<input type="text" name="housing" class="td_editable" style="width:160px; margin-right:5px" value="{document/fields/housing}"/> Взрослых <br/>
												<input type="text" name="housing" class="td_editable" style="width:160px; margin-right:5px" value="{document/fields/housing}"/> Детей
											</td>
										</tr>
								</table>
							</div>
							<div id="tabs-2">
								<br/>
								<table width="100%" border="0">
									<!-- Общее количество людей находившихся в зоне ЧС (чел.) -->
									<tr>
										<td class="fc">
											Общее количество людей находившихся в зоне ЧС :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Количество пострадавших (чел.) -->
									<tr>
										<td class="fc">
											Количество пострадавших (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- В том числе детей (чел.) -->
									<tr>
										<td class="fc">
											В том числе детей (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Количество Погибших (чел.) -->
									<tr>
										<td class="fc">
											Количество погибших (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- В том числе детей (чел.) -->
									<tr>
										<td class="fc">
											В том числе детей (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Количество людей пропавших без вести (чел.) -->
									<tr>
										<td class="fc">
											Количество пропавших без вести (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- В том числе детей (чел.) -->
									<tr>
										<td class="fc">
											В том числе детей (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Количество спасенных (чел.) -->
									<tr>
										<td class="fc">
											Количество спасенных (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- В том числе детей (чел.) -->
									<tr>
										<td class="fc">
											В том числе детей (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Обнаруженно людей в ходе проведения поисково - спасательных работ -->
									<tr>
										<td class="fc">
											Обнаруженно людей в ходе проведения поисково - спасательных работ :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Спасены и доставлены в мед. учреждения -->
									<tr>
										<td class="fc">
											Спасены и доставлены в мед. учреждения :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Общее количество людей требующих эвакуации (чел.) -->
									<tr>
										<td class="fc">
											Общее количество людей требующих эвакуации :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Количество эвакуированных  -->
									<tr>
										<td class="fc">
											Количество эвакуированных :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- В том числе детей (чел.) -->
									<tr>
										<td class="fc">
											В том числе детей (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Оказана первая медицинская помощь  -->
									<tr>
										<td class="fc">
											Оказана первая медицинская помощь :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- В том числе детей (чел.) -->
									<tr>
										<td class="fc">
											В том числе детей (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Наименование организаций, юридический адрес, реквизиты, оказывавших первую помощь  -->
									<tr>
										<td class="fc">
											Наименование организаций, юридический адрес, реквизиты, оказывавших первую помощь :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:600px;" value="{document/fields/carddate}"/>
										</td>
									</tr>

									<!-- Госпитализировано людей  111-->
									<tr>
										<td class="fc">
											Госпитализировано людей :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- В том числе детей (чел.) -->
									<tr>
										<td class="fc">
											В том числе детей (чел.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- ФИО, Пол, Возраст -->
									<tr>
										<td class="fc">

										</td>
										<td>
											ФИО : <input type="text" name="carddate" class="td_editable" style="width:200px; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Пол : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:100px; ; margin-left:5px; margin-right:5px" value="{document/fields/carddate}"/> Возраст : <input type="text" name="carddate" maxlength="10" class="td_editable" style="width:60px; ; margin-left:5px; " value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Повреждено -->
									<tr>
										<td class="fc">
											Повреждено :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Техники транспорт (ед.) -->
									<tr>
										<td class="fc">
											Техники транспорт (ед.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Уничтожено -->
									<tr>
										<td class="fc">
											Уничтожено :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Техники транспорт (ед.) -->
									<tr>
										<td class="fc">
											Техники транспорт (ед.) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Спасено материальных ценностей тенге всего -->
									<tr>
										<td class="fc">
											Спасено материальных ценностей тенге всего :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Имущества -->
									<tr>
										<td class="fc">
											Имущества :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Техники -->
									<tr>
										<td class="fc">
											Техники :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Материальный ущерб (предварительный) тенге -->
									<tr>
										<td class="fc">
											Материальный ущерб (предварительный) тенге :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
								</table>
							</div>
							<div id="tabs-3">
								<br/>
								<table width="100%" border="0">
									<!-- Время -->
									<tr>
										<td class="fc">
											Время :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!--Расстояние от места аварии до близлежащих населенных пунктов-->
									<tr>
										<td class="fc">
											Расстояние от места аварии до близлежащих населенных пунктов :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!--Охват населения своевременным оповещением об угрозе и возникновении ЧС (%)-->
									<tr>
										<td class="fc">
											Охват населения своевременным оповещением об угрозе и возникновении ЧС (%) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!--Время оповещения -->
									<tr>
										<td class="fc">
											Время оповещения :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Дежурный дежурно-диспетчерских служб области, города, района (ФИО, телефон, факс) -->
									<tr>
										<td class="fc">
											Дежурный дежурно-диспетчерских служб области, города, района (ФИО, телефон, факс) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
								</table>
							</div>
							<div id="tabs-4">
								<br/>
								<table width="100%" border="0">
									<!-- Дата и время локализации ЧС -->
									<tr>
										<td class="fc">
											Дата и время локализации ЧС :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!--Дата и время ликвидации ЧС-->
									<tr>
										<td class="fc">
											Дата и время ликвидации ЧС :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!--Было задействовано в ликвидации-->
									<tr>
										<td class="fc">
											Было задействовано в ликвидации :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!--Время оповещения -->
									<tr>
										<td class="fc">
											Время оповещения :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- в том числе -->
									<tr>
										<td class="fc">
											в том числе :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Штаб ликвидации аварии -->
									<tr>
										<td class="fc">
											Штаб ликвидации аварии :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Руководитель ликвидации ЧС (ФИО, должность, место работы) -->
									<tr>
										<td class="fc">
											Руководитель ликвидации ЧС (ФИО, должность, место работы) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Виновное лицо (ФИО, возраст) -->
									<tr>
										<td class="fc">
											Виновное лицо (ФИО, возраст) :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Затраты на ликвидацию ЧС, тенге -->
									<tr>
										<td class="fc">
											Затраты на ликвидацию ЧС, тенге :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
									<!-- Сведения о создании Правительственной комиссии по расследованию аварии -->
									<tr>
										<td class="fc">
											Сведения о создании Правительственной комиссии по расследованию аварии :
										</td>
										<td>
											<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
										</td>
									</tr>
								</table>
							</div>
								<div id="tabs-5">
									<br/>
									<table width="100%" border="0">
										<!-- Характеристика автомобильного транспорта -->
										<tr>
											<td class="fc">
												Характеристика автомобильного транспорта :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Марка транспортного средства -->
										<tr>
											<td class="fc">
												Марка транспортного средства :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!--Государственный номер автомобиля-(ей) -->
										<tr>
											<td class="fc">
												Государственный номер автомобиля-(ей) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Характеристика железнодорожного транспорта -->
										<tr>
											<td class="fc">
												Характеристика железнодорожного транспорта :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- № поезда-(ов) -->
										<tr>
											<td class="fc">
												№ поезда-(ов) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Характеристика морского транспорта -->
										<tr>
											<td class="fc">
												Характеристика морского транспорта :
											</td>
											<td>
											</td>
										</tr>
										<!-- Вид транспорта -->
										<tr>
											<td class="fc">
												Вид транспорта :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Модель транспортного средства -->
										<tr>
											<td class="fc">
												Модель транспортного средства :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Характеристика авиатранспорта -->
										<tr>
											<td class="fc">
												Характеристика авиатранспорта :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- марка -->
										<tr>
											<td class="fc">
												марка :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- № рейса -->
										<tr>
											<td class="fc">
												№ рейса :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Общие характеристики -->
										<tr>
											<td class="fc">
												Общие характеристики :
											</td>
											<td>
											</td>
										</tr>
										<!-- год выпуска транспортного средства -->
										<tr>
											<td class="fc">
												год выпуска транспортного средства :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- вместительность каждого транспортного средства -->
										<tr>
											<td class="fc">
												вместительность каждого транспортного средства :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- грузоподъемность каждого транспортного средства -->
										<tr>
											<td class="fc">
												грузоподъемность каждого транспортного средства :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- дата последнего технического обслуживания (освидетельствования, ремонта) -->
										<tr>
											<td class="fc">
												дата последнего технического обслуживания (освидетельствования, ремонта) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- срок службы транспортного средства -->
										<tr>
											<td class="fc">
												срок службы транспортного средства :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- эксплуатационный ресурс -->
										<tr>
											<td class="fc">
												эксплуатационный ресурс :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- ресурс для списания -->
										<tr>
											<td class="fc">
												ресурс для списания :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- рабочий ресурс -->
										<tr>
											<td class="fc">
												рабочий ресурс :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Форма собственности -->
										<tr>
											<td class="fc">
												Форма собственности :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Принадлежность каждого транспорта -->
										<tr>
											<td class="fc">
												Принадлежность каждого транспорта :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Информация о владельце (полный почтовый адрес, телефон, факс и e-mail организации, ФИО руководителей) -->
										<tr>
											<td class="fc">
												Информация о владельце (полный почтовый адрес, телефон, факс и e-mail организации, ФИО руководителей) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Наличие системы -->
										<tr>
											<td class="fc">
												Наличие системы :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Наличие аварийно-спасательных служб и формирований -->
										<tr>
											<td class="fc">
												Наличие аварийно-спасательных служб и формирований :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Наличие финансовых и материальных ресурсов для ликвидации аварии -->
										<tr>
											<td class="fc">
												Наличие финансовых и материальных ресурсов для ликвидации аварии :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Характер происшествия -->
										<tr>
											<td class="fc">
												Характер происшествия :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Обстоятельства и причины, приведшие к ЧС (описание) -->
										<tr>
											<td class="fc">
												Обстоятельства и причины, приведшие к ЧС (описание) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Количество транспорта, попавшего в аварию -->
										<tr>
											<td class="fc">
												Количество транспорта, попавшего в аварию :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Скорость движения транспортных средств -->
										<tr>
											<td class="fc">
												Скорость движения транспортных средств :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Описание состояния транспортных магистралей, железнодорожного полотна, взлетной полосы и т.д. -->
										<tr>
											<td class="fc">
												Описание состояния транспортных магистралей, железнодорожного полотна, взлетной полосы и т.д. :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Количество объектов попавших в зону ЧС -->
										<tr>
											<td class="fc">
												Количество объектов попавших в зону ЧС :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!--населенных пунктов -->
										<tr>
											<td class="fc">
												населенных пунктов (ед.) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!--водных акваторий (площадь, км) -->
										<tr>
											<td class="fc">
												водных акваторий (площадь, км) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- дорог (км) -->
										<tr>
											<td class="fc">
												дорог (км) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- ЛЭП (км) -->
										<tr>
											<td class="fc">
												ЛЭП (км) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Природные и климатические условия (описание) -->
										<tr>
											<td class="fc">
												Природные и климатические условия (описание) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- скорость ветра, м/с -->
										<tr>
											<td class="fc">
												скорость ветра, м/с :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- направление ветра -->
										<tr>
											<td class="fc">
												направление ветра :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- температура воздуха, С -->
										<tr>
											<td class="fc">
												температура воздуха, С :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- атмосферное давление, р.с.-->
										<tr>
											<td class="fc">
												атмосферное давление, р.с. :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- влажность воздуха-->
										<tr>
											<td class="fc">
												влажность воздуха :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- количество осадков -->
										<tr>
											<td class="fc">
												количество осадков :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Наличие и характер разрушений, загрязнения окружающей среды (характеристики, описание) -->
										<tr>
											<td class="fc">
												Наличие и характер разрушений, загрязнения окружающей среды (характеристики, описание) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Площадь распространения ЧС, км -->
										<tr>
											<td class="fc">
												Площадь распространения ЧС, км :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
									</table>
								</div>
								<div id="tabs-6">
									<br/>
									<table width="100%" border="0">
										<!-- Описание происшедшего ЧС-->
										<tr>
											<td class="fc">
												Описание происшедшего ЧС :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Условия, способствовавшие развитию происшествия -->
										<tr>
											<td class="fc">
												Условия, способствовавшие развитию происшествия :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Обстоятельства возникновения происшествия -->
										<tr>
											<td class="fc">
												Обстоятельства возникновения происшествия :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Особенности происшествия -->
										<tr>
											<td class="fc">
												Особенности происшествия :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Анализ возможных причин возникновения ЧС -->
										<tr>
											<td class="fc">
												Анализ возможных причин возникновения ЧС :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Принятые меры по обеспечению техники безопасности -->
										<tr>
											<td class="fc">
												Принятые меры по обеспечению техники безопасности :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Условия, способствовавшие получению травм и гибели людей -->
										<tr>
											<td class="fc">
												Условия, способствовавшие получению травм и гибели людей :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Выделение финансовых средств на мероприятия по ликвидации последствий ЧС из -->
										<tr>
											<td class="fc">
												Выделение финансовых средств на мероприятия по ликвидации последствий ЧС из :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- О проведенных мероприятиях по предупреждению и снижению тяжести случившегося ЧС -->
										<tr>
											<td class="fc">
												О проведенных мероприятиях по предупреждению и снижению тяжести случившегося ЧС :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Положительные стороны и недостатки при ликвидации ЧС -->
										<tr>
											<td class="fc">
												Положительные стороны и недостатки при ликвидации ЧС :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Выводы, предложения, меры -->
										<tr>
											<td class="fc">
												Выводы, предложения, меры :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
										<!-- Ответственный по заполнению (ФИО, должность, тел.) -->
										<tr>
											<td class="fc">
												Ответственный по заполнению (ФИО, должность, тел.) :
											</td>
											<td>
												<input type="text" name="carddate" maxlength="10" class="td_editable" style="width:80px;" value="{document/fields/carddate}"/>
											</td>
										</tr>
									</table>
								</div>

							<!-- Скрытые поля -->
							<input type="hidden" name="type" value="save"/>
							<input type="hidden" name="id" value="{/request/@id}"/>
							<input type="hidden" name="author" value="{document/fields/author/@attrval}"/>
							<input type="hidden" name="doctype" value="{document/@doctype}"/>
							<input type="hidden" name="key" value="{document/@docid}"/>
							<input type="hidden" id="currentuserid" value="{@userid}"/>
							<input type="hidden" id="localusername" value="{@username}"/>
						</form>
					</div>
					<div style="height:10px"/>
				</div>
			</div>
			<xsl:call-template name="formoutline"/>
		</body>
	</html>
	</xsl:template>
</xsl:stylesheet>