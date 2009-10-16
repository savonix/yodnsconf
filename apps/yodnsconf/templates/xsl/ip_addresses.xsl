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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="html_main.xsl"/>
  <xsl:include href="pager.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>


<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=myip_addresses" />

<div>
  <table width="100%" class="tablesorter" id="myip_addresses">
    <thead>
      <tr>
        <th>
          <span id="i18n-id">ID</span>
        </th>
        <th>
          <span id="i18n-ip_addr">IP Address</span>
        </th>
        <th></th>
      </tr>
      <tr>
        <form method="get">
          <input type="hidden" name="nid" value="ydc-ip-addr"/>
          <td>
            <input type="text" name="ip_addr" value="{/_R_/_get/ip_addr}"/>
          </td>
          <td></td>
          <td align="right">
            <input name="Filter" type="submit" id="Filter" value="Filter"/>
          </td>
        </form>
      </tr>
    </thead>
    <tbody>
      <xsl:for-each select="/_R_/ip_addr_get_all/ip_addr_get_all">
      <tr>
        <td>
          <a href="{$link_prefix}ydc-ip-addr-edit&amp;ip_id={ip_id}">
            <xsl:value-of select="ip_id"/>
          </a>
        </td>
        <td>
          <a href="{$link_prefix}ydc-ip-addr-edit&amp;ip_id={ip_id}">
            <xsl:value-of select="ip_addr"/>
          </a>
        </td>
        <td align="right">
          <a href="#x-ydc-ip-addr-delete&amp;ip_id={ip_id}"
          onclick="delete_ip('{ip_id}',this); return false;">Delete</a>
        </td>
      </tr>
      </xsl:for-each>
      <tr>
        <td colspan="3">
          <span id="i18n-ips_from_zone_records">IP Addresses from Zone Records</span>
        </td>
      </tr>
      <xsl:for-each select="/_R_/ip_get_distinct_public/ip_get_distinct_public">
      <tr>
        <td>
          <a href="{$link_prefix}ydc-ip-addr-edit&amp;ip_id={ip_id}">
            <xsl:value-of select="id"/>
          </a>
        </td>
        <td>
          <a href="{$link_prefix}ydc-ip-addr-edit&amp;ip_id={ip_id}">
            <xsl:value-of select="data"/>
          </a>
        </td>
        <td align="right">
          <a href="#x-ydc-ip-addr-delete&amp;ip_id={ip_id}"
          onclick="delete_ip('{ip_id}',this); return false;">Delete</a>
        </td>
      </tr>
      </xsl:for-each>
    </tbody>
  </table>
</div>
<xsl:call-template name="pager">
  <xsl:with-param name="my-table">myip_addresses</xsl:with-param>
</xsl:call-template>
<div style="text-align: right">
  <a href="{$link_prefix}x-ip-addr-export">Export</a>
</div>


  </xsl:template>
</xsl:stylesheet>
