<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: services.xsl
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
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>
    <xsl:call-template name="jquery-setup">
      <xsl:with-param name="my-table">myservices</xsl:with-param>
      <xsl:with-param name="no-sort-column">,
        headers: { 2: {sorter: false} }
			</xsl:with-param>
    </xsl:call-template>
    <script type="text/javascript">
    function delete_service(id) {
        if(confirm('Are you sure?')){
        $.post("<xsl:value-of select="$link_prefix"/>x-service-delete&amp;service_id="+id,
        {
					'service_id': id
        },
        function (data){
          $("#s_"+id).remove();
        });
        }
    }
    </script>
    <div class="tableframe">
      <table width="100%" class="tablesorter" id="myservices">
        <thead>
          <tr>
            <th>Service</th>
            <th>Edit</th>
            <th>Delete</th>
            <th>Clone</th>
          </tr>
          <tr>
            <form method="get">
              <input type="hidden" name="nid" value="services"/>
              <td>
                <input type="text" name="http_service" value="{/_R_/_get/http_service}"/>
              </td>
              <td></td>
              <td align="right">
                <input name="Filter" type="submit" id="Filter" value="Filter"/>
              </td>
							<td>
							</td>
							<td>
							</td>
            </form>
          </tr>
        </thead>
				<tbody>
        <xsl:for-each select="/_R_/services_get_all/services_get_all">
          <tr id="s_{id}">
            <td>
              <a href="{$link_prefix}service-edit&amp;service_id={id}">
								<xsl:if test="string-length(service) &gt; 80">
									<xsl:attribute name="title" select="service"/>
								</xsl:if>
								<xsl:value-of select="substring(name,0,80)"/>
								<xsl:if test="string-length(service) &gt; 80">
									<xsl:text>...</xsl:text>
								</xsl:if>
              </a>
            </td>
            <td>
              <a href="{$link_prefix}service-edit&amp;service_id={id}">
								Edit
              </a>
            </td>
            <td align="right">
              <a href="{$link_prefix}x--service-delete&amp;service_id={id}"
								onclick="delete_service('{id}'); return false;">
								Delete
							</a>
            </td>
            <td>
              <a href="{$link_prefix}service-edit&amp;service_id={id}&amp;clone=true">
								Clone
              </a>
            </td>
          </tr>
        </xsl:for-each>
				</tbody>
      </table>
    </div>
    <div class="table_controls">
    <xsl:call-template name="pager">
      <xsl:with-param name="my-table">myservices</xsl:with-param>
    </xsl:call-template>
    </div>
    <div style="text-align: right" class="table_meta">
      <a href="{$link_prefix}service-edit">New Service</a>
    </div>
  </xsl:template>
</xsl:stylesheet>
