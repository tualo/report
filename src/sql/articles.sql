delimiter ;
/*
CREATE TABLE IF NOT EXISTS `hauptkassenbuecher` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `aktiv` int(11) DEFAULT NULL,
  `konto` varchar(100) NOT NULL,
  `fibukonto` varchar(10) DEFAULT '100001',
  `hauptkassenbuecher` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `kassenterminals` (
  `id` varchar(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `kasse` int(11) NOT NULL,
  `lager` int(11) NOT NULL,
  `beleg` int(11) NOT NULL,
  `bs_auto_print` tinyint(4) DEFAULT 0,
  `bs_system` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_kassenterminals_name` (`name`),
  KEY `fk_kassenterminal_hauptkassenbuecher` (`kasse`),
  KEY `fk_kassenterminal_lager` (`lager`),
  KEY `fk_kassenterminal_beleg` (`beleg`),
  CONSTRAINT `fk_kassenterminal_beleg` FOREIGN KEY (`beleg`) REFERENCES `blg_config` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_kassenterminal_hauptkassenbuecher` FOREIGN KEY (`kasse`) REFERENCES `hauptkassenbuecher` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_kassenterminal_lager` FOREIGN KEY (`lager`) REFERENCES `lager` (`id`) ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS `buchungskreise` (
  `id` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `vat_id` varchar(50) DEFAULT '',
  `firmen_name` varchar(100) DEFAULT '',
  `firmen_strasse` varchar(100) DEFAULT '',
  `firmen_plz` varchar(10) DEFAULT '',
  `firmen_ort` varchar(100) DEFAULT '',
  PRIMARY KEY (`id`)
) ;
insert ignore into buchungskreise (id,name) values ('0000','Standard');
*/

/*
CREATE TABLE IF NOT EXISTS `vertriebsregion` (
  `region` char(1) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT '',
  PRIMARY KEY (`region`)
);

insert ignore into vertriebsregion (region,name) values ('0','');


CREATE TABLE IF NOT EXISTS `geschaeftsstellen` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `kostenstelle` varchar(20) DEFAULT NULL,
  `prefix` varchar(20) DEFAULT NULL,
  `lohnartpc` int(11) DEFAULT NULL,
  `status` varchar(4) DEFAULT 'Ja',
  `auftrag` varchar(10) DEFAULT NULL,
  `zusatztext` varchar(100) DEFAULT NULL,
  `auswertungstext` varchar(20) DEFAULT '',
  `region` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_geschaeftsstellen_id` (`name`),
  KEY `idx_geschaeftsstellen_region` (`region`),
  CONSTRAINT `fk_geschaeftsstellen_vertriebsregion` FOREIGN KEY (`region`) REFERENCES `vertriebsregion` (`region`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
insert ignore into geschaeftsstellen (id,name) values (100,'Standard');
*/
/*
CREATE TABLE IF NOT EXISTS `warenhauptgruppen` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_warenhauptgruppen_name` (`name`)
);
INSERT IGNORE INTO warenhauptgruppen (id, name) values (0, 'Keine Hauptgruppe');
*/
/*
CREATE TABLE IF NOT EXISTS `buchungskonten` (
  `konto` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`konto`)
);
INSERT IGNORE INTO buchungskonten (konto, name) values ('0000', 'Kein Konto');

CREATE TABLE IF NOT EXISTS `mengeneinheiten` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `symbol` varchar(20) NOT NULL,
  `faktor` decimal(15,6) DEFAULT 1.000000,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_mengeneinheiten_name` (`name`)
);

INSERT IGNORE INTO mengeneinheiten (id, name, symbol, faktor) values (1, 'STK', 'Stk.', 1.000000);


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


delimiter //
CREATE OR REPLACE TRIGGER `artikelgruppen_setup_defaults_ai` 
AFTER UPDATE ON `artikelgruppen` FOR EACH ROW
BEGIN

    IF NOT EXISTS(
        select 
            `gruppe` 
        from `staffeln` 
        where `gruppe` = NEW.gruppe
    ) THEN
        
        
        insert into `staffeln` (`gruppe`) values (NEW.gruppe);

    END IF;

    IF NOT EXISTS(
        select 
            `gruppe` 
        from `bfkonten_zuordnung` 
        where `gruppe` = NEW.gruppe
    ) THEN
        
        
        
        insert into `bfkonten_zuordnung` (`gruppe`,`konto_id`) values (NEW.gruppe, NEW.konto_id);

    END IF;

END //

delimiter ;
*//*
CREATE TABLE  IF NOT EXISTS `steuergruppen` (
  `steuergruppe` varchar(25) NOT NULL,
  `feld` varchar(20) DEFAULT NULL,
  `bezeichnung` varchar(100) DEFAULT NULL,
  `aktiv` tinyint(4) DEFAULT 0,
  `sap_kennzeichen` varchar(5) DEFAULT 'A',
  `position` int(11) DEFAULT 999,
  PRIMARY KEY (`steuergruppe`),
  UNIQUE KEY `idx_steuergruppen_feld` (`feld`)
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
*/
/*
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


CREATE TABLE IF NOT EXISTS `brieffusstextspalten` (
  `id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `brieffusstext` (
  `id` int(11) NOT NULL,
  `spalte_id` varchar(50) NOT NULL,
  `buchungskreis_id` varchar(10) NOT NULL,
  `wert` varchar(255) NOT NULL,
  `start_am` date DEFAULT '2000-01-01',
  `ende_am` date DEFAULT '2099-12-31',
  `position` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_brieffusstext_spalte_id` (`spalte_id`),
  KEY `idx_brieffusstext_buchungskreis_id` (`buchungskreis_id`),
  CONSTRAINT `fk_brieffusstext_buchungskreise` FOREIGN KEY (`buchungskreis_id`) REFERENCES `buchungskreise` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_brieffusstext_spalte_id` FOREIGN KEY (`spalte_id`) REFERENCES `brieffusstextspalten` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

*/

