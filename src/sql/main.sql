


-- SOURCE FILE: ./src/000.RPT.getArticleAccountNumber.sql 

DELIMITER //
 
CREATE OR REPLACE FUNCTION `getArticleAccountNumber`( in_steuergruppe varchar(20), in_bookingdate date, in_article varchar(255) ) 
    RETURNS varchar(10)
    READS SQL DATA
    COMMENT ''
BEGIN 
    DECLARE fld varchar(10);
    DECLARE result varchar(10);

    SELECT feld INTO fld FROM steuergruppen where steuergruppe = in_steuergruppe;

    select
        JSON_VALUE(js,concat('$.konto',fld))
    INTO
        result
    from 
        view_readtable_bfkonten
        join bfkonten_zuordnung 
            on view_readtable_bfkonten.id = bfkonten_zuordnung.konto_id 
            and view_readtable_bfkonten.gueltig = bfkonten_zuordnung.gueltig 
            and bfkonten_zuordnung.gruppe = in_article
    WHERE 
        in_bookingdate between view_readtable_bfkonten.gueltig_von and view_readtable_bfkonten.gueltig;

    return result;
END //

DELIMITER ;
-- SOURCE FILE: ./src/000.RPTJSON.func.get.sql 
/*
{
    version:  / * version string for the report api, defaults to 0.0 * /
    id: -1  / * report number on update or below zero or null for an new one* /
    date:  / * ISO Date, defaults current date * /
    bookingdate:  / * ISO Date, defaults current date * /
    service_period_start: / * ISO Date, defaults current date * /
    service_period_stop: / * ISO Date, defaults current date * /
    warehouse: / * id of the warehouse to use, defaults to 0 (no warehouse) * /
    reference: / * free text string, defaults empty string * /
    address: / * multiline string defaults empty string * /

    positions: [
        {
            article:  
            account:
            amount:
            singleprice:
            net:
            taxvalue:
            gross:
        }
    ],
    payments: [
        {

        }
    ]
}
*/

DELIMITER //

/*




DROP FUNCTION IF EXISTS getReport_sysauftrag //
CREATE FUNCTION `getReport_sysauftrag`(  in_id bigint )
RETURNS JSON
READS SQL DATA
COMMENT ''
BEGIN 
    DECLARE result JSON;
    DECLARE positions TEXT;
    DECLARE signum LONGTEXT;
    DECLARE payments TEXT;
    DECLARE txt TEXT;
    DECLARE reductions TEXT;


    SET result = '{}';

    select  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "article", artikel, 
                "position", pos,
                "account", konto,
                "amount",anzahl, 
                "anzahl",anzahl, 
                "notes", bemerkung,
                "additionaltext", zusatztext,
                "singleprice",epreis, 
                "tax",steuersatz,
                "net",netto,
                "taxvalue",steuer,
                "gross",brutto,
                "reference", referenz,

                
                "inventory", null,

                "zid", zid,
                "zzusatz", zzusatz,
                "vid", vid,
                "vzusatz", vzusatz,

                "locked", if (zid is null and vid is null, false,true)

            )
            separator ','
        ),'')
        ,']'
        ) o 
    INTO positions
    FROM blg_pos_sysauftrag 
    WHERE beleg = in_id;

    select  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "date", datum, 
                "type",art, 
                "value",betrag

            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO payments
    FROM blg_pay_sysauftrag 
    WHERE belegnummer = in_id;

    SELECT  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "type", name, 
                "note", bemerkung, 
                "value",betrag

            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO reductions
    FROM blg_min_sysauftrag 
    WHERE belegnummer = in_id;


    SELECT  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "pos", pos,
                "x", x,
                "y", y
            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO signum
    FROM blg_signum_sysauftrag 
    WHERE id = in_id;



    SELECT  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "type", typ,
                "text", text
            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO txt
    FROM blg_txt_sysauftrag 
    WHERE id = in_id;

    SELECT JSON_OBJECT(

        "id", hdr.id,
        "date", hdr.datum,
        "bookingdate", hdr.buchungsdatum,
        "service_period_start", hdr.zeitraum_von,
        "service_period_stop", hdr.zeitraum_bis,
        "warehouse", hdr.von_lager,
        "reference", hdr.referenz,
        "address", ifnull(adr.adresse,''),
        "companycode", ifnull(bkr.buchungskreis_id,'0000'),
        "office", hdr.geschaeftsstelle,

        "login", hdr.login,

        "positions",JSON_MERGE('[]',positions),
        "payments",JSON_MERGE('[]',payments),
        "reductions",JSON_MERGE('[]',reductions),
        "signum",JSON_MERGE('[]',signum),
        "texts",JSON_MERGE('[]',txt)

    ) INTO result
    FROM 
        blg_hdr_sysauftrag hdr
        LEFT JOIN blg_adr_sysauftrag adr ON hdr.id = adr.id
        LEFT JOIN blg_bkr_sysauftrag bkr ON bkr.id = hdr.id
    WHERE hdr.id = in_id;

    RETURN result;
END //




DROP FUNCTION IF EXISTS getReport_FR //
CREATE FUNCTION `getReport_FR`(  in_id bigint )
RETURNS JSON
READS SQL DATA
COMMENT ''
BEGIN 
    DECLARE result JSON;
    DECLARE positions LONGTEXT;
    DECLARE signum LONGTEXT;
    DECLARE payments TEXT;
    DECLARE txt TEXT;
    DECLARE reductions TEXT;


    SET result = '{}';

    select  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "article", artikel, 
                "position", pos,
                "account", konto,
                "amount",anzahl, 
                "anzahl",anzahl, 
                "notes", bemerkung,
                "additionaltext", zusatztext,
                "singleprice",epreis, 
                "tax",steuersatz,
                "net",netto,
                "taxvalue",steuer,
                "gross",brutto,
                "reference", referenz,

                
                "inventory", null,

                "zid", zid,
                "zzusatz", zzusatz,
                "vid", vid,
                "vzusatz", vzusatz,

                "locked", if (zid is null and vid is null, false,true)

            )
            separator ','
        ),'')
        ,']'
        ) o 
    INTO positions
    FROM blg_pos_fr
    WHERE beleg = in_id;

    select  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "date", datum, 
                "type",art, 
                "value",betrag

            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO payments
    FROM blg_pay_fr
    WHERE belegnummer = in_id;

    SELECT  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "type", name, 
                "note", bemerkung, 
                "value",betrag

            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO reductions
    FROM blg_min_fr
    WHERE belegnummer = in_id;


    SELECT  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "pos", pos,
                "x", x,
                "y", y
            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO signum
    FROM blg_signum_fr
    WHERE id = in_id;



    SELECT  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "type", typ,
                "text", text
            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO txt
    FROM blg_txt_fr
    WHERE id = in_id;

    SELECT JSON_OBJECT(

        "id", hdr.id,
        "date", hdr.datum,
        "bookingdate", hdr.buchungsdatum,
        "service_period_start", hdr.zeitraum_von,
        "service_period_stop", hdr.zeitraum_bis,
        "warehouse", hdr.von_lager,
        "reference", hdr.referenz,
        "address", ifnull(adr.adresse,''),
        "companycode", ifnull(bkr.buchungskreis_id,'0000'),
        "office", hdr.geschaeftsstelle,

        "login", hdr.login,

        "positions",JSON_MERGE('[]',positions),
        "payments",JSON_MERGE('[]',payments),
        "reductions",JSON_MERGE('[]',reductions),
        "signum",JSON_MERGE('[]',signum),
        "texts",JSON_MERGE('[]',txt)

    ) INTO result
    FROM 
        blg_hdr_fr hdr
        LEFT JOIN blg_adr_fr adr ON hdr.id = adr.id
        LEFT JOIN blg_bkr_fr bkr ON bkr.id = hdr.id
    WHERE hdr.id = in_id;

    RETURN result;
END //





DROP FUNCTION IF EXISTS getReport_kaz //
CREATE FUNCTION `getReport_kaz`(  in_id bigint )
RETURNS JSON
READS SQL DATA
COMMENT ''
BEGIN 
    DECLARE result JSON;
    DECLARE positions TEXT;
    DECLARE signum LONGTEXT;
    DECLARE payments TEXT;
    DECLARE txt TEXT;
    DECLARE reductions TEXT;


    SET result = '{}';

    select  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "article", artikel, 
                "position", pos,
                "account", konto,
                "amount",anzahl, 
                "anzahl",anzahl, 
                "notes", bemerkung,
                "additionaltext", zusatztext,
                "singleprice",epreis, 
                "tax",steuersatz,
                "net",netto,
                "taxvalue",steuer,
                "gross",brutto,
                "reference", referenz,

                
                "inventory", null,

                "zid", zid,
                "zzusatz", zzusatz,
                "vid", vid,
                "vzusatz", vzusatz,

                "locked", if (zid is null and vid is null, false,true)

            )
            separator ','
        ),'')
        ,']'
        ) o 
    INTO positions
    FROM blg_pos_kaz
    WHERE beleg = in_id;

    select  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "date", datum, 
                "type",art, 
                "value",betrag

            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO payments
    FROM blg_pay_kaz
    WHERE belegnummer = in_id;

    SELECT  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "type", name, 
                "note", bemerkung, 
                "value",betrag

            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO reductions
    FROM blg_min_kaz
    WHERE belegnummer = in_id;


    SELECT  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "pos", pos,
                "x", x,
                "y", y
            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO signum
    FROM blg_signum_kaz
    WHERE id = in_id;



    SELECT  concat('[',ifnull(group_concat( 
        JSON_OBJECT( 

                "type", typ,
                "text", text
            )
            separator ','
        ),'')
        ,']'
    ) o 
    INTO txt
    FROM blg_txt_kaz
    WHERE id = in_id;

    SELECT JSON_OBJECT(

        "id", hdr.id,
        "date", hdr.datum,
        "bookingdate", hdr.buchungsdatum,
        "service_period_start", hdr.zeitraum_von,
        "service_period_stop", hdr.zeitraum_bis,
        "warehouse", hdr.von_lager,
        "reference", hdr.referenz,
        "address", ifnull(adr.adresse,''),
        "companycode", ifnull(bkr.buchungskreis_id,'0000'),
        "office", hdr.geschaeftsstelle,

        "login", hdr.login,

        "positions",JSON_MERGE('[]',positions),
        "payments",JSON_MERGE('[]',payments),
        "reductions",JSON_MERGE('[]',reductions),
        "signum",JSON_MERGE('[]',signum),
        "texts",JSON_MERGE('[]',txt)

    ) INTO result
    FROM 
        blg_hdr_kaz hdr
        LEFT JOIN blg_adr_kaz adr ON hdr.id = adr.id
        LEFT JOIN blg_bkr_kaz bkr ON bkr.id = hdr.id
    WHERE hdr.id = in_id;

    RETURN result;
END //

*/
-- SOURCE FILE: ./src/000.RPTJSON.proc.checkReportRequirements.sql 
DELIMITER //

