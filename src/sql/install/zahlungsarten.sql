DELIMITER ;
CREATE TABLE IF NOT EXISTS `zahlungsarten` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `referenzds` varchar(255) DEFAULT NULL,
  `belegid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)  COMMENT='Erlaubte Zahlarten.';
