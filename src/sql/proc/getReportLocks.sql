DELIMITER //

CREATE OR REPLACE PROCEDURE `getReportLocks`(
    in reporttype varchar(20),
    in in_id bigint,
    out result JSON
) READS SQL DATA COMMENT '' BEGIN
DECLARE base_table varchar(128);
DECLARE flds LONGTEXT;
SET @SQL = concat(
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

                select "updates" lock_type, "automatic locked"  lock_reason from blg_config where tabellenzusatz = quote(',
        reporttype,
        ') and auto_lock=1
        
                union
                select "updates" lock_type, "bookingdate noch unvollständig"       lock_reason from blg_config where tabellenzusatz = quote(',
        reporttype,
        ') and periodensperre=1

                union
                select "updates" lock_type, "allready sap"       lock_reason from blg_pos_',
        reporttype,
        ' where beleg = quote(',
        in_id,
        ') and ( sap_beleg is not null )

                union
                select "convert" lock_type, "allready converted"       lock_reason from blg_ueb_',
        reporttype,
        ' where zid = quote(',
        in_id,
        ')
                
                union
                select "convert" lock_type, "allready positions converted"       lock_reason from blg_pos_',
        reporttype,
        ' where beleg = quote(',
        in_id,
        ') and ( zid is not null )

    ) a
    '
    );
PREPARE stmt
FROM @SQL;
execute stmt;
DEALLOCATE PREPARE stmt;
SET result = JSON_MERGE("[]", @result);
END // 