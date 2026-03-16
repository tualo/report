DELIMITER //
CREATE OR REPLACE PROCEDURE checkReportRequirements(in reporttype varchar(20), in in_json JSON) 
BEGIN 
    IF NOT JSON_VALID(in_json) THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "JSON not valid";
    END IF;
    IF NOT JSON_EXISTS(in_json, '$.referencenr') THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Missing attribute referencenr";
    END IF;
    IF NOT JSON_EXISTS(in_json, '$.positions') THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Missing attribute positions";
    END IF;
    IF NOT JSON_TYPE(JSON_EXTRACT(in_json, '$.positions')) = 'ARRAY' THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Attribute positions has to be an array";
    END IF;
    IF JSON_LENGTH(JSON_EXTRACT(in_json, '$.positions')) = 0 THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Attribute positions has no elements";
    END IF;
    SET @ref := NULL;
    SELECT concat(
            'SELECT concat(',
            ' `',
            bezug_id,
            '`,\'|\',',
            if(
                bezug_kst is null
                or bezug_kst = '0',
                '0',
                concat('`', bezug_kst, '`')
            ),
            ' ',
            ') x ',
            'INTO @ref ',
            'FROM `',
            adress_bezug,
            '` ',
            'WHERE ( `',
            bezug_id,
            '`,',
            if(
                bezug_kst is null
                or bezug_kst = '0',
                '0',
                concat('`', bezug_kst, '`')
            ),
            ' ) = (\'',
            JSON_VALUE(in_json, '$.referencenr'),
            '\',0)'
        ) INTO @SQL
    FROM blg_config
    WHERE tabellenzusatz = reporttype;
    call debug_message(@SQL);
    call debug_message(reporttype);
    PREPARE stmt
    FROM @SQL;
    execute stmt;
    DEALLOCATE PREPARE stmt;
    IF @ref IS NULL THEN
    select in_json;
    SET @error = concat(
            "reference error: ",
            JSON_VALUE(in_json, '$.referencenr'),
            ' reporttype ',
            reporttype
        );
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = @error;
    END IF;
END // -- SOURCE FILE: ./src/000.RPTJSON.proc.get.sql 
DELIMITER //