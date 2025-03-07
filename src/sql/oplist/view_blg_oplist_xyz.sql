delimiter;
create view IF NOT EXISTS view_blg_oplist_rechnung as

with ms as (
    select vid,max(datum) datum, max(stufe) stufe from (
    select blg_pos_ms1.vid, blg_hdr_ms1.datum, 1 stufe from blg_pos_ms1 join blg_hdr_ms1 on blg_pos_ms1.beleg = blg_hdr_ms1.id
    union all
    select blg_pos_ms2.vid, blg_hdr_ms2.datum, 2 stufe from blg_pos_ms2 join blg_hdr_ms2 on blg_pos_ms2.beleg = blg_hdr_ms2.id
    union all
    select blg_pos_ms3.vid, blg_hdr_ms3.datum, 3 stufe from blg_pos_ms3 join blg_hdr_ms3 on blg_pos_ms3.beleg = blg_hdr_ms3.id
    ) t
    group by vid
)
select k.kundennummer,
    min(h.id) erster_beleg,
    max(h.id) letzter_beleg,
    min(p.datum) erste_zahlung,
    max(p.datum) letzte_zahlung,
    min(h.datum) erstes_belegdatum,
    max(h.datum) letztes_belegdatum,
    sum(h.brutto) summe_brutto,
    sum(ifnull(p.betrag, 0)) zahl_betrag,
    sum(ifnull(m.betrag, 0)) minderungsbetrag,
    max(ms.datum) letzte_ms,
    max(ms.stufe) ms_stufe
from blg_hdr_rechnung h
    join blg_adressen_rechnung k on k.id = h.id
    left join blg_pay_rechnung p on p.belegnummer = h.id
    left join blg_min_rechnung m on m.belegnummer = h.id
    left join ms on vid = h.id
where h.id > 202300000
group by k.kundennummer;