CREATE OR REPLACE PROCEDURE checkReportRequirements( in reporttype varchar(20), in in_json JSON )
BEGIN
    IF NOT JSON_VALID( in_json ) THEN  
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "JSON not valid";
    END IF;
    
    IF NOT JSON_EXISTS( in_json, '$.referencenr'         ) THEN  
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Missing attribute referencenr";
    END IF;
    IF NOT JSON_EXISTS( in_json, '$.positions'         ) THEN  
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Missing attribute positions";
    END IF;

    IF NOT JSON_TYPE( JSON_EXTRACT(in_json,'$.positions') ) = 'ARRAY' THEN  
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Attribute positions has to be an array";
    END IF;
    
    IF JSON_LENGTH( JSON_EXTRACT(in_json,'$.positions') ) = 0 THEN  
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Attribute positions has no elements";
    END IF;

    SET @ref:=NULL;
    
    SELECT 
    concat(
        'SELECT concat(',
        ' `',bezug_id,'`,\'|\',',if(bezug_kst is null or bezug_kst='0','0',concat('`',bezug_kst,'`')),' ',
        ') x ',
        'INTO @ref ',
        'FROM `',adress_bezug,'` ',
        'WHERE ( `',bezug_id,'`,',if(bezug_kst is null or bezug_kst='0','0',concat('`',bezug_kst,'`')),' ) = (\'',JSON_VALUE( in_json, '$.referencenr'),'\',0)'
    )
    INTO
    @SQL
    FROM blg_config
    WHERE tabellenzusatz=reporttype;

    call debug_message(@SQL);

    call debug_message(reporttype);

    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;

    IF @ref IS NULL THEN  
        select in_json;
        SET @error = concat( "reference error: ",JSON_VALUE( in_json, '$.referencenr'),' reporttype ',reporttype);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error;
    END IF;

END //



-- SOURCE FILE: ./src/000.RPTJSON.proc.get.sql 
DELIMITER //

