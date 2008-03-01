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
<form method="post" action="soa_list.php" name="myform" enctype="multipart/form-data">
<div class="frmTextHead">Zones (SOA)</div>
<input style="float: right; margin-top: -20px" type="button" value="Add New Zone" onClick="location.href='soa_edit.php'" />
<table width="100%" border="0" cellspacing="0" cellpadding="4">

  <tr>
    <td class="tblHead">Origin</td>
    <td class="tblHead">Name Server</td>

    <td class="tblHead">TTL</td>
    <td class="tblHead">Active</td>

    <td class="tblHead"></td>
  </tr>
  <tr>
    <td class="frmText11"><input type="text" name="search_origin" value="" class="text" /></td>
    <td class="frmText11"><input type="text" name="search_ns" value="" class="text" /></td>
    <td class="frmText11"><input type="text" name="search_ttl" value="" class="text" /></td>
    <td class="frmText11">
        <select name="search_active" onChange="document.myform.submit();"><option value=""></option>
        <option value='Y'>Yes</option>
        <option value='N'>No</option>
        </select>
    </td>
    <td class="frmText11" align="right"><input name="Filter" type="submit" id="Filter" value="Filter"/></td>
  </tr>
    <tr bgcolor="#EEEEEE">
    <td class="frmText11"><a href="soa_edit.php?id=1" class="frmText11">dddddf.com.</a></td>
    <td class="frmText11"><a href="soa_edit.php?id=1" class="frmText11">ns1.example.com.</a></td>
    <td class="frmText11"><a href="soa_edit.php?id=1" class="frmText11">86400</a></td>
    <td class="frmText11"><a href="soa_edit.php?id=1" class="frmText11">Yes</a></td>
    <td class="frmText11" align="right">[<a href="javascript: del_record('');" class="frmText11">Delete</a>]</td>
  </tr>

  
  <tr>
          <td colspan="5" height="40" align="center" class="tblFooter">
              <a href=""><img src="../themes/grey/images/btn_left.png" border="0"/></a>Page 1 of 1 
              <a href="soa_list.php?page=0"> <img src="../themes/grey/images/btn_right.png" border="0"/></a>
          </td>
  </tr>
</table>
</form>
</xsl:template>
</xsl:stylesheet>
