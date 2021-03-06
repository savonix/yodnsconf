/*
###
Program: YoDNSConf
Component: yodnsconf.js
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
##
*/

function create_row(zone,myr) {
  var newtextnode = document.createTextNode(zone);
  mytd.appendChild(newtextnode);
  return mytr;
}

function build_list(data,options) {
  
}
function build_table(table,data,options,key) {
    index = $(table).data('index');
    zones = data;
    zoneview = $(table).data(key).slice(index,index + 10);

    var mytb = document.createElement("tbody");
    var mytr = document.createElement("tr");
    var mytd1 = document.createElement("td");
    mytd1.className = 'primary-key';
    var mytd2 = document.createElement("td");
    for(var i=0,max=options.length;i<max;i++){
      var mysp1 = document.createElement("span");
      var mytn1 = document.createTextNode(options[i]);
      mysp1.appendChild(mytn1);
      mytd2.appendChild(mysp1);
    }
    
    $.each(zoneview, function(i,zone) {
        myr = mytr.cloneNode(true);
        var mytdd1 = mytd1.cloneNode(true);
        var mytdd2 = mytd2.cloneNode(true);
        myr.appendChild(mytdd1);
        myr.appendChild(mytdd2);
        var newtextnode = document.createTextNode(zone);
        mytdd1.appendChild(newtextnode);
        mytb.appendChild(myr);
    });
    $('tbody',table).replaceWith(mytb);
    $('.primary-key',table).click(function(){
        thezone = $(this).text();
        load_zone(thezone);
    });
    $(table).data('index', index + 5);
    $('#origin').quicksearch('tbody tr',table);
}
function load_zones() {
  $('#content').load(app_prefix + 'raw/xhtml/zones.html', function() {
    $.getJSON(app_prefix + 'raw/json/zones',function(data) {
        $('#myzones').data('zones', data);
        $('#myzones').data('index', 0);
        var options = ["Edit", "Delete", "Clone"];
        build_table('#myzones',data,options,'zones');
    });
  });
}
function load_redirects() {
  $('#content').load(app_prefix + 'raw/xhtml/redirects.html', function() {
    $.getJSON(app_prefix + 'raw/json/redirects',function(data) {
        $('#myzones').data('zones', data);
        $('#myzones').data('index', 0);
        var options = ["Edit", "Delete", "Clone"];
        build_table('#myzones',data,options,'zones');
    });
  });
}
function load_zone(thezone) {
  document.title = thezone;
  $.history.load(thezone);
  $('#content').load(app_prefix + 'raw/xhtml/zone_edit.html', function() {
      $('input:text[name="origin[]"]').val(thezone);
      $.getJSON(app_prefix + 'raw/json/records/soa/'+thezone,function(data) {
          for (var key in data) {
            $('input:text[name="'+key+'"]').val(data[key]);
          }
      });
      $.getJSON(app_prefix + 'raw/json/public-ns/'+thezone,function(data) {
          for (var i=0;i<data.length;i=i+1) {
            var ns = data[i] + ", ";
            $('#public-resolvers .data').append(ns);
          }
      });
      $.getJSON(app_prefix + 'raw/json/yd-zone-groups',function(data) {
          var opt = $('#zone_group_id').find('option').clone();
          for (var i=0;i<=data.length;i=i+1) {
            var zg = data[i];
            opt.clone().val(zg.id).text(zg.label).appendTo($('#zone_group_id'));
          }
      });
  });
}
function load_records(thezone) {
  
}

$(document).ready(function() {
  $('#nav').droppy();
  if($('#myzones').length > 0) {
    $.history.init(function(url) {
      if(url == "") {
        load_zones();
      } else {
        load_zone(url);
      }
    });
  }
  if($('#myredirects').length > 0) {
    $.history.init(function(url) {
      if(url == "") {
      } else {
      }
    });
  }
});





/* DEPRECATED */


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
