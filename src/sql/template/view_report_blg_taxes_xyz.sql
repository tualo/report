delimiter ;

CREATE OR REPLACE VIEW `view_report_blg_taxes_#####` AS
select
    `blg_pos_#####`.`beleg` AS `beleg`,
    200000 + `blg_pos_#####`.`steuersatz` AS `_prio`,
    concat('tax') AS `cssattr`,
    concat(
        'Steuer (',
        format(`blg_pos_#####`.`steuersatz`, 0),
        '%):'
    ) AS `text`,
    concat(
        format(
            round(sum(`blg_pos_#####`.`brutto`), 2) - round(sum(`blg_pos_#####`.`netto`), 2),
            2,
            'de_DE'
        ),
        ' €'
    ) AS `wert`,
    concat(
        'Steuer (',
        format(`blg_pos_#####`.`steuersatz`, 0),
        '%):'
    ) AS `pos_text`,
    concat(
        format(
            round(sum(`blg_pos_#####`.`brutto`), 2) - round(sum(`blg_pos_#####`.`netto`), 2),
            2,
            'de_DE'
        ),
        ' €'
    ) AS `pos_wert`
from
    `blg_pos_#####`
group by
    `blg_pos_#####`.`beleg`,
    `blg_pos_#####`.`steuersatz`
union
select
    `blg_pos_#####`.`beleg` AS `beleg`,
    100000 + `blg_pos_#####`.`steuersatz` AS `_prio`,
    concat('totalnet') AS `cssattr`,
    concat(
        'Netto (',
        format(`blg_pos_#####`.`steuersatz`, 0),
        '%):'
    ) AS `text`,
    concat(format(sum(`blg_pos_#####`.`netto`), 2, 'de_DE'), ' €') AS `wert`,
    concat(
        'Netto (',
        format(`blg_pos_#####`.`steuersatz`, 0),
        '%, ',
        format(sum(`blg_pos_#####`.`steuer`), 2, 'de_DE'),
        'EUR):'
    ) AS `pos_text`,
    concat(format(sum(`blg_pos_#####`.`netto`), 2, 'de_DE'), ' €') AS `pos_wert`
from
    `blg_pos_#####`
group by
    `blg_pos_#####`.`beleg`,
    `blg_pos_#####`.`steuersatz`
union
select
    `blg_hdr_#####`.`id` AS `beleg`,
    900000 AS `_prio`,
    concat('total') AS `cssattr`,
    concat('Gesamt:') AS `text`,
    concat(
        format(sum(`blg_hdr_#####`.`brutto`), 2, 'de_DE'),
        ' €'
    ) AS `wert`,
    concat('Gesamt:') AS `pos_text`,
    concat(
        format(sum(`blg_hdr_#####`.`brutto`), 2, 'de_DE'),
        ' €'
    ) AS `pos_wert`
from
    `blg_hdr_#####`
group by
    `blg_hdr_#####`.`id`
union
select
    `blg_min_#####`.`id` AS `beleg`,
    980000 AS `_prio`,
    concat('total') AS `cssattr`,
    concat('Abschlag:') AS `text`,
    concat(
        format(sum(`blg_min_#####`.`betrag`), 2, 'de_DE'),
        ' €'
    ) AS `wert`,
    concat('Abschlag:') AS `pos_text`,
    concat(
        format(sum(`blg_min_#####`.`betrag`), 2, 'de_DE'),
        ' €'
    ) AS `pos_wert`
from
    `blg_min_#####`
group by
    `blg_min_#####`.`id`