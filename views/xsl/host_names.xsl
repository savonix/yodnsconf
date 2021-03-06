<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: host_names.xsl
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
  <table width="100%" class="tablesorter" id="my_host_names">
    <thead>
      <tr>
        <th>
          Host Name
        </th>
        <th>Edit</th>
        <th>Delete</th>
        <th>Clone</th>
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
          <td>
          </td>
        </form>
      </tr>
    </thead>
    <tbody>
    <xsl:for-each select="/_R_/hosts_get_all/hosts_get_all">
      <tr id="h_{id}">
        <td>
          <a href="{$link_prefix}host-edit&amp;host={host}&amp;host_id={id}&amp;cloner=0">
            <xsl:value-of select="host"/>
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
  <a href="{$link_prefix}x-hosts-export">/etc/hosts Export</a>&#160;
  <a href="{$link_prefix}x-hosts-export-unbound">Unbound Export</a>&#160;
  <a href="{$link_prefix}x-hosts-export-puppet">Puppet Export</a>&#160;
  <a href="{$link_prefix}x-hosts-export-nagios">Nagios3 Export</a>&#160;
  <a href="{$link_prefix}host-create">New Host</a>&#160;
  <a href="{$link_prefix}hostgroups">Hostgroups</a>
</div>
</div>
  </xsl:template>
</xsl:stylesheet>
