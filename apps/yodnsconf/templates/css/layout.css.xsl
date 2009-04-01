<!--
Program: YoDNSConf
Component: layout.css.xsl
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
<xsl:template name="layout">
#main {
  width: 100%;
  text-align: left;
}

#content {
  padding: .5em;
}

.wten {
  width: 30em;
}
#top_nav {
  background-color: gray;
  font-size: small;
  padding: 2px;
  display: block;
}
#main-menu-buttons {
	padding: 2px;
	background-color: #CCC;
}
#main-menu-buttons a {
	line-height: 2em;
  margin-left: .4em;
	padding: .3em 1em .3em 1em;
}
.prefoot {
  position: absolute;
  bottom: 3px;
  right: 100px;
}
#footer {
  position: absolute;
  bottom: 0px;
}
.simple-table tr td {
	padding: 2px;
	border: 0;
}

.bottom-edge tr {
	border: 0;
	border-bottom: 1px;
	border-style: solid;
}
.tablesorter {
	margin: 0 !important;
}
.table_controls
{
  position: absolute;
  bottom: 35px;
  left: 100px
}
.table_meta
{
  position: absolute;
  bottom: 35px;
  right: 100px;
}
.tableframe
{
  position: absolute;
  top: 40px;
  left: 100px;
  right: 100px;
  bottom: 60px;
  border: 1px solid #999999;
  background-color: #F9F9F9;
  overflow: auto;
  <xsl:if test="//browser='msie'">
  /* css hack for IE */
  width: expression((parseInt(document.documentElement.clientWidth)-230)+'px');
  height: expression((parseInt(document.documentElement.clientHeight)-125)+'px');
  </xsl:if>
}

</xsl:template>
</xsl:stylesheet>
