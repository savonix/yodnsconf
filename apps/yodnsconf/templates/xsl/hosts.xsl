<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: hosts.xsl
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
    <xsl:call-template name="jquery-setup">
      <xsl:with-param name="my-table">myhosts</xsl:with-param>
      <xsl:with-param name="no-sort-column">,
        headers: { 2: {sorter: false} }
			</xsl:with-param>
    </xsl:call-template>
    <div id="my_hosts_div" class="tableframe">
      <table width="100%" class="tablesorter" id="myhosts">
        <thead>
          <tr>
            <th>Address</th>
            <th>Hostname</th>
            <th>Edit</th>
            <th>Delete</th>
            <th>Clone</th>
          </tr>
          <tr>
            <form method="get">
              <input type="hidden" name="nid" value="hosts"/>
              <td>
                <input type="text" name="http_host" value="{/_R_/_get/http_host}"/>
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
        <xsl:for-each select="/_R_/hosts_get_all/hosts_get_all">
          <tr>
            <td>
              <a href="{$link_prefix}host-edit&amp;host_id={id}&amp;cloner=0">
                <xsl:value-of select="ip"/>
              </a>
            </td>
            <td>
              <a href="{$link_prefix}host-edit&amp;host_id={id}&amp;cloner=0">
								<xsl:if test="string-length(host) &gt; 80">
									<xsl:attribute name="title">
										<xsl:value-of select="host"/>
									</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="substring(host,0,80)"/>
								<xsl:if test="string-length(host) &gt; 80">
									<xsl:text>...</xsl:text>
								</xsl:if>
              </a>
            </td>
            <td>
              <a href="{$link_prefix}host-edit&amp;host_id={id}&amp;cloner=0">
								Edit
              </a>
            </td>
            <td align="right">
              <a href="{$link_prefix}x--host-delete&amp;host_id={id}&amp;cloner=0"
								onclick="delete_host('{id}',this); return false;">
								Delete
							</a>
            </td>
            <td>
              <a href="{$link_prefix}host-edit&amp;host_id={id}&amp;clone=true&amp;cloner=1">
								Clone
              </a>
            </td>
          </tr>
        </xsl:for-each>
				</tbody>
      </table>
    </div>
    <xsl:call-template name="pager">
      <xsl:with-param name="my-table">myhosts</xsl:with-param>
    </xsl:call-template>
		<div  class="prefoot">
    <div style="text-align: right">
      <a href="{$link_prefix}x--hosts-export">/etc/hosts Export</a> - <a href="{$link_prefix}x--hosts-export-unbound">Unbound Export</a>
    </div>
    <div style="text-align: right">
			<a href="{$link_prefix}x--hosts-export-puppet">Puppet Export</a> - <a href="{$link_prefix}x--hosts-export-nagios">Nagios3 Export</a>
		</div>
    <div style="text-align: right">
      <a href="{$link_prefix}host-create">New Host</a>
    </div>
    <div style="text-align: right">
      <a href="{$link_prefix}hostgroups">Hostgroups</a>
    </div>
		</div>
  </xsl:template>
</xsl:stylesheet>