CREATE OR REPLACE PROCEDURE `getReport`( in reporttype varchar(20), in in_id bigint, out result JSON )
READS SQL DATA
COMMENT ''
BEGIN 
    DECLARE base_table varchar(128);

    DECLARE flds LONGTEXT;
 
    SELECT adress_bezug INTO base_table from blg_config where tabellenzusatz = reporttype;









    IF in_id < 0 THEN


    SET result = JSON_OBJECT(
        "reporttype",  reporttype, 
        "address", "",
        "companycode", getSessionCurrentBKR(),
        "office", getSessionCurrentOffice(),
        "referencenr", 0,
        "costcenter", 0,

           "date", curdate(),
        "payuntildate", curdate(),
        "service_period_start", curdate(),
        "service_period_stop", curdate(),
        "reference", "",
        "bookingdate", curdate(),

        "positions",ifnull((
            select 
            JSON_ARRAYAGG(
            JSON_OBJECT(
                "pos", position,
                "position", position,
                "artikel", blg_artikel.artikel,
                "amount", blg_artikel.anzahl,
                "price", blg_artikel.epreis,
                "note", blg_artikel.bemerkung
            )
            order by position
            )
            from 
                blg_artikel 
                join blg_config
                    on blg_config.id = blg_artikel.belegart
                    and blg_config.tabellenzusatz = reporttype
        ),JSON_ARRAY()),
        "payments",JSON_ARRAY(),
        "reductions",JSON_ARRAY(),
        "signum",JSON_ARRAY(),
        "texts",JSON_ARRAY(),
        "locks",JSON_ARRAY()
    );


    ELSE


        --  ZAHLUNGEN 
        call debug_message('get report payment');
        call getReportPayments(reporttype,in_id,@payments);
        --  MINDERUNGEN SQL
        call debug_message('get report reductions');
        call getReportReductions(reporttype,in_id,@reductions);

        --  SPERREN ERMITTELN
        call debug_message('get report locks');
        set @locks='[]';
        -- call getReportLocks(reporttype,in_id,@locks);

        --  UNTERSCHRIFT SQL
        call debug_message('get report signum');
        SET @SQL = concat('SELECT  concat("[",ifnull(group_concat( 
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
                blg_signum_',reporttype,' 
            WHERE id = ',in_id,'
        ');
        PREPARE stmt FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;



        --  BELEGTEXTE SQL
        call debug_message('get report txt');
        SET @SQL = concat('
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
                blg_txt_',reporttype,' 
            WHERE id = ',in_id,'
        ');

        PREPARE stmt FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;





        select
            group_concat(
                concat(
                    quote(
                        ifnull(
                            blghdr_translations.json_attribute_name,
                            ds_column.column_name
                        )
                    ),
                    ',',
                    concat('hdr.',ds_column.column_name)
                ) separator ','
            ) j into flds
        from
            ds_column
            left join blghdr_translations on blghdr_translations.column_name = ds_column.column_name
        where
            table_name = concat('blg_hdr_', reporttype)
            and ds_column.existsreal = 1
            and ds_column.writeable = 1;



        --  KOPFDATEN SQL
        call debug_message('get report hdr');
        SET @SQL = concat('
        SELECT JSON_OBJECT(

            ',flds,',

            "reporttype",  ',quote(reporttype),', 
            "address", ifnull(adr.adresse,""),
            "companycode", ifnull(bkr.buchungskreis_id,"0000"),
            "referencenr", bez.kundennummer,
            "costcenter", bez.kostenstelle,

            "positions",JSON_MERGE("[]",@positions),
            "payments",JSON_MERGE("[]",@payments),
            "reductions",JSON_MERGE("[]",@reductions),
            "signum",JSON_MERGE("[]",@signum),
            "texts",JSON_MERGE("[]",@txt),
            "locks",JSON_MERGE("[]",@locks)

        ) INTO @result
        FROM 
            blg_hdr_',reporttype,'  hdr
            LEFT JOIN blg_adr_',reporttype,'  adr ON hdr.id = adr.id
            LEFT JOIN blg_bkr_',reporttype,'  bkr ON bkr.id = hdr.id
            LEFT JOIN blg_',base_table,'_',reporttype,'  bez ON bez.id = hdr.id
        WHERE hdr.id = ',in_id,'
        ');
        -- select @SQL; 

        PREPARE stmt FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;


        --  Belegpositionen
        call debug_message('get report pos');
        call getReportPositions(reporttype,in_id,@positions);
        SET result = JSON_SET(@result,'$.positions',JSON_MERGE('[]',@positions));


    END IF;

END //

-- call getReport('rechnung',200901667,@res);
-- select @res;

-- SOURCE FILE: ./src/000.RPTJSON.proc.getPayments.sql 

DELIMITER ;

CREATE TABLE IF NOT EXISTS blgpayments_translations (
    column_name varchar(128) primary key,
    json_attribute_name varchar(128),
    is_required tinyint default 0
);
INSERT IGNORE INTO blgpayments_translations (column_name,json_attribute_name,is_required) values ('id','id',1);
INSERT IGNORE INTO blgpayments_translations (column_name,json_attribute_name,is_required) values ('art','type',1);
INSERT IGNORE INTO blgpayments_translations (column_name,json_attribute_name,is_required) values ('datum','date',1);
INSERT IGNORE INTO blgpayments_translations (column_name,json_attribute_name,is_required) values ('betrag','value',1);
INSERT IGNORE INTO blgpayments_translations (column_name,json_attribute_name,is_required) values ('belegnummer','reportnr',1);

DELIMITER // 
DROP PROCEDURE IF EXISTS getReportPayments // 
CREATE PROCEDURE `getReportPayments`(
    in reporttype varchar(20),
    in in_id bigint,
    out result JSON
) READS SQL DATA COMMENT '' BEGIN DECLARE base_table varchar(128);

DECLARE flds LONGTEXT;

select
    group_concat(
        concat(
            quote(
                ifnull(
                    blgpayments_translations.json_attribute_name,
                    ds_column.column_name
                )
            ),
            ',',
            ds_column.column_name
        ) separator ','
    ) j into flds
from
    ds_column
    left join blgpayments_translations on blgpayments_translations.column_name = ds_column.column_name
where
    table_name = concat('blg_pay_', reporttype)
    and ds_column.existsreal = 1
    and ds_column.writeable = 1;

SET
    @SQL = concat(
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
        blg_pay_',
        reporttype,
        ' 
    WHERE belegnummer = ',
        in_id,
        '
    '
    );

PREPARE stmt
FROM
    @SQL;

execute stmt;

DEALLOCATE PREPARE stmt;

SET
    result = @positions;

END //
-- SOURCE FILE: ./src/000.RPTJSON.proc.getPositions.sql 
DELIMITER //
CREATE OR REPLACE PROCEDURE `getReportPositions`(
    in reporttype varchar(20),
    in in_id bigint,
    out result JSON
) READS SQL DATA COMMENT '' BEGIN DECLARE base_table varchar(128);

DECLARE flds LONGTEXT;



select
    group_concat(
        concat(
            quote(
                ifnull(
                    blgpos_translations.json_attribute_name,
                    ds_column.column_name
                )
            ),
            ',',
            concat('pos.',ds_column.column_name)
        ) separator ','
    ) j into flds
from
    ds_column
    left join blgpos_translations on blgpos_translations.column_name = ds_column.column_name
where
    table_name = concat('blg_pos_', reporttype)
    and ds_column.existsreal = 1
    and ds_column.writeable = 1;

set flds =concat(
    flds,',',
    '"artikelgruppen_artikelnummer",`artikelgruppen`.`artikelnummer`,',
    '"warengruppen_wgsort",`warengruppen`.`wgsort`,',
    '"mengeneinheiten_symbol",`mengeneinheiten`.`symbol`'
  
);
--    POSITIONEN SQL
SET
    @SQL = concat(
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
        blg_pos_', reporttype, ' pos 

        left join `artikelgruppen` on `pos`.`artikel` = `artikelgruppen`.`gruppe`
        left join `warengruppen` on  `warengruppen`.`warengruppe` = `artikelgruppen`.`warengruppe`
        left join `mengeneinheiten` on `artikelgruppen`.`einheit` = `mengeneinheiten`.`id`
        
    WHERE beleg = ',
        in_id,
        '
    '
    );

PREPARE stmt FROM @SQL;

execute stmt;
DEALLOCATE PREPARE stmt;
SET result = @positions;

END //
-- SOURCE FILE: ./src/000.RPTJSON.proc.getReductions.sql 

DELIMITER ;

CREATE TABLE IF NOT EXISTS blgreductions_translations (
    column_name varchar(128) primary key,
    json_attribute_name varchar(128),
    is_required tinyint default 0
);
INSERT IGNORE INTO blgreductions_translations (column_name,json_attribute_name,is_required) values ('id','id',1);
INSERT IGNORE INTO blgreductions_translations (column_name,json_attribute_name,is_required) values ('name','type',1);
INSERT IGNORE INTO blgreductions_translations (column_name,json_attribute_name,is_required) values ('bemerkung','note',1);
INSERT IGNORE INTO blgreductions_translations (column_name,json_attribute_name,is_required) values ('betrag','value',1);
INSERT IGNORE INTO blgreductions_translations (column_name,json_attribute_name,is_required) values ('belegnummer','reportnr',1);

DELIMITER // 

DROP PROCEDURE IF EXISTS getReportReductions // 
CREATE PROCEDURE `getReportReductions`(
    in reporttype varchar(20),
    in in_id bigint,
    out result JSON
) READS SQL DATA COMMENT '' BEGIN DECLARE base_table varchar(128);

DECLARE flds LONGTEXT;

select
    group_concat(
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
from
    ds_column
    left join blgreductions_translations on blgreductions_translations.column_name = ds_column.column_name
where
    table_name = concat('blg_min_', reporttype)
    and ds_column.existsreal = 1
    and ds_column.writeable = 1;

SET
    @SQL = concat(
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
FROM
    @SQL;

execute stmt;

DEALLOCATE PREPARE stmt;

SET
    result = @positions;

END //
-- SOURCE FILE: ./src/000.RPTJSON.proc.getReportLocks.sql 

DELIMITER // 
DROP PROCEDURE IF EXISTS getReportLocks // 
CREATE PROCEDURE `getReportLocks`(
    in reporttype varchar(20),
    in in_id bigint,
    out result JSON
) READS SQL DATA COMMENT '' BEGIN DECLARE base_table varchar(128);

DECLARE flds LONGTEXT;


SET
    @SQL = concat(
    '
    select  
        concat("[",

            ifnull(group_concat( 
                JSON_OBJECT(
                    "lock_type", lock_type,
                    "lock_reason", lock_reason
                ) 
                separator ","
            ),''),
            
        "]")

    into @result
    
    from (

                select "updates" lock_type, "automatic locked"  lock_reason from blg_config where tabellenzusatz = quote(',reporttype,') and auto_lock=1
        
                union
                select "updates" lock_type, "bookingdate noch unvollständig"       lock_reason from blg_config where tabellenzusatz = quote(',reporttype,') and periodensperre=1

                union
                select "updates" lock_type, "allready sap"       lock_reason from blg_pos_',reporttype,' where beleg = quote(',in_id,') and ( sap_beleg is not null )

                union
                select "convert" lock_type, "allready converted"       lock_reason from blg_ueb_',reporttype,' where zid = quote(',in_id,')
                
                union
                select "convert" lock_type, "allready positions converted"       lock_reason from blg_pos_',reporttype,' where beleg = quote(',in_id,') and ( zid is not null )

    ) a
    '
    );

PREPARE stmt
FROM
    @SQL;

execute stmt;
DEALLOCATE PREPARE stmt;
SET result = JSON_MERGE("[]",@result);

END //
-- SOURCE FILE: ./src/000.RPTJSON.proc.setReport.sql 
DELIMITER //




CREATE OR REPLACE PROCEDURE setReportOLD( in reporttype varchar(20), in in_json JSON, out out_json JSON )
BEGIN
    DECLARE i INTEGER DEFAULT 0;
    DECLARE j INTEGER DEFAULT 0;
    DECLARE positionid BIGINT DEFAULT 0;
    DECLARE positions LONGTEXT;
    DECLARE resultpositions LONGTEXT;
    DECLARE position LONGTEXT;


    DECLARE payments LONGTEXT;
    DECLARE payment LONGTEXT;
    


    DECLARE looparray LONGTEXT;
    DECLARE loopelement LONGTEXT;

    DECLARE xref JSON;
    DECLARE xrefs JSON;


    DECLARE textval JSON;
    DECLARE texts JSON;


    SET @newrptnr:=NULL;

    -- call debug_message('update report');
            
    call checkReportRequirements(reporttype,in_json);
    call setReportDefaults(reporttype,in_json,in_json);


    SELECT JSON_EXTRACT(in_json,'$.positions') INTO positions;



    SET @positionid:=0;
    SET @SQL := CONCAT('SELECT ifnull(max(id),0)+1 i INTO @positionid FROM blg_pos_',reporttype);
    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;
    
    /*
    IF @newrptnr IS NOT NULL THEN
        call debug_message('new report');
    ELSE
        call debug_message('update report');
    END IF;
    */


    SELECT '[]' INTO resultpositions;
    SET resultpositions := JSON_MERGE('[]',resultpositions);
    -- call debug_message(' x1');

    call setReportHeader(reporttype,in_json);
    SET @use_rptnr = @newrptnr;
    -- call debug_message(concat(' x2',@use_rptnr));

    WHILE i < JSON_LENGTH(positions) DO
        SELECT JSON_EXTRACT(positions,CONCAT('$[',i,']')) INTO position;


        IF @newrptnr IS NOT NULL AND JSON_EXISTS(position,'$.id')=0 THEN 
            SET position:=JSON_INSERT(position,'$.id',@positionid); 
            SET @positionid:=@positionid+1;
            SET position:=JSON_SET(position,'$.reportnr',@use_rptnr); 
        ELSEIF @newrptnr IS NOT NULL AND JSON_EXISTS(position,'$.id')=1 THEN 
            SET position:=JSON_SET(position,'$.id',@positionid); 
            SET @positionid:=@positionid+1;
            SET position:=JSON_SET(position,'$.reportnr',@use_rptnr); 
        END IF;

        IF  JSON_EXISTS(position,'$.id')=0 THEN
            SET position:=JSON_SET(position,'$.id',@positionid); 
            SET @positionid:=@positionid+1;
        END IF;


        IF  NOT JSON_VALUE(position,'$.account')="" THEN
            SET position:=JSON_SET(position,'$.account',"8400"); 
        END IF;

        call setReportPosition(reporttype,position);
        

        IF JSON_EXISTS(position,'$.xref') THEN 
            SET j:=0;
            SELECT JSON_EXTRACT(position,'$.xref') INTO xrefs;
            WHILE j < JSON_LENGTH(xrefs) DO
                SELECT JSON_EXTRACT(xrefs,CONCAT('$[',j,']')) INTO xref;
                IF ( JSON_VALUE(xref,'$.zuordnung')='z') THEN
                    SET @USQL = concat( 'update blg_pos_',JSON_VALUE(xref,'$.tabellenzusatz'),' set zid=\'',JSON_VALUE(position,'$.id'),'\',zzusatz=\'',reporttype,'\' where id=',JSON_VALUE(xref,'$.posid'),' ');
                    -- call debug_message(@USQL);

                    PREPARE stmt FROM @USQL;
                    execute stmt;
                    DEALLOCATE PREPARE stmt;

                    SET @USQL = concat( 'insert ignore into blg_ueb_',reporttype,' (id,zid,tabellenzusatz) values (' , JSON_VALUE(position,'$.reportnr'), ',' ,JSON_VALUE(xref,'$.belegnummer'), ',\'' , JSON_VALUE(xref,'$.tabellenzusatz') , '\')');
                    -- call debug_message(@USQL);
                    PREPARE stmt FROM @USQL;
                    execute stmt;
                    DEALLOCATE PREPARE stmt;

                END IF;
                SET j:=j+1;
            END WHILE;
        END IF;

        -- call debug_message(concat('pos index ',i));

        SET i:=i+1;

    END WHILE;


   

    -- call debug_message(concat('before payment'));


    IF JSON_EXISTS(in_json,'$.payment') THEN 
        
        SET @paymentid:=0;
        SET @SQL := CONCAT('SELECT ifnull(max(id),0)+1 i INTO @paymentid FROM blg_pay_',reporttype);
        -- call debug_message(@SQL );
        PREPARE stmt FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;
        
        if @paymentid is null THEN
            set @paymentid=1;
        end if;
        SELECT JSON_EXTRACT(in_json,'$.payment') INTO payments;
        SET i:=0;
        WHILE i < JSON_LENGTH(payments) DO
            SELECT JSON_EXTRACT(payments,CONCAT('$[',i,']')) INTO payment;
            SET @paymentid:=@paymentid+1;
                    

            SET @USQL = concat( 'insert into blg_pay_',reporttype,' 
                (
                    id,
                    datum,
                    zeit,
                    belegnummer,
                    art,
                    betrag,
                    pending
                ) 
                values (' , 
                    @paymentid, ',' ,
                    quote( JSON_VALUE(payment,'$.date')), ',' ,
                    quote( JSON_VALUE(payment,'$.time')), ',' ,
                    @use_rptnr, ',' ,
                    quote( JSON_VALUE(payment,'$.type')), ',' ,
                    ifnull(JSON_VALUE(payment,'$.value'),0), ',' ,
                    JSON_VALUE(payment,'$.pending'),
                    
                ') on duplicate key update 
                    `id`=values(`id`)
                    
                ');
                
            PREPARE stmt FROM @USQL;
            execute stmt;
            DEALLOCATE PREPARE stmt;
            -- call debug_message('done');

            SET i:=i+1;
        END WHILE;
    END IF;

    IF JSON_EXISTS(in_json,'$.images') THEN 
        SELECT JSON_EXTRACT(in_json,'$.images') INTO looparray;
        SET i:=0;
        WHILE i < JSON_LENGTH(looparray) DO
            SELECT JSON_EXTRACT(looparray,CONCAT('$[',i,']')) INTO loopelement;
                    

            
            SET @USQL = concat( 'insert into blg_images_',reporttype,' 
                (
                    id,
                               type,
                    imagedata
                ) 
                values (' , 
                    @use_rptnr, ',' ,
                    quote( JSON_VALUE(loopelement,'$.type')),',' ,
                    quote( JSON_VALUE(loopelement,'$.data')),
                ') on duplicate key update 
                    `id`=values(`id`)
                ');
                
            PREPARE stmt FROM @USQL;
            execute stmt;
            DEALLOCATE PREPARE stmt;
            -- call debug_message('done');

            SET i:=i+1;
        END WHILE;
    END IF;


    IF JSON_EXISTS(in_json,'$.geo') THEN 
        SELECT JSON_EXTRACT(in_json,'$.geo') INTO looparray;
        SET i:=0;
        WHILE i < JSON_LENGTH(looparray) DO
            SELECT JSON_EXTRACT(looparray,CONCAT('$[',i,']')) INTO loopelement;
                    

            SET @USQL = concat( 'insert into blg_geo_',reporttype,' 
                (
                    geoid,
                    id,
                    latitude,
                    longitude,
                    accuracy,
                    timestamp 
                ) 
                values (' , 
                    quote( uuid() ), ',' ,
                    @use_rptnr, ',' ,
                    quote( JSON_VALUE(loopelement,'$.latitude')), ',' ,
                    quote( JSON_VALUE(loopelement,'$.longitude')), ',' ,
                    ifnull(JSON_VALUE(loopelement,'$.accuracy'),0), ',' ,
                    ifnull(JSON_VALUE(loopelement,'$.timestamp'),0), '' ,
                ') on duplicate key update 
                    `id`=values(`id`)
                ');
                
            PREPARE stmt FROM @USQL;
            execute stmt;
            DEALLOCATE PREPARE stmt;
            -- call debug_message('done');

            SET i:=i+1;
        END WHILE;
    END IF;


    -- TSE ------------------------>
    -- call debug_message('call TSE');
    call setReportTSE(reporttype,in_json,@out);



    IF JSON_EXISTS(in_json,'$.texts') THEN 
    SELECT JSON_EXTRACT(in_json,'$.texts') INTO texts;
    SET i:=0;
    WHILE i < JSON_LENGTH(texts) DO

        SELECT JSON_EXTRACT(texts,CONCAT('$[',i,']')) INTO textval;
        SET @USQL = concat( 'insert into blg_txt_',reporttype,' (`id`,`typ`,`text`) values (' , JSON_VALUE(position,'$.reportnr'), ',\'' ,JSON_VALUE(textval,'$.type'), '\',\'' , JSON_VALUE(textval,'$.text') , '\') on duplicate key update `text`=values(`text`)');
        PREPARE stmt FROM @USQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;
        SET i:=i+1;
        
    END WHILE;
    END IF;





    SET @SQL =concat('SELECT round(sum(steuer),2) s, round(sum(netto),2) n, round(sum(brutto),2) b INTO  @use_s, @use_n, @use_b FROM blg_pos_',reporttype,' WHERE beleg = ',JSON_VALUE(position,'$.reportnr'));
    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;

    SET @SQL =concat('UPDATE  blg_hdr_',reporttype,'   SET    netto = @use_n,   brutto = @use_b,   steuer = @use_b-@use_n  WHERE     id = ',JSON_VALUE(position,'$.reportnr'));
    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;




    -- SET @SQL := CONCAT('SELECT getReport_',reporttype,'(',JSON_VALUE(position,'$.reportnr'),') INTO @tempout ');
    -- PREPARE stmt FROM @SQL;
    -- execute stmt;
    -- DEALLOCATE PREPARE stmt;
    
    -- call debug_message('REPORT SAVED');

    call getReport(reporttype,JSON_VALUE(position,'$.reportnr'),@tempout);
    
    -- call debug_message(reporttype);
    
    IF lower(reporttype)<>'wb' THEN
        -- call setWarehouseReport(@tempout,@tempout2);
        SET @tempout=JSON_SET(@tempout,'$.__wb',@tempout2);
        call debug_message(concat(  '_in_warehouse ',JSON_EXISTS(@tempout,'$._in_warehouse')));

        /*
        IF JSON_EXISTS(@tempout,'$._in_warehouse')!=0 THEN
            IF JSON_VALUE(@tempout,'$._in_warehouse')!=0 THEN
                call debug_message(concat(  '_in_warehouse ',JSON_VALUE(@tempout,'$._in_warehouse')));
                SET @R2 = JSON_SET(@tempout,'$.warehouse',JSON_VALUE(@tempout,'$._in_warehouse'));
                call setWarehouseReport(@R2,@tempout2);

                SET @tempout=JSON_SET(@tempout,'$.__wbX',@tempout2);
            END IF;
        END IF;
        */
    END IF;

    -- LOOP Throught conversions
    -- call convertToWarehouse(@tempout)
        -- 'WB'
        -- Filtern der bestandsprodukte
        -- Vorzeichen der Anzahl setzen ( Abgang oder Zugang ; lagerfaktor aus blg_config )
        -- Konten der Artikel setzen (aus bfkonten)
        -- referenz der position setzen
        -- referenz der hdr setzen
        -- preis gemäß definition setzen (gld, ek usw ...)



    SELECT @tempout  INTO out_json;


END //



-- SOURCE FILE: ./src/000.RPTJSON.proc.setReportDefaults.sql 

DELIMITER //

CREATE OR REPLACE PROCEDURE setReportDefaults( in reporttype varchar(20), in in_json JSON, out out_json JSON )
BEGIN
    DECLARE strval varchar(255);

    SELECT JSON_INSERT(in_json, '$.__messages', JSON_MERGE('[]','[]') ) INTO in_json;
    SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','begin defaults');

    IF NOT JSON_EXISTS( in_json, '$.id'                  ) THEN  
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','id not set -> set to -1');

        SELECT JSON_INSERT(in_json, '$.id',-1) INTO in_json;

        call debug_message('id not set -> set to -1');

    END IF;



    call debug_message( concat('default report id ', json_value( in_json, '$.id') ));

    IF JSON_EXISTS( in_json, '$.id') = 1 OR   json_value( in_json, '$.id') > 0 THEN
        
        SET @old_rn = null;
        SET @SQL := CONCAT('select id into @old_rn from blg_hdr_',reporttype,' where id = ',json_value( in_json, '$.id'),' ');
        PREPARE stmt FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;

        if @old_rn is null then
            set @newrptnr = json_value( in_json, '$.id');
            SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages',concat('new reportnumber ' ));
            SET in_json = JSON_INSERT(in_json,'$.isNewReport',1=1);
        end if;


    END IF;



    IF json_value( in_json, '$.id')= -1  THEN

        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages',concat('new id requested, query getReportNumber',reporttype,'()' ));
        
        SET @SQL := CONCAT('set @newrptnr = getReportNumber',reporttype,'()   ');

        PREPARE stmt FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;

    call debug_message( concat('default report new id ', @SQL ));
        -- reserve the new id as soon as possible
        SET @SQL = concat('
        insert into blg_hdr_',reporttype,' (id,datum,faelligam,login) values (@newrptnr,current_date,current_date,getSessionUser())
        ');
        PREPARE stmt FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;


        SELECT JSON_SET(in_json, '$.id',@newrptnr) INTO in_json;

        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages',concat('new id requested, set to ',@newrptnr,'' ));

    END IF;


    set @newrptnr =  json_value( in_json, '$.id');


    
    IF NOT JSON_EXISTS( in_json, '$.costcenter'         ) THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','costcenter not set -> set to 0');
        SELECT JSON_INSERT(in_json, '$.costcenter',0) INTO in_json;
    END IF;

    IF NOT JSON_EXISTS( in_json, '$._in_warehouse'         ) THEN
        SELECT JSON_INSERT(in_json, '$._in_warehouse',0) INTO in_json;
    END IF;

    IF NOT JSON_EXISTS( in_json, '$.date'                ) THEN  
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','date not set -> set to current date');
        SELECT JSON_INSERT(in_json, '$.date',CURRENT_DATE) INTO in_json;  
    END IF;

    IF NOT JSON_EXISTS( in_json, '$.service_period_start') THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','service_period_start not set -> set to current date');
        SELECT JSON_INSERT(in_json, '$.service_period_start',CURRENT_DATE) INTO in_json;
    END IF;
    IF NOT JSON_EXISTS( in_json, '$.service_period_stop' ) THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','service_period_stop not set -> set to current date');
        SELECT JSON_INSERT(in_json, '$.service_period_stop',CURRENT_DATE) INTO in_json;
    END IF;


    IF NOT JSON_EXISTS( in_json, '$.bookingdate'         ) THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','bookingdate not set -> set to current date');
        SELECT JSON_INSERT(in_json, '$.bookingdate',CURRENT_DATE) INTO in_json;
    END IF;


    IF NOT JSON_EXISTS( in_json, '$.companycode' ) THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','companycode not set -> set to session default');
        SELECT JSON_INSERT(in_json, '$.companycode',getSessionDefaultBKR() ) INTO in_json;
    END IF;

    IF NOT JSON_EXISTS( in_json, '$.kindofbill' ) THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','kindofbill not set -> query');
        SELECT max(preisorientierung) INTO strval FROM blg_config WHERE lower(tabellenzusatz)=lower(reporttype);
        SELECT JSON_INSERT(in_json, '$.kindofbill', strval ) INTO in_json;
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages',concat( 'kindofbill not set -> ',strval ));
    END IF;


    SET in_json := JSON_INSERT(in_json,'$.create_timestamp',now());
    SET in_json := JSON_INSERT(in_json,'$.login',getSessionUser());
    

    SELECT in_json INTO out_json;
END //


-- SOURCE FILE: ./src/000.RPTJSON.proc.setReportHeader.sql 
DELIMITER //

CREATE TABLE IF NOT EXISTS blghdr_translations (
    column_name varchar(128) primary key,
    json_attribute_name varchar(128),
    is_required tinyint default 0
) //

INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('id','id',1) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('geschaeftsstelle','office',0) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('login','login',0) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('tabellenzusatz','reporttype',0) //

INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('preisorientierung','kindofbill',1)  //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('referenz','reference',1) //


INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('an_lager','_in_warehouse',1) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('von_lager','warehouse',1) //


INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('zeitraum_von','service_period_start',1) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('zeitraum_bis','service_period_stop',1) //


INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('zeit','time',1) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('buchungsdatum','bookingdate',1) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('datum','date',1) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('faelligam','payuntildate',1) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('faelligam','bookingdate',1) //

INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('create_timestamp','create_timestamp',1) //


INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('steuernummer','taxid',0) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('zahlart','paytype',0) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('mandatsreferenz','separeference',0) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('hardwareid','hardwareid',0) //


INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('netto','netto',0) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('brutto','brutto',0) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('steuer','steuer',0) //


INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('zbeleg_zusatz','zbeleg_zusatz',0) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('zbeleg','zbeleg',0) //

INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('svkunde','svkunde',0) //
INSERT IGNORE INTO blghdr_translations (column_name,json_attribute_name,is_required) values ('svmodel','svmodel',0) //


CREATE OR REPLACE PROCEDURE setReportHeader( in reporttype varchar(20), in in_json JSON )
BEGIN


    DECLARE flds LONGTEXT default '';
    DECLARE vals LONGTEXT default '';
    DECLARE upda LONGTEXT default '';
    DECLARE v LONGTEXT default '';

    DECLARE done INT DEFAULT FALSE;

    DECLARE column_name varchar(128);
    DECLARE json_attribute_name varchar(128);
    DECLARE is_required INT DEFAULT 0;


    DECLARE c1 CURSOR FOR
    select 
        ds_column.column_name,
        ifnull(blghdr_translations.json_attribute_name,ds_column.column_name) json_attribute_name,
        ifnull(is_required,0) is_required
    from 
        ds_column 
        left join blghdr_translations
            on blghdr_translations.column_name=ds_column.column_name
    where 
        table_name=concat('blg_hdr_',reporttype)
        and ds_column.existsreal = 1
        and ds_column.writeable = 1
    ;



    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    
    OPEN c1;

    read_loop: LOOP

            FETCH c1 INTO column_name,json_attribute_name,is_required;

            If done THEN
                LEAVE read_loop;
            END IF;

            IF NOT JSON_EXISTS(in_json,concat('$.',json_attribute_name) ) THEN  
                IF is_required=1 THEN
                    SET @error_message = concat(json_attribute_name,' attribute is needed');
                    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
                END IF;
            ELSE

                SET flds := if(flds='', column_name, concat(flds,',',column_name));
                SET upda := if(upda='', concat('`',column_name,'`=values(`',column_name,'`)'), concat(upda,',',concat('`',column_name,'`=values(`',column_name,'`)')));
                SET v:=JSON_VALUE(in_json, concat('$.',json_attribute_name));


                IF JSON_TYPE(JSON_EXTRACT(in_json, concat('$.',json_attribute_name))) <> 'NULL' THEN
                    set v:=QUOTE( v );
                ELSE
                    set v:='null';
                END IF;
                SET vals := if(vals='', v ,  concat(vals,',', v ));

                

            END IF;
    END LOOP;

    CLOSE c1;
    

call debug_message(flds);
call debug_message(vals);
call debug_message(upda);

   
    SET @SQL := CONCAT('INSERT INTO blg_hdr_',reporttype,' (',flds,') values (',vals,') on duplicate key update ',upda);


    call debug_message(@SQL);

    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;

    SET @SQL := concat('INSERT INTO blg_bkr_',reporttype,' (id,buchungskreis_id) values (', JSON_VALUE(in_json,'$.id' ),',',QUOTE( JSON_VALUE(in_json,'$.companycode' ) ),') ON DUPLICATE KEY UPDATE buchungskreis_id=values(buchungskreis_id) ');


    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;

    SELECT 
        ds.table_name rt,
        bezug_id,
        bezug_kst
    INTO 
        @base_table,
        @readtable_bezug_id,
        @readtable_bezug_kst
    FROM
        blg_config
        join ds
            on ds.table_name = blg_config.adress_bezug
    WHERE upper(blg_config.tabellenzusatz) = upper(reporttype);



    SET @SQL := concat('INSERT INTO blg_',@base_table,'_',reporttype,' (id,kundennummer,kostenstelle) values (', JSON_VALUE(in_json,'$.id' ),',',QUOTE( JSON_VALUE(in_json,'$.referencenr' ) ),',',QUOTE( JSON_VALUE(in_json,'$.costcenter' ) ),') ON DUPLICATE KEY UPDATE kundennummer=values(kundennummer),kostenstelle=values(kostenstelle) ');

    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;

    call debug_message(@SQL);


    IF NOT JSON_EXISTS( in_json, '$.address'         ) THEN  
        
        SET @readtable_name:=       NULL;
        SET @readtable_bezug_id:=   NULL;
        SET @readtable_bezug_kst:=  NULL;
        SET @adr:=                  '';

        SELECT 
            if(ifnull(ds.read_table,'')='',ds.table_name,ds.read_table) rt,
            bezug_id,
            bezug_kst
        INTO 
            @readtable_name,
            @readtable_bezug_id,
            @readtable_bezug_kst
        FROM
            blg_config
            join ds
                on ds.table_name = blg_config.adress_bezug
            join ds_column
                on lower(ds_column.column_name)='report_address' 
                and blg_config.adress_bezug = ds_column.table_name
        WHERE upper(blg_config.tabellenzusatz) = upper(reporttype);
        


        IF  @basetable_name IS NOT NULL THEN
            SET @SQL := concat(
                'select report_address into @adr FROM ',
                @readtable_name,
                ' WHERE ',
                '`',@readtable_bezug_id,'` = ',QUOTE( JSON_VALUE(in_json,'$.referencenr' ) ),
                ' AND ',
                '`',@readtable_bezug_kst,'` = ',QUOTE( JSON_VALUE(in_json,'$.costcenter' ) ),
                ''
            );
            PREPARE stmt FROM @SQL;
            execute stmt;
            DEALLOCATE PREPARE stmt;
            


        END IF;
    ELSE
        SET @adr:=JSON_VALUE( in_json, '$.address' ); 
    END IF;


    SET @adr:= replace( replace(@adr,concat(char(10),char(10)),char(10)) ,concat(char(10),char(10)),char(10));
    SET @SQL := concat('INSERT INTO blg_adr_',reporttype,' (id,adresse) values (', JSON_VALUE(in_json,'$.id' ),',@adr) ON DUPLICATE KEY UPDATE adresse=values(adresse) ');

        call debug_message(@SQL);

    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;

    call debug_message('hdr ok');

END //

-- SOURCE FILE: ./src/000.RPTJSON.proc.setReportN.sql 
DELIMITER //


DELIMITER //

CREATE OR REPLACE PROCEDURE setReportDefaultsN( in reporttype varchar(20), in in_json JSON, out out_json JSON )
BEGIN
    DECLARE strval varchar(255);

    SELECT 
        JSON_INSERT(in_json, '$.__messages', JSON_ARRAY() ) 
    INTO in_json;

    SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','begin defaults');
    SET in_json = JSON_INSERT(in_json,'$.isNewReport',1=0);

    IF JSON_EXISTS( in_json, '$.id') = 0 THEN  
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','id not set -> set to -1');
        SELECT JSON_INSERT(in_json, '$.id',-1) INTO in_json;
    END IF;
    IF JSON_VALUE( in_json, '$.id') > 0 THEN
        
        SET @old_rn = null;
        SET @SQL := CONCAT('select id into @old_rn from blg_hdr_',reporttype,' where id = ',json_value( in_json, '$.id'),' ');
        PREPARE stmt FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;
        if @old_rn is null then
            set @newrptnr = JSON_VALUE( in_json, '$.id');
            SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages',concat('new reportnumber the given one was not found' ));
            SET in_json = JSON_SET(in_json,'$.isNewReport',1=1);
        end if;
    END IF;

    IF JSON_VALUE( in_json, '$.id') < 0  THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages',concat('new id requested, query getReportNumber',reporttype,'()' ));
        SET @SQL := CONCAT('set @newrptnr = getReportNumber',reporttype,'()   ');
        PREPARE stmt FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;
        SELECT JSON_SET(in_json, '$.id',@newrptnr) INTO in_json;
        SET in_json = JSON_SET(in_json,'$.isNewReport',1=1);
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages',concat('new id requested, set to ',@newrptnr,'' ));

    END IF;
    IF NOT JSON_EXISTS( in_json, '$._in_warehouse'         ) THEN
        SELECT JSON_INSERT(in_json, '$._in_warehouse',0) INTO in_json;
    END IF;
    IF NOT JSON_EXISTS( in_json, '$.payuntildate'         ) THEN
        SELECT JSON_INSERT(in_json, '$.payuntildate',curdate()+interval+ 10 day) INTO in_json;
    END IF;

     IF NOT JSON_EXISTS( in_json, '$.reference'         ) THEN
        SELECT JSON_INSERT(in_json, '$.reference','') INTO in_json;
    END IF;

    IF JSON_EXISTS( in_json, '$.costcenter'         ) = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','costcenter not set -> set to 0');
        SELECT JSON_INSERT(in_json, '$.costcenter',0) INTO in_json;
    END IF;

    IF JSON_EXISTS( in_json, '$.date'                ) = 0 THEN  
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','date not set -> set to current date');
        SELECT JSON_INSERT(in_json, '$.date',CURRENT_DATE) INTO in_json;  
    END IF;

    IF JSON_EXISTS( in_json, '$.service_period_start') = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','service_period_start not set -> set to current date');
        SELECT JSON_INSERT(in_json, '$.service_period_start',CURRENT_DATE) INTO in_json;
    END IF;
    IF JSON_EXISTS( in_json, '$.service_period_stop' ) = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','service_period_stop not set -> set to current date');
        SELECT JSON_INSERT(in_json, '$.service_period_stop',CURRENT_DATE) INTO in_json;
    END IF;


    IF JSON_EXISTS( in_json, '$.bookingdate'         ) = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','bookingdate not set -> set to current date');
        SELECT JSON_INSERT(in_json, '$.bookingdate',CURRENT_DATE) INTO in_json;
    END IF;


    IF JSON_EXISTS( in_json, '$.companycode' ) = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','companycode not set -> set to session default');
        SELECT JSON_INSERT(in_json, '$.companycode',getSessionDefaultBKR() ) INTO in_json;
    END IF;

    IF JSON_EXISTS( in_json, '$.kindofbill' ) = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages','kindofbill not set -> query');
        SELECT max(preisorientierung) INTO strval FROM blg_config WHERE lower(tabellenzusatz)=lower(reporttype);
        SELECT JSON_INSERT(in_json, '$.kindofbill', strval ) INTO in_json;
        SET in_json = JSON_ARRAY_APPEND(in_json,'$.__messages',concat( 'kindofbill not set -> ',strval ));
    END IF;


    SET in_json := JSON_INSERT(in_json,'$.create_timestamp',now());
    SET in_json := JSON_INSERT(in_json,'$.login',getSessionUser());
    

    SELECT in_json INTO out_json;

END //


CREATE OR REPLACE PROCEDURE `recalculateHeader`(in reporttype varchar(20), IN in_reportnumber bigint)
    MODIFIES SQL DATA
BEGIN
    SET @SQL = concat('SELECT 
        round(sum(steuer),2) s,
        round(sum(netto),2) n,
        round(sum(brutto),2) b 
    INTO
        @use_s,
        @use_n,
        @use_b
    FROM 
        blg_pos_',reporttype,'
    WHERE 
        beleg = ?
    ');

    PREPARE stmt FROM @SQL;
    execute stmt using in_reportnumber;
    DEALLOCATE PREPARE stmt;
    
    SET @SQL = concat(' 
    UPDATE 
        blg_hdr_',reporttype,'
    SET 
        netto = @use_n,
        brutto = @use_b,
        steuer = @use_b - @use_n
    WHERE
        id = ?
    ');
    PREPARE stmt FROM @SQL;
    execute stmt using in_reportnumber;
    DEALLOCATE PREPARE stmt;

    
END //

CREATE OR REPLACE PROCEDURE setReport( in reporttype varchar(20), in in_json JSON, out out_json JSON )
BEGIN
    DECLARE j INT DEFAULT 0;
    DECLARE position JSON;
    DECLARE positions JSON;

    call checkReportRequirements(reporttype,in_json);
    call setReportDefaultsN(reporttype,in_json,in_json);


    FOR rec in (select * from blghdr_translations) DO
        IF (
            rec.is_required = 1
            and JSON_EXISTS(in_json,concat('$.',rec.json_attribute_name)) = 0
        ) THEN
            SET @MSG = concat('Required field ',rec.json_attribute_name,' not found in JSON');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @MSG;
        ELSEIF JSON_EXISTS(in_json,concat('$.',rec.json_attribute_name)) = 1 THEN
            SET in_json = JSON_SET(in_json,concat('$.',rec.column_name), JSON_VALUE(in_json,concat('$.',rec.json_attribute_name)));
        END IF;
        
    END FOR;
 
    SET positions = JSON_EXTRACT(in_json,'$.positions');

    -- SET in_json = JSON_REMOVE(in_json,'$.positions');
    -- SET in_json = JSON_REMOVE(in_json,'$.__messages');

    SET @request = JSON_OBJECT(
        'tablename',concat('blg_hdr_',reporttype),
        'data',JSON_ARRAY( JSON_MERGE(in_json,'{}')),
        'type','insert',
        'update',1=1
    );
    call dsx_rest_api_set(@request,@result);
    if(JSON_VALUE(@result,'$.success') <> 1) then
        SET @MSG = concat('Error while inserting into blg_hdr_',reporttype,' : ',JSON_VALUE(@result,'$.message'));
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @MSG;
    end if;

    SET @SQL := concat('INSERT INTO blg_bkr_',reporttype,' (id,buchungskreis_id) values (', JSON_VALUE(in_json,'$.id' ),',',QUOTE( JSON_VALUE(in_json,'$.companycode' ) ),') ON DUPLICATE KEY UPDATE buchungskreis_id=values(buchungskreis_id) ');
    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;


    SELECT 
        ds.table_name rt,
        bezug_id,
        bezug_kst
    INTO 
        @base_table,
        @readtable_bezug_id,
        @readtable_bezug_kst
    FROM
        blg_config
        join ds
            on ds.table_name = blg_config.adress_bezug
    WHERE upper(blg_config.tabellenzusatz) = upper(reporttype);
    SET @SQL := concat('INSERT INTO blg_',@base_table,'_',reporttype,' (id,kundennummer,kostenstelle) values (', JSON_VALUE(in_json,'$.id' ),',',QUOTE( JSON_VALUE(in_json,'$.referencenr' ) ),',',QUOTE( JSON_VALUE(in_json,'$.costcenter' ) ),') ON DUPLICATE KEY UPDATE kundennummer=values(kundennummer),kostenstelle=values(kostenstelle) ');
    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;

    SET @adr:= JSON_VALUE(in_json,'$.address');
    IF @adr is null THEN SET @adr = ''; END IF;
    SET @SQL := concat('INSERT INTO blg_adr_',reporttype,' (id,adresse) values (', JSON_VALUE(in_json,'$.id' ),',@adr) ON DUPLICATE KEY UPDATE adresse=values(adresse) ');
    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;



    SET @positionid:=0;
    SET @SQL := CONCAT('SELECT ifnull(max(id),0)+1 i INTO @positionid FROM blg_pos_',reporttype);
    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;

    WHILE j < JSON_LENGTH(positions) DO
        SELECT JSON_EXTRACT(positions,CONCAT('$[',j,']')) INTO position;
        SET j:=j+1;

        SET position = JSON_SET(position,'$.reportnr',JSON_VALUE(in_json,'$.id'));
        IF JSON_VALUE(in_json,'$.isNewReport')=1 THEN
            SET position = JSON_SET(position,'$.id',@positionid);
            SET @positionid=@positionid+1;
        ELSEIF 
            JSON_VALUE(in_json,'$.isNewReport')=0 
            and JSON_EXISTS(position,'$.id') = 0
        THEN
            SET position = JSON_SET(position,'$.id',@positionid);
            SET @positionid=@positionid+1;
        END IF;

        IF JSON_EXISTS(position,'$.position') = 0 THEN
            SET position = JSON_SET(position,'$.position',j);
        END IF;

        FOR rec in (select * from blgpos_translations) DO
            IF (
                rec.is_required = 1
                and JSON_EXISTS(position,concat('$.',rec.json_attribute_name)) = 0
            ) THEN
                SET @MSG = concat('Required field ',rec.json_attribute_name,' not found in JSON');
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @MSG;
            ELSEIF JSON_EXISTS(position,concat('$.',rec.json_attribute_name)) = 1 THEN
                SET position = JSON_SET(position,concat('$.',rec.column_name), JSON_VALUE(position,concat('$.',rec.json_attribute_name)));
            END IF;
            
        END FOR;

        SET position = JSON_SET(position,'$.__id', JSON_VALUE(position,'$.id'));
        
        SET @request = JSON_OBJECT(
            'tablename',concat('blg_pos_',reporttype),
            'data',JSON_ARRAY( JSON_MERGE(position,'{}')),
            'type','insert',
            'update',1=1
        );

        call dsx_rest_api_set(@request,@result);
    END WHILE;


    call recalculateHeader(reporttype,JSON_VALUE(in_json,'$.id'));
    call getReport(reporttype,JSON_VALUE(in_json,'$.id'),out_json);
END //

/*
SET @sessionuser='thomas.hoffmann@tualo.de' //
set @log_dsx_commands=0 //
start transaction //
SET @report ='{
        "address": "Sammeldebitor     . . . . #22000 # # (0)",
        "referencenr": "22000",
        "costcenter": "0",
        "office": "100",
        "reference": "",
        "_in_warehouse": "0",
        "warehouse": "0",
        "time": "00:00:00",
        "order_id": "",
        "bookingdate": "2023-07-20",
        "reporttype": "angebot",
        "positions": [
            {
                "__id": "view_editor_blg_pos_angebot-34",
                "__table_name": "view_editor_blg_pos_angebot",
                "__rownumber": 0,
                "amount": 1,
                "article": "Muster",
                "einheit": "Stk.",
                "einheit_faktor": "1",
                "einheit_symbol": "Stk.",
                "ekpreis": "0",
                "ekpreis_summe": "0",
                "gldpreis": "0",
                "gldpreis_summe": "0",
                "handwerkeranteil": "0",
                "kombiartikel": "0",
                "tax": 19,
                "unit": "1",
                "singleprice": 5.12,
                "net": 5.12,
                "gross": 6.0927999999999995,
                "taxvalue": 0.9727999999999994,
                "account": "8400"
            }
        ],
        "date": "2023-07-20",
        "payuntildate": "2023-07-20",
        "service_period_stop": "2023-07-20",
        "service_period_start": "2023-07-20"
    }' //
set @debug=0 //
call setReportN('angebot',@report,@out) //
commit //
-- select * from test_ds_cmd //
*/
-- SOURCE FILE: ./src/000.RPTJSON.proc.setReportPosition.sql 

DELIMITER ;

/*
CREATE TABLE IF NOT EXISTS `blg_lager_wb` (
  `id` bigint(20) NOT NULL,
  `kundennummer` int(11) NOT NULL,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `ref_kundennummer` varchar(255) DEFAULT NULL,
  `gegenkonto` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_blg_lager_wb_kn` (`kundennummer`),
  CONSTRAINT `fk_blg_lager_wb` FOREIGN KEY (`kundennummer`) REFERENCES `lager` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_blg_lager_wb_id` FOREIGN KEY (`id`) REFERENCES `blg_hdr_wb` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
*/

CREATE TABLE IF NOT EXISTS blgpos_translations (
    column_name varchar(128) primary key,
    json_attribute_name varchar(128),
    is_required tinyint default 0
);

INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('id','id',1);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('beleg','reportnr',1);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('pos','position',1);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('artikel','article',1);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('anzahl','amount',1);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('epreis','singleprice',1);

INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('konto','account',0);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('steuersatz','tax',0);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('steuer','taxvalue',0);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('netto','net',0);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('brutto','gross',0);


INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('zusatztext','additionaltext',0);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('bemerkung','notes',0);
INSERT IGNORE INTO blgpos_translations (column_name,json_attribute_name,is_required) values ('referenz','reference',0);

DELIMITER //

CREATE OR REPLACE PROCEDURE setReportPosition( in reporttype varchar(20), in in_json JSON )
BEGIN
    DECLARE flds LONGTEXT default '';
    DECLARE vals LONGTEXT default '';
    DECLARE upda LONGTEXT default '';
    DECLARE v LONGTEXT default '';

    DECLARE done INT DEFAULT FALSE;

    DECLARE column_name varchar(128);
    DECLARE json_attribute_name varchar(128);
    DECLARE is_required INT DEFAULT 0;


    DECLARE c1 CURSOR FOR
    select 
        ds_column.column_name,
        ifnull(blgpos_translations.json_attribute_name,ds_column.column_name) json_attribute_name,
        ifnull(is_required,0) is_required
    from 
        ds_column 
        left join blgpos_translations
            on blgpos_translations.column_name=ds_column.column_name
    where 
        table_name=concat('blg_pos_',reporttype)
        and ds_column.existsreal = 1
        and ds_column.writeable = 1
    ;

 

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;



    -- call debug_message('setReportPosition');

call debug_message(in_json);

    OPEN c1;

    read_loop: LOOP
            FETCH c1 INTO column_name,json_attribute_name,is_required;

            If done THEN
                LEAVE read_loop;
            END IF;

            IF NOT JSON_EXISTS(in_json,concat('$.',json_attribute_name) ) THEN  
                IF is_required=1 THEN
                    SET @error_message = concat(json_attribute_name,' attribute is needed');
                    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
                END IF;
            ELSE

                SET flds := if(flds='', column_name, concat(flds,',',column_name));
                SET upda := if(upda='', concat('`',column_name,'`=values(`',column_name,'`)'), concat(upda,',',concat('`',column_name,'`=values(`',column_name,'`)')));

                call debug_message(concat('$.',json_attribute_name));

                SET v:=JSON_VALUE(in_json, concat('$.',json_attribute_name));
call debug_message(v);
                

                IF JSON_TYPE(JSON_EXTRACT(in_json, concat('$.',json_attribute_name))) <> 'NULL' THEN
                    set v:=QUOTE( v );
                ELSE
                    set v:='null';
                END IF;

                SET vals := if(vals='', v ,  concat(vals,',', v ));

                

            END IF;
    END LOOP;

    CLOSE c1;
    

   
call debug_message(flds);
call debug_message(vals);
call debug_message(upda);

    SET @SQL := CONCAT('INSERT INTO blg_pos_',reporttype,' (',flds,') values (',vals,') on duplicate key update ',upda);


    -- call debug_message( @SQL);


    PREPARE stmt FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;


END //
-- SOURCE FILE: ./src/000.RPTJSON.proc.setReportTSE.sql 
DELIMITER //


DROP PROCEDURE IF EXISTS setReportTSE //
CREATE PROCEDURE setReportTSE( in reporttype varchar(20), in in_json JSON, out out_json JSON )
BEGIN

    DECLARE i INTEGER DEFAULT 0;
    DECLARE tses LONGTEXT;
    DECLARE tse LONGTEXT;



    IF JSON_EXISTS(in_json,'$.tse') THEN 
        SELECT JSON_EXTRACT(in_json,'$.tse') INTO tses;
        SET i:=0;
        WHILE i < JSON_LENGTH(tses) DO
            SELECT JSON_EXTRACT(tses,CONCAT('$[',i,']')) INTO tse;

            SET @USQL = concat( 'insert into blg_tse_',reporttype,' 
                (
                    `reportnr`,
                    `transaction_type`,
                    `process_type`,
                    `process_data`,
                    `hardware_id`,                   
                    `tse_id`,
                    `tse_error`,
                    `tse_transactionnumber`,
                    `tse_signature`,
                    `tse_time`,
                    `tse_signature_count`
                ) values (' , 

                    @use_rptnr, ',' ,
                    quote( JSON_VALUE(tse,'$.transaction_type')), ',' ,
                    quote( JSON_VALUE(tse,'$.process_type')), ',' ,
                    quote( JSON_VALUE(tse,'$.process_data')), ',' ,
                    quote( JSON_VALUE(tse,'$.hardware_id')), ',' ,
                    quote( JSON_VALUE(tse,'$.tse_id')), ',' ,
                    quote( JSON_VALUE(tse,'$.tse_error')), ',' ,
                    quote( JSON_VALUE(tse,'$.tse_transactionnumber')), ',' ,
                    quote( JSON_VALUE(tse,'$.tse_signature')), ',' ,
                    quote( JSON_VALUE(tse,'$.tse_time')), ',' ,
                    JSON_VALUE(tse,'$.tse_signature_count'),
                    
                ') on duplicate key update 
                    `process_type`=values(`process_type`),
                    `process_data`=values(`process_data`),
                    `hardware_id`=values(`hardware_id`),                   
                    `tse_id`=values(`tse_id`),
                    `tse_error`=values(`tse_error`),
                    `tse_transactionnumber`=values(`tse_transactionnumber`),
                    `tse_signature`=values(`tse_signature`),
                    `tse_time`=values(`tse_time`),
                    `tse_signature_count`=values(`tse_signature_count`)
                ');


            PREPARE stmt FROM @USQL;
            execute stmt;
            DEALLOCATE PREPARE stmt;

            SET i:=i+1;
        END WHILE;
    END IF;

    SELECT @tempout  INTO out_json;
END //
-- SOURCE FILE: ./src/000.TBL.wb_artikel_combinations.sql 
DELIMITER ;

CREATE TABLE IF NOT EXISTS `wb_artikel_combinations` (

  `trigger_article` varchar(255) DEFAULT NULL,
  `result_article` varchar(255) DEFAULT NULL,
  `result_factor` decimal(15,6) DEFAULT 1.000000,

  PRIMARY KEY(`trigger_article`,`result_article`),
  
  CONSTRAINT `fk_wb_artikel_combinations_result_factor` FOREIGN KEY (`result_article`) REFERENCES `artikelgruppen` (`gruppe`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wb_artikel_combinations_trigger_article` FOREIGN KEY (`trigger_article`) REFERENCES `artikelgruppen` (`gruppe`) ON DELETE CASCADE ON UPDATE CASCADE
);
-- SOURCE FILE: ./src/010.view.bkr_config.sql 
DELIMITER //
create view if not exists view_readtable_blg_config_buchungskreis as
select '0000' buchungskreis_id,id blg_id,belegnummer_von von,belegnummer_bis bis from blg_config

//

-- create unique index idx_blg_pos_wb_fid_fzusatz on  blg_pos_wb(fid,fzusatz)

-- SOURCE FILE: ./src/calculateGLD.sql 
DELIMITER //
CREATE OR REPLACE FUNCTION `calculateGLD`( in_booking_circle varchar(20), in_report_nr bigint ) 
RETURNS varchar(10)
READS SQL DATA
COMMENT ''
BEGIN 
    DECLARE fld varchar(10);
    DECLARE result varchar(10);

    SELECT
        artikel,
        (wert_alt+wert_neu/(menge_alt+menge_neu)) gld
    INTO
        @nonce,
        result
    from 

    (
        SELECT

            blg_pos_wb.artikel,
            blg_bkr_wb.buchungskreis_id,
            sum( blg_pos_wb.anzahl ) menge_alt,
            ifnull(bewertungspreis.epreis,0) * sum( blg_pos_wb.anzahl ) wert_alt

        FROM
            blg_pos_wb
            join ( select artikel,blg_bkr_wb.buchungskreis_id from blg_pos_wb join blg_bkr_wb on blg_pos_wb.beleg = blg_bkr_wb.id where blg_pos_wb.beleg = in_report_nr ) nblg 
                on blg_pos_wb.artikel = nblg.artikel and artikel.buchungskreis_id=nblg.buchungskreis_id
            left join bewertungspreis on blg_pos_wb.artikel <> bewertungspreis.gruppe and bewertungspreis.typ='GLD'

        WHERE
            blg_pos_wb.id < (
                select min(id) from blg_pos_wb where beleg = in_report_nr
            )
        GROUP BY blg_pos_wb.artikel
    ) alt join 
    (
        SELECT
            blg_pos_wb.artikel,
            sum( blg_pos_wb.anzahl ) menge_neu,
            sum( blg_pos_wb.preis * blg_pos_wb.anzahl ) wert_neu
        FROM
            (select * from blg_pos_wb where beleg = in_report_nr ) blg_pos_wb
            left join bewertungspreis on blg_pos_wb.artikel <> bewertungspreis.gruppe and bewertungspreis.typ='GLD'
        GROUP BY blg_pos_wb.artikel
    ) neu
    on alt.artikel = neu.artikel;

    return result;
END //

