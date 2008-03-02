<?php

include('xdump/xdump.php');

//echo xDump::dump($_SESSION);

Nexista_Flow::add("pun_config",$pun_config,false);

# This wacky path builder is required due to mod_rewrite situations
$path = $_SERVER['REQUEST_URI'];
Nexista_Flow::add("request_uri",$path);
$path = dirname($path)."/".basename($_SERVER['SCRIPT_NAME']);
$path_prefix = dirname($path)."/";
//$app_prefix = "acc/".APP_NAME."/";
//$link_prefix = $path."?nid=".$app_prefix;
$link_prefix = $path."?nid=";
$right_now = date('Y-m-d H:i:s');



$runtime = array('host_name'=>$_SERVER['SERVER_NAME'],
                'path_prefix'=>$path_prefix,
                'link_prefix'=>$link_prefix,
                'right_now'=>$right_now,
                'username'=>$_SESSION['NX_AUTH']['username'],
                'user_id'=>$_SESSION['NX_AUTH']['user_id'],
                'group_id'=>$_SESSION['NX_AUTH']['group_id'],
                'remote_ip'=>$_SERVER['REMOTE_ADDR'],
                'debug'=>$debug,
                'admin'=>1,
                'top_left_logo'=>$top_left_logo,
                'db_version'=>$db_version,
                'timestamp'=>time());

Nexista_Flow::add("runtime",$runtime,false);


?>