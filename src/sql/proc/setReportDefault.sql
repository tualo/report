DELIMITER //
CREATE OR REPLACE PROCEDURE setReportDefault(
        in reporttype varchar(20),
        in in_json JSON,
        out out_json JSON
) BEGIN
    DECLARE strval varchar(255);
    DECLARE text JSON;

    SELECT JSON_INSERT(in_json, '$.__messages', JSON_ARRAY()) INTO in_json;
    SET in_json = JSON_ARRAY_APPEND(in_json, '$.__messages', 'begin defaults');
    SET in_json = JSON_INSERT(in_json, '$.isNewReport', 1 = 0);
    IF JSON_EXISTS(in_json, '$.id') = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(in_json, '$.__messages', 'id not set -> set to -1');
        SELECT JSON_INSERT(in_json, '$.id', -1) INTO in_json;
    END IF;

    IF JSON_VALUE(in_json, '$.id') > 0 THEN
        SET @old_rn = null;
        SET @SQL := CONCAT(
            'select id into @old_rn from blg_hdr_',
            reporttype,
            ' where id = ',
            json_value(in_json, '$.id'),
            ' '
        );
        PREPARE stmt
        FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;

        if @old_rn is null then
            set @newrptnr = JSON_VALUE(in_json, '$.id');
            SET in_json = JSON_ARRAY_APPEND(
                    in_json,
                    '$.__messages',
                    concat('new reportnumber the given one was not found')
                );
            SET in_json = JSON_SET(in_json, '$.isNewReport', 1 = 1);
        end if;
    END IF;
    IF JSON_VALUE(in_json, '$.id') < 0 THEN
        SET in_json = JSON_ARRAY_APPEND(
                in_json,
                '$.__messages',
                concat(
                    'new id requested, query getReportNumber',
                    reporttype,
                    '()'
                )
            );
        SET @SQL := CONCAT(
                'set @newrptnr = getReportNumber',
                reporttype,
                '()   '
            );
        PREPARE stmt
        FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;
        SELECT JSON_SET(in_json, '$.id', @newrptnr) INTO in_json;
        SET in_json = JSON_SET(in_json, '$.isNewReport', 1 = 1);
        SET in_json = JSON_ARRAY_APPEND(
                in_json,
                '$.__messages',
                concat('new id requested, set to ', @newrptnr, '')
            );
    END IF;
    IF NOT JSON_EXISTS(in_json, '$._in_warehouse') THEN
        SELECT JSON_INSERT(in_json, '$._in_warehouse', 0) INTO in_json;
    END IF;
    IF NOT JSON_EXISTS(in_json, '$.payuntildate') THEN
        SELECT JSON_INSERT(
                in_json,
                '$.payuntildate',
                curdate() + interval + 10 day
            ) INTO in_json;
    END IF;
    IF NOT JSON_EXISTS(in_json, '$.reference') THEN
        SELECT JSON_INSERT(in_json, '$.reference', '') INTO in_json;
    END IF;

    IF JSON_EXISTS(in_json, '$.costcenter') = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(
                in_json,
                '$.__messages',
                'costcenter not set -> set to 0'
            );
        SELECT JSON_INSERT(in_json, '$.costcenter', 0) INTO in_json;
    END IF;

    IF JSON_EXISTS(in_json, '$.date') = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(
                in_json,
                '$.__messages',
                'date not set -> set to current date'
            );
        SELECT JSON_INSERT(in_json, '$.date', CURRENT_DATE) INTO in_json;
    END IF;

    IF JSON_EXISTS(in_json, '$.service_period_start') = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(
            in_json,
            '$.__messages',
            'service_period_start not set -> set to current date'
        );
        SELECT JSON_INSERT(in_json, '$.service_period_start', CURRENT_DATE) INTO in_json;
    END IF;

    IF JSON_EXISTS(in_json, '$.service_period_stop') = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(
            in_json,
            '$.__messages',
            'service_period_stop not set -> set to current date'
        );
        SELECT JSON_INSERT(in_json, '$.service_period_stop', CURRENT_DATE) INTO in_json;
    END IF;
    IF JSON_EXISTS(in_json, '$.bookingdate') = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(
            in_json,
            '$.__messages',
            'bookingdate not set -> set to current date'
        );
        SELECT JSON_INSERT(in_json, '$.bookingdate', CURRENT_DATE) INTO in_json;
    END IF;
    IF JSON_EXISTS(in_json, '$.companycode') = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(
            in_json,
            '$.__messages',
            'companycode not set -> set to session default'
        );
        SELECT JSON_INSERT(in_json, '$.companycode', getSessionDefaultBKR()) INTO in_json;
    END IF;
    IF JSON_EXISTS(in_json, '$.kindofbill') = 0 THEN
        SET in_json = JSON_ARRAY_APPEND(
            in_json,
            '$.__messages',
            'kindofbill not set -> query'
        );
        SELECT max(preisorientierung) INTO strval
        FROM blg_config
        WHERE lower(tabellenzusatz) = lower(reporttype);
        SELECT JSON_INSERT(in_json, '$.kindofbill', strval) INTO in_json;
        SET in_json = JSON_ARRAY_APPEND(
            in_json,
            '$.__messages',
            concat('kindofbill not set -> ', strval)
        );
    END IF;
    SET in_json := JSON_INSERT(in_json, '$.create_timestamp', now());
    SET in_json := JSON_INSERT(in_json, '$.login', getSessionUser());
    SELECT in_json INTO out_json;
END //
