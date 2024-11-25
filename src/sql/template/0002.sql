DELIMITER //

CREATE OR REPLACE FUNCTION /*IF NOT EXISTS*/ `getReport_#####`(  in_id bigint ) 
RETURNS JSON 
READS SQL DATA 
BEGIN 
    DECLARE result LONGTEXT;
    DECLARE positions LONGTEXT;
    DECLARE signum LONGTEXT;
    DECLARE payments LONGTEXT;
    DECLARE txt LONGTEXT;
    DECLARE reductions LONGTEXT;

    DECLARE taxregistration JSON;
    DECLARE buyerinformation JSON;
    DECLARE sellerinformation JSON;
    DECLARE seller_global_ids JSON;
    DECLARE taxes JSON;



    SET result = "{}";

    select  concat("[",ifnull(group_concat( 
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
            separator ","
        ),"")
        ,"]"
        ) o 
    INTO positions
    FROM blg_pos_##### 
    WHERE beleg = in_id;

    select  concat("[",ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "date", datum, 
                "type",art, 
                "value",betrag

            )
            separator ","
        ),"")
        ,"]"
    ) o 
    INTO payments
    FROM blg_pay_##### 
    WHERE belegnummer = in_id;

    SELECT  concat("[",ifnull(group_concat( 
        JSON_OBJECT( 

                "id", id,
                "type", name, 
                "note", bemerkung, 
                "value",betrag

            )
            separator ","
        ),"")
        ,"]"
    ) o 
    INTO reductions
    FROM blg_min_##### 
    WHERE belegnummer = in_id;


    SELECT  concat("[",ifnull(group_concat( 
        JSON_OBJECT( 

                "pos", pos,
                "x", x,
                "y", y
            )
            separator ","
        ),"")
        ,"]"
    ) o 
    INTO signum
    FROM blg_signum_##### 
    WHERE id = in_id;



    SELECT  concat("[",ifnull(group_concat( 
        JSON_OBJECT( 

                "type", typ,
                "text", text
            )
            separator ","
        ),"")
        ,"]"
    ) o 
    INTO txt
    FROM blg_txt_##### 
    WHERE id = in_id;


    SELECT  
        JSON_OBJECTAGG( `key`, `val` )
    INTO taxregistration
    FROM 
        blg_taxregistration_##### 
    WHERE id = in_id;


    SELECT 
        JSON_OBJECTAGG( `key`, `val` )
    INTO 
        sellerinformation
    FROM 
        blg_seller_##### 
    WHERE id = in_id;


    SELECT 
        JSON_OBJECTAGG( `key`, `val` )
    INTO 
        buyerinformation
    FROM 
        blg_buyer_##### 
    WHERE id = in_id;

    SELECT 
        JSON_OBJECTAGG( `key`, `val` )
    INTO 
        seller_global_ids
    FROM 
        blg_seller_globalid_##### 
    WHERE id = in_id;

    
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
    INTO 
        taxes
    FROM
        (
            SELECT
                beleg, 
                steuersatz,
                'S' `category`,
                'VAT' `type`,
                steuersatz `rate`,
                sum(brutto) `gross`,
                sum(netto) `net`,
                sum(steuer) `tax`
            FROM 
                view_report_blg_taxes_##### 
            WHERE 
                id = in_id
            GROUP BY 
                beleg, 
                steuersatz 
        ) x
    ;


    SELECT JSON_OBJECT(

        "id", hdr.id,
        "date", hdr.datum,
        "bookingdate", hdr.buchungsdatum,
        "service_period_start", hdr.zeitraum_von,
        "service_period_stop", hdr.zeitraum_bis,
        "warehouse", hdr.von_lager,
        "reference", hdr.referenz,
        "address", ifnull(adr.adresse,""),
        "companycode", ifnull(bkr.buchungskreis_id,"0000"),
        "office", hdr.geschaeftsstelle,

        "login", hdr.login,

        "referencenr", bez.kundennummer,
        "costcenter", bez.kostenstelle,


        "zbeleg", hdr.zbeleg,
        "zbeleg_zusatz", hdr.zbeleg_zusatz,

        "gross", hdr.brutto,
        "net", hdr.netto,
        "steuer", hdr.steuer,
        "payed", hdr.bezahlt,
        "open", hdr.offen,
        

        "positions",JSON_MERGE("[]",positions),
        "payments",JSON_MERGE("[]",payments),
        "reductions",JSON_MERGE("[]",reductions),
        "signum",JSON_MERGE("[]",signum),
        "texts",JSON_MERGE("[]",txt),

        "tax_registration",     ifnull(taxregistration,JSON_OBJECT()),
        "buyer_information",    ifnull(buyerinformation,JSON_OBJECT()),
        "seller_information",   ifnull(sellerinformation,JSON_OBJECT()),
        "seller_global_ids",    ifnull(seller_global_ids,JSON_OBJECT()),

        "taxes", JSON_MERGE("[]", taxes )

    ) 
    INTO result

    FROM 
        blg_hdr_##### hdr
        LEFT JOIN blg_adr_##### adr ON hdr.id = adr.id
        LEFT JOIN blg_bkr_##### bkr ON bkr.id = hdr.id
        LEFT JOIN blg_#BEZ#_##### bez ON bez.id = hdr.id
    WHERE hdr.id = in_id;

    RETURN result;
