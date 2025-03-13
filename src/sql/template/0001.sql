DELIMITER //

CREATE OR REPLACE FUNCTION `getReportToAccount`(intabellenzusatz VARCHAR(20), kundennummer VARCHAR(50),kostenstelle integer) RETURNS varchar(50)  
    DETERMINISTIC
BEGIN
    DECLARE res VARCHAR(50);
    select gegenkonto_bezug into res from blg_config where tabellenzusatz=intabellenzusatz and gegenkonto_bezug<>'*';
    if res is null then
        set res = kundennummer;
    end if;
    return res;
END //

create table if not exists CHECK_BLG_STATES(
  id integer primary key,
  name varchar(50) not null,
  aktiv tinyint default 1
) // 
insert ignore into CHECK_BLG_STATES (id,name)  values (1,'freigegeben'),(2,'fehlerhaft') // 

create table if not exists pos_preistyp(
  id tinyint primary key,
  name varchar(100) not null
) //

insert ignore into pos_preistyp (id,name) values (0,'unbestimmt'),(1,'preiskategorie'),(2,'preisvereinbarung'),(3,'manuell') //



CREATE  FUNCTION IF NOT EXISTS `getGiroCodeText#####`(in_number bigint) RETURNS longtext 
    READS SQL DATA
BEGIN 

DECLARE result longtext;

DECLARE use_value fixed(15,6) default 0;
DECLARE use_text varchar(50);
DECLARE use_GIROCODE_BIC varchar(100);
DECLARE use_GIROCODE_NAME varchar(100);
DECLARE use_GIROCODE_IBAN varchar(100);





select 
    girocode_name,girocode_iban,girocode_bic,
    concat('RN ',blg_hdr_#####.id, ' KN ',blg_adressen_#####.kundennummer),
    blg_hdr_#####.brutto
INTO use_GIROCODE_NAME, use_GIROCODE_IBAN, use_GIROCODE_BIC,use_text,use_value
from 

    girocode_buchungskreise 
    join blg_bkr_##### on blg_bkr_#####.buchungskreis_id =  girocode_buchungskreise.buchungskreis
    join blg_hdr_##### on blg_hdr_#####.id = blg_bkr_#####.id
    join blg_#BEZ#_##### on blg_hdr_#####.id = blg_#BEZ#_#####.id

where blg_bkr_#####.id = in_number;
if use_GIROCODE_IBAN is null then return null; end if;
select concat(
    'BDC',char(10),
    '002',char(10),
    '1',char(10),
    'SCT',char(10),
    ifnull(use_GIROCODE_BIC,'00000000'),char(10),
    ifnull(use_GIROCODE_NAME,'GIROCODE_NAME'),char(10),
    ifnull(use_GIROCODE_IBAN,'DE000000000000000000'),char(10),
    'EUR',round(use_value,2),char(10),
    '',char(10),
    '',char(10),
    use_text,char(10),
    '',char(10)
) 
INTO result;

RETURN result;

END //


create table if not exists blg_hdr_#####(

  id bigint primary key,
  datum date not null,
  faelligam date not null,

  von_lager integer default 0,
  an_lager integer default 0,

  skonto_netto fixed(12,5) not null,
  skonto_brutto  fixed(12,5) not null,

  provision_netto  fixed(12,5) not null,
  provision_brutto  fixed(12,5) not null,

  netto  fixed(12,5) not null,
  brutto  fixed(12,5) not null,
  steuer  fixed(12,5) not null,

  bezahlt  fixed(12,5) not null,
  minderung  fixed(12,5) not null,
  gegeben  fixed(12,5) not null,
  zurueck  fixed(12,5) not null,
  zahlart varchar(20) default 'bar',

  referenz varchar(255),
  login varchar(255) not null,

  zbeleg bigint,
  zbeleg_zusatz integer,

  preisorientierung varchar(10) default 'netto',

  istoffen integer default 1,

  buchungsdatum date,
  zeitraum_von date,
  zeitraum_bis date
) //


