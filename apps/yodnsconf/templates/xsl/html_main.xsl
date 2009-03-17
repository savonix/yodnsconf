<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: main.xsl
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
  <xsl:include href="html_shell.xsl"/>
  <xsl:include href="html_head.xsl"/>
  <xsl:include href="html_header.xsl"/>
  <xsl:include href="html_footer.xsl"/>
  <xsl:include href="html_menu.xsl"/>
  <xsl:include href="source_spacer.xsl"/>
  <xsl:template name="main">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>


    <div id="main">
      <xsl:call-template name="main_menu">
          <xsl:with-param name="link_prefix" select="$link_prefix"/>
          <xsl:with-param name="path_prefix" select="$path_prefix"/>
        </xsl:call-template>

      <div id="content">
        <xsl:call-template name="content">
          <xsl:with-param name="link_prefix" select="$link_prefix"/>
          <xsl:with-param name="path_prefix" select="$path_prefix"/>
        </xsl:call-template>
      </div>

      <xsl:call-template name="footer"/>
    </div>
  </xsl:template>
</xsl:stylesheet>