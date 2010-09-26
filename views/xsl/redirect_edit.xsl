<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: redirect_edit.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">

<div>
<xsl:variable name="my_redirects"
select="/_R_/redirects_get_all/redirects_get_all" />

<form method="post" name="redirect">
  <input type="hidden" name="http_host" value="{/_R_/_get/http_host}"/>
  <xsl:if test="/_R_/_get/nid='redirect-edit'">
    <input type="hidden" name="action" value="edit"/>
  </xsl:if>
  <xsl:if test="not(/_R_/_get/http_host)">
    <input type="hidden" name="action" value="create"/>
  </xsl:if>
  <table width="100%">
    <tr>
      <td>From Host:</td>
      <td>
        <input name="http_host" class="wten" type="text"
          value="{/_R_/_get/http_host}"/>
      </td>
    </tr>
    <tr>
      <td>To URL:</td>
      <td>
        <input name="redirect" class="wten" type="text"
          value="{$my_redirects[http_host=/_R_/_get/http_host]/redirect}"/>
      </td>
    </tr>
    <tr>
      <td>Rewrite Type:</td>
      <td>
        <input name="rewrite_type" type="text"
          value="{$my_redirects[http_host=/_R_/_get/http_host]/rewrite_type}"/>
      </td>
    </tr>
    <tr>
      <td/>
      <td>
        <input type="submit" class="button" value="Save"/>
        <input type="button" class="button" value="Cancel" />
      </td>
    </tr>
  </table>
</form>
</div>

  </xsl:template>
</xsl:stylesheet>