call addFieldIfNotExists('blg_hdr_#####','gedruckt','tinyint default 0') //
call addFieldIfNotExists('blg_hdr_#####','gedruckt_am','datetime default null') //
call addFieldIfNotExists('blg_hdr_#####','tabellenzusatz','varchar(255) default \'#####\'') //
call addFieldIfNotExists('blg_hdr_#####','archiv','integer default 0') //
call addFieldIfNotExists('blg_hdr_#####','letzte_zahlung','integer default null') //
call addFieldIfNotExists('blg_hdr_#####','letzte_zahlung_datum','date default null') //
call addFieldIfNotExists('blg_hdr_#####','mahnstufe','integer default 0') //
call addFieldIfNotExists('blg_hdr_#####','offen','decimal(15,6) default 0') //
call addFieldIfNotExists('blg_hdr_#####','sperre','integer default 0') //
call addFieldIfNotExists('blg_hdr_#####','zeit','time') //

call addFieldIfNotExists('blg_hdr_#####','vertriebsweg','varchar(255)') //
call addFieldIfNotExists('blg_hdr_#####','mandatsreferenz','varchar(50)') //
call addFieldIfNotExists('blg_hdr_#####','steuernummer','varchar(50)') //
call addFieldIfNotExists('blg_hdr_#####','datev_export','integer') //
call addFieldIfNotExists('blg_hdr_#####','layout','integer default 0') //
call addFieldIfNotExists('blg_hdr_#####','create_timestamp','timestamp default current_timestamp') //

call addFieldIfNotExists('blg_hdr_#####','hardwareid','varchar(36) default NULL ') //
call addFieldIfNotExists('blg_hdr_#####','abschluss','bigint default NULL ') //


call addFieldIfNotExists('blg_hdr_#####','buchungskreis','varchar(10) default NULL ') //
call addFieldIfNotExists('blg_hdr_#####','geschaeftsstelle','integer default NULL ') //



alter table `blg_hdr_#####` modify skonto_netto	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify skonto_brutto	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify provision_netto	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify provision_brutto	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify netto	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify brutto	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify steuer	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify bezahlt	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify minderung	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify gegeben	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify zurueck	decimal(12,5) default 0 //
alter table `blg_hdr_#####` modify faelligam date default CURRENT_TIMESTAMP //

create table if not exists blg_ueb_#####(
  id bigint ,
  zid bigint ,
  primary key (id,zid)
) //
call addForeignKeyIfNotExists ('blg_ueb_#####','blg_hdr_#####','fk_blg_ueb_#####_id','id','id','cascade','cascade') //

create table if not exists blg_adr_#####(

    id bigint primary key,
    adresse varchar(4000) not null

) //
call addForeignKeyIfNotExists ('blg_adr_#####','blg_hdr_#####','fk_blg_adr_#####_id','id','id','cascade','cascade') //


CREATE TABLE IF NOT EXISTS `blg_geo_#####` (
  `geoid` varchar(36) not null,
  `id` bigint(20) NOT NULL,
  `latitude` decimal(15,10),
  `longitude` decimal(15,10),
  `accuracy` decimal(15,10) ,
  `timestamp` TIMESTAMP,
  PRIMARY KEY (`geoid`),
  CONSTRAINT `fk_blg_geo_#####_id` FOREIGN KEY (`id`) REFERENCES `blg_hdr_#####` (`id`) 
  ON DELETE CASCADE ON UPDATE CASCADE
) //


CREATE TABLE IF NOT EXISTS `blg_images_#####` (
  `type` varchar(36) not null,
  `id` bigint(20) NOT NULL,
  `imagedata` LONGTEXT,
  PRIMARY KEY (`type`,`id`),
  CONSTRAINT `fk_blg_images_#####_id` FOREIGN KEY (`id`) REFERENCES `blg_hdr_#####` (`id`) 
  ON DELETE CASCADE ON UPDATE CASCADE
) //

