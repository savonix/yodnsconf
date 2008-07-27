<!--
Program: YoDNSConf
Component: redirects_export.xsl
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

$ORIGIN <xsl:value-of select="name"/>
$TTL 12he
savonix.com.  IN  SOA  ns.savonix.com. username.savonix.com (
              2007120710
              1d 
              1d
              4w
              1h
              )

savonix.com.  NS    ns1
savonix.com.  NS    ns2
savonix.com.  NS    ns3
savonix.com.  NS    ns4

savonix.com.  MX    10 mail.savonix.com.
savonix.com.  A     64.25.86.90
ns1            A    64.25.86.90
www           CNAME ns1
mx3          A      64.25.86.86


</xsl:template>
</xsl:stylesheet>
