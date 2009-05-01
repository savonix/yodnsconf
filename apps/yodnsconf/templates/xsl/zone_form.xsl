<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: zone_form.xsl
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
	<xsl:template name="zone-form">
		<xsl:param name="zone_prefix"/>
		<script type="text/javascript">
		<![CDATA[
		function add_element () {
      $("#origin").after("<br/><input name=\"origin[]\" type=\"text\"/> <span style=\"font-size: 1.5em; cursor: pointer;\" onclick=\"remove_element();\">x</span>");
    }
    function remove_element () {
      alert('Not functional yet.');
    }
		]]>
    </script>
		<table width="100%">
			<tr>
				<td>
				Origin:
				<xsl:if test="not($zone_prefix/origin)">
					<br/>
					(one per line)
				</xsl:if>
				</td>
				<td>
					<xsl:if test="$zone_prefix/origin">
						<input name="origin" type="text" value="{$zone_prefix/origin}"/>
            (example.com.)
          </xsl:if>
					<xsl:if test="not($zone_prefix/origin)">
						<input name="origin[]" type="text"/>
						<span style="cursor: pointer; font-weight: bold; font-size: 1.5em;"
							id="origin" onclick="add_element(); return false;">+</span>
					</xsl:if>
					<br/>
					<br/>
				</td>
			</tr>
			<tr>
				<td>Name Server:</td>
				<td>
					<input name="ns" type="text" value="{$zone_prefix/ns}"/>
				</td>
			</tr>
			<tr>
				<td>Admin Email:</td>
				<td>
					<input name="mbox" type="text" value="{$zone_prefix/mbox}"/>
				</td>
			</tr>
			<xsl:if test="/_R_/_get/zone">
				<tr>
					<td>Serial No.:</td>
					<td>
						<input name="serial" type="text" value="{$zone_prefix/serial}" readonly="readonly" />
					</td>
				</tr>
			</xsl:if>
			<tr>
				<td>Refresh:</td>
				<td>
					<input name="refresh" type="text" value="{$zone_prefix/refresh}" required="1"/>
				</td>
			</tr>
			<tr>
				<td>Retry:</td>
				<td>
					<input name="retry" type="text" value="{$zone_prefix/retry}"/>
				</td>
			</tr>
			<tr>
				<td>Expire:</td>
				<td>
					<input name="expire" type="text" value="{$zone_prefix/expire}"/>
				</td>
			</tr>
			<tr>
				<td>Minimum TTL:</td>
				<td>
					<input name="minimum" type="text" value="{$zone_prefix/minimum}"/>
				</td>
			</tr>
			<tr>
				<td>TTL:</td>
				<td>
					<input name="ttl" type="text" value="{$zone_prefix/ttl}"/>
				</td>
			</tr>
			<tr>
				<td>Notes:</td>
				<td>
					<input name="notes" type="text" value="{$zone_prefix/notes}"/>
				</td>
			</tr>
			<tr>
				<td>Expiration Date:</td>
				<td>
					<input name="expiration_date" type="text" value="{$zone_prefix/expiration_date}"/>
				</td>
			</tr>
			<tr>
				<td>Group:</td>
				<td>
          <select name="zone_group_id">
              <option>None</option>
            <xsl:for-each select="//zone_groups_get_all/zone_groups_get_all">
              <xsl:variable name="my_zone_group_id" select="zone_group_id"/>
              <option value="{zone_group_id}">
                <xsl:if test="$zone_prefix/zone_group_id=$my_zone_group_id">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="zone_group_name"/>
              </option>
            </xsl:for-each>
          </select>
				</td>
			</tr>
			<tr>
				<td valign="top">Active:</td>
				<td>
					<input name="active" type="radio" value="Y">
						<xsl:if test="$zone_prefix/active='Y'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input> Yes<br/>
					<input name="active" type="radio" value="N">
						<xsl:if test="$zone_prefix/active='N'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input> No<br/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="submit" class="button" value="Save"/>&#160;
					<input type="button" class="button" value="Cancel"
						onClick="window.location.href='{/_R_/runtime/link_prefix}index'"/>
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>
