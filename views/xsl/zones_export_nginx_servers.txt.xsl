<!--
Program: YoDNSConf
Component: zones_export_nginx_map.txt.xsl
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

server {

  listen 80 default;
  server_name _;

  location / {
    proxy_set_header   Host             $host;
<xsl:for-each select="/_R_/zone_groups_get_all/zone_groups_get_all">
    # <xsl:value-of select="zone_group_name" />
    if ($zone_group_id = <xsl:value-of select="zone_group_id" />) {
      break;
      proxy_pass  http://<xsl:value-of select="zone_group_http_proxy" />;
    }
</xsl:for-each>
    proxy_pass http://127.0.0.1:6081;
  }


  location /s/ {
<xsl:for-each select="/_R_/zone_groups_get_all/zone_groups_get_all">
    # <xsl:value-of select="zone_group_name" />
    if ($zone_group_id = <xsl:value-of select="zone_group_id" /><xsl:text>) {</xsl:text>
    <xsl:if test="contains(zone_group_static_paths,'/s/') or zone_group_id='2'">
      root /var/www/public;
    </xsl:if>
    <xsl:if test="not(zone_group_id='2')">
      break;
      proxy_pass  http://<xsl:value-of select="zone_group_http_proxy" />;
    </xsl:if>
    <xsl:text>}</xsl:text>
</xsl:for-each>
  }
}
</xsl:template>
</xsl:stylesheet>
