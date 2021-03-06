<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: zone_clone.xsl
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
  <xsl:include href="zone_form.xsl"/>
  <xsl:template match="/">

<div>
<form method="post" onSubmit="return validateStandard(this);" name="myform">
  <xsl:if test="/_R_/_get/zone">
    <input type="hidden" name="zone" value="{/_R_/_get/zone}"/>
    <input type="hidden" name="action" value="clone"/>
    <xsl:call-template name="zone-form">
      <xsl:with-param name="zone_prefix" select="/_R_/zone_get_by_id/zone_get_by_id"/>
    </xsl:call-template>
  </xsl:if>
</form>

<div style="float: right; width: 60%">
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
  <xsl:if test="count(/_R_/records_get_by_id/records_get_by_id) &gt; 10">
    <xsl:call-template name="pager">
      <xsl:with-param name="my-table">records_table</xsl:with-param>
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="count(/_R_/records_get_by_id/records_get_by_id) &gt; 4">
  </xsl:if>
</div>
<br/><a href="{$link_prefix}x-zone-export&amp;zone={//id}">Export</a>
</div>

  </xsl:template>
</xsl:stylesheet>
