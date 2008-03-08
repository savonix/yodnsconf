<!--
Program: YoDNSConf
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
<xsl:include href="pager.xsl"/>
<xsl:template name="content">
<xsl:call-template name="jquery-setup">
    <xsl:with-param name="my-table">myzones</xsl:with-param>
</xsl:call-template>
<script type="text/javascript" src="{//path_prefix}s/js/jquery.uitablefilter.js"></script>
<script type="text/javascript">
function delete_zone(zone,row) {
    if(confirm('Are you sure?')){
    $.post("<xsl:value-of select="//link_prefix"/>x-zone-delete&amp;zone="+zone, 
    {
        'zone': zone
    },
    function (data){
    });
    myTable = document.getElementById("myzones");
    myTable.deleteRow(row);
    }
}
function filter_table(phrase,column)
{ 
$.uiTableFilter( $("#myzones"), phrase, column)
}
</script>
<script type="text/javascript">

</script>
<table width="100%" class="tablesorter" id="myzones">
    <thead>
    <tr>
        <th>Origin</th>
        <th>Name Server</th>
        <th>TTL</th>
        <th>Active</th>
        <th></th>
    </tr>
    <tr>
        <form method="get">
        <td><input type="text" name="origin" value="{//_get/origin}" onkeyup="filter_table(this.value,'Origin')"/></td>
        <td></td>
        <td></td>
        <td>
        </td>
        <td align="right"><input name="Filter" type="submit" id="Filter" value="Filter"/></td>
        </form>
    </tr>
    </thead>
    <xsl:for-each select="//zones_get_all">
    <tr>
        <td><a href="{//link_prefix}zone-edit&amp;zone={id}"><xsl:value-of select="origin"/></a></td>
        <td><a href="{//link_prefix}zone-edit&amp;zone={id}"><xsl:value-of select="ns"/></a></td>
        <td><a href="{//link_prefix}zone-edit&amp;zone={id}"><xsl:value-of select="ttl"/></a></td>
        <td><a href="{//link_prefix}zone-edit&amp;zone={id}"><xsl:value-of select="active"/></a></td>
        <td align="right">[<a href="{//link_prefix}x-zone-delete&amp;id={id}" 
        onclick="delete_zone({id},this.parentNode.parentNode.rowIndex); return false;">Delete</a>]</td>
    </tr>
    </xsl:for-each>
</table>
<xsl:call-template name="pager"/>
</xsl:template>
</xsl:stylesheet>
