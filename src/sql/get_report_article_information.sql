DELIMITER //    

CREATE OR REPLACE PROCEDURE `reportArticleInformation`( in request JSON, out result JSON )
BEGIN

    SET result = JSON_OBJECT();

    SET result = JSON_INSERT(result,'$.tax', 0);
    SET result = JSON_INSERT(result,'$.singleprice', 0);
    SET result = JSON_INSERT(result,'$.account', 0);
    SET result = JSON_INSERT(result,'$.unit', 1);


    SELECT id,adress_bezug,konten_bezug,preis_bezug into @BLG_ID, @ADR, @KNT,@PREISBEZUG from blg_config where tabellenzusatz=JSON_VALUE(request,'$.header.reporttype');
    SELECT feld INTO @FLD FROM steuergruppen where steuergruppe = @KNT;
    SET @PREISKATEGORIE = (select min(preiskategorie) from staffeln where gruppe =JSON_VALUE(request,'$.position.article'));

    SET result = JSON_SET(result,'$.KNT',@KNT);

    IF 
        JSON_EXISTS(request,'$.header.referencenr') = 1 
        and @ADR='adressen'
    THEN
        SELECT steuerschluessel,preiskategorie INTO @STEUERSCHLUESSEL,@PREISKATEGORIE 
        FROM adressen where kundennummer = JSON_VALUE(request,'$.header.referencenr') and kostenstelle = JSON_VALUE(request,'$.header.costcenter') ;
        SELECT ifnull(feld,'') INTO @FLD FROM steuergruppen where steuergruppe = IF (@KNT='steuerschluessel',@STEUERSCHLUESSEL,@KNT);
        SET result = JSON_SET(result,'$.STEUERSCHLUESSEL',@STEUERSCHLUESSEL);
        SET result = JSON_SET(result,'$.PREISKATEGORIE',@PREISKATEGORIE);

    END IF;

    IF @PREISBEZUG is NULL THEN
        set @PREISBEZUG = 'epreis';
    END IF;

    IF @FLD is NULL THEN
        set @FLD = '';
    END IF;

    SET @SQL = concat('
        select 
            staffeln.`',@PREISBEZUG,'` as `usepreis`,
            mengeneinheiten.id mengeneinheit
        into @usepreis,@mengeneinheit
        from
            `staffeln` 
            join `artikelgruppen`
        on 
            `artikelgruppen`.`gruppe` = `staffeln`.`gruppe`
            and `artikelgruppen`.`gruppe` = ',QUOTE(IFNULL(JSON_VALUE(request,'$.position.article'),'')),'
            and (`staffeln`.`json_formel` = "" or `staffeln`.`json_formel` is null)
            and `staffeln`.`von` <= ',IFNULL(JSON_VALUE(request,'$.position.amount'),0),'
            and `staffeln`.`bis` >= ',IFNULL(JSON_VALUE(request,'$.position.amount'),0),'
            and `staffeln`.`zeitraum_von` <= ',QUOTE(IFNULL(JSON_VALUE(request,'$.header.service_period_stop'),curdate())),'
            and `staffeln`.`zeitraum_bis` >= ',QUOTE(IFNULL(JSON_VALUE(request,'$.header.service_period_stop'),curdate())),'
            and `staffeln`.`preiskategorie` = ',@PREISKATEGORIE,'                                      
        left join bfkonten_zuordnung
            on bfkonten_zuordnung.gruppe = artikelgruppen.gruppe
        left join bfkonten 
            on bfkonten_zuordnung.konto_id = bfkonten.id
            and `bfkonten`.`gueltig_von` <= ',QUOTE(IFNULL(JSON_VALUE(request,'$.header.service_period_stop'),curdate())),'
            and `bfkonten`.`gueltig` >= ',QUOTE(IFNULL(JSON_VALUE(request,'$.header.service_period_stop'),curdate())),'

        left join mengeneinheiten
            on artikelgruppen.einheit=mengeneinheiten.id
        LIMIT 1
    ');

    PREPARE stmt FROM @SQL;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
 
    SET result = JSON_SET(result,'$.singleprice',@usepreis);
    SET result = JSON_SET(result,'$.unit',@mengeneinheit);

    SET @SQL = concat('
        SELECT
            bfkonten.konto',@FLD,' as account,
            bfkonten.steuer',@FLD,' as tax
        INTO @account,@tax
        FROM  
            bfkonten_zuordnung
            join bfkonten
                on 
                    bfkonten_zuordnung.konto_id = bfkonten.id
                    and bfkonten_zuordnung.gruppe = ',QUOTE(IFNULL(JSON_VALUE(request,'$.position.article'),'')),'
                    and `bfkonten`.`gueltig_von` <= ',QUOTE(IFNULL(JSON_VALUE(request,'$.header.service_period_stop'),curdate())),'
                    and `bfkonten`.`gueltig` >= ',QUOTE(IFNULL(JSON_VALUE(request,'$.header.service_period_stop'),curdate())),'
        LIMIT 1
    ');
    SET result = JSON_SET(result,'$.FLD',@FLD);

    PREPARE stmt FROM @SQL;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
 
    SET result = JSON_SET(result,'$.account',@account);
    SET result = JSON_SET(result,'$.tax',@tax);
    
END //



set @test = '{
    "header": {
        "referencenr": "10001",
        "costcenter": "0",
        "office": "100",
        "date": "28.03.2023",
        "payuntildate": "07.04.2023",
        "service_period_start": "2023-03-28",
        "service_period_stop": "2023-03-28",
        "reference": "",
        "bookingdate": "2023-03-28",
        "reporttype": "angebot"
    },
    "position": {
        "__id": "view_editor_blg_pos_angebot-2",
        "id": null,
        "__table_name": "view_editor_blg_pos_angebot",
        "__rownumber": 0,
        "additionaltext": null,
        "amount": null,
        "anzahl": null,
        "article": "Muster",
        "artikel": null,
        "beleg": null,
        "bemerkung": null,
        "bereich": null,
        "bezugsnebenkosten": null,
        "brutto": null,
        "einheit": "Stk.",
        "einheit_angebotktor": null,
        "einheit_faktor": "1",
        "einheit_symbol": "Stk.",
        "einspeiserkennzeichen": null,
        "ekpreis": "0",
        "ekpreis_summe": "0",
        "epreis": null,
        "fremdbezeichnung": null,
        "gewicht": null,
        "gldpreis": "0",
        "gldpreis_summe": "0",
        "handwerkeranteil": "0",
        "kombiartikel": "0",
        "konto": null,
        "netto": null,
        "notes": null,
        "pos": null,
        "preistyp": null,
        "referenz": null,
        "steuer": null,
        "steuersatz": null,
        "tax": null,
        "vdatum": null,
        "vid": null,
        "vzusatz": null,
        "zid": null,
        "zusatztext": null,
        "zzusatz": null,
        "singleprice": "0",
        "net": "0",
        "gross": "0",
        "taxvalue": 0
    }
}' //

call reportArticleInformation(@test,@result) //
select @result //
