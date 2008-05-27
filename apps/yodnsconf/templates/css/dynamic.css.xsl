<!--
Program: YoDNSConf
Component: dynamic.css.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:include href="base.css.xsl"/>
<xsl:include href="colors.css.xsl"/>
<xsl:include href="layout.css.xsl"/>
<xsl:include href="typography.css.xsl"/>
<xsl:template match="/">

<xsl:call-template name="base"/>
<xsl:call-template name="typography"/>
<xsl:call-template name="layout"/>
<xsl:call-template name="colors"/>
a
{
    color: red;
}


body {
    font-family: sans-serif;
    border: 0;
    padding: 0;
    margin: 0;
    margin-top: 0;
	font-size: small;
}

img {
    border: 0;
}
textarea,input.text,select,option{
	color:#000;
	font-family: CourierNew, Courier, monospace;
	background-color:#FCFCFC;
	font-size: 120%;
	border: 1 solid ##BFCBD9;
	position: relative;
}
.button {
	border-color: #666699;
	border-width: 1px;
    color: #000;
	background-color: #FFF;
}

#main-menu {
	font-size: small;
}
#main-menu a {
	padding: .3em 1em .3em 1em;
	background-color: #DEE4F2;
	border: 1px solid #C0CCDA;
    color: black;
    margin-left: .4em;
}

#main-menu a.sub {
	background-color: #FFF;
}

#main-menu select {
    right: .4em; position: fixed; margin-top: -.5em;
}

#primary-workspace {
    padding: 1em;
    min-height: 30em;
}
#footer {
    padding: 1em;
    padding-top: 2em;
    font-size: small;
}

.error {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	color: #000000;
	border: 1px solid #CC0000;
	text-decoration: none;
}

input {
	border: 1px solid #BFCBD9;
}

textarea {
	border: 1px solid #BFCBD9;
}

</xsl:template>
</xsl:stylesheet>
