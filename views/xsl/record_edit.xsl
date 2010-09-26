<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: record_edit.xsl
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
  <xsl:template match="/">


<div>
<form method="post" name="record">

  <xsl:if test="/_R_/_get/id">
    <input type="hidden" name="id" value="{/_R_/_get/id}"/>
  </xsl:if>
  <!-- YES, YOU NEED "zone" AS A GET PARAMETER HERE. -->
  <input type="hidden" name="zone"   value="{/_R_/_get/zone}"/>
  <input type="hidden" name="serial" value="{/_R_/zone_get_by_id/zone_get_by_id/serial}"/>

  <xsl:if test="/_R_/_get/nid='record-edit'">
    <input type="hidden" name="action" value="edit"/>
  </xsl:if>
  <xsl:if test="/_R_/_get/action='copy' or not(/_R_/_get/id)">
    <input type="hidden" name="action" value="create"/>
  </xsl:if>
  <table width="100%">
    <tr>
      <td width="200">Name:</td>
      <td width="400">
        <input name="name" type="text"
          value="{/_R_/record_get_by_id/record_get_by_id/name}"/>
      </td>
    </tr>
    <tr>
      <td>Type:</td>
      <td>
        <select name="type">
          <option value="A">A</option>
          <option value="AAAA">AAAA</option>
          <option value="ALIAS">ALIAS</option>
          <option value="CNAME">CNAME</option>
          <option value="MX">MX</option>
          <option value="NS">NS</option>
          <option value="PTR">PTR</option>
          <option value="SRV">SRV</option>
          <option value="TXT">TXT</option>
        </select>
      </td>
    </tr>
    <tr>
      <td>Data:</td>
      <td>
        <input name="data" type="text"
          value="{/_R_/record_get_by_id/record_get_by_id/data}"/>
      </td>
    </tr>
    <tr id="rr_prio_row" style="display:none;">
      <td>Preference/Priority:</td>
      <td>
        <input name="aux" type="text"
          value="{/_R_/record_get_by_id/record_get_by_id/aux}"/>
      </td>
    </tr>
    <xsl:if test="/_R_/record_get_by_id/record_get_by_id/type='SRV'">
      <tr>
        <td>Weight:</td>
        <td>
          <input name="weight" type="text"
            value="{/_R_/record_get_by_id/record_get_by_id/weight}"/>
        </td>
      </tr>
      <tr>
        <td>Port:</td>
        <td>
          <input name="port" type="text"
            value="{/_R_/record_get_by_id/record_get_by_id/port}"/>
        </td>
      </tr>
    </xsl:if>
    <tr>
      <th>
        <span id="i18n-ttl">TTL</span>
      </th>
      <td>
        <input name="ttl" type="text"
          value="{/_R_/record_get_by_id/record_get_by_id/ttl}"/>
      </td>
    </tr>
    <tr>
      <th>
        <label for="http_host">
          <span id="i18n-protocols">HTTP Host?</span>
        </label>
      </th>
      <td>
        <input type="checkbox" name="http_host" id="http_host" />
      </td>
    </tr>
    <tr>
      <th>
        <label for="notes">
          <span id="i18n-notes">Notes</span>
        </label>
      </th>
      <td>
        <input name="notes" type="text" id="notes"
        value="{/_R_/record_get_by_id/record_get_by_id/notes}"/>
      </td>
    </tr>
    <tr>
      <td/>
      <td>
        <input type="submit" class="button" value="Save"/>&#160;
        <input type="button" class="button" value="Cancel"
        onClick="window.location.href='{$link_prefix}records&amp;zone={/_R_/_get/zone}'"/>
      </td>
    </tr>
  </table>
</form>
</div>

  </xsl:template>
</xsl:stylesheet>
