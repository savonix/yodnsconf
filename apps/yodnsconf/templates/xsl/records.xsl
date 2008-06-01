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
<xsl:include href="pager.xsl"/>
<xsl:template name="content">
<xsl:call-template name="jquery-setup">
    <xsl:with-param name="my-table">records_table</xsl:with-param>
    <xsl:with-param name="my-table-div">myInvoicesDiv</xsl:with-param>
    <xsl:with-param name="no-sort-column">,
        headers: { 
            5: {sorter: false},
            6: {sorter: false},
            7: {sorter: false}
        }
    </xsl:with-param>
</xsl:call-template>
<script type="text/javascript">
function delete_record(record_id,zone,row) {
    if(confirm('Are you sure?')){
    $.post("<xsl:value-of select="/_R_/runtime/link_prefix"/>x-record-delete&amp;record_id="+record_id, 
    {
        'record_id': record_id,
        'zone': zone
    },
    function (data){
    });
    myTable = document.getElementById("records_table");
    myTable.deleteRow(row);
    }
}

function create_default_dns_records(zone) { 
    $.post("<xsl:value-of select="/_R_/runtime/link_prefix"/>zone-create-default-dns-records&amp;zone="+zone, 
    {
        'zone': zone
    },
    function (data){
        window.location.reload(true);
    });
}
function create_default_a_records(zone) { 
    $.post("<xsl:value-of select="/_R_/runtime/link_prefix"/>zone-create-default-a-records&amp;zone="+zone, 
    {
        'zone': zone
    },
    function (data){
        window.location.reload(true);
    });
}
</script>
<table width="100%" class="tablesorter" id="records_table">
    <thead>
    <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Data</th>
        <th>Preference/Priority</th>
        <th>TTL</th>
        <th>Dig</th>
        <th></th>
        <th>+</th>
    </tr>
    <tr>
        <form method="get">
        <input type="hidden" name="nid" value="{/_R_/_get/nid}"/>
        <input type="hidden" name="zone" value="{/_R_/_get/zone}"/>
        <td><input type="text" name="name" value="{/_R_/_get/name}" /></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td align="right">
        <input name="Filter"  type="submit" id="Filter" value="Filter"/>
        </td>
        <td></td>
        </form>
    </tr>
    </thead>
    <tbody>
    <xsl:for-each select="//records_get_by_id">
    <tr>
        <td>
            <a href="{/_R_/runtime/link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=edit">
                <xsl:value-of select="name"/>
            </a>
        </td>
        <td>
            <a href="{/_R_/runtime/link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=edit">
                <xsl:value-of select="type"/>
            </a>
        </td>
        <td>
            <a href="{/_R_/runtime/link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=edit">
                <xsl:value-of select="data"/>
            </a>
        </td>
        <td>
            <a href="{/_R_/runtime/link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=edit">
                <xsl:value-of select="aux"/>
            </a>
        </td>
        <td>
            <a href="{/_R_/runtime/link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=edit">
                <xsl:value-of select="ttl"/>
            </a>
        </td>
        <td>
            <a href="{/_R_/runtime/link_prefix}tools-query&amp;hostname={name}.{//zone_get_by_id/origin}&amp;type={type}">Dig</a>
        </td>
        <td align="right"><a href="{/_R_/runtime/link_prefix}x-record-delete&amp;record_id={id}" 
            onclick="delete_record({id},{zone},this.parentNode.parentNode.rowIndex); return false;">Delete</a></td>
        <td>
            <a href="{/_R_/runtime/link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=copy" title="Copy">+</a>
        </td>
    </tr>
    </xsl:for-each>
    </tbody>
</table>
<xsl:call-template name="pager">
    <xsl:with-param name="my-table">records_table</xsl:with-param>
</xsl:call-template>
<div style="float: right;">
<a href="{/_R_/runtime/link_prefix}zone-create-default-dns-records&amp;zone={/_R_/_get/zone}"
    onclick="confirm('Are you sure?'); create_default_dns_records({/_R_/_get/zone}); return false;">
    Create Default DNS Records
</a>
<br/>
<br/>
<a href="{/_R_/runtime/link_prefix}zone-create-default-a-records&amp;zone={/_R_/_get/zone}"
    onclick="confirm('Are you sure?'); create_default_a_records({/_R_/_get/zone}); return false;">
    Create Default A Records
</a>
</div>
</xsl:template>
</xsl:stylesheet>
