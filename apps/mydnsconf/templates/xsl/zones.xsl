<!--
Program: MyDNSConf
Component: zones.xsl
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
<form method="post" name="myform" enctype="multipart/form-data">
<table width="100%">
    <tr>
        <td>Origin</td>
        <td>Name Server</td>
        <td>TTL</td>
        <td>Active</td>
        <td></td>
    </tr>
    <tr>
        <td><input type="text" name="search_origin" value="" class="text" /></td>
        <td><input type="text" name="search_ns" value="" class="text" /></td>
        <td><input type="text" name="search_ttl" value="" class="text" /></td>
        <td>
            <select name="search_active" onChange="document.myform.submit();"><option value=""></option>
            <option value='Y'>Yes</option>
            <option value='N'>No</option>
            </select>
        </td>
        <td align="right"><input name="Filter" type="submit" id="Filter" value="Filter"/></td>
    </tr>
    <xsl:for-each select="//zones_get_all">
    <tr>
        <td><a href="{//link_prefix}zone-edit&amp;zone={id}"><xsl:value-of select="origin"/></a></td>
        <td><a href="{//link_prefix}zone-edit&amp;zone={id}"><xsl:value-of select="ns"/></a></td>
        <td><a href="{//link_prefix}zone-edit&amp;zone={id}"><xsl:value-of select="ttl"/></a></td>
        <td><a href="{//link_prefix}zone-edit&amp;zone={id}"><xsl:value-of select="active"/></a></td>
        <td align="right">[<a href="{//link_prefix}delete&amp;id={id}">Delete</a>]</td>
    </tr>
    </xsl:for-each> 
    <tr>
        <td colspan="5" height="40" align="center">
            <a href=""><img src="{//path_prefix}s/themes/grey/images/btn_left.png"/></a>
            Page 1 of 1 
            <a href=""> <img src="{//path_prefix}s/themes/grey/images/btn_right.png"/></a>
        </td>
    </tr>
</table>
</form>
</xsl:template>
</xsl:stylesheet>
