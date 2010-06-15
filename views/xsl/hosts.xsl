<!--
Program: YoDNSConf - http://www.yodnsconf.com/
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml">
  <xsl:template match="/">

<div>
<div class="tableframe">
  <table width="100%" class="tablesorter" id="my_hosts">
    <thead>
      <tr>
        <th>
          <span id="i18n-address">Address</span>
        </th>
        <th>Hostname</th>
        <th>Edit</th>
        <th>Delete</th>
        <th>Clone</th>
      </tr>
      <tr>
          <input type="hidden" name="nid" value="hosts"/>
          <td>
            <input type="text" name="http_host" value="{/_R_/_get/http_host}"/>
          </td>
          <td></td>
          <td align="right">
            <input name="Filter" type="submit" id="Filter" value="Filter"/>
          </td>
          <td colspan="2"></td>
      </tr>
    </thead>
    <tbody>
    <xsl:for-each select="/_R_/hosts_get_all/hosts_get_all">
      <tr id="h_{id}">
        <td>
          <a href="{$link_prefix}ydc-hosts-get-by-ip-addr&amp;ip_addr={ip}">
            <xsl:value-of select="ip"/>
          </a>
        </td>
        <td>
          <a href="{$link_prefix}host-edit&amp;host={host}&amp;host_id={id}&amp;cloner=0">
            <xsl:if test="string-length(host) &gt; 80">
              <xsl:attribute name="title">
                <xsl:value-of select="host"/>: <xsl:value-of select="notes"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="not(string-length(host) &gt; 80)">
              <xsl:attribute name="title">
                <xsl:value-of select="notes"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="substring(host,0,80)"/>
            <xsl:if test="string-length(host) &gt; 80">
              <xsl:text>...</xsl:text>
            </xsl:if>
          </a>
        </td>
        <td>
          <a href="{$link_prefix}host-edit&amp;host_id={id}&amp;cloner=0">
            Edit
          </a>
        </td>
        <td align="right">
          <a href="{$link_prefix}x-host-delete&amp;host_id={id}&amp;cloner=0"
            onclick="delete_host('{id}'); return false;">
            Delete
          </a>
        </td>
        <td>
          <a href="{$link_prefix}host-edit&amp;host_id={id}&amp;clone=true&amp;cloner=1">
            Clone
          </a>
        </td>
      </tr>
    </xsl:for-each>
    </tbody>
  </table>
</div>
<div  class="prefoot" style="text-align: right">
  <a href="{$link_prefix}hosts-all">View All Hosts</a>&#160;
  <a href="{$link_prefix}x-hosts-export">/etc/hosts Export</a>&#160;
  <a href="{$link_prefix}x-hosts-export-unbound">Unbound Export</a>&#160;
  <a href="{$link_prefix}x-hosts-export-puppet">Puppet Export</a>&#160;
  <a href="{$link_prefix}x-hosts-export-nagios">Nagios3 Export</a>&#160;
  <a href="{$link_prefix}host-edit">New Host</a>&#160;
  <a href="{$link_prefix}hostgroups">Hostgroups</a>
</div>
<div class="table_controls">
</div>
</div>
  </xsl:template>
</xsl:stylesheet>
