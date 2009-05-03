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
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="html_main.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <script language="javascript" src="{$path_prefix}s/js/jsval.js"></script>
    <script language="javascript">
    <![CDATA[
    function initValidation()
    {
        var objForm = document.forms["record"];
        objForm.name.required = 0;
        objForm.name.regexp = /^[A-Za-z0-9\-\.]*$/;
        objForm.data.required = 1;
        if(objForm.type.value=='A') {
            $("#rr_prio_row").css("display","none");
            objForm.data.regexp = /^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$/;
        } else if (objForm.type.value=='TXT') {
            $("#rr_prio_row").css("display","none");
            var blah = "barf";
        } else if (objForm.type.value=='MX') {
            $("#rr_prio_row").css("display","");
        } else {
            $("#rr_prio_row").css("display","none");
            objForm.data.regexp = /^[A-Za-z0-9\-\.]*$/;
        }
    }
    ]]>
    </script>
    <form method="post" name="record" onSubmit="return validateStandard(this);">

      <xsl:if test="/_R_/_get/id">
        <input type="hidden" name="id" value="{/_R_/_get/id}"/>
      </xsl:if>
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
            <select name="type" onchange="initValidation();">
              <xsl:for-each select="//record_types/type">
                <xsl:variable name="this_type" select="."/>
                <option value="{.}">
                  <xsl:if test="/_R_/record_get_by_id/record_get_by_id/type=$this_type">
                    <xsl:attribute name="selected">selected</xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="."/>
                </option>
              </xsl:for-each>
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
          <td>TTL:</td>
          <td>
            <input name="ttl" type="text"
							value="{/_R_/record_get_by_id/record_get_by_id/ttl}"/>
          </td>
        </tr>
        <tr>
          <td>Notes:</td>
          <td>
            <input name="notes" type="text"
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
    <script language="javascript">
		initValidation();
    </script>
  </xsl:template>
</xsl:stylesheet>
