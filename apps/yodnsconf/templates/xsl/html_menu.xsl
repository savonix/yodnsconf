<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: main_menu.xsl
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
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
  <xsl:template name="main_menu">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:variable
      name   = "my_origin"
      select = "/_R_/zone_get_by_id/zone_get_by_id/origin"
    />
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">main_menu</xsl:with-param>
    </xsl:call-template>

    <form action="{$link_prefix}index" method="get"
      style="padding-left: 10em; right:10px;z-index:1000;position:absolute;">
    <xsl:if test="not(/_R_/_get/zone)">
      <!-- to do: match selection -->
      <input type="hidden" name="nid" value="index"/>
      <select name="ns_filter">
        <option value="%">Select All</option>
        <xsl:for-each select="//zones_get_ns/zones_get_ns/ns">
        <option value="{.}">
          <xsl:if test="//runtime/ns_filter=."><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
          <xsl:value-of select="."/>
        </option>
        </xsl:for-each>
      </select>
      <input type="submit" value="Go"/>
    </xsl:if>
    </form>
    <ul id="nav">
      <li>
        <a href="{$link_prefix}index">
          <xsl:value-of select="/_R_/i18n/zones"/>
        </a>
      </li>
        <xsl:if test="not(/_R_/_get/zone)">
        <li>
					<a href="{$link_prefix}zone-edit">
						<xsl:value-of select="/_R_/i18n/new_zone"/>
					</a>
        </li>
        <li>
					<a href="{$link_prefix}redirects">
						<xsl:value-of select="/_R_/i18n/redirects"/>
					</a>
        </li>
        <li>
					<a href="{$link_prefix}ip">
						<xsl:value-of select="/_R_/i18n/ip"/>
					</a>
        </li>
        <li>
					<a href="{$link_prefix}hosts">
						<xsl:value-of select="/_R_/i18n/hosts"/>
					</a>
        </li>
				<li>
          <a href="{$link_prefix}services">
						<xsl:value-of select="/_R_/i18n/services"/>
					</a>
        </li>
        <li>
					<a href="{$link_prefix}yodns-options">
						<xsl:value-of select="/_R_/i18n/options"/>
					</a>
        </li>
				</xsl:if>
        <xsl:if test="/_R_/_get/zone">
          <li>
          <a href="{$link_prefix}zone-edit&amp;zone={/_R_/_get/zone}">
            <span style="color: #8C2323; font-weight: bold;">
              <xsl:value-of select="$my_origin"/>
            </span>
          </a>
          </li>
          <li>
          <a href="{$link_prefix}records&amp;zone={/_R_/_get/zone}">
            Records
          </a>
          </li>
          <li>
          <a href="{$link_prefix}record-edit&amp;zone={/_R_/_get/zone}">
            New Record
          </a>
          </li>
          <li>
          <a href="http://www.{substring($my_origin,0,string-length($my_origin))}" target="_blank">
            Visit
          </a>
          </li>
        </xsl:if>
    </ul>
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_end">main_menu</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="menu">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:variable
      name   = "my_origin"
      select = "/_R_/zone_get_by_id/zone_get_by_id/origin"
    />
    <script type="text/javascript">
    $(document).ready(function()
    {
        $('#nav').droppy();
    });
    </script>
    <form action="{$link_prefix}index" method="get"
      style="padding-left: 10em; right:10px;z-index:1000;position:absolute;">
    <xsl:if test="not(/_R_/_get/zone)">
      <!-- to do: match selection -->
      <input type="hidden" name="nid" value="index"/>
      <select name="ns_filter">
        <option value="%">Select All</option>
        <xsl:for-each select="//zones_get_ns/zones_get_ns/ns">
        <option value="{.}">
          <xsl:if test="//runtime/ns_filter=."><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
          <xsl:value-of select="."/>
        </option>
        </xsl:for-each>
      </select>
      <input type="submit" value="Go"/>
    </xsl:if>
    </form>
    <ul id="nav">
      <xsl:for-each select="/_R_/menu/item[not(@active=0)]">
        <xsl:call-template name="button">
          <xsl:with-param name="key" select="key"/>
        </xsl:call-template>
      </xsl:for-each>
      
        <xsl:if test="/_R_/_get/zone">
          <li>
          <a href="{$link_prefix}zone-edit&amp;zone={/_R_/_get/zone}">
            <span style="color: #8C2323; font-weight: bold;">
              <xsl:value-of select="$my_origin"/>
            </span>
          </a>
          </li>
          <li>
          <a href="{$link_prefix}records&amp;zone={/_R_/_get/zone}">
            Records
          </a>
          </li>
          <li>
          <a href="{$link_prefix}record-edit&amp;zone={/_R_/_get/zone}">
            New Record
          </a>
          </li>
          <li>
          <a href="http://www.{substring($my_origin,0,string-length($my_origin))}" target="_blank">
            Visit
          </a>
          </li>
        </xsl:if>
    </ul>
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
</xsl:stylesheet>
