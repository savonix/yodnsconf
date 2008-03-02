<!--
Program: MyDNSConf
Component: zones.xsl
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
<form method="post" action="soa_edit.php" name="myform" enctype="multipart/form-data">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
    <tr>
    <td class="frmTextHead"><div style="float:left;"><b>SOA</b></div></td>
  </tr>
    <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
	    <td width="2" class="frmTab"></td>
        <td width="100" align="center" class="frmTabSelected"><a href="" class="frmText11">SOA</a></td>
        <td width="2" class="frmTab"></td>
        <td width="100" class="frmTabDefault"><a href="{//link_prefix}records&amp;zone={//_get/id}" class="frmText11">Records</a></td>
        <td width="2" class="frmTab"></td>
        <td class="frmTab"></td>
      </tr>
    </table></td>
  </tr>
    <tr>
    <td>
<table width="500" border="0" cellspacing="0" cellpadding="2">
  <tr>

    <td width="126" class="frmText11">Origin:</td>
    <td width="366" class="frmText11">
        <input name="origin" type="text" class="text" value="{//soa_get_by_id/origin}" size="30" maxlength="255"/>
    </td>
  </tr>
  <tr>
    <td width="126" class="frmText11">Name Server:</td>
    <td width="366" class="frmText11">
        <input name="ns" type="text" class="text" value="{//soa_get_by_id/ns}" size="30" maxlength="255"/></td>
  </tr>
  <tr>

    <td width="126" class="frmText11">Admin Email:</td>
    <td width="366" class="frmText11">
        <input name="mbox" type="text" class="text" value="{//soa_get_by_id/mbox}" size="30" maxlength="255"/></td>
  </tr>
  <tr>
    <td width="126" class="frmText11">Serial No.:</td>
    <td width="366" class="frmText11">
        <input name="serial" type="text" class="text" value="{//soa_get_by_id/ttl}" size="30" maxlength="255"/></td>
  </tr>
  <tr>

    <td width="126" class="frmText11">Refresh:</td>
    <td width="366" class="frmText11">
        <input name="refresh" type="text" class="text" value="{//soa_get_by_id/refresh}" size="30" maxlength="255"/></td>
  </tr>
  <tr>
    <td width="126" class="frmText11">Retry:</td>
    <td width="366" class="frmText11"><input name="retry" type="text" class="text" value="{//soa_get_by_id/retry}" size="30" maxlength="255"/></td>
  </tr>
  <tr>

    <td width="126" class="frmText11">Expire:</td>
    <td width="366" class="frmText11">
        <input name="expire" type="text" class="text" value="{//soa_get_by_id/expire}" size="30" maxlength="255"/></td>
  </tr>
  <tr>
    <td width="126" class="frmText11">Minimum TTL:</td>
    <td width="366" class="frmText11">
        <input name="minimum" type="text" class="text" value="{//soa_get_by_id/minimum}" size="30" maxlength="255"/></td>
  </tr>
  <tr>

    <td width="126" class="frmText11">TTL:</td>
    <td width="366" class="frmText11">
        <input name="ttl" type="text" class="text" value="{//soa_get_by_id/ttl}" size="30" maxlength="255"/></td>
  </tr>
  <tr>
    <td width="126" class="frmText11" valign="top">Active:</td>
    <td width="366" class="frmText11"><input name='active[]' type='radio' value='Y' /> Yes<br/>
<input name='active[]' type='radio' value='N'/> No<br/>

</td>
  </tr>
  <tr>
    <td width="126" class="frmText11">Zone Transfers:</td>
    <td width="366" class="frmText11"><input name="xfer" type="text" class="text" value="" size="30" maxlength="255"/></td>
  </tr>  <tr>
    <td class="frmText11"></td>
    <td class="frmText11"></td>

  </tr>
  <tr>
    <td></td>
    <td><input name="btn_save" type="submit" class="button" value="Save"/>
      <input name="btn_cancel" type="button" class="button" value="Cancel" onClick="window.location.href='{//link_prefix}index'"/>
    </td>
  </tr>
</table></td></tr>
</table>

</form>
</xsl:template>
</xsl:stylesheet>
