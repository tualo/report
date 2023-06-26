DELIMITER //


create  view  if not exists view_point_of_sale_belege_##### as 
SELECT 

    blg_hdr_#####.id belegnummer, 
    blg_hdr_#####.brutto,
    blg_hdr_#####.datum,
    if(blg_abschluss_#####.abschluss_id is null, 'kein Tagesabschluss', concat('Tag abgeschlossen (#',blg_abschluss_#####.abschluss_id,')') ) abschluss_text,

    blg_abschluss_#####.abschluss_id abschluss_id,
    blg_hdr_#####.hardwareid

FROM 

blg_hdr_##### left join blg_abschluss_#####
on blg_hdr_#####.id = blg_abschluss_#####.belegnummer
//


create view if not exists view_report_blg_taxes_##### as 
select 
	beleg, 
    200000 + steuersatz _prio,
    concat('tax') cssattr,
    concat('Steuer (',FORMAT(steuersatz,0),'%):') text,
    concat(FORMAT(sum(steuer),2 ,'de_DE'),' €') wert,
    
    concat('Steuer (',FORMAT(steuersatz,0),'%):') pos_text,
    concat(FORMAT(sum(steuer),2 ,'de_DE'),' €') pos_wert
from 
	blg_pos_#####
group by beleg, steuersatz

union


select 
	beleg, 
    100000 + steuersatz _prio,
    concat('totalnet') cssattr,
    concat('Netto (',FORMAT(steuersatz,0),'%):') text,
    concat(FORMAT(sum(netto),2 ,'de_DE'),' €') wert,

    concat('Netto (',FORMAT(steuersatz,0),'%, ',FORMAT(sum(steuer),2 ,'de_DE'),'EUR):') pos_text,
    concat(FORMAT(sum(netto),2 ,'de_DE'),' €') pos_wert
from 
	blg_pos_#####
group by beleg, steuersatz

union


select 
	id beleg, 
    900000 _prio,
    concat('total') cssattr,
    concat('Gesamt:') text,
    concat(FORMAT(sum(brutto),2 ,'de_DE'),' €') wert,

    concat('Gesamt:') pos_text,
    concat(FORMAT(sum(brutto),2 ,'de_DE'),' €') pos_wert
from 
	blg_hdr_#####
group by beleg


union


select 
	id beleg, 
    980000 _prio,
    concat('total') cssattr,
    concat('Abschlag:') text,
    concat(FORMAT(sum(betrag),2 ,'de_DE'),' €') wert,

    concat('Abschlag:') pos_text,
    concat(FORMAT(sum(betrag),2 ,'de_DE'),' €') pos_wert
from 
	blg_min_#####
group by beleg

// 



create view if not exists view_report_blg_pos_##### as 
select 

    pos.id,

    pos.pos,
    pos.beleg,
    pos.artikel,

    pos.bemerkung,

    pos.zusatztext,

    concat(FORMAT( (pos.anzahl),0 ,'de_DE'), ifnull(mengeneinheiten.symbol,'')) anzahl,

    concat(FORMAT( (pos.epreis), if(pos.beleg between 435000000 and 435999999 ,3,2) ,'de_DE'),' €') epreis,

    concat(FORMAT( (pos.netto),2 ,'de_DE'),' €') netto,
    concat(FORMAT( (pos.brutto),2 ,'de_DE'),' €') brutto,

    concat(pos.artikel ) pos_text,
    concat(FORMAT( (pos.brutto),2 ,'de_DE'),' EUR') pos_brutto,

    concat(FORMAT( (pos.steuer),2 ,'de_DE'),' €') steuer,
    concat(FORMAT( (pos.steuersatz),0 ,'de_DE'),' %') steuersatz,

    pos.anzahl number_anzahl,
    pos.netto number_netto,
    pos.epreis number_epreis,
    pos.brutto number_brutto,
    pos.steuer number_steuer,
    pos.steuersatz number_steuersatz,

    pos.referenz,
    pos.konto

from

    blg_pos_##### pos
    join artikelgruppen
    on pos.artikel = artikelgruppen.gruppe
    left join mengeneinheiten 
    on artikelgruppen.einheit = mengeneinheiten.id
where
    pos.anzahl<>0

order by pos.pos //


create view if not exists view_report_blg_adr_##### as
select 
    id,
    concat('',replace(adresse,char(10),'<br/>'),' ') adresse
from  blg_adr_##### //



create view if not exists view_report_blg_txt_##### as
select
* from 
blg_txt_##### //



create view if not exists  view_report_blg_hdr_##### as
select
    hdr.*,
    DATE_FORMAT(hdr.datum,'%d. %M %Y') txt_datum,
    concat('', hdr.id) txt_belegnummer,
    concat('', bez.kundennummer) txt_bezugsnummer,
    DATE_FORMAT(hdr.zeitraum_von,'%d. %M %Y') txt_zeitraum_von,
    DATE_FORMAT(hdr.zeitraum_bis,'%d. %M %Y') txt_zeitraum_bis,
    DATE_FORMAT(hdr.faelligam,'%d. %M %Y') txt_faelligam,
    bkr.buchungskreis_id txt_buchungskreis

from 
blg_hdr_##### hdr
join blg_#BEZ#_##### bez on hdr.id = bez.id
join blg_bkr_##### bkr on hdr.id = bkr.id
//


create  view if not exists `view_editor_artikelgruppen` as
select gruppe from artikelgruppen //

create view if not exists `view_editor_blg_pos_#####` as
select 
    id,
    beleg,
    pos,
    artikel,
    bemerkung,
    zusatztext,
    anzahl,
    epreis,
    netto,
    brutto,
    steuer,
    steuersatz,
    konto,
    referenz,
    bezugsnebenkosten,
    gewicht,
    einheit,
    einheit_symbol,
    einheit_faktor,
    vdatum,
    handwerkeranteil,
    bereich,
    kombiartikel,
    einspeiserkennzeichen,
    fremdbezeichnung,
    preistyp,
    ekpreis,
    ekpreis_summe,
    gldpreis,
    gldpreis_summe,
    zzusatz,
    zid
from 
    blg_pos_##### 

//




create view if not exists `view_editor_blg_pos_#####` as
select 
    *
from 
    blg_pos_##### 
//


create view if not exists `view_editor_blg_hdr_#####` as
select 
    *
from 
    blg_hdr_##### 
//

create view if not exists `view_blg_list_#####`  as  select
    hdr.id,
    '#####' tabellenzusatz,
    '#BLG_CONFIG_ID#' report_config_id,
    concat( YEAR(hdr.datum),' / ', DATE_FORMAT( hdr.datum, "%m") ,' / ', hdr.id) belegnummer_anzeige,
    hdr.id belegnummer,
    bez.kundennummer,
    bez.kostenstelle,
    hdr.netto,
    hdr.brutto,
    hdr.steuer,
    hdr.offen,
    hdr.bezahlt,
    hdr.minderung,
    hdr.zahlart,
    hdr.gedruckt,
    hdr.referenz,

    hdr.datum,
    hdr.zeit,
    hdr.faelligam,
    hdr.buchungsdatum,
    hdr.zeitraum_von,
    hdr.zeitraum_bis,
    hdr.gedruckt_am,
hdr.geschaeftsstelle,

    bez.kundennummer bezugsnummer

  from
    blg_hdr_##### hdr
    join blg_#BEZ#_##### bez
      on hdr.id = bez.id
    join view_readtable_#BEZUG# bezug
      on (#BEZUG_ID_REF##BEZUG_KST_REF0#) = (bez.kundennummer,bez.kostenstelle)
// 



CREATE OR REPLACE VIEW `view_report_blg_hdr_#####_girocode` AS 
select `blg_hdr_#####`.`id` AS `id`,`getGiroCodeText#####`(`blg_hdr_#####`.`id` ) AS `girocode` from (`blg_hdr_#####` join `blg_#BEZ#_#####` 
on(`blg_hdr_#####`.`id` = `blg_#BEZ#_#####`.`id`)) //



create or replace view  view_report_blg_hdrtitle_##### as
select
hdr.id,
hdr.datum,
blg_config.name
from 
blg_hdr_##### hdr
join blg_config on  blg_config.tabellenzusatz = hdr.tabellenzusatz
//

CREATE OR REPLACE VIEW `view_report_blg_senderadr_#####` AS 
select blg_hdr_#####.id belegnummer, ifnull(geschaeftsstellen.zusatztext,'keine GST vergeben') adresse from blg_hdr_##### left join geschaeftsstellen on blg_hdr_#####.geschaeftsstelle = geschaeftsstellen.id
//



create or replace view view_report_blg_brieffusstextspalten_##### as 
select
    blg_bkr_#####.id belegnummer,
    brieffusstextspalten.id spalte,
    brieffusstextspalten.name,
    brieffusstext.wert,
    brieffusstext.position
from
    brieffusstextspalten
    join brieffusstext on 
        brieffusstextspalten.id= brieffusstext.spalte_id
    join blg_bkr_##### on 
        brieffusstext.buchungskreis_id = blg_bkr_#####.buchungskreis_id
    join blg_hdr_##### on 
        blg_hdr_#####.id = blg_bkr_#####.id
        and blg_hdr_#####.buchungsdatum between brieffusstext.start_am and brieffusstext.ende_am
order by brieffusstextspalten.id, brieffusstext.position //

create or replace view view_report_blg_brieffusstextspalten_ids_##### as 
select belegnummer,spalte,'#####' tabellenzusatz from view_report_blg_brieffusstextspalten_##### group by belegnummer,spalte order by belegnummer,spalte //


