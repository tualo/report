DELIMITER //
CREATE OR REPLACE PROCEDURE `getReport`(
        in reporttype varchar(20),
        in in_id bigint,
        out result JSON
    ) READS SQL DATA COMMENT '' 
BEGIN
    DECLARE base_table varchar(128);
    DECLARE flds LONGTEXT;
    SELECT adress_bezug INTO base_table
    from blg_config
    where tabellenzusatz = reporttype;
IF in_id < 0 THEN
    SET result = JSON_OBJECT(
            "reporttype",
            reporttype,
            "address",
            "",
            "companycode",
            getSessionCurrentBKR(),
            "office",
            getSessionCurrentOffice(),
            "referencenr",
            0,
            "costcenter",
            0,
            "date",
            curdate(),
            "payuntildate",
            curdate(),
            "service_period_start",
            curdate(),
            "service_period_stop",
            curdate(),
            "reference",
            "",
            "bookingdate",
            curdate(),
            "positions",
            ifnull(
                (
                    select JSON_ARRAYAGG(
                            JSON_OBJECT(
                                "pos",
                                position,
                                "position",
                                position,
                                "artikel",
                                blg_artikel.artikel,
                                "amount",
                                blg_artikel.anzahl,
                                "price",
                                blg_artikel.epreis,
                                "note",
                                blg_artikel.bemerkung
                            )
                            order by position
                        )
                    from blg_artikel
                        join blg_config on blg_config.id = blg_artikel.belegart
                        and blg_config.tabellenzusatz = reporttype
                ),
                JSON_ARRAY()
            ),
            "payments",
            JSON_ARRAY(),
            "reductions",
            JSON_ARRAY(),
            "signum",
            JSON_ARRAY(),
            "texts",
            JSON_ARRAY(),
            "locks",
            JSON_ARRAY()
        );
ELSE --  ZAHLUNGEN 
call debug_message('get report payment');
call getReportPayments(reporttype, in_id, @payments);
--  MINDERUNGEN SQL
call debug_message('get report reductions');
call getReportReductions(reporttype, in_id, @reductions);
--  SPERREN ERMITTELN
call debug_message('get report locks');
set @locks = '[]';
-- call getReportLocks(reporttype,in_id,@locks);
--  UNTERSCHRIFT SQL
call debug_message('get report signum');
SET @SQL = concat(
        'SELECT  concat("[",ifnull(group_concat( 
                JSON_OBJECT( 

                        "pos", pos,
                        "x", x,
                        "y", y
                    )
                    separator ","
                ),"")
                ,"]"
            ) o 
            INTO @signum
            FROM 
                blg_signum_',
        reporttype,
        ' 
            WHERE id = ',
        in_id,
        '
        '
    );
PREPARE stmt
FROM @SQL;
execute stmt;
DEALLOCATE PREPARE stmt;
--  BELEGTEXTE SQL
call debug_message('get report txt');
SET @SQL = concat(
        '
            SELECT  
                concat(
                    "[",
                    ifnull(group_concat( 
                        JSON_OBJECT( 

                            "type", typ,
                            "text", text
                        )
                        separator ","
                    ),
                    ""),
                    "]"
                ) o 
            INTO @txt
            FROM
                blg_txt_',
        reporttype,
        ' 
            WHERE id = ',
        in_id,
        '
        '
    );
PREPARE stmt
FROM @SQL;
execute stmt;
DEALLOCATE PREPARE stmt;
set @SQL = replace(
        concat(
            'select  ifnull(
                    (SELECT  
                        JSON_OBJECTAGG( `key`, `val` )
                    FROM 
                        blg_taxregistration_##### 
                    WHERE id = ',
            in_id,
            ')
                    ,json_object()
                ) into @tax_registration'
        ),
        '#####',
        reporttype
    );
PREPARE stmt
FROM @SQL;
execute stmt;
DEALLOCATE PREPARE stmt;
set @SQL = replace(
        concat(
            'select  ifnull(
                    (SELECT  
                        JSON_OBJECTAGG( `key`, `val` )
                    FROM 
                        blg_buyer_##### 
                    WHERE id = ',
            in_id,
            ')
                    ,json_object()
                ) into @buyer_information'
        ),
        '#####',
        reporttype
    );
