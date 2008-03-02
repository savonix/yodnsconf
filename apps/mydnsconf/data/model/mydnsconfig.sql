
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
  PRIMARY KEY  (`id`),
  UNIQUE KEY `origin` (`origin`),
  KEY `active` (`active`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


CREATE TABLE `rr` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `zone` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `type` enum('A','AAAA','CNAME','HINFO','MX','NAPTR','NS','PTR','RP','SRV','TXT') default NULL,
  `data` char(128) NOT NULL,
  `aux` int(10) unsigned NOT NULL,
  `ttl` int(10) unsigned NOT NULL default '86400',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `rr` (`zone`,`name`,`type`,`data`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

