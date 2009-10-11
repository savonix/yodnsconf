<!--
Program: YoDNSConf
Component: html_custom.xsl
Copyright: Savonix Corporation
Author: Albert L. Lash, IV
License: Gnu Affero Public License version 3
http://www.gnu.org/licenses

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program; if not, see http://www.gnu.org/licenses
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="xml" indent="yes" encoding="UTF-8"
  omit-xml-declaration="no" doctype-public="-//W3C//DTD XHTML 1.1//EN"
  doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" />
  <xsl:strip-space elements="*"/>
  <xsl:template match="/">
    <html>
      <xsl:variable name="link_prefix" select="/_R_/runtime/link_prefix"/>
      <xsl:variable name="path_prefix" select="/_R_/runtime/path_prefix"/>
      <xsl:variable name="my18n"
        select="document('../../i18n/en_US/yodnsconf.xml')/i18n"/>

      <xsl:call-template name="head">
        <xsl:with-param name="link_prefix" select="$link_prefix"/>
        <xsl:with-param name="path_prefix" select="$path_prefix"/>
      </xsl:call-template>
      <body>
				<xsl:for-each select="//pre_body_content">
					<xsl:sort select="priority" order="ascending"/>
					<xsl:apply-templates select="nodes/*"/>
				</xsl:for-each>

        <xsl:call-template name="main">
          <xsl:with-param name="link_prefix" select="$link_prefix"/>
          <xsl:with-param name="path_prefix" select="$path_prefix"/>
          <xsl:with-param name="i18n" select="$my18n"/>
        </xsl:call-template>

        <xsl:for-each select="//footer_nodes">
          <xsl:sort select="priority" order="ascending"/>
          <xsl:apply-templates select="nodes/*"/>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>


  <xsl:template name="header">
    <xsl:param name="link_prefix"/>
    <xsl:param name="i18n"/>
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">header</xsl:with-param>
    </xsl:call-template>
    <div id="header">
      <div style="float:right;margin: 4px;">
        <form action="index.php" method="get">
          <input type="hidden" name="nid" value="journal-search" />
          <input type="text" name="entry_search" />
          <input type="submit" />
        </form>
      </div>
    	<span id="company-name">
        <xsl:value-of select="//runtime/company_name"/>
      </span>
      <h1 class="page-title">
        <xsl:value-of select="/_R_/i18n/*[name()=/_R_/_get/nid]"/>
      </h1>
    </div>

    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_end">header</xsl:with-param>
    </xsl:call-template>
  </xsl:template>



  <xsl:template name="button">
    <xsl:param name="key"/>
    <li>
      <div id="nav_{$key}">
        <xsl:if test="//_get/nid=/_R_/menu/item[key=$key]/item/url">
          <xsl:attribute name="class">nav_selected</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="/_R_/i18n/*[local-name()=$key]"/>
      </div>
      <ul>
        <xsl:for-each select="/_R_/menu/item[key=$key]/item">
          <xsl:variable name="my_key" select="key"/>
          <li>
            <a href="{/_R_/runtime/link_prefix}{url}" id="{key}">
              <xsl:value-of select="/_R_/i18n/*[local-name()=$my_key]"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>
    </li>
  </xsl:template>
  <xsl:template name="drop-downs">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>


<div style="padding-left: 10em; right:10px;z-index:1000;position:absolute;">
  <div style="float: right;">
  <form action="{$link_prefix}index" method="get">
  <xsl:if test="not(/_R_/_get/zone or /_R_/_get/origin)">
    <!-- to do: match selection -->
    <input type="hidden" name="nid" value="index"/>
    <select name="zone_group_id" onchange="location.href='{$link_prefix}index&amp;zone_group_id='+$(this).val()">
      <option value="%">Select All</option>
      <xsl:for-each select="//zone_groups_get_all/zone_groups_get_all">
      <xsl:variable name="zone_group_id" select="zone_group_id"/>
      <option value="{zone_group_id}">
        <xsl:if test="//runtime/zone_group_id=$zone_group_id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
        <xsl:value-of select="zone_group_name"/>
      </option>
      </xsl:for-each>
    </select>
    <input type="submit" value="Go"/>
  </xsl:if>
  </form>
  </div>

  <div style="float: right;">
  <form action="{$link_prefix}" method="get">
  <xsl:if test="not(/_R_/_get/zone or /_R_/_get/origin)">
    <!-- to do: match selection -->
    <input type="hidden" name="nid" value="zone-edit"/>
    <select name="zone_group_id" onchange="location.href='{$link_prefix}zone-edit&amp;zone='+$(this).val()">
      <option value="%">Quick Zone Links</option>
      <xsl:for-each select="//zones_get_all/zones_get_all[notes='quicklink']">
      <option value="{id}">
        <xsl:if test="//_get/zone_id=."><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
        <xsl:value-of select="origin"/>
      </option>
      </xsl:for-each>
    </select>
    <input type="submit" value="Go"/>
  </xsl:if>
  </form>
  </div>
</div>


  </xsl:template>

  <xsl:template name="head">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>


<head>
  <title>Web DNS <xsl:value-of select="/_R_/i18n/*[name()=//_get/nid]/."/>
    <xsl:if test="/_R_/_get/zone">
      :<xsl:value-of select="//zone_get_by_id/zone_get_by_id/origin"/>
    </xsl:if>
    <xsl:if test="/_R_/_get/host_id">
      :<xsl:value-of select="/_R_/hosts_get_all/hosts_get_all[id=/_R_/_get/host_id]/ip"/>
    </xsl:if>
 </title>
  <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/combo?2.7.0/build/reset/reset-min.css"/>
  <link rel="stylesheet" type="text/css" href="{$link_prefix}x-dynamic-css"></link>
  <link rel="stylesheet" type="text/css" href="{$path_prefix}s/css/thickbox.css"></link>
  <link rel="stylesheet" type="text/css" href="{$path_prefix}s/css/droppy.css"></link>
  <link rel="stylesheet" type="text/css" href="{/_R_/runtime/path_prefix}s/js/blue/style.css"/>
  <script type="text/javascript" src="{$path_prefix}s/js/jquery/jquery-1.3.2.min.js"></script>
  <script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.cookiejar.js"></script>
  <script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.droppy.js"></script>
  <script type="text/javascript" src="{$path_prefix}s/pkgs/tablesorter/jquery.tablesorter.js"></script>
  <script type="text/javascript" src="{$path_prefix}s/pkgs/tablesorter/addons/pager/jquery.tablesorter.pager.js"></script>
  <script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.dimensions.js"></script>
  <script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.date_input.js"></script>
  <script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.cookie.js"></script>
  <script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.json.js"></script>
  <script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.tablesorter.cookie.js"></script>
  <script type="text/javascript" src="{$link_prefix}x-javascript"></script>
  <script type="text/javascript" src="{$link_prefix}x-xhtml2dom-js"></script>
  <xsl:for-each select="//head_nodes">
    <xsl:sort select="priority" order="ascending"/>
    <xsl:apply-templates select="nodes/*"/>
  </xsl:for-each>
</head>


  </xsl:template>

</xsl:stylesheet>
