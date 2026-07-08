delimiter //

CREATE OR REPLACE PROCEDURE `getReportPositions`(
        in reporttype varchar(20),
        in in_id bigint,
        out result JSON
    ) READS SQL DATA COMMENT '' BEGIN
DECLARE base_table varchar(128);
DECLARE flds LONGTEXT;
select group_concat(
        concat(
            quote(
                ifnull(
                    blgpos_translations.json_attribute_name,
                    ds_column.column_name
                )
            ),
            ',',
            concat('pos.', ds_column.column_name)
        ) separator ','
    ) j into flds
from ds_column
    left join blgpos_translations on blgpos_translations.column_name = ds_column.column_name
where table_name = concat('blg_pos_', reporttype)
    and ds_column.existsreal = 1
    and ds_column.writeable = 1;
set flds = concat(
        flds,
        ',',
        '"artikelgruppen_artikelnummer",`artikelgruppen`.`artikelnummer`,',
        '"warengruppen_wgsort",`warengruppen`.`wgsort`,',
        '"mengeneinheiten_symbol",`mengeneinheiten`.`symbol`'
    );
--    POSITIONEN SQL
SET @SQL = concat(
        'select  
        concat("[",ifnull(group_concat( 
        JSON_OBJECT( 
                ',
        flds,
        '
            )
                order by pos
                separator ","
        ),"")
        ,"]"
        ) o 
    INTO @positions
    FROM 
        blg_pos_',
        reporttype,
        ' pos 

        left join `artikelgruppen` on `pos`.`artikel` = `artikelgruppen`.`gruppe`
        left join `warengruppen` on  `warengruppen`.`warengruppe` = `artikelgruppen`.`warengruppe`
        left join `mengeneinheiten` on `artikelgruppen`.`einheit` = `mengeneinheiten`.`id`
        
    WHERE beleg = ',
        in_id,
        '

    '
    );
PREPARE stmt
FROM @SQL;
execute stmt;
DEALLOCATE PREPARE stmt;
SET result = @positions;
END //