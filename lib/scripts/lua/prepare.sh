#!/bin/sh
# Program: YoDNSConf
# Component: runtime.php
# Copyright: Savonix Corporation
# Author: Albert L. Lash, IV
# License: Gnu Affero Public License version 3

cat /var/www/dev/yodnsconf/config/config.xml | sed "s/&//g" > /var/www/dev/yodnsconf/config/config_noent.xml
xsltproc --param datasource_id 'yodnsconf_read' lua_tables.xsl /var/www/dev/yodnsconf/config/config_noent.xml > config.lua
