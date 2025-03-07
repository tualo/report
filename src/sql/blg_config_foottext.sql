

CREATE TABLE `blg_config_foottext` (
  `id` bigint(20) NOT NULL,
  `belegid` int(11) DEFAULT NULL,
  `txt` longtext DEFAULT NULL,
  `zahlart` varchar(255) DEFAULT NULL,
  `standard` tinyint DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_blg_config_foottext_blg_config` (`belegid`),
  CONSTRAINT `fk_blg_config_foottext_blg_config` FOREIGN KEY (`belegid`) REFERENCES `blg_config` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `blg_config_headtext` (
  `id` bigint(20) NOT NULL,
  `belegid` int(11) DEFAULT NULL,
  `txt` longtext DEFAULT NULL,
  `zahlart` varchar(255) DEFAULT NULL,
  `standard` tinyint DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_blg_config_headtext_blg_config` (`belegid`),
  CONSTRAINT `fk_blg_config_headtext_blg_config` FOREIGN KEY (`belegid`) REFERENCES `blg_config` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);