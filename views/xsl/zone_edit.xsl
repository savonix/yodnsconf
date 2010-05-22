<!--
Program: YoDNSConf - http://www.yodnsconf.com/
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
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="zone_form.xsl"/>
  <xsl:template match="/">

<div>



<div style=" width: 50%;">
<form method="post" onSubmit="return validateStandard(this);" name="myform">
  <xsl:if test="/_R_/_get/zone or /_R_/_get/origin">
    <input type="hidden" name="zone" value="{/_R_/zone_get_by_id/zone_get_by_id/id}"/>
    <input type="hidden" name="action" value="edit"/>
    <xsl:call-template name="zone-form">
      <xsl:with-param name="zone_prefix" select="/_R_/zone_get_by_id/zone_get_by_id"/>
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="not(/_R_/_get/zone) and not(/_R_/_get/origin)">
    <input type="hidden" name="action" value="create"/>
    <xsl:call-template name="zone-form">
      <xsl:with-param name="zone_prefix" select="/_R_/config/zone_defaults"/>
    </xsl:call-template>
  </xsl:if>
</form>


<xsl:variable name="origin_link" select="substring(//origin,0,string-length(//origin))"/>
<a class="thickbox" href="http://www.{$origin_link}/?keepThis=true&amp;TB_iframe=true&amp;height=400&amp;width=600">Preview</a>
<br/>
<a class="thickbox" href="{$link_prefix}zone-keys&amp;zone={/_R_/zone_get_by_id/zone_get_by_id/id}">Zone Keys</a>
<br/>
<a href="{$link_prefix}x-zone-export&amp;zone={//id}">Export</a>
</div>
</div>
  </xsl:template>
</xsl:stylesheet>
