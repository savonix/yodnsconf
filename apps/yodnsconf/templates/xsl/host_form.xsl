<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: host_form.xsl
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
				<input type="hidden" name="post_type" value="clone"/>
			</xsl:if>
      <xsl:if test="/_R_/_get/host_id">
				<input type="hidden" name="post_type" value="edit"/>
      	<input type="hidden" name="http_host" value="{/_R_/_get/http_host}"/>
        <input type="hidden" name="host_id" value="{/_R_/_get/host_id}"/>
      </xsl:if>
      <xsl:if test="not(/_R_/_get/host_id)">
				<input type="hidden" name="post_type" value="create"/>
      </xsl:if>
      <table width="80%" class="simple-table bottom-edge">
        <xsl:if test="//_get/nid='host-name-edit'">
        	<input type="hidden" name="ip" value="300.300.300.300"/>
        </xsl:if>
        <xsl:if test="//_get/nid='host-edit'">
        <tr>
          <td style="width: 10em;">IP:</td>
          <td>
            <input name="ip" type="text" style="width: 12em;"
							value="{/_R_/hosts_get_all/hosts_get_all[id=/_R_/_get/host_id]/ip}"/>
          </td>
          <td>Order:</td>
          <td>
            <input name="priority" type="text" style="width: 4em;margin-right:100%;"
							value="{/_R_/hosts_get_all/hosts_get_all[id=/_R_/_get/host_id]/priority + //_get/cloner}"/>
          </td>
        </tr>
        </xsl:if>
        <tr>
          <td>Hosts:</td>
          <td colspan="3">
            <input name="host" type="text" style="width: 60em;"
							value="{/_R_/hosts_get_all/hosts_get_all[id=/_R_/_get/host_id]/host}"/>
          </td>
        </tr>
        <xsl:if test="//_get/nid='host-edit'">
        <tr>
          <td>Create PTR:</td>
          <td colspan="3">
            <input name="create_ptr_record" type="checkbox" />
          </td>
        </tr>
        </xsl:if>
				<xsl:if test="/_R_/hosts_get_all/hosts_get_all[id=/_R_/_get/host_id]/priority=0">
        <tr>
          <td>MAC Address:</td>
          <td colspan="3">
            <input name="macaddr" type="text" style="width: 30em;"
							value="{/_R_/hosts_get_all/hosts_get_all[id=/_R_/_get/host_id]/macaddr}"/>
          </td>
        </tr>
				<tr>
          <td style="vertical-align:top;">Applications:</td>
          <td colspan="3">
						<table class="simple-table">
							<xsl:for-each select="/_R_/services_get_all/services_get_all">
							<tr style="border-bottom: 0;">
								<td>
									<input name="service_id[]" type="checkbox" value="{id}">
										<xsl:if test="/_R_/host_services_get_all/host_services_get_all/service_id=id">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>
								</td>
								<td>
									<xsl:value-of select="name"/>
								</td>
							</tr>
							</xsl:for-each>
						</table>
          </td>
        </tr>
				</xsl:if>
        <tr>
          <td></td>
          <td>
            <input type="submit" class="button" value="Save"/>&#160;
            <input type="button" class="button" value="Cancel"
							onClick="window.location.href='{$link_prefix}hosts'"/>
          </td>
        </tr>
      </table>
    </form>
    <script language="javascript">
		initValidation();
    </script>
    <div style="text-align: right">
			<a href="{$link_prefix}x--hosts-export-puppet&amp;host_id={//_get/host_id}">Puppet Export</a>
		</div>
  </xsl:template>
</xsl:stylesheet>
