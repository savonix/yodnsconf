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

<xsl:param name="main_menu_doc" select="document('../../data/xml/main_menu.xml')"/>
<xsl:variable name="i18n" select="document('../../i18n/en_US/yodnsconf.xml')"/>

<xsl:template name="page">
<html>

  <xsl:call-template name="head" />
  <body>
    <xsl:for-each select="//pre_body_content">
      <xsl:sort select="priority" order="ascending"/>
      <xsl:apply-templates select="nodes/*"/>
    </xsl:for-each>

    <div id="main">
      <xsl:call-template name="drop-downs" />
      <xsl:call-template name="main-menu" />
    
      <div id="content">
        <xsl:apply-templates />
      </div>
    
      <div id="nofooter"/>
    </div>

    <xsl:for-each select="//footer_nodes">
      <xsl:sort select="priority" order="ascending"/>
      <xsl:apply-templates select="nodes/*"/>
    </xsl:for-each>
  </body>
</html>


  </xsl:template>


  <xsl:template name="header">
    <div id="header">
    </div>
  </xsl:template>




  <xsl:template name="drop-downs">

<div id="zonelinks">
  <div style="float: right;">
    <form action="{$link_prefix}index" method="get">
      <!-- to do: match selection -->
      <fieldset>
      <input type="hidden" name="nid" value="index"/>
      <select name="zone_group_id">
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
      </fieldset>
    </form>
  </div>

  <div style="float: right;">
    <form action="{$link_prefix}" method="get">
      <!-- to do: match selection -->
      <fieldset>
      <input type="hidden" name="nid" value="zone-edit"/>
      <select name="zone_group_id">
        <option value="%">Quick Zone Links</option>
        <xsl:for-each select="//zones_get_all/zones_get_all[notes='quicklink']">
        <option value="{id}">
          <xsl:if test="//_get/zone_id=."><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
          <xsl:value-of select="origin"/>
        </option>
        </xsl:for-each>
      </select>
      <input type="submit" value="Go"/>
      </fieldset>
    </form>
  </div>
  <xsl:if test="/_R_/zone_get_by_id/zone_get_by_id/id">
    <div id="zoneoptions">
      <a href="{$link_prefix}zone-edit&amp;zone={/_R_/zone_get_by_id/zone_get_by_id/id}">
        <xsl:value-of select="/_R_/zone_get_by_id/zone_get_by_id/origin"/>
      </a>
      <a href="{$link_prefix}records&amp;zone={/_R_/zone_get_by_id/zone_get_by_id/id}">
        <span id="i18n-records">Records</span>
      </a>
    </div>
  </xsl:if>
</div>


  </xsl:template>

  <xsl:template name="head">


<head>
  <title>YDC <xsl:value-of select="/_R_/i18n/*[name()=//_get/nid]/."/>
    <xsl:if test="/_R_/_get/zone">
      :<xsl:value-of select="//zone_get_by_id/zone_get_by_id/origin"/>
    </xsl:if>
    <xsl:if test="/_R_/_get/host_id">
      :<xsl:value-of select="/_R_/hosts_get_all/hosts_get_all[id=/_R_/_get/host_id]/ip"/>
    </xsl:if>
 </title>
    <script type="text/javascript">
var app_prefix = '<xsl:value-of select="$path_prefix"/>';
    </script>
  <link rel="stylesheet" type="text/css" href="{$path_prefix}s/css/bundles/all.css?{$TS}"></link>
  <link rel="stylesheet" type="text/css" href="{$link_prefix}s/css/stylesheet.css"></link>
  <script type="text/javascript" src="{$path_prefix}s/js/bundles/all.js?{$TS}"></script>
  <xsl:for-each select="//head_nodes">
    <xsl:sort select="priority" order="ascending"/>
    <xsl:apply-templates select="nodes/*"/>
  </xsl:for-each>
</head>


  </xsl:template>

  	<!-- UI PRIMARY MENU -->
  <xsl:template name="main-menu">
    <ul id="nav">
      <xsl:for-each select="$main_menu_doc/menu/item">
        <xsl:call-template name="list-button">
          <xsl:with-param name="key" select="key"/>
        </xsl:call-template>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- UI LIST BUTTON -->
  <xsl:template name="list-button">
    <xsl:param name="key"/>
<li>
  <div><xsl:value-of select="$i18n/i18n/*[local-name()=$key]"/></div>
  <ul>
    <xsl:for-each select="$main_menu_doc/menu/item[key=$key]/item">
      <xsl:variable name="my_key" select="key"/>
      <li>
        <a href="{$link_prefix}{url}" id="{key}">
          <xsl:value-of select="$i18n/i18n/*[local-name()=$my_key]"/>
        </a>
      </li>
    </xsl:for-each>
  </ul>
</li>
  </xsl:template>


</xsl:stylesheet>
