CREATE TABLE IF NOT EXISTS `warenhauptgruppen` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_warenhauptgruppen_name` (`name`)
);
insert into warenhauptgruppen (id, name) values (0, 'Keine Hauptgruppe');

CREATE TABLE IF NOT EXISTS `buchungskonten` (
  `konto` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`konto`)
);
insert into buchungskonten (konto, name) values ('0000', 'Kein Konto');

CREATE TABLE IF NOT EXISTS `mengeneinheiten` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `symbol` varchar(20) NOT NULL,
  `faktor` decimal(15,6) DEFAULT 1.000000,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_mengeneinheiten_name` (`name`)
);

insert into mengeneinheiten (id, name, symbol, faktor) values (1, 'STK', 'Stk.', 1.000000);

CREATE TABLE IF NOT EXISTS `warengruppen` (
  `id` int(11) NOT NULL,
  `warengruppe` varchar(100) NOT NULL,
  `wgsort` int(11) DEFAULT 999,
  `farbe` varchar(20) DEFAULT 'rgb(0,0,0)',
  `warenhauptgruppe` int(11) DEFAULT 0,
  `beleggruppierung` varchar(20) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_warengruppen_warengruppe` (`warengruppe`),
  KEY `idx_warenhauptgruppe` (`warenhauptgruppe`),
  CONSTRAINT `fk_waregruppen_warenhauptgruppe` FOREIGN KEY (`warenhauptgruppe`) REFERENCES `warenhauptgruppen` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS `bfkonten` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT '',
  `konto` varchar(100) DEFAULT NULL,
  `steuer` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel` varchar(5) DEFAULT 'A',
  `konto_1` varchar(100) DEFAULT NULL,
  `steuer_1` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel_1` varchar(5) DEFAULT NULL,
  `konto_10` varchar(100) DEFAULT NULL,
  `steuer_10` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel_10` varchar(5) DEFAULT NULL,
  `konto_2` varchar(100) DEFAULT NULL,
  `steuer_2` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel_2` varchar(5) DEFAULT NULL,
  `konto_3` varchar(100) DEFAULT NULL,
  `steuer_3` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel_3` varchar(5) DEFAULT NULL,
  `konto_4` varchar(100) DEFAULT NULL,
  `steuer_4` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel_4` varchar(5) DEFAULT NULL,
  `konto_5` varchar(100) DEFAULT NULL,
  `steuer_5` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel_5` varchar(5) DEFAULT NULL,
  `konto_6` varchar(100) DEFAULT NULL,
  `steuer_6` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel_6` varchar(5) DEFAULT NULL,
  `konto_7` varchar(100) DEFAULT NULL,
  `steuer_7` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel_7` varchar(5) DEFAULT NULL,
  `konto_8` varchar(100) DEFAULT NULL,
  `steuer_8` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel_8` varchar(5) DEFAULT NULL,
  `konto_9` varchar(100) DEFAULT NULL,
  `steuer_9` decimal(15,2) DEFAULT 0.00,
  `sap_schluessel_9` varchar(5) DEFAULT NULL,
  `gueltig` date NOT NULL DEFAULT '2099-12-31',
  `gueltig_von` date DEFAULT '2000-01-01',
  PRIMARY KEY (`id`,`gueltig`),
  KEY `fk_bfkonten_konto` (`konto`),
  KEY `fk_bfkonten_konto_1` (`konto_1`),
  KEY `fk_bfkonten_konto_10` (`konto_10`),
  KEY `fk_bfkonten_konto_2` (`konto_2`),
  KEY `fk_bfkonten_konto_3` (`konto_3`),
  KEY `fk_bfkonten_konto_4` (`konto_4`),
  KEY `fk_bfkonten_konto_5` (`konto_5`),
  KEY `fk_bfkonten_konto_6` (`konto_6`),
  KEY `fk_bfkonten_konto_7` (`konto_7`),
  KEY `fk_bfkonten_konto_8` (`konto_8`),
  KEY `fk_bfkonten_konto_9` (`konto_9`),
  KEY `idx_bfkonten_name` (`name`),
  CONSTRAINT `fk_bfkonten_konto` FOREIGN KEY (`konto`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_konto_1` FOREIGN KEY (`konto_1`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_konto_10` FOREIGN KEY (`konto_10`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_konto_2` FOREIGN KEY (`konto_2`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_konto_3` FOREIGN KEY (`konto_3`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_konto_4` FOREIGN KEY (`konto_4`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_konto_5` FOREIGN KEY (`konto_5`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_konto_6` FOREIGN KEY (`konto_6`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_konto_7` FOREIGN KEY (`konto_7`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_konto_8` FOREIGN KEY (`konto_8`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_konto_9` FOREIGN KEY (`konto_9`) REFERENCES `buchungskonten` (`konto`) ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS `artikelgruppen` (
  `gruppen_id` int(11) NOT NULL,
  `gruppe` varchar(255) NOT NULL,
  `kurztext` varchar(30) DEFAULT '',
  `warengruppe` varchar(100) NOT NULL,
  `artikelnummer` varchar(20) DEFAULT NULL,
  `bestandsartikel` tinyint(4) DEFAULT 0,
  `system` tinyint(4) DEFAULT 0,
  `kommission` tinyint(4) DEFAULT 0,
  `mdeartikel` tinyint(4) DEFAULT 0 COMMENT 'Artikel in der mobilen Datenerfassung verwenden',
  `gebinde` tinyint(4) DEFAULT 0,
  `offenerposten` tinyint(4) DEFAULT 0 COMMENT 'OP werden in bestimmten Listen zur weiteren Verarbeitung angezeigt',
  `zusatztext` varchar(4000) DEFAULT NULL,
  `bemerkung` varchar(4000) DEFAULT NULL,
  `plugin` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `ingebrauch` tinyint(4) DEFAULT 0 COMMENT 'wird gesetzt, sobald der Artikel mit dieser Bezeichnung in einer Belegart verwendet wird',
  `verkaufszeitraum_von` date DEFAULT '2000-01-01' COMMENT 'Verkaufszeitraum Zeitraum',
  `verkaufszeitraum_bis` date DEFAULT '2099-12-31' COMMENT 'Verkaufszeitraum Zeitraum',
  `averkaufszeitraum_von` date DEFAULT '2000-01-01' COMMENT 'administrativer Verkaufszeitraum Zeitraum',
  `averkaufszeitraum_bis` date DEFAULT '2099-12-31' COMMENT 'administrativer Verkaufszeitraum Zeitraum',
  `einheit` varchar(20) DEFAULT 'STK',
  `mde_sortierung` int(11) DEFAULT 0 COMMENT 'Sortierung in der mobilen Datenerfassung',
  `insert_date` date DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `max_anzahl` int(11) DEFAULT 999999,
  `max_weight` decimal(15,6) DEFAULT 99999.000000,
  `max_height` decimal(15,6) DEFAULT 99999.000000,
  `max_length` decimal(15,6) DEFAULT 99999.000000,
  `max_thickness` decimal(15,6) DEFAULT 99999.000000,
  `prio` int(11) DEFAULT 0,
  `kundennummer` varchar(255) DEFAULT NULL,
  `kostenstelle` int(11) DEFAULT 0,
  `konto_id` int(11) DEFAULT 0,
  `sartikelnummer` varchar(255) DEFAULT NULL,
  `innenauftrag_suffix` varchar(4) DEFAULT '0000',
  `zielregion` varchar(20) DEFAULT 'Verbundgebiet',
  `upoc` varchar(20) DEFAULT NULL,

  `avgpreis_1` decimal(15,5) DEFAULT 0.00000,
  `anzahl_1` decimal(15,5) DEFAULT 0.00000,
  `avgpreis_6` decimal(15,5) DEFAULT 0.00000,
  `anzahl_6` decimal(15,5) DEFAULT 0.00000,
  `avgpreis_12` decimal(15,5) DEFAULT 0.00000,
  `anzahl_12` decimal(15,5) DEFAULT 0.00000,

  PRIMARY KEY (`gruppen_id`),
  UNIQUE KEY `uidx_artikelgruppen_gruppe` (`gruppe`),
  KEY `idx_artikelgruppen_warengruppe` (`warengruppe`),
  KEY `idx_artikelgruppen_offenerposten` (`offenerposten`),
  KEY `idx_artikelgruppen_max_anzahl` (`max_anzahl`),
  KEY `idx_artikelgruppen_einheit` (`einheit`),
  KEY `fk_artikelgruppen_konto_id` (`konto_id`),
  KEY `idx_artikelgruppen_status` (`status`),
  CONSTRAINT `fk_artikelgruppen_einheit` FOREIGN KEY (`einheit`) REFERENCES `mengeneinheiten` (`name`) ON UPDATE CASCADE,
  CONSTRAINT `fk_artikelgruppen_konto_id` FOREIGN KEY (`konto_id`) REFERENCES `bfkonten` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_artikelgruppen_warengruppe` FOREIGN KEY (`warengruppe`) REFERENCES `warengruppen` (`warengruppe`) ON UPDATE CASCADE
);



CREATE TABLE IF NOT EXISTS `bfkonten_zuordnung` (
  `gruppe` varchar(255) NOT NULL,
  `konto_id` int(11) NOT NULL,
  `gueltig` date NOT NULL DEFAULT '2099-12-31',
  PRIMARY KEY (`gruppe`,`konto_id`,`gueltig`),
  KEY `idx_bfkonten_zuordnung_konto_id_gueltig` (`konto_id`,`gueltig`),
  CONSTRAINT `fk_bfkonten_zuordnung_artikelgruppen_gruppe` FOREIGN KEY (`gruppe`) REFERENCES `artikelgruppen` (`gruppe`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_bfkonten_zuordnung_artikelgruppen_konto_id` FOREIGN KEY (`konto_id`, `gueltig`) REFERENCES `bfkonten` (`id`, `gueltig`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `preiskategorien` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`)
) 
COMMENT='Preiskategorien für das ermitteln des Einzelpreises, dies kann im Bezugsstamm oder im Belege festgelegt werden.'
;


CREATE TABLE IF NOT EXISTS `staffeln` (
  `gruppe` varchar(255) NOT NULL,
  `von` int(11) NOT NULL DEFAULT -1000000,
  `bis` int(11) NOT NULL DEFAULT 1000000,
  `preiskategorie` int(11) NOT NULL DEFAULT 1,
  `preis` decimal(15,6) DEFAULT 0.000000,
  `bruttopreis` decimal(15,6) DEFAULT 0.000000,
  `epreis` decimal(15,6) DEFAULT 0.000000,
  `mpreis` decimal(15,6) DEFAULT 0.000000,
  `gld` decimal(12,5) DEFAULT 0.00000,
  `gebiet` varchar(50) DEFAULT '',
  `json_formel` varchar(4000) DEFAULT '',
  `zeitraum_von` date NOT NULL DEFAULT '2000-01-01',
  `zeitraum_bis` date NOT NULL DEFAULT '2099-12-31',
  PRIMARY KEY (`gruppe`,`preiskategorie`,`von`,`bis`,`zeitraum_von`,`zeitraum_bis`),
  KEY `idx_staffeln_gruppe` (`gruppe`),
  KEY `idx_staffeln_preiskategorie` (`preiskategorie`),
  CONSTRAINT `fk_staffeln_gruppe` FOREIGN KEY (`gruppe`) REFERENCES `artikelgruppen` (`gruppe`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_staffeln_preiskategorie` FOREIGN KEY (`preiskategorie`) REFERENCES `preiskategorien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
