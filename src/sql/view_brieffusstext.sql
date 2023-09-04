delimiter ;
CREATE OR REPLACE DEFINER VIEW `view_blg_brieffusstextspalten` AS
select
    `brieffusstextspalten`.`id` AS `spalte`,
    `brieffusstextspalten`.`name` AS `name`,
    json_merge_preserve(
        '[]',
        concat(
            '[',
            group_concat(
                json_object(
                    'wert',
                    `brieffusstext`.`wert`,
                    'position',
                    `brieffusstext`.`position`,
                    'start_am',
                    `brieffusstext`.`start_am`,
                    'ende_am',
                    `brieffusstext`.`ende_am`,
                    'buchungskreis_id',
                    `brieffusstext`.`buchungskreis_id`
                )
                order by
                    `brieffusstext`.`position` ASC separator ','
            ),
            ']'
        )
    ) AS `zeilen`
from
    (
        `brieffusstextspalten`
        join `brieffusstext` on(
            `brieffusstextspalten`.`id` = `brieffusstext`.`spalte_id`
        )
    )
group by
    `brieffusstextspalten`.`id`;