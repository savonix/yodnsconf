<!--
Program: YoDNSConf
Component: lua_tables.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"
  omit-xml-declaration = "yes"
  version="1.0"
  encoding = "UTF-8"
/>

<xsl:template match="/">
  <xsl:text>dbconfig={}

</xsl:text>
  <xsl:for-each select="//datasource[@id='yodnsconf_read']/*">
    <xsl:text>dbconfig["</xsl:text>
    <xsl:value-of select="local-name()"/>"] = "<xsl:value-of select="."/>
    <xsl:text>"
</xsl:text>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
