<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: ip_address_form.xsl
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


<form method="post" name="ip_addr_form" onSubmit="return validateStandard(this);">
  <xsl:if test="/_R_/_get/ip_id">
    <input type="hidden" name="action" value="edit"/>
    <input type="hidden" name="ip_id" value="{//_get/ip_id}"/>
  </xsl:if>
  <xsl:if test="not(/_R_/_get/ip_id)">
    <input type="hidden" name="action" value="create"/>
  </xsl:if>
  <table>
    <tbody>
      <tr>
        <th>
          <label for="ip_addr">
            <span id="i18n-ip_addr">IP Address</span>
          </label>
        </th>
        <td>
          <input name="ip_addr" id="ip_addr" type="text"
          value="{//ip_addr_get_all/ip_addr}"/>
        </td>
      </tr>
      <tr>
        <th>
          <label for="ip_description">
            <span id="i18n-description">Description</span>
          </label>
        </th>
        <td>
          <input name="ip_description" id="ip_description" type="text"
          value="{//ip_addr_get_all/ip_description}"/>
        </td>
      </tr>
      <tr>
        <th>
          <label for="ip_notes">
            <span id="i18n-notes">Notes</span>
          </label>
        </th>
        <td>
          <input id="ip_notes" name="ip_notes" type="text"
          value="{//ip_addr_get_all/ip_notes}"/>
        </td>
      </tr>
      <tr>
        <td/>
        <td>
          <input name="btn_save" type="submit" class="button" value="Save"/>
          <input name="btn_cancel" type="button" class="button" value="Cancel"
          onClick="window.location.href='{$link_prefix}redirects'"/>
        </td>
      </tr>
    </tbody>
  </table>
</form>


  </xsl:template>
</xsl:stylesheet>
