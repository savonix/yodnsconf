<!--
Program: MyDNSConf
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
<form method="post" action="rr_edit.php" name="myform" enctype="multipart/form-data">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
    <tr>
    <td class="frmTextHead"><div style="float:left;"><b>Record</b></div></td>
  </tr>
    <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
	    <td width="2" class="frmTab"></td>
        <td width="100" align="center" class="frmTabSelected">
            <a href="" class="frmText11">Record</a></td>
        <td width="2" class="frmTab"></td>
        <td class="frmTab"></td>
      </tr>
    </table></td>
  </tr>
    <tr>
    <td>
		<table width="500" border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td width="126" class="frmText11">Name:</td>
    <td width="366" class="frmText11">
        <input name="name" type="text" class="text" value="1" size="30" maxlength="255"/></td>
  </tr>
  <tr>
    <td width="126" class="frmText11">Type:</td>
    <td width="366" class="frmText11">
                <select name="type" class="text">
                        <option value='A'>A</option>
                        <option value='AAAA'>AAAA</option>
                        <option value='ALIAS'>ALIAS</option>
                        <option value='CNAME'>CNAME</option>
                        <option value='HINFO'>HINFO</option>
                        <option value='MX'>MX</option>
                        <option value='NS'>NS</option>
                        <option value='PTR'>PTR</option>
                        <option value='RP'>RP</option>
                        <option value='SRV'>SRV</option>
                        <option value='TXT'>TXT</option>
                </select>
        </td>
  </tr>
  <tr>
    <td width="126" class="frmText11">Data:</td>
    <td width="366" class="frmText11">
        <input name="data" type="text" class="text" value="www.dddddf.com." size="30" maxlength="255"/></td>
  </tr>
  <tr>

    <td width="126" class="frmText11">Preference/Priority:</td>
    <td width="366" class="frmText11"><input name="aux" type="text" class="text" value="0" size="30" maxlength="255"/></td>
  </tr>
  <tr>
    <td width="126" class="frmText11">TTL:</td>
    <td width="366" class="frmText11"><input name="ttl" type="text" class="text" value="86400" size="30" maxlength="255"/></td>
  </tr>  <tr>

    <td class="frmText11"></td>
    <td class="frmText11"></td>
  </tr>
  <tr>
    <td></td>
    <td><input name="btn_save" type="submit" class="button" value="Save"/>
      <input name="btn_cancel" type="button" class="button" value="Cancel" onClick="window.location.href='{//link_prefix}records&amp;zone={//_get/zone}'"/>
    </td>
  </tr>
</table>
</td></tr></table></form>
</xsl:template>
</xsl:stylesheet>
