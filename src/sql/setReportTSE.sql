delimiter //
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