/*CREATE TABLE IF NOT EXISTS `blg_artikel` (
  `id` int(11) NOT NULL,
  `belegart` int(11) NOT NULL,
  `artikel` varchar(255) NOT NULL,
  `bemerkung` varchar(255) NOT NULL,
  `anzahl` int(11) DEFAULT 0,
  `position` int(11) DEFAULT 0,
  `epreis` decimal(16,5) DEFAULT 0.00000,
  PRIMARY KEY (`id`),
  KEY `fk_blg_artikel_artikelgruppen` (`artikel`),
  KEY `fk_blg_artikel_blg_config` (`belegart`),
  CONSTRAINT `fk_blg_artikel_artikelgruppen` FOREIGN KEY (`artikel`) REFERENCES `artikelgruppen` (`gruppe`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_blg_artikel_blg_config` FOREIGN KEY (`belegart`) REFERENCES `blg_config` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
*/
/*
CREATE TABLE IF NOT EXISTS `buchungskreise_logins` (
  `buchungskreis_id` varchar(10) NOT NULL,
  `login` varchar(100) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 0,
  `standard` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`buchungskreis_id`,`login`),
  CONSTRAINT `fk_buchungskreise_logins_buchungskreise` FOREIGN KEY (`buchungskreis_id`) REFERENCES `buchungskreise` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `geschaeftsstellen_logins` (
  `geschaeftsstelle` int(11) NOT NULL,
  `login` varchar(100) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 0,
  `standard` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`geschaeftsstelle`,`login`),
  KEY `idx_geschaeftsstellen_logins_geschaeftsstelle_aktiv` (`geschaeftsstelle`,`aktiv`),
  CONSTRAINT `fk_geschaeftsstellen_logins_buchungskreise` FOREIGN KEY (`geschaeftsstelle`) REFERENCES `geschaeftsstellen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE OR REPLACE FUNCTION `getSessionDefaultBKR`() RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
RETURN ifnull( (  select buchungskreis_id from buchungskreise_logins where login=getSessionUser() and standard=1 ),'0000')
;

CREATE OR REPLACE FUNCTION `getSessionCurrentBKR`() RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
RETURN ( SELECT ifnull(@sessionbuchungskreis,getSessionDefaultBKR()) );
*/
/*
CREATE OR REPLACE  FUNCTION `getSessionCurrentOffice`() RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
RETURN ( SELECT ifnull(@sessionoffice,getSessionDefaultOffice()) );


CREATE OR REPLACE  FUNCTION `getSessionDefaultOffice`() RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
RETURN ifnull( (  select max(geschaeftsstelle) from geschaeftsstellen_logins where login=getSessionUser() and standard=1 ), ifnull( (  select min(geschaeftsstelle) from geschaeftsstellen_logins where login=getSessionUser() ),'0')  );
*/
