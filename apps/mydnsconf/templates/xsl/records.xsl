<!--
Program: MyDNSConf
Component: records.xsl
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
<xsl:template name="content"><div class="frmTextHead">Records</div>
<input style="float: right; margin-top: -20px" type="button" value="Add New Record" onClick="location.href='rr_edit.php'" />
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td class="tblHead">Name</td>
    <td class="tblHead">Type</td>
    <td class="tblHead">Data</td>

    <td class="tblHead">Preference/Priority</td>
    <td class="tblHead">TTL</td>
    <td class="tblHead"></td>
  </tr>
  <tr>
    <td class="frmText11"><input type="text" name="search_name" value="" class="text" /></td>
    <td class="frmText11">
    <select name="search_type" onChange="changeTab('rr');">
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
    </select></td>
    <td class="frmText11"><input type="text" name="search_data" value="" class="text" /></td>
    <td class="frmText11"><input type="text" name="search_aux" value="" class="text" /></td>
    <td class="frmText11"><input type="text" name="search_ttl" value="" class="text" /></td>
    <td class="frmText11" align="right">
        <input name="Filter" type="button" id="Filter" value="Filter" onClick="changeTab('rr');"/></td>
  </tr>
  <xsl:for-each select="//records_get_by_id">
  <tr bgcolor="#EEEEEE">
    <td class="frmText11"><a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}" class="frmText11"><xsl:value-of select="name"/></a></td>
    <td class="frmText11"><a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}" class="frmText11"><xsl:value-of select="type"/></a></td>
    <td class="frmText11"><a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}" class="frmText11"><xsl:value-of select="data"/></a></td>
    <td class="frmText11"><a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}" class="frmText11"><xsl:value-of select="aux"/></a></td>
    <td class="frmText11"><a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}" class="frmText11"><xsl:value-of select="ttl"/></a></td>
    <td class="frmText11" align="right">[<a href="" class="frmText11">Delete</a>]</td>
  </tr>
  </xsl:for-each>
  <tr>
          <td colspan="6" height="40" align="center" class="tblFooter">
            <a href="">
            <img src="../themes/grey/images/btn_left.png" border="0"/></a>   Page 1 of 1 <a href=""> 
            <img src="../themes/grey/images/btn_right.png" border="0"/></a></td>
  </tr>
</table>
</xsl:template>
</xsl:stylesheet>