PREPARE stmt
FROM @SQL;
execute stmt;
DEALLOCATE PREPARE stmt;
set @SQL = replace(
        concat(
            'select  ifnull(
                    (SELECT  
                        JSON_OBJECTAGG( `key`, `val` )
                    FROM 
                        blg_seller_##### 
                    WHERE id = ',
            in_id,
            ')
                    ,json_object()
                ) into @seller_information'
        ),
        '#####',
        reporttype
    );
PREPARE stmt
FROM @SQL;
execute stmt;
DEALLOCATE PREPARE stmt;
set @SQL = replace(
        concat(
            'select  ifnull(
                    (SELECT  
                        JSON_OBJECTAGG( `key`, `val` )
                    FROM 
                        blg_seller_globalid_##### 
                    WHERE id = ',
            in_id,
            ')
                    ,json_object()
                ) into @seller_global_ids'
        ),
        '#####',
        reporttype
    );
PREPARE stmt
FROM @SQL;
execute stmt;
DEALLOCATE PREPARE stmt;
set @SQL = replace(
        concat(
            '
                select  ifnull(
                    (
                        
                        SELECT 
                            JSON_ARRAYAGG(
                                JSON_OBJECT(
                                    "category", `category`,
                                    "type", `type`,
                                    "rate", `rate`,
                                    "net", `net`,
                                    "gross", `gross`,
                                    "tax", `tax`
                                )
                            )
                        FROM
                            (
                                SELECT
                                    beleg, 
                                    steuersatz,
                                    "S" `category`,
                                    "VAT" `type`,
                                    steuersatz `rate`,
                                    sum(brutto) `gross`,
                                    sum(netto) `net`,
                                    sum(steuer) `tax`
                                FROM 
                                    blg_pos_##### 
                                WHERE 
                                    beleg = ',
            in_id,
            '
                                GROUP BY 
                                    beleg, 
                                    steuersatz 
                            ) x
                    )
                    ,json_array()
                ) into @taxes'
        ),
        '#####',
        reporttype
    );
PREPARE stmt
FROM @SQL;
execute stmt;
DEALLOCATE PREPARE stmt;
select group_concat(
        concat(
            quote(
                ifnull(
                    blghdr_translations.json_attribute_name,
                    ds_column.column_name
                )
            ),
            ',',
            concat('hdr.', ds_column.column_name)
        ) separator ','
    ) j into flds
from ds_column
    left join blghdr_translations on blghdr_translations.column_name = ds_column.column_name
where table_name = concat('blg_hdr_', reporttype)
    and ds_column.existsreal = 1
    and ds_column.writeable = 1;
--  KOPFDATEN SQL
call debug_message('get report hdr');
SET @SQL = concat(
        '
        SELECT JSON_OBJECT(

            ',
        flds,
        ',

            "reporttype",  ',
        quote(reporttype),
        ', 
            "address", ifnull(adr.adresse,""),
            "companycode", ifnull(bkr.buchungskreis_id,"0000"),
            "referencenr", bez.kundennummer,
            "costcenter", bez.kostenstelle,

            "positions",JSON_MERGE("[]",@positions),
            "payments",JSON_MERGE("[]",@payments),
            "reductions",JSON_MERGE("[]",@reductions),
            "signum",JSON_MERGE("[]",@signum),
            "texts",JSON_MERGE("[]",@txt),
            "locks",JSON_MERGE("[]",@locks),

            "tax_registration",  JSON_MERGE("{}",@tax_registration),
            "seller_information", JSON_MERGE("{}",@seller_information),
            "buyer_information",  JSON_MERGE("{}",@buyer_information),
            "seller_global_ids",  JSON_MERGE("{}",@seller_global_ids),
            "taxes", JSON_MERGE("[]",@taxes)               

        ) 

        INTO 
            @result
        FROM 
            blg_hdr_',
        reporttype,
        '  hdr
            LEFT JOIN blg_adr_',
        reporttype,
        '  adr ON hdr.id = adr.id
            LEFT JOIN blg_bkr_',
        reporttype,
        '  bkr ON bkr.id = hdr.id
            LEFT JOIN blg_',
        base_table,
        '_',
        reporttype,
        '  bez ON bez.id = hdr.id
        WHERE hdr.id = ',
        in_id,
        '
        '
    );
-- select @SQL; 
PREPARE stmt
FROM @SQL;
execute stmt;
DEALLOCATE PREPARE stmt;
--  Belegpositionen
call debug_message('get report pos');
call getReportPositions(reporttype, in_id, @positions);
SET result = JSON_SET(
        @result,
        '$.positions',
        JSON_MERGE('[]', @positions)
    );
END IF;
END //