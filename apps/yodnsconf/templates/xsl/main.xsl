<!--
Program: YoDNSConf
Component: main.xsl
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
<xsl:output method="html" indent="yes" encoding="UTF-8" omit-xml-declaration="no" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
<xsl:template match="/">
<html>
<head>
<xsl:for-each select="//in_head">
    <xsl:sort select="priority"/>
    <xsl:value-of select="string" disable-output-escaping="yes"/>
</xsl:for-each>
    <link href="{//path_prefix}s/themes/grey/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<xsl:for-each select="//pre_body_content">
    <xsl:sort select="priority"/>
    <xsl:value-of select="string" disable-output-escaping="yes"/>
</xsl:for-each>
<div id="main-menu">
    <a href="{//link_prefix}index"><xsl:value-of select="/__ROOT__/i18n/label[@key='zones']"/></a>
    <a href="{//link_prefix}zone-edit"><xsl:value-of select="/__ROOT__/i18n/label[@key='new_zone']"/></a>
    <xsl:if test="//_get/zone">
    <a href="{//link_prefix}zone-edit&amp;zone={//_get/zone}" class="sub"><xsl:value-of select="//zone_get_by_id/origin"/></a>
    <a href="{//link_prefix}records&amp;zone={//_get/zone}" class="sub">Records</a>
    <a href="{//link_prefix}record-edit&amp;zone={//_get/zone}" class="sub">New Record</a>
    </xsl:if>
    <select name="zone">
    <option>Select</option>
    </select>
</div>
<hr/>
<div id="primary-workspace">
<xsl:call-template name="content"/>
</div>
<xsl:for-each select="//footer">
    <xsl:sort select="priority"/>
    <xsl:value-of select="string" disable-output-escaping="yes"/>
</xsl:for-each>
</body>
</html>
</xsl:template>
</xsl:stylesheet>