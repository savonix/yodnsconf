<!--
Program: YoDNSConf
Component: 	rewrite_rules.xml.xsl
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
<proxy_rules>
  <proxy_rule>
    <conditions>
      <condition order="10" flag="OR">
        <test_string>%{HTTP_HOST}</test_string>
        <pattern>www.example.com</pattern>
      </condition>
      <condition order="20">
        <test_string>%{HTTP_HOST}</test_string>
        <pattern>www.example.org</pattern>
      </condition>
    </conditions>
    <rule flags="P,R=301">
      <pattern>.</pattern>
      <substitution>http://192.168.0.1:8080</substitution>
    </rule>
  </proxy_rule>
</proxy_rules>
</xsl:template>
</xsl:stylesheet>