create table if not exists blg_check_#####(
    id bigint,
    login varchar(32) not null,
    updatedate datetime not null,
    state integer not null,
    primary key (id,login),
    constraint `fk_blg_check_#####_check_states`
    foreign key (`state`)
    references CHECK_BLG_STATES (`id`)
    on update cascade
    on delete restrict
) //
call addForeignKeyIfNotExists ('blg_check_#####','blg_hdr_#####','fk_blg_check_#####_id','id','id','cascade','cascade') //


create table if not exists blg_txt_#####(

    id bigint,
    typ varchar(20) default 'head',
    primary key (id,typ),
    text varchar(4000)

) //
call addForeignKeyIfNotExists ('blg_txt_#####','blg_hdr_#####','fk_blg_txt_#####_id','id','id','cascade','cascade') //

create table if not exists blg_bnk_#####(

    id bigint primary key,
    inhaber varchar(255) not null,
    konto varchar(10) not null,
    blz varchar(8) not null

) //
call addForeignKeyIfNotExists ('blg_bnk_#####','blg_hdr_#####','fk_blg_bnk_#####_id','id','id','cascade','cascade') //

call addFieldIfNotExists('blg_bnk_#####','iban','varchar(32)') //
call addFieldIfNotExists('blg_bnk_#####','bic','varchar(12)') //


create table if not exists blg_pos_#####(

    id bigint primary key,
    beleg bigint not null,
    pos integer not null,
    artikel varchar(255),
    bemerkung varchar(4000),
    zusatztext varchar(4000),
    anzahl  fixed(12,5) not null,
    epreis  fixed(12,5) not null,
    netto  fixed(12,5) not null,
    brutto  fixed(12,5) not null,
    steuer  fixed(12,5) not null,
    steuersatz  fixed(12,5) not null,
    konto integer not null,
    referenz varchar(255),
    bezugsnebenkosten integer default 0

) // 
call addForeignKeyIfNotExists ('blg_pos_#####','blg_hdr_#####','fk_blg_pos_#####_id','beleg','id','cascade','cascade') //

call addFieldIfNotExists('blg_pos_#####','gewicht','decimal(15,6) DEFAULT 0.000000') //
call addFieldIfNotExists('blg_pos_#####','einheit','varchar(10) DEFAULT NULL') //
call addFieldIfNotExists('blg_pos_#####','einheit_symbol','varchar(10) DEFAULT NULL') //
call addFieldIfNotExists('blg_pos_#####','einheit_faktor','decimal(15,6) DEFAULT 1') //
call addFieldIfNotExists('blg_pos_#####','vdatum','date DEFAULT current_date') //
call addFieldIfNotExists('blg_pos_#####','handwerkeranteil','decimal(15,6) DEFAULT 0') //
call addFieldIfNotExists('blg_pos_#####','ekpreis','decimal(15,6) DEFAULT 0') //
call addFieldIfNotExists('blg_pos_#####','ekpreis_summe','decimal(15,6) DEFAULT 0') //
call addFieldIfNotExists('blg_pos_#####','gldpreis','decimal(15,6) DEFAULT 0') //
call addFieldIfNotExists('blg_pos_#####','gldpreis_summe','decimal(15,6) DEFAULT 0') //
call addFieldIfNotExists('blg_pos_#####','einspeiserkennzeichen','varchar(5)') //
call addFieldIfNotExists('blg_pos_#####','fremdbezeichnung','varchar(100)') //
call addFieldIfNotExists('blg_pos_#####','preistyp','tinyint default 0') //
call addFieldIfNotExists('blg_pos_#####','bereich','varchar(20)') //
call addFieldIfNotExists('blg_pos_#####','kombiartikel','tinyint default 0') //

call addFieldIfNotExists('blg_pos_#####','zzusatz','varchar(100)') //
call addFieldIfNotExists('blg_pos_#####','zid','bigint') //
call addFieldIfNotExists('blg_pos_#####','vzusatz','varchar(100)') //
call addFieldIfNotExists('blg_pos_#####','vid','bigint') //


