<!--
Program: YoDNSConf
Component: main_menu.xsl
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
<xsl:template name="main_menu">
<div id="main-menu">
    <a href="{//link_prefix}index"><xsl:value-of select="/__ROOT__/i18n/label[@key='zones']"/></a>
    <a href="{//link_prefix}zone-edit"><xsl:value-of select="/__ROOT__/i18n/label[@key='new_zone']"/></a>
    <xsl:if test="//_get/zone">
    <a href="{//link_prefix}zone-edit&amp;zone={//_get/zone}" class="sub">
        <span style="color: red; font-weight: bold;">
            <xsl:value-of select="//zone_get_by_id/origin"/>
        </span>
    </a>
    <a href="{//link_prefix}records&amp;zone={//_get/zone}" class="sub">
        Records
    </a>
    <a href="{//link_prefix}record-edit&amp;zone={//_get/zone}" class="sub">
        New Record
    </a>
    <a href="http://www.{//origin}" class="sub" target="_blank">
        Visit
    </a>
    </xsl:if>
    <select name="zone">
    <option>Select</option>
    </select>
</div>
</xsl:template>
</xsl:stylesheet>