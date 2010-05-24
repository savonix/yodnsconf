<!--
Program: YoDNSConf
Component: redirects_export.txt.xsl
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
</xsl:template>

<xsl:template name="default">
  <xsl:for-each select="/_R_/redirects_get_all/redirects_get_all">
    <xsl:value-of select="http_host"/><xsl:text> </xsl:text><xsl:value-of select="redirect"/>
    <xsl:text>
</xsl:text>
  </xsl:for-each>

</xsl:template>


<xsl:template name="nginx">
<!--
map  $http_host  $name  {
    hostnames;

    default          0;

    example.com      1;
    *.example.com    1;
    test.com         2;
    *.test.com       2;
    .site.com        3;
}
map $uri $new {
    default        http://www.domain.com/home/;

    /aa            http://aa.domain.com/;
    /bb            http://bb.domain.com/;
    /john          http://my.domain.com/users/john/;
}

server {
    server_name   www.domain.com;
    rewrite  ^    $new   redirect;
}

-->
<!--
<xsl:for-each select="/_R_/redirects_get_all/redirects_get_all">
if ($host = "<xsl:value-of select="http_host"/>") {
    rewrite ^ http://<xsl:value-of select="redirect"/> permanent;
}</xsl:for-each>
-->

map $host $new {
<xsl:for-each select="/_R_/redirects_get_all/redirects_get_all">
  <xsl:variable name="myhost" select="http_host"/>
  <xsl:if test="not(contains(http_host,'_')) and contains(redirect,'www')">
    <xsl:if test="//records_get_all_www/records_get_all_www[wwwhost=$myhost]"><xsl:text>
      </xsl:text><xsl:value-of select="http_host"/>  http://<xsl:value-of select="redirect"/>
      <xsl:text>;</xsl:text>
    </xsl:if>
  </xsl:if>
</xsl:for-each>
}

#if ($new) {
#rewrite  ^    $new   permanent;
#}
<xsl:for-each select="/_R_/redirects_get_all/redirects_get_all">
  <xsl:variable name="myhost" select="http_host"/>
  <xsl:if test="not(contains(http_host,'_'))">
    <xsl:if test="not(//records_get_all_www/records_get_all_www[wwwhost=$myhost])">
      <xsl:text>
#</xsl:text><xsl:value-of select="http_host"/>
    </xsl:if>
  </xsl:if>
</xsl:for-each>
<!--
<xsl:for-each select="//records_get_all_www/records_get_all_www">
    <xsl:text>#</xsl:text><xsl:value-of select="wwwhost"/>
    <xsl:text>
</xsl:text>
</xsl:for-each>
-->

</xsl:template>


</xsl:stylesheet>
