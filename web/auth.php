<?php

ini_set('display_errors',true);
error_reporting(E_ALL ^ E_NOTICE);

// Where is nexista? This path should be to a folder containing nexista
// This is the only thing you may need to edit:
if(file_exists('../nexista/')) {
    define('NX_PATH_BASE', '../nexista/');
}
if (file_exists('../../nexista/')) {
    define('NX_PATH_BASE', '../../nexista/');
}



/* Probably don't need to edit anything under this line. */

// Bad hack
if(!strpos($_SERVER['REQUEST_URI'],'.php')) {
    header('Location: '.$_SERVER['REQUEST_URI'].'index.php');
    exit;
}

$server_name = $_SERVER['SERVER_NAME'];
define('SERVER_NAME', $server_name);
$project_root = dirname(dirname(__FILE__));
$project_root = str_replace('\\', '/', $project_root);
define('NX_PATH_CORE', NX_PATH_BASE.'kernel/');
define('PROJECT_ROOT', $project_root);
define('PROJECT_NAME', 'yodnsconf');
define('APP_NAME', 'auth');

$server_init = PROJECT_ROOT.'/cache/'.SERVER_NAME.'/'.APP_NAME.'/'.APP_NAME.'.php';

if(!include(NX_PATH_BASE.'extensions/nexista_builder.php')) {
    echo 'Error: Unable to load server loader or builder.';
    exit;
}

// Loader not there or manually getting rebuilt? Build it!
if(!file_exists($server_init) || isset($_POST['x--dev--rebuild'])) {
    nexista_build_it_now($server_init);
} else { // Loader is there, check freshness, then either rebuild or include it.
    nexista_check_freshness($server_init);
    include($server_init);
    exit;
}
