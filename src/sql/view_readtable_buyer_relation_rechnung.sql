CREATE OR REPLACE VIEW `view_readtable_buyer_relation_rechnung` AS
select concat(
        `adressen`.`kundennummer`,
        '|',
        `adressen`.`kostenstelle`
    ) AS `id`,
    `adressen`.`kundennummer` AS `referencenr`,
    `adressen`.`kostenstelle` AS `costcenter`,
    _shortname AS `line1`,
    '' AS `line2`,
    strasse AS `line3`,
    plz AS `city`,
    ort AS `postcode`
from `view_readtable_adressen` `adressen`