<!--
Program: YoDNSConf
Component: pager.xsl
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
<xsl:output method="html" omit-xml-declaration="yes"/> 

<!-- This template is used by pages which use the tablesorter and the table paginator -->
<xsl:template name="jquery-setup">
<xsl:param name="my-table"/>
<xsl:call-template name="jquery-links"/>
<script type="text/javascript" src="{__ROOT__/runtime/path_prefix}s/js/jquery.tablesorter.pager.js">&#160;</script>
<script type="text/javascript">
$(document).ready(function() 
    { 
        $("#<xsl:value-of select="$my-table"/>")
        .tablesorter({widgets: ['zebra']})
        .tablesorterPager({container: $("#pager")}); 
    } 
); 
</script>
</xsl:template>

<!-- This template is used by pages which only use the tablesorter, not the paginator-->
<xsl:template name="jquery-setup-simple">
<xsl:param name="my-table"/>
<xsl:call-template name="jquery-links"/>
<script type="text/javascript">
$(document).ready(function() 
    { 
        $("#<xsl:value-of select="$my-table"/>")
        .tablesorter({widgets: ['zebra']});
    } 
); 
</script>
</xsl:template>

<!-- load the javascript -->
<xsl:template name="jquery-links">
<link rel="stylesheet" href="{__ROOT__/runtime/path_prefix}s/js/blue/style.css" type="text/css" media="print, projection, screen" />
<script type="text/javascript" src="{__ROOT__/runtime/path_prefix}s/js/jquery-1.2.1.min.js">&#160;</script>
<script type="text/javascript" src="{__ROOT__/runtime/path_prefix}s/js/jquery.tablesorter.min.js">&#160;</script>
</xsl:template>

<xsl:template name="pager">
<div id="pager" class="pager" style="margin-top: 20px;">
    <table>
        <tr>
        <td>
		<img src="{/__ROOT__/runtime/path_prefix}/s/js/blue/first.png" class="first"/>
		<img src="{/__ROOT__/runtime/path_prefix}/s/js/blue/prev.png" class="prev"/>
		</td>
        <td>
        <input type="text" class="pagedisplay" size="10" readonly="readonly"/>
        </td>
        <td>
		<img src="{/__ROOT__/runtime/path_prefix}/s/js/blue/next.png" class="next"/>
		<img src="{/__ROOT__/runtime/path_prefix}/s/js/blue/last.png" class="last"/>
        </td>
        </tr>
    </table>
    <input class="pagesize" type="hidden" name="pagesize" value="10"/>
</div>
</xsl:template> 
</xsl:stylesheet>
