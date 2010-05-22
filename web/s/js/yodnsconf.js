/*
Program: YoDNSConf
Component: js_functions.js.xsl
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
*/

function delete_redirect(http_host,pos) {
    if(confirm('Are you sure?')){
      $.post(app_prefix + "x-redirect-delete&http_host="+http_host,
      {
        'http_host': http_host
      },
      function (data){
        $("#h_"+pos).remove();
      });
    }
}

function delete_host(id) {
  if(confirm('Are you sure?')){
    $.post(app_prefix + "x-host-delete&host_id="+id,
    {
      'host_id': id
    },
    function (data){
      $("#h_"+id).remove();
    });
  }
}

function delete_ip(ip_id) {
    if(confirm('Are you sure?')){
    $.post(app_prefix + "x-ydc-ip-addr-delete&ip_id="+ip_id,
    {
        'ip_id': ip_id
    },
    function (data){
      $("#ip_"+ip_id).remove();
    });
    }
}

function delete_record(record_id,zone) {
  if(confirm('Are you sure?')){
    $.post(app_prefix + "x-record-delete&record_id="+record_id,
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
    $.post(app_prefix + "x-hostgroup-delete&hostgroup_id="+id,
    {
      'hostgroup_id': id
    },
    function (data){
      $("#hg_"+id).remove();
    });
  }
}
// zone delete / delete_zone
function zd(zone) {
  if(confirm('Delete zone id '+zone+'? You can deactivate it instead.')){
    $.post(app_prefix + "x-zone-delete&zone="+zone,
    {
      'zone': zone
    },
    function (data){
      $("#"+zone).remove();
    });
    // TODO - FIXME - Use jQuery AJAX.
    $("#"+zone).remove();
  }
  return false;
}
function delete_zone_group(zone_group_id) {
  if(confirm('Are you sure you want to ?')){
    $.post(app_prefix + "x-zone-group-delete&zg_id="+zone_group_id,
    {
      'zone_group_id': zone_group_id
    },
    function (data){
      $("#zg_"+zone_group_id).remove();
    });
    // TODO - FIXME - Use jQuery AJAX.
    $("#zg_"+zone_group_id).remove();
  }
  return false;
}


function delete_service(id) {
    if(confirm('Are you sure?')){
    $.post(app_prefix + "x-service-delete&service_id="+id,
    {
      'service_id': id
    },
    function (data){
      $("#s_"+id).remove();
    });
    }
}

function select_all_boxes(checkbox_name) {
  $(":checkbox[name='"+checkbox_name+"[]']").attr("checked","checked");
}

function fixup_rows() {
  // Has this already been done?
  if($(".zrow td:nth-child(3) a:nth-child(1)").text()=="") {

    // Zone Row Highlight
    $(".zrow tr").hover(
      function () {
        $(this).addClass("active");
      },
      function () {
        $(this).removeClass("active");
      }
    );

    /*
    $("#myzonesbody tr").append('<td class="ztrow"><a href="#">Delete</a></td>');
    $("<a/>", {
      'text': 'Delete',
      'click': function () {
        zd($(this).parent().parent().attr("id"));
      }
    }).appendTo(".ztrow");
    */

  }
}


$(document).ready(function() {
  fixup_rows();
  $(".header").bind("mouseleave", function(e) { fixup_rows(); });
  $(".prev,.next").bind("click", function(e) { fixup_rows(); });
  $('#nav').droppy();
});