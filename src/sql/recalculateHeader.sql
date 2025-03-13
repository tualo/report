DELIMITER //

CREATE  or replace PROCEDURE `recalculateHeader`(IN tabellenzusatz varchar(50),  IN in_reportnumber bigint)
    MODIFIES SQL DATA
BEGIN

    DECLARE use_kn varchar(10);
    DECLARE use_ks integer;

    DECLARE use_s fixed(15,6);
    DECLARE use_n fixed(15,6);
    DECLARE use_b fixed(15,6);
    

    SET @SQL = concat('
        SELECT 
            round(sum(steuer),2) s,
            round(sum(netto),2) n,
            round(sum(brutto),2) b 
        INTO
            @use_s,
            @use_n,
            @use_b
        FROM 
            blg_pos_',tabellenzusatz,'
        WHERE 
            beleg = ?
    ');



    PREPARE stmt FROM @SQL;
    execute stmt using in_reportnumber;
    DEALLOCATE PREPARE stmt;

    SET @SQL = concat('UPDATE 
        blg_hdr_',tabellenzusatz,'
    SET 
        netto = ?,
        brutto = ?,
        steuer = ?-?,
        offen = ? - ifnull( (select sum(betrag) from ( 
            select betrag from blg_pay_',tabellenzusatz,' where belegnummer=? union all 
            select betrag from blg_min_',tabellenzusatz,' where belegnummer=? ) x ), 0)
    WHERE
        id = ?
    '); 

    PREPARE stmt FROM @SQL;
    execute stmt using @use_n,@use_b,@use_b,@use_n,@use_b, in_reportnumber, in_reportnumber, in_reportnumber;
    DEALLOCATE PREPARE stmt;
END //