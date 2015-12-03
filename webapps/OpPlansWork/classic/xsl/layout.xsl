<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="templates/constants.xsl"/>
    <xsl:import href="templates/outline.xsl"/>
    <xsl:import href="templates/view.xsl"/>
    <xsl:import href="templates/actions.xsl"/>
    <xsl:import href="templates/utils.xsl"/>

    <xsl:variable name="isAjaxRequest" select="//ajax = '1'"/>

    <xsl:output method="html" encoding="utf-8" indent="no"/>
    <xsl:decimal-format name="df" grouping-separator=" "/>

    <xsl:template name="layout">
        <xsl:param name="w_title" select="concat(//captions/viewnamecaption/@caption, ' - ', $APP_NAME)"/>
        <xsl:param name="active_aside_id" select="//current_outline_entry/response/content/entry/@id"/>
        <xsl:param name="aside_collapse" select="''"/>
        <xsl:param name="include" select="''"/>
        <xsl:param name="body_class" select="''"/>

        <xsl:call-template name="HTML-DOCTYPE"/>
        <html>
            <xsl:call-template name="html_head">
                <xsl:with-param name="w_title" select="$w_title"/>
                <xsl:with-param name="include" select="$include"/>
            </xsl:call-template>
            <body class="layout_fullscreen {$body_class}">
                <div class="main-load" id="main-load" style="display:none"></div>
                <div class="layout layout_header-fixed {$aside_collapse}">
                    <div class="content-overlay" id="content-overlay"></div>
                    <xsl:call-template name="main-header"/>
                    <xsl:apply-templates select="//included_share_navi" mode="outline">
                        <xsl:with-param name="active-entry-id" select="$active_aside_id"/>
                    </xsl:apply-templates>
                    <section class="layout_content">
                        <xsl:call-template name="_content"/>
                    </section>
                    <xsl:call-template name="main-footer"/>
                </div>
                <xsl:call-template name="util-js-mark-as-read"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="_content"/>

    <xsl:template name="html_head">
        <xsl:param name="include" select="''"/>
        <xsl:param name="w_title" select="''"/>
        <head>
            <title>
                <xsl:value-of select="$w_title"/>
            </title>
            <link rel="shortcut icon" href="favicon.ico"/>
            <meta name="format-detection" content="telephone=no"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

            <link rel="stylesheet" href="/SharedResources/vendor/bootstrap/css/bootstrap.min.css"/>
            <link type="text/css" rel="stylesheet"
                  href="/SharedResources/vendor/font-awesome/css/font-awesome.min.css"/>
            <link type="text/css" rel="stylesheet"
                  href="/SharedResources/vendor/jquery/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>
            <link type="text/css" rel="stylesheet" href="classic/css/all.min.css"/>

            <xsl:call-template name="STYLE_FIX_FIELDSET"/>

            <script type="text/javascript" src="/SharedResources/vendor/jquery/jquery-2.1.4.min.js"></script>
            <script src="/SharedResources/vendor/bootstrap/js/bootstrap.min.js"></script>
            <script type="text/javascript"
                    src="/SharedResources/vendor/jquery/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
            <script type="text/javascript" src="/SharedResources/vendor/jquery/jquery.cookie.min.js"></script>
            <script type="text/javascript" src="classic/scripts/form-ui-init.js"></script>
            <script type="text/javascript" src="/SharedResources/nb/js/nb.build.js"></script>

            <xsl:copy-of select="$include"/>
        </head>
    </xsl:template>

    <xsl:template name="main-header">
        <header class="layout_header navbar navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button class="navbar-toggle collapsed" type="button" data-toggle="collapse"
                            data-target="#nb-navbar"
                            aria-controls="nb-navbar" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <img alt="logo" src="{$APP_LOGO_IMG_SRC}" class="brand-logo" height="50px"/>
                    <span class="brand-title">
                        <xsl:value-of select="$APP_NAME"/>
                        <small>Учет сведений о ЧС</small>
                    </span>
                </div>
                <nav id="nb-navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <xsl:value-of select="@username"/>
                                <i class="fa fa-angle-down"></i>
                            </a>
                            <ul class="dropdown-menu right">
                                <li>
                                    <a id="currentuser" title="{//captions/view_userprofile/@caption}"
                                       href=" Provider?type=edit&amp;element=userprofile&amp;id=userprofile">
                                        <xsl:value-of select="@username"/>
                                    </a>
                                </li>
                                <li>
                                    <a id="logout" href="Logout" title="{document/captions/logout/@caption}">
                                        <xsl:value-of select="//captions/logout/@caption"/>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <xsl:if test="not(document)">
                        <form class="navbar-form navbar-right" role="search" onsubmit="return false;">
                            <input type="text" class="form-control" name="keyword" placeholder="Search"/>
                        </form>
                    </xsl:if>
                </nav>
            </div>
        </header>
    </xsl:template>

    <xsl:template name="main-footer"/>

    <xsl:template match="action" mode="header">
        <a class="no-desktop head-item nav-action" title="{@hint}" href="#" data-action="{@id}">
            <xsl:if test="js">
                <xsl:attribute name="href" select="concat('javascript:', js)"/>
            </xsl:if>
            <xsl:if test="@url != ''">
                <xsl:attribute name="href" select="@url"/>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="@id = 'add_new'">
                    <i class="fa fa-plus"/>
                </xsl:when>
                <xsl:when test="@id = 'delete_document'">
                    <i class="fa fa-remove"/>
                </xsl:when>
            </xsl:choose>
            <span class="action-label">
                <xsl:value-of select="@caption"/>
            </span>
        </a>
    </xsl:template>

</xsl:stylesheet>
