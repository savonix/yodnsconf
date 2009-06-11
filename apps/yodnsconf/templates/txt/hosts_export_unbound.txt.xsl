<!--
Program: YoDNSConf
Component: hosts_export.txt.xsl
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
<xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:template match="/">
<xsl:text>

	access-control: 192.168.0.0/16 allow
	access-control: 172.20.0.184/32 allow
	access-control: 192.168.134.22/32 allow
	chroot: ""
</xsl:text>
  <xsl:for-each select="/_R_/hosts_get_all/hosts_get_all">
    <xsl:text>	local-data: "</xsl:text><xsl:value-of select="host"/><xsl:text> </xsl:text>
		<xsl:if test="priority &gt;= 0">A</xsl:if>
		<xsl:if test="priority &lt; 0">PTR</xsl:if>
		<xsl:text> </xsl:text><xsl:value-of select="ip"/><xsl:text>"</xsl:text>
    <xsl:text>
</xsl:text>
  </xsl:for-each>
<!-- string-length(ip) -->
</xsl:template>
</xsl:stylesheet>
