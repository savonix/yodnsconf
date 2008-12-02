<!--
Program: YoDNSConf
Component: hosts.xsl
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
  <xsl:include href="main.xsl"/>
  <xsl:include href="pager.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:call-template name="jquery-setup">
      <xsl:with-param name="my-table">myhosts</xsl:with-param>
      <xsl:with-param name="my-table-div">my-hosts-div</xsl:with-param>
      <xsl:with-param name="no-sort-column">,
        headers: { 2: {sorter: false} }
    </xsl:with-param>
    </xsl:call-template>
    <script type="text/javascript">
    function delete_host(http_host,row) {
        if(confirm('Are you sure?')){
        $.post("<xsl:value-of select="$link_prefix"/>x--host-delete&amp;http_host="+http_host,
        {
            'http_host': http_host
        },
        function (data){
        });
        myTable = document.getElementById("myhosts");
        myTable.deleteRow(row.parentNode.parentNode.rowIndex);
        }
    }
    </script>
    <div id="my-hosts-div">
      <script type="text/javascript">
        document.getElementById('my-hosts-div').style.visibility = 'hidden';
      </script>
      <table width="100%" class="tablesorter" id="myhosts">
        <thead>
          <tr>
            <th>Address</th>
            <th>Hostname</th>
            <th></th>
          </tr>
          <tr>
            <form method="get">
              <input type="hidden" name="nid" value="hosts"/>
              <td>
                <input type="text" name="http_host" value="{/_R_/_get/http_host}"/>
              </td>
              <td></td>
              <td align="right">
                <input name="Filter" type="submit" id="Filter" value="Filter"/>
              </td>
            </form>
          </tr>
        </thead>
        <xsl:for-each select="/_R_/hosts_get_all/hosts_get_all">
          <tr>
            <td>
              <a href="{$link_prefix}host-edit&amp;http_host={http_host}">
                <xsl:value-of select="ip"/>
              </a>
            </td>
            <td>
              <a href="{$link_prefix}host-edit&amp;http_host={http_host}">
                <xsl:value-of select="host"/>
              </a>
            </td>
            <td align="right">
              <a href="{$link_prefix}x--host-delete&amp;http_host={http_host}" onclick="delete_host('{http_host}',this); return false;">Delete</a>
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </div>
    <xsl:call-template name="pager">
      <xsl:with-param name="my-table">myhosts</xsl:with-param>
    </xsl:call-template>
    <div style="text-align: right">
      <a href="{$link_prefix}x--hosts-export">Export</a>
    </div>
  </xsl:template>
</xsl:stylesheet>
