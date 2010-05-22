<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: redirects.xsl
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
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>


<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=myredirects" />

<div class="tableframe">
  <table width="100%" class="tablesorter" id="myredirects">
    <thead>
      <tr>
        <th width="45%">
          <span id="i18n-domain_name">Domain Name</span>
        </th>
        <th width="45%">
          <span id="i18n-destination">Destination</span>
        </th>
        <th width="10%" />
      </tr>
      <tr>
        <form method="get">
          <input type="hidden" name="nid" value="redirects"/>
          <td>
            <input type="text" name="http_host" value="{/_R_/_get/http_host}"/>
          </td>
          <td />
          <td align="right">
            <input name="Filter" type="submit" value="Filter"/>
          </td>
        </form>
      </tr>
    </thead>
    <tbody>
    <xsl:for-each select="/_R_/redirects_get_all/redirects_get_all">
      <tr id="h_{position()}">
        <td>
          <div style="width:20em;white-space:nowrap;overflow:hidden">
            <a href="{$link_prefix}redirect-edit&amp;http_host={http_host}"
            title="{http_host}">
              <xsl:value-of select="http_host"/>
            </a>
          </div>
        </td>
        <td>
          <div style="width:20em;white-space:nowrap;overflow:hidden">
            <a href="{$link_prefix}redirect-edit&amp;http_host={http_host}"
            title="{redirect}">
              <xsl:value-of select="redirect"/>
            </a>
          </div>
        </td>
        <td align="right">
          <a href="{$link_prefix}x-redirect-delete&amp;http_host={http_host}"
          onclick="delete_redirect('{http_host}',{position()}); return false;">
            <span id="i18n-delete">Delete</span>
        </a>
        </td>
      </tr>
    </xsl:for-each>
    </tbody>
  </table>
</div>
<div class="table_controls">
<xsl:call-template name="pager">
  <xsl:with-param name="my-table">myredirects</xsl:with-param>
</xsl:call-template>
</div>
<div style="text-align: right" class="table_meta">
  <a href="{$link_prefix}redirect-edit">
    <span id="i18n-new">New</span>
  </a>&#160;
  <a href="{$link_prefix}x-redirects-export">
    <span id="i18n-export">Export</span>
  </a>&#160;
  <a href="{$link_prefix}x-redirects-export-nginx">
    <span id="i18n-nginx">NGINX</span>
  </a>
</div>


  </xsl:template>
</xsl:stylesheet>