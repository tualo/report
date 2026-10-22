CREATE  function  if not exists `findAccountNumber`(article_id bigint,  steuerschluessel varchar(36) ,use_date date) RETURNS varchar(255) 
    DETERMINISTIC
BEGIN 
    DECLARE result varchar(255);

    select 
        -- bfkonten_steuersatz.steuergruppen,
        -- bfkonten_steuersatz.gueltig_von,
        -- bfkonten_steuersatz.gueltig_bis,
        max(bfkonten_steuersatz.konto) as konto
        -- bfkonten_steuersatz.steuer,
        -- bfkonten_zuordnung.gruppen_id
    INTO result
    from 
        bfkonten_steuersatz
        join bfkonten on bfkonten_steuersatz.id = bfkonten.id    
        join bfkonten_zuordnung on bfkonten_zuordnung.konto_id = bfkonten.id
    where 
        bfkonten_zuordnung.gruppen_id = article_id
        and bfkonten_steuersatz.steuergruppen = steuerschluessel
        and bfkonten_steuersatz.gueltig_von <= use_date
        and bfkonten_steuersatz.gueltig_bis >= use_date;
    RETURN result;
END //

CREATE  function  if not exists `findTaxRate`(article_id bigint,  steuerschluessel varchar(36) ,use_date date) RETURNS decimal(10,2) 
    DETERMINISTIC
BEGIN 
    DECLARE result decimal(10,2);

    select 
        -- bfkonten_steuersatz.steuergruppen,
        -- bfkonten_steuersatz.gueltig_von,
        -- bfkonten_steuersatz.gueltig_bis,
        max(bfkonten_steuersatz.steuer) as steuer
        -- bfkonten_steuersatz.steuer,
        -- bfkonten_zuordnung.gruppen_id
    INTO result
    from 
        bfkonten_steuersatz
        join bfkonten on bfkonten_steuersatz.id = bfkonten.id    
        join bfkonten_zuordnung on bfkonten_zuordnung.konto_id = bfkonten.id
    where 
        bfkonten_zuordnung.gruppen_id = article_id
        and bfkonten_steuersatz.steuergruppen = steuerschluessel
        and bfkonten_steuersatz.gueltig_von <= use_date
        and bfkonten_steuersatz.gueltig_bis >= use_date;
    RETURN result;
END //



select 
    a.steuerschluessel,
    p.artikel,
    p.konto,
    p.steuersatz,

    findAccountNumber(p.artikel,a.steuerschluessel,curdate()) x,
    findTaxRate(p.artikel,a.steuerschluessel,curdate()) y

from 
    blg_pos_calculation p
    join blg_hdr_calculation h
        on p.beleg = h.id
        and h.datum>='2026-01-01'
    join tualo_job j
        on j.id = h.jobid
    join adressen a
        on (j.kundennummer,j.kostenstelle) = (a.kundennummer,a.kostenstelle)
having  
    steuersatz<>y

create procedure if not exists `correctTaxRateDiscrepancy`()
BEGIN

    for recs in (
        select 
            p.id,
            a.steuerschluessel,
            p.artikel,
            p.konto,
            p.steuersatz,

            findAccountNumber(p.artikel,a.steuerschluessel,h.datum) x,
            findTaxRate(p.artikel,a.steuerschluessel,h.datum) y

        from 
            blg_pos_calculation p
            join blg_hdr_calculation h
                on p.beleg = h.id
                and h.datum>='2026-01-01'
            join tualo_job j
                on j.id = h.jobid
                and j.status in (
                    1,
                    2,
                    3,
                    4
                )
            join adressen a
                on (j.kundennummer,j.kostenstelle) = (a.kundennummer,a.kostenstelle)
        having  
            steuersatz<>y
            and konto =0
        limit 100
    ) do
        -- You can add your processing logic here, for example:
        /*
        IF (new.steuer <> (new.netto * (0+new.steuersatz/100))) THEN
     SET new.steuer = (new.netto * (0+new.steuersatz/100));
   END IF;
   SET NEW.brutto = new.netto + new.steuer;
        */
        update blg_pos_calculation set steuersatz = recs.y, konto = recs.x where id = recs.id;
        update blg_pos_calculation set steuer = (netto * (0+recs.y/100)), brutto = (netto + (netto * (0+recs.y/100))) where id = recs.id;
    end for;
END //
