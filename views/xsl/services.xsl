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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">

<div>
<div class="tableframe">
  <table width="100%" class="tablesorter" id="myservices">
    <thead>
      <tr>
        <th><span id="i18n-service">Service</span></th>
        <th>Edit</th>
        <th>Delete</th>
        <th>Clone</th>
      </tr>
      <tr>
        <td>
          <input type="text" name="http_service" value="{/_R_/_get/http_service}"/>
          <input name="Filter" type="submit" id="Filter" value="Filter"/>
        </td>
        <td colspan="3">
        </td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
    </tbody>
  </table>
</div>
<div class="table_controls">
</div>
<div style="text-align: right" class="table_meta">
  <a href="{$link_prefix}service-edit">New Service</a>
</div>
</div>

  </xsl:template>
</xsl:stylesheet>
