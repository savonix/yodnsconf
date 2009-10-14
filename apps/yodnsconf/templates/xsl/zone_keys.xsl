<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: zone_keys.xsl
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
  <xsl:include href="html_main.xsl"/>
  <xsl:include href="pager.xsl"/>
  <xsl:include href="zone_form.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>


<table>
<form method="post" name="myform">
    <input type="hidden" name="zone" value="{/_R_/zone_get_by_id/zone_get_by_id/id}"/>
    <xsl:for-each select="//zone_meta/meta">
      <tr><td><xsl:value-of select="meta_key"/>:</td>
      <td><input type="text" name="{meta_key}"/></td></tr>
    </xsl:for-each>
</form>
</table>


  </xsl:template>
</xsl:stylesheet>
