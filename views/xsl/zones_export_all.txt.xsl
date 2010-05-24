<!--
Program: YoDNSConf
Component: zones_export_all.txt.xsl
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
<!-- select template via parameter -->
</xsl:template>

<xsl:template name="default">
<xsl:for-each select="/_R_/zones_get_all/zones_get_all"><xsl:text>
    </xsl:text>zone:
    	name: <xsl:value-of select="origin"/>
	zonefile: zones/<xsl:value-of select="origin"/>zone
</xsl:for-each>
</xsl:template>

<xsl:template name="download">
<xsl:for-each select="/_R_/zones_get_all/zones_get_all">
wget -O <xsl:value-of select="origin"/>zone http://<xsl:value-of select="//runtime/export_target_server"/>/a/dev/yodnsconf/index.php?nid=x-zone-export\&amp;zone=<xsl:value-of select="id"/></xsl:for-each>

</xsl:template>

<xsl:template name="unbound">
<xsl:for-each select="//records_get_all_www/records_get_all_www">
    <xsl:text>  local-data: "</xsl:text>
    <xsl:value-of select="name"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="substring(origin,0,string-length(origin))"/>
    <xsl:text> A 192.168.8.2"
</xsl:text>
</xsl:for-each>
<xsl:text>  local-data: "www-b.evenserver.com A 192.168.8.2"
  local-data: "www-abc.evenserver.com A 192.168.8.2"
  local-data: "www-abch.evenserver.com A 192.168.8.2"
  local-data: "www-02.evenserver.com A 192.168.8.2"
  local-data: "www-01.evenserver.com A 192.168.8.2"</xsl:text>
</xsl:template>

<xsl:template name="bind">
<xsl:for-each select="/_R_/zones_get_all/zones_get_all"><xsl:text>
</xsl:text>zone "<xsl:value-of select="origin"/>" {
	type master;
	file "/etc/bind/zones/<xsl:value-of select="origin"/>zone";
};
</xsl:for-each>

</xsl:template>



<xsl:template name="maradns">
<xsl:for-each select="/_R_/zones_get_all/zones_get_all">
<xsl:text>csv2["</xsl:text><xsl:value-of select="origin"/>"] = "<xsl:value-of select="origin"/>zone"
</xsl:for-each>

</xsl:template>


<xsl:template name="csv">
<xsl:for-each select="/_R_/zones_get_all/zones_get_all">
  <xsl:if test="//_get/simple='true'">
    <xsl:text>.</xsl:text>
    <xsl:value-of select="substring(origin,0,string-length(origin))"/>
    <xsl:text> </xsl:text>
  </xsl:if>
  <xsl:if test="not(//_get/simple) or //_get/simple=''">
    <xsl:text>www.</xsl:text>
    <xsl:value-of select="substring(origin,0,string-length(origin))"/>
    <xsl:text>,</xsl:text>
  </xsl:if>
</xsl:for-each>
</xsl:template>

<xsl:template name="nginxmap">
map_hash_bucket_size 128;
map $http_host $zone_group_id {
  hostnames;
<xsl:for-each select="/_R_/zones_get_all/zones_get_all">

    <xsl:text>  .</xsl:text>
    <xsl:value-of select="substring(origin,0,string-length(origin))"/>
    <xsl:text> </xsl:text><xsl:value-of select="zone_group_id" />;
</xsl:for-each>
}
</xsl:template>

<xsl:template name="nginxservers">

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





<xsl:template name="nginxzonegroup">

<xsl:for-each select="/_R_/zone_groups_get_all/zone_groups_get_all">
<xsl:if test="not(zone_group_http_proxy='NOHTTP')">
  <xsl:variable name="my_zone_group_id" select="zone_group_id"/>
<xsl:text>
server {
  listen 80;
  server_name_in_redirect off;
  server_tokens off;
  server_name</xsl:text>
	<xsl:for-each select="/_R_/zones_get_all/zones_get_all[zone_group_id=$my_zone_group_id][active='Y']">
    <xsl:if test="www_only='YES' or $my_zone_group_id=2">
      <xsl:text> www.</xsl:text>
    </xsl:if>
    <xsl:if test="not(www_only='YES') and not($my_zone_group_id=2)">
      <xsl:text> .</xsl:text>
    </xsl:if>
    <xsl:value-of select="substring(origin,0,string-length(origin))"/>
  </xsl:for-each>
  <xsl:text>;
  if ($gofast = 0) {
    set $limit_rate  256k;
  }
  if ($gofast != 0) {
    set $limit_rate  512k;
  }
  if ($slow = 1) {
    set $limit_rate  17k;
  }

  if ($new) {
    rewrite  ^    $new   permanent;
  }</xsl:text>

  <xsl:if test="zone_group_proxy_only='YES'">
  <xsl:text>
  location / {
    if ($query_string ~* "=http:\/\/" ) {
      return 503;
    }
    proxy_pass http://127.0.0.1:6081;
  }
</xsl:text>
</xsl:if>
  <xsl:if test="not(zone_group_proxy_only='YES')">
  <xsl:text>
  location / {
    if ($query_string ~* "=http:\/\/" ) {
      return 503;
    }
    proxy_pass http://127.0.0.1:6081;
  }
  location /blog/ {
    add_header P3P "policyref=\"/w3c/p3p.xml\", CP=\" NON CURa\"";
    root /var/www/virtual/$host/public;
    if ($query_string ~* "=http:\/\/" ) {
      return 503;
    }
    if ( $request_uri ~* "\.(jpg|gif|png)$") {
        expires 14400;
    }
    if (-f $request_filename/index.html) {
        break;
    }
    if (!-f $request_filename) {
        break;
        proxy_pass  http://127.0.0.1:6081;
    }
  }
  location /blog/s/ {
    root /var/www/virtual/$host/public;
    if ($query_string ~* "=http:\/\/" ) {
      return 503;
    }
    if ( $request_uri ~* "\.(jpg|gif|png)$") {
        expires 14400;
    }
    if (!-f $request_filename) {
        break;
        proxy_pass  http://127.0.0.1:6081;
    }
  }
  location /s/ {
    root /var/www/public;
    if (!-f $request_filename) {
        break;
        proxy_pass  http://127.0.0.1:6081;
    }
    if ( $request_uri ~* "\.(jpg|gif|png)$") {
        expires 14400;
    }
  }
  location /blog/cgi-bin/ {
      proxy_pass        http://192.168.8.2:88;
  }
  location /p/ {
      rewrite ^/p(.*) $1 break;
      proxy_pass        http://127.0.0.1:6081;
  }

</xsl:text>
</xsl:if>

  location /google86d5f0d256551366.html {
    root /var/www/public;
    access_log off;
  }
}
</xsl:if>
</xsl:for-each>


</xsl:template>
</xsl:stylesheet>