END //


CREATE FUNCTION IF NOT EXISTS `getReportNumber#####`()
RETURNS BIGINT DETERMINISTIC
BEGIN

    DECLARE res BIGINT;
    DECLARE use_bkr varchar(10);

    DECLARE use_von BIGINT;
    DECLARE use_bis BIGINT;
    DECLARE use_blg_id INTEGER;



    select max(id) INTO use_blg_id from blg_config where tabellenzusatz = '#####';
    select getSessionCurrentBKR() INTO use_bkr;
    IF (use_bkr='0000') THEN 
        select getSessionDefaultBKR() INTO use_bkr;
    END IF ;

    select min(von),max(bis)  into use_von,use_bis from view_readtable_blg_config_buchungskreis where buchungskreis_id=use_bkr and blg_id = use_blg_id;


    SELECT ifnull(max(id)+1,use_von ) x INTO res FROM blg_hdr_##### WHERE id>=use_von and id<=use_bis;

    IF res < use_von THEN
        SET res=NULL;
    END IF;

    IF res > use_bis  THEN
        SET res=NULL;
    END IF;

    RETURN res;
END //




CREATE FUNCTION  IF NOT EXISTS  `getReportNrText#####`(bid bigint)
RETURNS varchar(100) DETERMINISTIC
BEGIN

    DECLARE res varchar(100);

    SELECT  concat( YEAR(datum),' ',month(datum),' ', id)
    INTO res FROM blg_hdr_##### WHERE id=bid;

    IF res IS NULL  THEN
        SET res=bid;
    END IF;

    RETURN res;
END //



CREATE TRIGGER IF NOT EXISTS blg_pay_#####_ai
AFTER INSERT  
ON blg_pay_##### FOR EACH ROW
BEGIN
    

    update blg_hdr_##### set letzte_zahlung_datum=NEW.datum,letzte_zahlung=DATEDIFF(NEW.datum,datum)  where id = NEW.belegnummer;
    update blg_hdr_##### set bezahlt = ifnull((select sum(betrag) from blg_pay_##### where blg_pay_#####.belegnummer = NEW.belegnummer ),0) where id= NEW.belegnummer;
    update blg_hdr_##### set minderung = ifnull((select sum(betrag) from blg_min_##### where blg_min_#####.belegnummer = NEW.belegnummer ),0) where id= NEW.belegnummer;
    update blg_hdr_##### set offen = brutto-bezahlt-minderung   where id= NEW.belegnummer;
    

END //  


CREATE TRIGGER IF NOT EXISTS blg_pay_#####_au
AFTER UPDATE  
ON blg_pay_##### FOR EACH ROW
BEGIN
    

    update blg_hdr_##### set letzte_zahlung_datum=NEW.datum,letzte_zahlung=DATEDIFF(NEW.datum,datum)  where id = NEW.belegnummer;
    update blg_hdr_##### set bezahlt = ifnull((select sum(betrag) from blg_pay_##### where blg_pay_#####.belegnummer = NEW.belegnummer ),0) where id= NEW.belegnummer;
    update blg_hdr_##### set minderung = ifnull((select sum(betrag) from blg_min_##### where blg_min_#####.belegnummer = NEW.belegnummer ),0) where id= NEW.belegnummer;
    update blg_hdr_##### set offen = brutto-bezahlt-minderung   where id= NEW.belegnummer;
    

END //  
