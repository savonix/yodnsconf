<!--
Program: YoDNSConf
Component: hostgroups_export_nagios3.txt.xsl
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

  <xsl:for-each select="/_R_/hostgroups_get_all/hostgroups_get_all">
		<xsl:variable name="my_hostgroup_id" select="id"/>
define hostgroup {
	hostgroup_name  <xsl:value-of select="name"/>
	alias           <xsl:value-of select="alias"/>
	<xsl:text>
	members         </xsl:text>
	<xsl:for-each select="/_R_/hostgroups_get_all_hosts/hostgroups_get_all_hosts[id=$my_hostgroup_id]">
		<xsl:value-of select="host"/>
		<xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
	</xsl:for-each>
}
			<xsl:text>
</xsl:text>
  </xsl:for-each>
</xsl:template>
</xsl:stylesheet>
