<!--
Program: YoDNSConf
Component: sitetest.txt.xsl
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
  <xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    function delete_host(id) {
      if(confirm('Are you sure?')){
        $.post("<xsl:value-of select="//link_prefix"/>x-host-delete&amp;host_id="+id,
        {
					'host_id': id
        },
        function (data){
          $("#h_"+id).remove();
        });
      }
    }
    function delete_record(record_id,zone) {
      if(confirm('Are you sure?')){
        $.post("<xsl:value-of select="//link_prefix"/>x-record-delete&amp;record_id="+record_id,
        {
          // zone is needed to update serial
          'record_id': record_id,
          'zone': zone
        },
        function (data){
					$("#"+record_id).remove();
        });
      }
    }
    function delete_hostgroup(id) {
      if(confirm('Are you sure?')){
        $.post("<xsl:value-of select="//link_prefix"/>x-hostgroup-delete&amp;hostgroup_id="+id,
        {
					'hostgroup_id': id
        },
        function (data){
          $("#hg_"+id).remove();
        });
      }
    }
  </xsl:template>
</xsl:stylesheet>
