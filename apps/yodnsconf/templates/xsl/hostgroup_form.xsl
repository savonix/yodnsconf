<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: hostgroup_form.xsl
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
  <xsl:include href="main.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>
    <script language="javascript" src="{$path_prefix}s/js/jsval.js"></script>
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
			<xsl:if test="//_get/clone='true'">
				<input type="hidden" name="clone" value="true"/>
			</xsl:if>
      <xsl:if test="/_R_/_get/hostgroup_id">
      	<input type="hidden" name="http_host" value="{/_R_/_get/http_host}"/>
        <input type="hidden" name="hostgroup_id" value="{/_R_/_get/hostgroup_id}"/>
      </xsl:if>
      <table width="100%" class="simple-table bottom-edge">
        <tr>
          <td style="width: 10em;">Hostgroup:</td>
          <td>
            <input name="ip" type="text" style="width: 12em;"
							value="{/_R_/hostgroups_get_all/hostgroups_get_all[id=/_R_/_get/hostgroup_id]/ip}"/>
          </td>
          <td>Order:</td>
          <td>
            <input name="priority" type="text" style="width: 4em;margin-right:100%;"
							value="{/_R_/hostgroups_get_all/hostgroups_get_all[id=/_R_/_get/hostgroup_id]/priority + //_get/cloner}"/>
          </td>
        </tr>
        <tr>
          <td>Hosts:</td>
          <td colspan="3">
						<select name="hosts" multiple="multiple" style="height: 8em; width: 14em;">
							<xsl:for-each select="//hosts_get_all/hosts_get_all[priority=0]">
								<option value="{id}"><xsl:value-of select="host"/></option>
							</xsl:for-each>
						</select>
          </td>
        </tr>
        <tr>
          <td></td>
          <td>
            <input name="btn_save" type="submit" class="button" value="Save"/>&#160;
            <input name="btn_cancel" type="button" class="button" value="Cancel"
							onClick="window.location.href='{$link_prefix}hosts'"/>
          </td>
        </tr>
      </table>
    </form>
    <script language="javascript">
		initValidation();
    </script>
	</xsl:template>
</xsl:stylesheet>
