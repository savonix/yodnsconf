<?php
/* <!--
Program: YoDNSConf
Component: runtime.php
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
*/

$path        = $_SERVER['SCRIPT_NAME'];
$path_prefix = dirname($path).'/';
$link_prefix = $path . '?nid=';

$utcdate = gmdate('Y-m-d H:i:s');


$tablesorter = json_decode(rawurldecode($_COOKIE['jqCookieJar_tablesorter']),true);
//$defaults = Nexista_Config::getSection('zone_defaults');
//Nexista_Flow::add('zone_defaults', $defaults, false);


if(isset($_GET['ns_filter'])) {
    $_SESSION['ns_filter'] = $_GET['ns_filter'];
} elseif (!$_SESSION['ns_filter']) {
    $_SESSION['ns_filter'] = '%';
}

$ns_filter = $_SESSION['ns_filter'];


$runtime = array(
        'path_prefix' => $path_prefix,
        'link_prefix' => $link_prefix,
        'utcdate' => $utcdate,
        'ns_filter' => $ns_filter,
        'db_version' => $db_version
        );

Nexista_Flow::add('runtime', $runtime, false);
Nexista_Flow::add('tablesorter', $tablesorter, false);
/*
{"myzones-page":1,"myredirects-sort":[[0,0]],"myredirects-page":8,"records_table-page":1,"myposts-page":1,"my-template-table-page":1,"myhosts-page":9}
*/
?>