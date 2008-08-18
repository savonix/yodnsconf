<!--
Program: YoDNSConf
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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="main_menu">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">main_menu</xsl:with-param>
    </xsl:call-template>

    <div id="main-menu">

      <div id="main-menu-buttons">
        <a href="{$link_prefix}index" class="menu-button">
          <xsl:value-of select="/_R_/i18n/zones"/>
        </a>
        <xsl:if test="/_R_/_get/zone">
        <a href="{$link_prefix}zone-edit" class="menu-button">
          <xsl:value-of select="/_R_/i18n/new_zone"/>
        </a>
        <a href="{$link_prefix}redirects" class="menu-button">
          <xsl:value-of select="/_R_/i18n/redirects"/>
        </a>
        <a href="{$link_prefix}ip" class="menu-button">
          <xsl:value-of select="/_R_/i18n/ip"/>
        </a>
        <a href="{$link_prefix}hosts" class="menu-button">
          <xsl:value-of select="/_R_/i18n/hosts"/>
        </a>
        <a href="{$link_prefix}options" class="menu-button">
          <xsl:value-of select="/_R_/i18n/options"/>
        </a>
				</xsl:if>
        <xsl:if test="/_R_/_get/zone">
          <a href="{$link_prefix}zone-edit&amp;zone={/_R_/_get/zone}"
            class="menu-button">
            <span style="color: red; font-weight: bold;">
              <xsl:value-of select="//zone_get_by_id/origin"/>
            </span>
          </a>
          <a href="{$link_prefix}records&amp;zone={/_R_/_get/zone}"
            class="menu-button">
            Records
          </a>
          <a href="{$link_prefix}record-edit&amp;zone={/_R_/_get/zone}"
            class="menu-button">
            New Record
          </a>
          <a href="http://www.{//origin}" class="menu-button" target="_blank">
            Visit
          </a>
        </xsl:if>
        <xsl:if test="not(/_R_/_get/zone)">
				<!-- to do: match selection -->
				<form action="{$link_prefix}index" method="get" style="padding-left: 10em; display: inline;">
				<input type="hidden" name="nid" value="index"/>
				<select name="ns_filter">
					<option value="%">Select All</option>
					<option value="ns1.savonix.com.">ns1.savonix.com.</option>
					<option value="ns1.archiecomics.com.">ns1.archiecomics.com.</option>
				</select>
				<input type="submit" value="Go"/>
				</form>
				</xsl:if>
      </div>
    </div>
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_end">main_menu</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
