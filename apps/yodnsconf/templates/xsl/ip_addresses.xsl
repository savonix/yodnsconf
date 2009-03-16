<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: ip_addresses.xsl
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
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="html_main.xsl"/>
  <xsl:include href="pager.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:call-template name="jquery-setup">
      <xsl:with-param name="my-table">myip_addresses</xsl:with-param>
      <xsl:with-param name="my-table-div">my-ip_addresses-div</xsl:with-param>
      <xsl:with-param name="no-sort-column">,
        headers: { 2: {sorter: false} }
    </xsl:with-param>
    </xsl:call-template>
    <script type="text/javascript">
    function delete_ip(ip_address,row) {
        if(confirm('Are you sure?')){
        $.post("<xsl:value-of select="$link_prefix"/>x--ip-delete&amp;ip_address="+ip_address,
        {
            'ip_address': ip_address
        },
        function (data){
        });
        myTable = document.getElementById("myip_addresses");
        myTable.deleteRow(row.parentNode.parentNode.rowIndex);
        }
    }
    </script>
    <div id="my-ip_addresses-div">
      <script type="text/javascript">
			document.getElementById('my-ip_addresses-div').style.visibility = 'hidden';
      </script>
      <table width="100%" class="tablesorter" id="myip_addresses">
        <thead>
          <tr>
            <th>Address</th>
            <th>Hostname</th>
            <th></th>
          </tr>
          <tr>
            <form method="get">
              <input type="hidden" name="nid" value="ip_addresses"/>
              <td>
                <input type="text" name="ip_address" value="{/_R_/_get/ip_address}"/>
              </td>
              <td></td>
              <td align="right">
                <input name="Filter" type="submit" id="Filter" value="Filter"/>
              </td>
            </form>
          </tr>
        </thead>
        <xsl:for-each select="/_R_/ip_addresses_get_all/ip_addresses_get_all">
          <tr>
            <td>
              <a href="{$link_prefix}ip-edit&amp;ip_address={ip_address}">
                <xsl:value-of select="ip"/>
              </a>
            </td>
            <td>
              <a href="{$link_prefix}ip-edit&amp;ip_address={ip_address}">
                <xsl:value-of select="ip"/>
              </a>
            </td>
            <td align="right">
              <a href="{$link_prefix}x--ip-delete&amp;ip_address={ip_address}"
								onclick="delete_ip('{ip_address}',this); return false;">Delete</a>
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </div>
    <xsl:call-template name="pager">
      <xsl:with-param name="my-table">myip_addresses</xsl:with-param>
    </xsl:call-template>
    <div style="text-align: right">
      <a href="{$link_prefix}x--ip_addresses-export">Export</a>
    </div>
  </xsl:template>
</xsl:stylesheet>
