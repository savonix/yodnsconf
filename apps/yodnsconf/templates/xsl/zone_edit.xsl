<!--
Program: YoDNSConf
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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:include href="main.xsl"/>
<xsl:template name="content">
<script language="javascript" src="{//path_prefix}s/js/jsval.js"></script>
<script language="javascript">
<![CDATA[
    function initValidation()
    {
        var objForm = document.forms["myform"];
        objForm.origin.required = 1;
        objForm.origin.regexp = /^[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)+\.$/;
        objForm.ns.required = 1;
        objForm.ns.regexp = /^[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)+\.$/;
        objForm.ttl.required = 1;
        objForm.ttl.regexp = /^[0-9]+$/;
    }
]]>
</script>
<form method="post" onSubmit="return validateStandard(this);" name="myform">
<input type="hidden" name="zone" value="{//_get/zone}"/>
<xsl:if test="//_get/zone">
    <input type="hidden" name="action" value="edit"/>
</xsl:if>
<xsl:if test="not(//_get/zone)">
    <input type="hidden" name="action" value="create"/>
</xsl:if>

<table width="100%">
  <tr>
    <td>Origin:</td>
    <td>
        <input name="origin" type="text" value="{//zone_get_by_id/origin}"/>
        (example.com.)
    </td>
  </tr>
  <tr>
    <td>Name Server:</td>
    <td>
        <input name="ns" type="text" value="{//zone_get_by_id/ns}"/></td>
  </tr>
  <tr>
    <td>Admin Email:</td>
    <td>
        <input name="mbox" type="text" value="{//zone_get_by_id/mbox}"/></td>
  </tr>
  <tr>
    <td>Serial No.:</td>
    <td>
        <input name="serial" type="text" value="{//zone_get_by_id/ttl}" required="1" /></td>
  </tr>
  <tr>
    <td>Refresh:</td>
    <td>
        <input name="refresh" type="text" value="{//zone_get_by_id/refresh}"/></td>
  </tr>
  <tr>
    <td>Retry:</td>
    <td><input name="retry" type="text" value="{//zone_get_by_id/retry}"/></td>
  </tr>
  <tr>
    <td>Expire:</td>
    <td>
        <input name="expire" type="text" value="{//zone_get_by_id/expire}"/></td>
  </tr>
  <tr>
    <td>Minimum TTL:</td>
    <td>
        <input name="minimum" type="text" value="{//zone_get_by_id/minimum}"/></td>
  </tr>
  <tr>
    <td>TTL:</td>
    <td>
        <input name="ttl" type="text" value="{//zone_get_by_id/ttl}"/></td>
  </tr>
  <tr>
    <td valign="top">Active:</td>
    <td>
        <input name="active" type="radio" value="Y"><xsl:if test="//zone_get_by_id/active='Y'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input> Yes<br/>
        <input name="active" type="radio" value="N"><xsl:if test="//zone_get_by_id/active='N'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input> No<br/>
    </td>
  </tr>
  <tr>
    <td>Zone Transfers:</td>
    <td><input name="xfer" type="text" value="{//zone_get_by_id/xfer}"/></td>
  </tr>
  <tr>
    <td></td>
    <td><input name="btn_save" type="submit" class="button" value="Save"/>&#160;
      <input name="btn_cancel" type="button" class="button" value="Cancel"
        onClick="window.location.href='{//link_prefix}index'"/>
    </td>
  </tr>
</table>
</form>
<script language="javascript">
    initValidation();
</script>
</xsl:template>
</xsl:stylesheet>
