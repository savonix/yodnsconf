<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: source_spacer.xsl
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
  <xsl:template name="source_spacer">
    <xsl:param name="section_start"></xsl:param>
    <xsl:param name="section_end"></xsl:param>
    <xsl:if test="not($section_end='')">
      <xsl:comment>
        <xsl:value-of select="$section_end"/> end</xsl:comment>
    </xsl:if>
    <xsl:if test="not($section_start='')">
      <xsl:comment>
        <xsl:value-of select="$section_start"/> start</xsl:comment>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
