<!--
Program: YoDNSConf
Component: records.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:include href="main.xsl"/>
<xsl:template name="content">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
        <td>Name</td>
        <td>Type</td>
        <td>Data</td>
        <td>Preference/Priority</td>
        <td>TTL</td>
        <td></td>
    </tr>
    <tr>
        <td><input type="text" name="search_name" value="" class="text" /></td>
        <td>
        <select name="type" class="text">
        <xsl:for-each select="//record_types/type">
            <xsl:variable name="this_type"><xsl:value-of select="."/></xsl:variable>
            <option value="{type}">
                <xsl:if test="//record_get_by_id/type=$this_type">
                    <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </option>
        </xsl:for-each>
        </select>
        </td>
        <td><input type="text" name="search_data" value="" class="text" /></td>
        <td><input type="text" name="search_aux" value="" class="text" /></td>
        <td><input type="text" name="search_ttl" value="" class="text" /></td>
        <td align="right">
        <input name="Filter" type="button" id="Filter" value="Filter" onClick="changeTab('rr');"/>
        </td>
    </tr>
    <xsl:for-each select="//records_get_by_id">
    <tr>
        <td><a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}"><xsl:value-of select="name"/></a></td>
        <td><a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}"><xsl:value-of select="type"/></a></td>
        <td><a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}"><xsl:value-of select="data"/></a></td>
        <td><a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}"><xsl:value-of select="aux"/></a></td>
        <td><a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}"><xsl:value-of select="ttl"/></a></td>
        <td align="right">[<a href="">Delete</a>]</td>
    </tr>
    </xsl:for-each>
    <tr>
        <td colspan="6" height="40" align="center">
        <a href=""><img src="{//path_prefix}s/themes/grey/images/btn_left.png" border="0"/></a>   
        Page 1 of 1 
        <a href=""><img src="{//path_prefix}s/themes/grey/images/btn_right.png" border="0"/></a>
        </td>
    </tr>
</table>
</xsl:template>
</xsl:stylesheet>
