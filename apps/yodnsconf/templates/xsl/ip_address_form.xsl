<!--
Program: YoDNSConf
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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="main.xsl"/>
  <xsl:template name="content">
    <script language="javascript" src="{/_R_/runtime/path_prefix}s/js/jsval.js"></script>
    <script language="javascript">
<![CDATA[
    function initValidation()
    {
        var objForm = document.forms["redirect"];
        objForm.http_host.required = 1;
        objForm.redirect.required = 1;
    }
]]>
</script>
    <form method="post" name="redirect" onSubmit="return validateStandard(this);">
      <input type="hidden" name="http_host" value="{/_R_/_get/http_host}"/>
      <xsl:if test="/_R_/_get/nid='ip-address-edit'">
        <input type="hidden" name="action" value="edit"/>
      </xsl:if>
      <xsl:if test="not(/_R_/_get/http_host)">
        <input type="hidden" name="action" value="create"/>
      </xsl:if>
      <table width="100%">
        <tr>
          <td>From Host:</td>
          <td>
            <input name="http_host" type="text" value="{/_R_/_get/http_host}"/>
          </td>
        </tr>
        <tr>
          <td>To URL:</td>
          <td>
            <input name="redirect" type="text" value="{/_R_/redirects_get_all/redirects_get_all[http_host=/_R_/_get/http_host]/redirect}"/>
          </td>
        </tr>
        <tr>
          <td></td>
          <td>
            <input name="btn_save" type="submit" class="button" value="Save"/>&#160;
      <input name="btn_cancel" type="button" class="button" value="Cancel"
                onClick="window.location.href='{/_R_/runtime/link_prefix}redirects'"/>
          </td>
        </tr>
      </table>
    </form>
    <script language="javascript">
    initValidation();
</script>
  </xsl:template>
</xsl:stylesheet>
