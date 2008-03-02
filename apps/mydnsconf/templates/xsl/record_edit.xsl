<!--
Program: YoDNSConf
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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:include href="main.xsl"/>
<xsl:template name="content">
<form method="post">
<input type="hidden" name="id" value="{//_get/id}"/>
<input type="hidden" name="zone" value="{//_get/zone}"/>
<table width="100%">
  <tr>
    <td>Name:</td>
    <td>
        <input name="name" type="text" class="text" value="{//record_get_by_id/name}" size="30" maxlength="255"/></td>
  </tr>
  <tr>
    <td>Type:</td>
    <td>
    <select name="type" class="text">
    <xsl:for-each select="//record_types/type">
        <xsl:variable name="this_type"><xsl:value-of select="."/></xsl:variable>
        <option value="{type}">
            <xsl:if test="//record_get_by_id/type=$this_type">
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
        <input name="data" type="text" class="text" value="{//record_get_by_id/data}" size="30" maxlength="255"/></td>
  </tr>
  <tr>
    <td>Preference/Priority:</td>
    <td><input name="aux" type="text" class="text" value="{//record_get_by_id/aux}" size="30" maxlength="255"/></td>
  </tr>
  <tr>
    <td>TTL:</td>
    <td><input name="ttl" type="text" class="text" value="{//record_get_by_id/ttl}" size="30" maxlength="255"/></td>
  </tr>
  <tr>
    <td></td>
    <td><input name="btn_save" type="submit" class="button" value="Save"/>&#160;
      <input name="btn_cancel" type="button" class="button" value="Cancel"
        onClick="window.location.href='{//link_prefix}records&amp;zone={//_get/zone}'"/>
    </td>
  </tr>
</table></form>
</xsl:template>
</xsl:stylesheet>
