<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: zone_groups.xsl
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
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=my_zone_groups" />

<div class="tableframe">
  <table width="100%" class="tablesorter" id="my_zone_groups">
    <thead>
      <tr>
        <th>
          <span id="i18n-zone_group">Zone Group</span>
        </th>
        <th>
          <span id="i18n-edit">Edit</span>
        </th>
        <th>
          <span id="i18n-delete">Delete</span>
        </th>
      </tr>
    </thead>
    <tbody>
    <xsl:for-each select="/_R_/zone_groups_get_all/zone_groups_get_all">
      <tr id="hg_{id}">
        <td>
          <a href="{$link_prefix}index&amp;zone_group_id={zone_group_id}">
            <xsl:value-of select="zone_group_name"/>
          </a>
        </td>
        <td>
          <a href="{$link_prefix}zone-group-edit&amp;zone_group_id={zone_group_id}&amp;cloner=0">
            <span id="i18n-edit">Edit</span>
          </a>
        </td>
        <td align="right">
          <a href="{$link_prefix}x-zone-group-delete&amp;zone_group_id={zone_group_id}&amp;cloner=0"
          onclick="delete_zone_group('{zone_group_id}'); return false;">
            <span id="i18n-delete">Delete</span>
          </a>
        </td>
      </tr>
    </xsl:for-each>
    </tbody>
  </table>
</div>
<br/>
<div class="table_controls">
<xsl:call-template name="pager">
  <xsl:with-param name="my-table">my_zone_groups</xsl:with-param>
</xsl:call-template>
</div>

<div class="table_meta" style="float: right">
  <a href="{$link_prefix}zone-group-edit">
    <span id="i18n-new_zone_group">New Zone Group</span>
  </a>
</div>


  </xsl:template>
</xsl:stylesheet>
