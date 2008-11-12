<!--
Program: YoDNSConf
Component: head.xsl
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
  <xsl:template name="head">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>



    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">head</xsl:with-param>
    </xsl:call-template>
    <head>
      <title>Web DNS:
        <xsl:if test="/_R_/_get/zone">
              <xsl:value-of select="//zone_get_by_id/origin"/>
        </xsl:if>
     </title>
      <link rel="stylesheet" type="text/css" href="{$link_prefix}dynamic-css"></link>
      <script type="text/javascript" src="{$path_prefix}/s/js/jquery/jquery.js"></script>
      <script type="text/javascript" src="{$path_prefix}/s/js/jquery/plugins/jquery.cookiejar.js"></script>
      <script type="text/javascript" src="{$path_prefix}/s/js/jquery/plugins/jquery.tablesorter.min.js"></script>
      <script type="text/javascript" src="{$path_prefix}/s/js/jquery/plugins/jquery.tablesorter.pager.js"></script>
      <script type="text/javascript" src="{$path_prefix}/s/js/jquery/plugins/jquery.dimensions.js"></script>
      <script type="text/javascript" src="{$path_prefix}/s/js/jquery/plugins/jquery.date_input.js"></script>
      <script type="text/javascript" src="{$path_prefix}/s/js/jquery/plugins/jquery.cookie.js"></script>
      <script type="text/javascript" src="{$path_prefix}/s/js/jquery/plugins/jquery.json.js"></script>
      <script type="text/javascript" src="{$path_prefix}/s/js/jquery/plugins/jquery.tablesorter.cookie.js"></script>
      <script type="text/javascript" src="{$path_prefix}/s/js/jquery.uitablefilter.js"></script>
      <xsl:for-each select="/_R_/in_head">
        <xsl:sort select="priority"/>
        <xsl:value-of select="string" disable-output-escaping="yes"/>
      </xsl:for-each>
    </head>

    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">head</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
