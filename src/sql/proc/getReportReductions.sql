DELIMITER // 
CREATE OR REPLACE PROCEDURE `getReportReductions`(
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
                    blgreductions_translations.json_attribute_name,
                    ds_column.column_name
                )
            ),
            ',',
            ds_column.column_name
        ) separator ','
    ) j into flds
from ds_column
    left join blgreductions_translations on blgreductions_translations.column_name = ds_column.column_name
where table_name = concat('blg_min_', reporttype)
    and ds_column.existsreal = 1
    and ds_column.writeable = 1;
SET @SQL = concat(
        'select  
        concat("[",ifnull(group_concat( 
        JSON_OBJECT( 
                ',
        flds,
        '
            )
            separator ","
        ),"")
        ,"]"
        ) o 
    INTO @positions
    FROM 
        blg_min_',
        reporttype,
        ' 
    WHERE belegnummer = ',
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