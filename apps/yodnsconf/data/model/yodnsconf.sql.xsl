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
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:template match="/">


CREATE TABLE `<xsl:value-of select="//table_prefix"/>soa` (
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
  `zone_group_id` int(11),
  PRIMARY KEY  (`id`),
  UNIQUE KEY `origin` (`origin`),
  KEY `active` (`active`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE `<xsl:value-of select="//table_prefix"/>zone_groups` (
  `zone_group_id` int(11) NOT NULL auto_increment,
  `zone_group_name` varchar(255) NOT NULL,
  KEY  (`zone_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ;

CREATE TABLE `<xsl:value-of select="//table_prefix"/>rr` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `zone` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `type` enum('A','AAAA','CNAME','HINFO','MX','NAPTR','NS','PTR','RP','SRV','TXT') default NULL,
  `data` char(256) NOT NULL,
  `aux` int(10) unsigned default NULL,
  `ttl` int(10) unsigned NOT NULL default '86400',
  `weight` int(10) unsigned default NULL,
  `port` int(10) unsigned NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `rr` (`zone`,`name`,`type`,`data`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE `<xsl:value-of select="//table_prefix"/>hosts` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `ip` int(10) unsigned NOT NULL,
  `host` varchar(255) NOT NULL,
  `priority` varchar(255) NOT NULL default 10,
  `macaddr` int(10) NOT NULL,
  `notes` varchar(255) NOT NULL,
  `hostgroup_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `hosts` (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `<xsl:value-of select="//table_prefix"/>redirects` (
  `source` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `created` timestamp DEFAULT <xsl:value-of select="//db_engines/engine_default_timestamp/text"/>,
  PRIMARY KEY  (`http_host`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



CREATE TABLE `<xsl:value-of select="//table_prefix"/>hostgroups` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE `<xsl:value-of select="//table_prefix"/>hostgroup_parents` (
  `hostgroup_id` int(11) unsigned NOT NULL,
  `parent_id` int(11) unsigned NOT NULL,
  KEY  (`hostgroup_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ;

CREATE TABLE `<xsl:value-of select="//table_prefix"/>hostgroup_hosts` (
  `hostgroup_id` int(11) NOT NULL,
  `host_id` int(11) NOT NULL,
  KEY  (`hostgroup_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ;


CREATE TABLE `<xsl:value-of select="//table_prefix"/>services` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


CREATE TABLE `<xsl:value-of select="//table_prefix"/>host_services` (
  `host_id` int(10) unsigned NOT NULL,
  `service_id` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ;


CREATE TABLE `<xsl:value-of select="//table_prefix"/>ip` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `data` char(128) NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `<xsl:value-of select="//table_prefix"/>zone_metadata` (
    `zone_id` int(11) NOT NULL auto_increment,
    `meta_key` varchar(100) NULL,
    `meta_value` varchar(100) NULL,
    PRIMARY KEY `zone_index` (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `<xsl:value-of select="//table_prefix"/>record_metadata` (
    `record_id` int(11) NOT NULL auto_increment,
    `meta_key` varchar(100) NULL,
    `meta_value` varchar(100) NULL,
    PRIMARY KEY `record_index` (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `<xsl:value-of select="//table_prefix"/>options` (
    `option_key` varchar(255) NOT NULL default 'untitled',
    `option_value` varchar(255) default NULL,
    UNIQUE KEY (`option_key`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
</xsl:template>
</xsl:stylesheet>
