<!--
Program: YoDNSConf
Component: yodnsconf.sql.xsl
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
<xsl:template match="/">


CREATE TABLE `soa` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `origin` char(255) NOT NULL,
  `ns` char(255) NOT NULL,
  `mbox` char(255) NOT NULL,
  `serial` int(10) unsigned NOT NULL default '1',
  `refresh` int(10) unsigned NOT NULL default '28800',
  `retry` int(10) unsigned NOT NULL default '7200',
  `expire` int(10) unsigned NOT NULL default '604800',
  `minimum` int(10) unsigned NOT NULL default '86400',
  `ttl` int(10) unsigned NOT NULL default '86400',
  `active` enum('Y','N') NOT NULL,
  `xfer` char(255) NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `origin` (`origin`),
  KEY `active` (`active`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


CREATE TABLE `rr` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `zone` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `type` enum('A','AAAA','CNAME','HINFO','MX','NAPTR','NS','PTR','RP','SRV','TXT') default NULL,
  `data` char(256) NOT NULL,
  `aux` int(10) unsigned NOT NULL,
  `weight` int(10) unsigned NOT NULL,
  `port` int(10) unsigned NOT NULL,
  `ttl` int(10) unsigned NOT NULL default '86400',
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `rr` (`zone`,`name`,`type`,`data`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


CREATE TABLE `ip` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `data` char(128) NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `<xsl:value-of select="//table_prefix"/>zone_metadata` (
    `zone_id` int(11) NOT NULL auto_increment,
    `meta_key` varchar(100) NULL,
    `meta_value` varchar(100) NULL,
    PRIMARY KEY `static_file_index` (`static_file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `<xsl:value-of select="//table_prefix"/>record_metadata` (
    `zone_id` int(11) NOT NULL auto_increment,
    `meta_key` varchar(100) NULL,
    `meta_value` varchar(100) NULL,
    PRIMARY KEY `static_file_index` (`static_file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `<xsl:value-of select="//table_prefix"/>options` (
    `option_key` varchar(255) NOT NULL default 'untitled',
    `option_value` varchar(255) default NULL,
    UNIQUE KEY (`option_key`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
</xsl:template>
</xsl:stylesheet>
