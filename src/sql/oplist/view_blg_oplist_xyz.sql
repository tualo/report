delimiter;
create view IF NOT EXISTS view_blg_oplist_rechnung as
select k.kundennummer,
    min(h.id) erster_beleg,
    max(h.id) letzter_beleg,
    min(p.datum) erste_zahlung,
    max(p.datum) letzte_zahlung,
    min(h.datum) erstes_belegdatum,
    max(h.datum) letztes_belegdatum,
    sum(h.brutto) summe_brutto,
    sum(ifnull(p.betrag, 0)) zahl_betrag,
    sum(ifnull(m.betrag, 0)) minderungsbetrag
from blg_hdr_rechnung h
    join blg_adressen_rechnung k on k.id = h.id
    left join blg_pay_rechnung p on p.belegnummer = h.id
    left join blg_min_rechnung m on m.belegnummer = h.id
where h.id > 202300000
group by k.kundennummer;