DELIMITER ;

CREATE TABLE IF NOT EXISTS `kombiartikel` (
  `id` int(11) NOT NULL,
  `triggerartikel` varchar(255) DEFAULT NULL,
  `resultartikel` varchar(255) DEFAULT NULL,
  `resultfaktor` decimal(15,6) DEFAULT 1.000000,
  `resultpfaktor` decimal(15,6) DEFAULT 1.000000,
  `originalpreis` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_kombiartikel` (`triggerartikel`,`resultartikel`),
  KEY `idx_kombiartikel_triggerartikel` (`triggerartikel`),
  KEY `fk_kombiartikel_resultartikel_artikelgruppen` (`resultartikel`),
  CONSTRAINT `fk_kombiartikel_resultartikel_artikelgruppen` FOREIGN KEY (`resultartikel`) REFERENCES `artikelgruppen` (`GRUPPE`) ON DELETE CASCADE ON UPDATE CASCADE
);


