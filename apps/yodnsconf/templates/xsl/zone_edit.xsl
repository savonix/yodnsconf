<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: zone_edit.xsl
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
  <xsl:include href="pager.xsl"/>
  <xsl:include href="zone_form.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>
    <script type="text/javascript" src="{$path_prefix}s/js/jsval.js"></script>
    <script type="text/javascript">
		<![CDATA[
		function initValidation()
		{
			var objForm = document.forms["myform"];
			objForm.ns.required = 1;
			objForm.ns.regexp = /^[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)+\.$/;
			objForm.ttl.required = 1;
			objForm.ttl.regexp = /^[0-9]+$/;
		}
		]]>
    </script>
    <form method="post" onSubmit="return validateStandard(this);" name="myform">
      <xsl:if test="/_R_/_get/zone or /_R_/_get/origin">
        <input type="hidden" name="zone" value="{/_R_/zone_get_by_id/zone_get_by_id/id}"/>
        <input type="hidden" name="action" value="edit"/>
        <xsl:call-template name="zone-form">
          <xsl:with-param name="zone_prefix">zone_get_by_id</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="not(/_R_/_get/zone) and not(/_R_/_get/origin)">
        <input type="hidden" name="action" value="create"/>
        <xsl:call-template name="zone-form">
          <xsl:with-param name="zone_prefix">defaults</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </form>

		<xsl:if test="count(/_R_/records_get_by_id/records_get_by_id) &gt; 5">

    <div style="float: right; width: 60%">
      <xsl:call-template name="jquery-setup">
        <xsl:with-param name="my-table">records_table</xsl:with-param>
        <xsl:with-param name="no-sort-column">,
        headers: {
            2: {sorter: false}
        }
				</xsl:with-param>
      </xsl:call-template>

      <table style="width: 100%" class="tablesorter" id="records_table">
        <thead>
          <tr>
            <th>Name</th>
            <th>Data</th>
            <th>Dig</th>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="/_R_/records_get_by_id/records_get_by_id">
            <tr>
              <td>
                <a href="{$link_prefix}record-edit&amp;id={id}&amp;zone={zone}">
                  <xsl:value-of select="name"/>
                </a>
              </td>
              <td>
                <a href="{$link_prefix}record-edit&amp;id={id}&amp;zone={zone}">
                  <xsl:value-of select="substring(data,0,30)"/>
                </a>
              </td>
              <td>
                <a href="{$link_prefix}tools-query&amp;hostname={name}.{/_R_/zone_get_by_id/zone_get_by_id/origin}&amp;type={type}">
                Dig
								</a>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
		</xsl:if>
		<xsl:if test="count(/_R_/records_get_by_id/records_get_by_id) &gt; 10">
			<xsl:call-template name="pager">
				<xsl:with-param name="my-table">records_table</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<!--
		<xsl:if test="count(/_R_/records_get_by_id/records_get_by_id) &gt; 4">
			<iframe src="http://www.{//origin}" frameborder="0" height="240px" style="width: 80%"></iframe>
		</xsl:if>
		-->
		<xsl:variable name="origin_link" select="substring(//origin,0,string-length(//origin))"/>
		<a class="thickbox" href="http://www.{$origin_link}/?keepThis=true&amp;TB_iframe=true&amp;height=400&amp;width=600">Preview</a>
    <br/>
		<a href="{$link_prefix}x-zone-export&amp;zone={//id}">Export</a>
    <script type="text/javascript">
		initValidation();
		</script>
  </xsl:template>
</xsl:stylesheet>
