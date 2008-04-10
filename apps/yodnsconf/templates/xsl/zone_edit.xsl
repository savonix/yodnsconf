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
<xsl:include href="pager.xsl"/>
<xsl:include href="zone_form.xsl"/>
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
<div style="float: left;">
<form method="post" onSubmit="return validateStandard(this);" name="myform">
<xsl:if test="//_get/zone">
    <input type="hidden" name="zone" value="{//_get/zone}"/>
    <input type="hidden" name="action" value="edit"/>
    <xsl:call-template name="zone-form">
        <xsl:with-param name="zone_prefix">zone_get_by_id</xsl:with-param>
    </xsl:call-template>
</xsl:if>
<xsl:if test="not(//_get/zone)">
    <input type="hidden" name="action" value="create"/>
    <xsl:call-template name="zone-form">
        <xsl:with-param name="zone_prefix">defaults</xsl:with-param>
    </xsl:call-template>
</xsl:if>
</form>
</div>

<div style="float: right;">
<xsl:call-template name="jquery-setup">
    <xsl:with-param name="my-table">records_table</xsl:with-param>
    <xsl:with-param name="no-sort-column">,
        headers: { 
            2: {sorter: false}
        }
    </xsl:with-param>
</xsl:call-template>
<table style="width: 420px;" class="tablesorter" id="records_table">
    <thead>
    <tr>
        <th>Name</th>
        <th>Data</th>
        <th>Dig</th>
    </tr>
    </thead>
    <tbody>
    <xsl:for-each select="//records_get_by_id">
    <tr>
        <td>
            <a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}">
                <xsl:value-of select="name"/>
            </a>
        </td>
        <td>
            <a href="{//link_prefix}record-edit&amp;id={id}&amp;zone={zone}">
                <xsl:value-of select="substring(data,0,30)"/>
            </a>
        </td>
        <td>
            <a href="{//link_prefix}tools-query&amp;hostname={name}.{//zone_get_by_id/origin}&amp;type={type}">
                Dig
            </a>
        </td>
    </tr>
    </xsl:for-each>
    </tbody>
</table>
<xsl:if test="count(//records_get_by_id) &gt; 10">
    <xsl:call-template name="pager"/>
</xsl:if>
<iframe src="http://www.{//origin}"></iframe>
</div>
<script language="javascript">
    initValidation();
</script>
</xsl:template>
</xsl:stylesheet>
