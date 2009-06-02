<!--
Program: YoDNSConf
Component: 	pfsense_dhcp_config_export.xml.xsl
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
<xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="yes" />
<xsl:template match="/">
<dhcpd>
	<lan>
		<range>
			<from>192.168.1.170</from>
			<to>192.168.1.180</to>
		</range>
		<defaultleasetime>28800</defaultleasetime>
		<maxleasetime>86400</maxleasetime>
		<netmask/>
		<failover_peerip/>
		<gateway/>
		<ddnsdomain/>
		<next-server>192.168.1.32</next-server>
		<filename>pxeboot</filename>
		<enable/>
		<staticmap>
			<mac></mac>
			<ipaddr>192.168.1.32</ipaddr>
			<hostname></hostname>
			<descr></descr>
		</staticmap>
		<netboot/>
		<dnsserver>4.2.2.1</dnsserver>
		<dnsserver>192.168.8.2</dnsserver>
	</lan>
</dhcpd>
</xsl:template>
</xsl:stylesheet>
