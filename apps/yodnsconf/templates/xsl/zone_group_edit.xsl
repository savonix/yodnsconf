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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="html_main.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>

<xsl:variable name="my_zone_group"
select="/_R_/zone_groups_get_all/zone_groups_get_all" />

<form action="{$link_prefix}zone-group-edit" method="post">
  <input name="zone_group_id" type="hidden"
  value="{$my_zone_group/zone_group_id}"/>
  <table>
    <tbody>
    <tr>
      <th>
        <label for="name">
          <span id="i18n-name">Name</span>
        </label>
      </th>
      <td>
        <input name="name" type="text" id="name"
        value="{$my_zone_group/zone_group_name}"/>
      </td>
    </tr>
    <tr>
      <th>
        <label for="http_proxy">
          <span id="i18n-http_proxy">HTTP Proxy</span>
        </label>
      </th>
      <td>
        <input name="zone_group_http_proxy" type="text" id="http_proxy"
        value="{$my_zone_group/zone_group_http_proxy}"/>
      </td>
    </tr>
    <tr>
      <th>
        <label for="proxy_only">
          <span id="i18n-proxy_only">Proxy Only</span>
        </label>
      </th>
      <td>
        <input name="zone_group_proxy_only" type="text" id="proxy_only"
        value="{$my_zone_group/zone_group_proxy_only}"/>
      </td>
    </tr>
    </tbody>
  </table>
  <input type="submit"/>
</form>


  </xsl:template>
</xsl:stylesheet>
