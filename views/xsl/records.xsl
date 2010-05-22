<!--
Program: YoDNSConf - http://www.yodnsconf.com/
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
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="html_main.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>

<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=records_table" />



<form method="post" action="{$link_prefix}x-records-delete">
<input type="hidden" name="zone" value="{//zone_get_by_id/zone_get_by_id/id}"/>
<div class="tableframe">
<table width="100%" class="tablesorter" id="records_table" border="0">
  <thead>
    <tr>
      <th class="{{sorter: false}}">
        <input type="checkbox" name="select_all"
        onclick="select_all_boxes('record_id');"/>
      </th>
      <th>
        <span id="i18n-name">Name</span>
      </th>
      <th>
        <span id="i18n-type">Type</span>
      </th>
      <th>
        <span id="i18n-data">Data</span>
      </th>
      <th>
        <span id="i18n-priority">Priority</span>
      </th>
      <th>
        <span id="i18n-ttl">TTL</span>
      </th>
      <th class="{{sorter: false}}">
        <span id="i18n-dig">Dig</span>
      </th>
      <th class="{{sorter: false}}" />
      <th class="{{sorter: false}}">
        <span title="Clone">+</span>
      </th>
    </tr>
  </thead>
  <tbody>
  <xsl:for-each select="/_R_/records_get_by_id/records_get_by_id">
    <tr id="{id}">
      <td>
        <input class="record_boxes" type="checkbox" name="record_id[]"
        value="{id}"/>
      </td>
      <td>
        <a href="{$link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=edit" title="{notes}">
          <xsl:value-of select="name"/>
        </a>
      </td>
      <td>
        <a href="{$link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=edit">
          <xsl:value-of select="type"/>
        </a>
      </td>
      <td>
        <a href="{$link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=edit" title="{notes}">
          <xsl:value-of select="substring(data,0,40)"/>
        </a>
      </td>
      <td>
        <a href="{$link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=edit">
          <xsl:value-of select="aux"/>
        </a>
      </td>
      <td>
        <a href="{$link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=edit">
          <xsl:value-of select="ttl"/>
        </a>
      </td>
      <td>
        <a href="{$link_prefix}tools-query&amp;hostname={name}.{//zone_get_by_id/zone_get_by_id/origin}&amp;type={type}">Dig</a>
      </td>
      <td align="right">
        <a href="{$link_prefix}x-record-delete&amp;record_id={id}"
        onclick="delete_record({id},{zone}); return false;">Delete</a>
      </td>
      <td>
        <a href="{$link_prefix}record-edit&amp;id={id}&amp;zone={zone}&amp;action=copy" title="Copy">+</a>
      </td>
    </tr>
  </xsl:for-each>
  </tbody>
</table>
</div>
<input class="table_meta" style="right: 420px;" type="submit" name="submit"
value="Delete Selected Records"/>
</form>
<div class="table_meta" style="right: 80px;">
  <form method="post"
  action="{$link_prefix}zone-apply-profile&amp;zone={//zone_get_by_id/id}">
    <input type="hidden" name="zone"
    value="{//zone_get_by_id/zone_get_by_id/id}"/>
    <select name="profile_id">
        <option>Select</option>
        <xsl:for-each select="//zone_get_profiles/zone_get_profiles">
            <option value="{id}"><xsl:value-of select="origin"/></option>
        </xsl:for-each>
    </select>
    <input type="submit" value="Apply Zone Profile" style="cursor: pointer;"/>
  </form>
</div>
<div class="table_controls">
<xsl:call-template name="pager">
  <xsl:with-param name="my-table">records_table</xsl:with-param>
</xsl:call-template>
</div>


  </xsl:template>
</xsl:stylesheet>
