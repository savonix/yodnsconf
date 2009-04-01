<!--
Program: YoDNSConf - http://www.yodnsconf.com/
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
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="html_main.xsl"/>
  <xsl:include href="pager.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
		<xsl:variable name="pagenum" select="//tablesorter/myzones-page - 1"/>
    <xsl:call-template name="jquery-setup">
      <xsl:with-param name="my-table">myzones</xsl:with-param>
      <xsl:with-param name="my_page"><xsl:value-of select="$pagenum"/></xsl:with-param>
      <xsl:with-param name="no-sort-column">,
        headers: { 1: {sorter: false}, 2: {sorter: false} }
    </xsl:with-param>
    </xsl:call-template>
    <script type="text/javascript">
		// zone delete
    function zd(zone,row) {
			if(confirm('Are you sure?')){
			$.post("<xsl:value-of select="$link_prefix"/>x-zone-delete&amp;zone="+zone,
			{
					'zone': zone
			},
			function (data){
			});
			myTable = document.getElementById("myzones");
			myTable.deleteRow(row.parentNode.parentNode.rowIndex);
			}
			return false;
    }
		function fixup_rows() {
			if($(".zc:first").text()=="") {
				$(".zc,.zd,.ze").css("cursor","pointer");
				$(".zd").click( function () { 
					zd($(this).parent().parent().attr("id"));
				}
				);
				$(".zd").text("Delete");
				$(".zd").after(" | ");
				$(".zc").text("Clone");
				$(".zc").click( function () { 
					location.href="<xsl:value-of select="//link_prefix"/>zone-clone&amp;zone="+$(this).parent().parent().attr("id"); 
				}
				);
				$(".ze").click( function () { 
					location.href="<xsl:value-of select="//link_prefix"/>zone-edit&amp;zone="+$(this).parent().parent().attr("id"); 
				}
				);
			}
		}
    $(document).ready(function()
        {
					fixup_rows();
					//$(".prev,.next").click(function() { fixup_rows(); });
					//$("table").change(function() { fixup_rows(); });
					$(".header").bind("mouseleave", function(e) { fixup_rows(); });
					$(".prev,.next").bind("click", function(e) { fixup_rows(); });
				}
		);
    </script>
		
    <div id="my_zones_div" class="tableframe">
      <table width="100%" class="tablesorter" id="myzones">
        <thead>
          <tr>
            <th id="barf" width="700">Origin</th>
            <xsl:if test="verbose='true'">
              <th>Name Server</th>
            </xsl:if>
            <th width="100">TTL</th>
            <xsl:if test="verbose='true'">
              <th>Active</th>
            </xsl:if>
            <th width="100"></th>
          </tr>
          <tr>
            <form method="get">
						  <input type="hidden" name="nid" value="{/_R_/_get/nid}"/>
              <td>
                <input type="text" name="origin" value="{/_R_/_get/origin}"
									onkeyup="filter_table(this.value,'Origin')"/>
              </td>
              <xsl:if test="verbose='true'">
                <td></td>
                <td></td>
              </xsl:if>
              <td align="right">
                <input name="Filter" type="submit" id="Filter" value="Filter"/>
              </td>
            </form>
          </tr>
        </thead>
				<tbody id="myzonesbody">

        <xsl:for-each select="/_R_/zones_get_all/zones_get_all">
          <tr id="{id}">
            <td>
              <span class="ze">
                <xsl:value-of select="origin"/>
              </span>
            </td>
            <xsl:if test="verbose='true'">
              <td>
                <xsl:value-of select="ns"/>
              </td>
              <td>
                <xsl:value-of select="ttl"/>
              </td>
              <td>
                <xsl:value-of select="active"/>
              </td>
            </xsl:if>
            <xsl:if test="not(verbose)">
              <td>
                <xsl:value-of select="ttl"/>
              </td>
            </xsl:if>
            <td>
              <span class="zd"/>
							<span class="zc"/>
						</td>
          </tr>
        </xsl:for-each>
				</tbody>
      </table>
    </div>
    <div class="table_controls">
    <xsl:call-template name="pager">
      <xsl:with-param name="my-table">myzones</xsl:with-param>
    </xsl:call-template>
    </div>
		<div class="prefoot" style="float: right">
			Total number of zones: <xsl:value-of select="count(/_R_/zones_get_all/zones_get_all)"/>
			<br/>
      <a href="{$link_prefix}x-zones-export-csv&amp;ns_filter=ns1.savonix.com.">CSV Zone Export</a>
		</div>
  </xsl:template>
</xsl:stylesheet>
