<!--
Program: YoDNSConf - http://www.yodnsconf.com/
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
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml">
  <xsl:template match="/">

<div>
<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=myzones" />

<div class="tableframe">
  <table width="100%" class="tablesorter" id="myzones">
    <thead>
      <tr>
        <th id="barf" width="60%"  class="{{sorter: 'text'}}">Origin</th>
        <xsl:if test="verbose='true'">
          <th>Name Server</th>
        </xsl:if>
        <xsl:if test="verbose='true'">
          <th width="10%">TTL</th>
          <th width="10%">Active</th>
        </xsl:if>
        <th width="15%" class="{{sorter: false}}"/>
      </tr>
      <tr>
        <form method="get">
          <input type="hidden" name="nid" value="{/_R_/_get/nid}"/>
          <td>
            <input type="text" name="origin" value="{/_R_/_get/origin}" />
          </td>
          <xsl:if test="verbose='true'">
            <td/>
            <td/>
            <td/>
          </xsl:if>
          <td align="right">
            <input name="Filter" type="submit" id="Filter" value="Filter"/>
          </td>
        </form>
      </tr>
    </thead>
    <tbody id="myzonesbody" class="zrow">

    </tbody>
  </table>
</div>
<div class="table_controls">
</div>
<div class="table_meta" style="float: right">
  Total number of zones: <xsl:value-of select="count(/_R_/zones_get_all/zones_get_all)"/>&#160;
  <a href="{$link_prefix}x-zones-export-unbound">Unbound Local Data Export</a>&#160;
  <a href="{$link_prefix}x-zones-export-csv">CSV Zone Export</a>&#160;
  <a href="{$link_prefix}x-zones-export-nginx-map&amp;zone_group_id=%">NGINX Map Export</a>&#160;
  <a href="{$link_prefix}x-zones-export-nginx-servers&amp;zone_group_id=%">NGINX Server Export</a>
</div>

</div>
</xsl:template>
</xsl:stylesheet>
