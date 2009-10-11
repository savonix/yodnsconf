<!--
Program: Numerous
Component: html_custom.xsl
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
  <xsl:output method="xml" indent="yes" encoding="UTF-8"
  omit-xml-declaration="no" doctype-public="-//W3C//DTD XHTML 1.1//EN"
  doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>
  <xsl:strip-space elements="*"/>

	<!-- UI PRIMARY MENU -->
  <xsl:template name="main-menu">
    <ul id="nav">
      <xsl:for-each select="//menu/item[not(@active=0)]">
        <xsl:call-template name="list-button">
          <xsl:with-param name="key" select="key"/>
        </xsl:call-template>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- UI LIST BUTTON -->
  <xsl:template name="list-button">
    <xsl:param name="key"/>
    <li>
      <a href="#" class="head">
        <xsl:value-of select="/_R_/i18n/*[name()=$key]"/>
      </a>
      <ul>
        <xsl:for-each select="//menu/item[key=$key]/item">
          <xsl:variable name="my_key" select="key"/>
          <li>
            <a href="{//runtime/link_prefix}{url}" id="{key}">
              <xsl:value-of select="/_R_/i18n/*[name()=$my_key]"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>
    </li>
  </xsl:template>

  <!-- UI HEADER -->
  <xsl:template name="header">
    <xsl:param name="i18n"/>
    <div id="header">&#160;
    	<span id="company-name">
        <xsl:value-of select="//runtime/company_name"/>
      </span>
      <h1 class="page-title">
        <xsl:value-of select="/_R_/i18n/*[name()=/_R_/_get/nid]"/>
      </h1>
    </div>
  </xsl:template>

  <!-- HTML SHELL -->
  <xsl:template match="/">
    <html>
      <xsl:variable name="link_prefix" select="/_R_/runtime/link_prefix"/>
      <xsl:variable name="path_prefix" select="/_R_/runtime/path_prefix"/>

      <xsl:call-template name="head">
        <xsl:with-param name="link_prefix" select="$link_prefix"/>
        <xsl:with-param name="path_prefix" select="$path_prefix"/>
      </xsl:call-template>
      <body>
				<xsl:for-each select="//pre_body_content">
					<xsl:sort select="priority" order="ascending"/>
					<xsl:apply-templates select="nodes/*"/>
				</xsl:for-each>

        <xsl:call-template name="main">
          <xsl:with-param name="link_prefix" select="$link_prefix"/>
          <xsl:with-param name="path_prefix" select="$path_prefix"/>
          <xsl:with-param name="i18n" select="$my18n"/>
        </xsl:call-template>

        <xsl:for-each select="//footer_nodes">
          <xsl:sort select="priority" order="ascending"/>
          <xsl:apply-templates select="nodes/*"/>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

  <!-- HTML HEAD -->
	<xsl:template name="head">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<head>
			<title>
				STANDARD TEMPLATES
			</title>
		</head>
	</xsl:template>

  <!-- XHTML FRIENDLY IDENTITY TEMPLATE FOR ELEMENTS-->
  <xsl:template match="node()">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>

  <!-- XHTML FRIENDLY IDENTITY TEMPLATE FOR CONTENT AND NODES -->
  <xsl:template match="@*|text()|comment()|processing-instruction()">
    <xsl:copy/>
  </xsl:template>

</xsl:stylesheet>