alter table `blg_pos_#####` modify pos integer default 1//

create table if not exists blg_#BEZ#_#####(
  `id` bigint(20) NOT NULL,
  `kundennummer` varchar(10) NOT NULL,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `ref_kundennummer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_blg_#BEZ#_#####_kn` (`kundennummer`,`kostenstelle`),
  CONSTRAINT `fk_blg_#####_#BEZ#` FOREIGN KEY (`kundennummer`#KST_REF#) REFERENCES #BEZUG# (`#id_column#`#KST_REF#) ON DELETE CASCADE ON UPDATE CASCADE
) //
call addFieldIfNotExists('blg_#BEZ#_#####','gegenkonto','varchar(10)') // 
update blg_#BEZ#_##### set gegenkonto=getReportToAccount('#####',kundennummer,kostenstelle) where gegenkonto is null //



create table if not exists blg_rejected_##### (
  tabellenzusatz varchar(255),
  source bigint primary key,
  destination bigint not null
) //
call addForeignKeyIfNotExists ('blg_rejected_#####','blg_hdr_#####','fk_blg_rejected_#####_id','source','id','cascade','cascade') //

create table if not exists blg_min_#####(

    id bigint primary key,
    name varchar(255) not null,
    belegnummer bigint not null,
    bemerkung varchar(255) not null,
    betrag fixed(12,5) not null

) //
call addForeignKeyIfNotExists ('blg_min_#####','blg_hdr_#####','fk_blg_pos_#####_belegnummer','belegnummer','id','cascade','cascade') //


create table if not exists blg_pay_#####(

    id bigint primary key,
    datum date not null,
    belegnummer bigint not null,
    art varchar(255) not null,
    betrag fixed(12,5) not null

) //
call addForeignKeyIfNotExists ('blg_pay_#####','blg_hdr_#####','fk_blg_pay_#####_belegnummer','belegnummer','id','cascade','cascade') //

call addFieldIfNotExists('blg_pay_#####','referenztabellenzusatz','varchar(255) default null') //
call addFieldIfNotExists('blg_pay_#####','referenzbelegnummer','bigint') //


CREATE TABLE IF NOT EXISTS `blg_signum_#####` (
  `id` bigint(20) DEFAULT NULL,
  `pos` int(11) NOT NULL,
  `x` decimal(15,5) DEFAULT NULL,
  `y` decimal(15,5) DEFAULT NULL,
  KEY `idx_blg_signum_#####_id` (`id`),
  CONSTRAINT `fk_blg_signum_#####_id` FOREIGN KEY (`id`) REFERENCES `blg_hdr_#####` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) //



call addfieldifnotexists('blg_hdr_#####','geschaeftsstelle','integer default 100') //

CREATE TABLE IF NOT EXISTS `blg_bkr_#####` (
  `id` bigint(20) NOT NULL,
  `buchungskreis_id` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_blg_bkr_#####_buchungskreis_id` (`buchungskreis_id`),
  CONSTRAINT `fk_blg_bkr_#####_buchungskreise` FOREIGN KEY (`buchungskreis_id`) REFERENCES `buchungskreise` (`id`) ON UPDATE CASCADE
) //
call addForeignKeyIfNotExists ('blg_bkr_#####','blg_hdr_#####','fk_blg_bkr_#####_id','id','id','cascade','cascade') //



create table if not exists blg_gst_##### (
  `id` bigint primary key,
  `gst_id` integer NOT NULL,
  KEY `idx_blg_gst_#####_gst_id` (`gst_id` ),
  CONSTRAINT `fk_blg_gst_#####_gst_id` FOREIGN KEY (`gst_id`) REFERENCES `geschaeftsstellen` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) //

call addForeignKeyIfNotExists ('blg_gst_#####','blg_hdr_#####','fk_blg_gst_#####_id','id','id','cascade','cascade') //




