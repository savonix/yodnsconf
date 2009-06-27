<!--
Program: YoDNSConf
Component: zone_export.txt.xsl
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
<xsl:template match="/">$ORIGIN <xsl:value-of select="//zone_get_by_id/origin"/>
$TTL 12h
<xsl:value-of select="//zone_get_by_id/origin"/>  IN  SOA  <xsl:value-of select="//zone_get_by_id/ns"/><xsl:text> </xsl:text><xsl:value-of select="//zone_get_by_id/mbox"/> (
              <xsl:value-of select="//zone_get_by_id/serial"/><xsl:text>
              </xsl:text><xsl:value-of select="//zone_get_by_id/refresh"/><xsl:text>
              </xsl:text><xsl:value-of select="//zone_get_by_id/retry"/><xsl:text>
              </xsl:text><xsl:value-of select="//zone_get_by_id/expire"/><xsl:text>
              </xsl:text><xsl:value-of select="//zone_get_by_id/minimum"/>
              )
<xsl:for-each select="/_R_/records_get_by_id/records_get_by_id"><xsl:text>
</xsl:text>
<xsl:value-of select="name"/><xsl:text> </xsl:text><xsl:if test="ttl &gt; 0">IN <xsl:value-of select="ttl"/><xsl:text> </xsl:text></xsl:if><xsl:value-of select="type"/><xsl:if test="type='MX' or type='SRV'"><xsl:text> </xsl:text><xsl:value-of select="aux"/></xsl:if><xsl:if test="type='SRV'"><xsl:text> </xsl:text><xsl:value-of select="weight"/><xsl:text> </xsl:text><xsl:value-of select="port"/></xsl:if><xsl:text> </xsl:text><xsl:if test="type='TXT'">"</xsl:if><xsl:value-of select="data"/><xsl:if test="type='TXT'">"</xsl:if>
</xsl:for-each><xsl:text>
</xsl:text>
</xsl:template>
</xsl:stylesheet>
