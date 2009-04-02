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
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="pager.xsl"/>
	<xsl:output method="xml"
		indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>

  <xsl:template match="/">
		<xsl:if test="//_get/tbody">
			<tbody>
				<xsl:call-template name="rows"/>
			</tbody>
		</xsl:if>
		<xsl:if test="not(//_get/tbody)">
				<xsl:call-template name="rows"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="rows">
    <xsl:variable name="link_prefix" select="//link_prefix"/>
      <xsl:for-each select="/_R_/zones_get_all/zones_get_all">
        <tr id="{id}">
          <td>
            <a href="{$link_prefix}zone-edit&amp;zone={id}">
              <xsl:value-of select="origin"/>
            </a>
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
  </xsl:template>
	<!-- verbose 

        <xsl:for-each select="/_R_/zones_get_all/zones_get_all">
					<xsl:if test="position() &lt; 17">
          <tr>
            <td>
              <a href="{$link_prefix}zone-edit&amp;zone={id}">
                <xsl:value-of select="origin"/>
              </a>
            </td>
            <td>
              <a href="{$link_prefix}zone-edit&amp;zone={id}">
                <xsl:value-of select="domain_expires"/>
              </a>
            </td>
            <xsl:if test="verbose='true'">
              <td>
                <a href="{$link_prefix}zone-edit&amp;zone={id}">
                  <xsl:value-of select="ns"/>
                </a>
              </td>
              <td>
                <a href="{$link_prefix}zone-edit&amp;zone={id}">
                  <xsl:value-of select="ttl"/>
                </a>
              </td>
              <td>
                <a href="{$link_prefix}zone-edit&amp;zone={id}">
                  <xsl:value-of select="active"/>
                </a>
              </td>
            </xsl:if>
            <xsl:if test="not(verbose)">
              <td>
                <xsl:value-of select="ttl"/>
              </td>
            </xsl:if>
            <td align="right">
              <a href="{$link_prefix}x-zone-delete&amp;id={id}"
								onclick="delete_zone({id},this); return false;">Delete</a>
							| <a href="{$link_prefix}zone-clone&amp;zone={id}">
								Clone
							</a>
						</td>
          </tr>
					</xsl:if>
        </xsl:for-each>
				-->
</xsl:stylesheet>