create table if not EXISTS `blg_mailconfig_#####` (
  id integer primary key,
  mail_subject varchar(100),

  mail_from varchar(100),
  mail_from_name varchar(100),

  mail_reply varchar(100),
  mail_reply_name varchar(100),
  txt_template text,
  startfrom date
) //


create table if not EXISTS `blg_mailto_#BEZUG#_#####` (
  `id` integer not null,
  `mail_to` varchar(100),
  `kundennummer` varchar(10),
  `kostenstelle` integer default 0,
  primary key (id,mail_to,kundennummer,kostenstelle)
) //



create table if not EXISTS `blg_mail_#####` (
  `id` bigint primary key,
  `sendtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mailto` varchar(255)
) //

call addForeignKeyIfNotExists ('blg_mail_#####','blg_hdr_#####','fk_blg_mail_#####_id','id','id','cascade','cascade') //


create table if not EXISTS `blg_synced_#####` (
  id bigint primary key,
  synced datetime,
  login varchar(255),
  referenz varchar(100),
  constraint `fk_blg_synced_#####_blg_hdr_#####`
  foreign key (id)
  references blg_hdr_#####(id)
  on delete cascade
  on update cascade
) //

create table if not EXISTS `blg_defaultlayout_#BEZUG#_#####` (
  `kundennummer` varchar(32),
  `kostenstelle` integer,
  `layout` integer,
  primary key (layout,kundennummer,kostenstelle)
) //






create table if not exists `blg_abschluss`(
    id bigint primary key,
    terminalid varchar(36) not null,
    key `idx_kblg_abschlussterminalid` (`terminalid`),
    constraint `fk_blg_abschluss_terminalid` foreign key (`terminalid`) references `kassenterminals` (`id`) on delete cascade on update cascade,

    datum_zeit datetime default null,
    login varchar(100) not null,

    start_saldo fixed(15,6) default 0,
    stopp_saldo fixed(15,6) default 0    
) //





create table if not exists `blg_abschluss_#####`(


    belegnummer bigint not null,
    abschluss_id bigint not null,
    primary key (belegnummer,abschluss_id),

    key `idx_blg_abschluss_#####_belegnummer` (`belegnummer`),
    key `idx_blg_abschluss_#####_abschluss_id` (`abschluss_id`),
        
    constraint `fk_blg_abschluss_#####_abschluss_id` foreign key (`abschluss_id`) references `blg_abschluss` (`id`) on delete restrict on update cascade,
    constraint `fk_blg_abschluss_#####_belegnummer` foreign key (`belegnummer`) references `blg_hdr_#####` (`id`) on delete restrict on update cascade
)//


create table if not exists blg_taxregistration_#####(
    `id` bigint,
    `key` varchar(36),
    `val` varchar(20),
    primary key (`id`,`key`),
    constraint `fk_blg_taxregistration_#####_id` foreign key (`id`) references `blg_hdr_#####` (`id`) on delete restrict on update cascade
) //



create table if not exists blg_buyer_#####(
    `id` bigint,
    `key` varchar(36),
    `val` varchar(255),
    primary key (`id`,`key`),
    constraint `fk_blg_buyer_#####_id` foreign key (`id`) references `blg_hdr_#####` (`id`) on delete restrict on update cascade
) //


create table if not exists blg_seller_#####(
    `id` bigint,
    `key` varchar(36),
    `val` varchar(255),
    primary key (`id`,`key`),
    constraint `fk_blg_seller_#####_id` foreign key (`id`) references `blg_hdr_#####` (`id`) on delete restrict on update cascade
) //


create table if not exists blg_seller_globalid_#####(
    `id` bigint,
    `key` varchar(36),
    `val` varchar(255),
    primary key (`id`,`key`),
    constraint `fk_blg_seller_globalid_#####_id` foreign key (`id`) references `blg_hdr_#####` (`id`) on delete restrict on update cascade
) //
