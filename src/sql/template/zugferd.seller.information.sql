DELIMITER //

alter table buchungskreise add if not exists tax_id varchar(255) default '' //

CREATE OR REPLACE TRIGGER blg_hdr_#####_ai_seller_information
AFTER INSERT ON blg_hdr_##### FOR EACH ROW
BEGIN
    for record in (
        select 
            id,
            name,
            vat_id,
            tax_id,
            firmen_name,
            firmen_strasse,
            firmen_plz,
            firmen_ort
        from 
            buchungskreise 
        where id = new.buchungskreis
     ) do

        if (record.vat_id<>"") then
            insert ignore into blg_taxregistration_##### (
                `id`,
                `key`,
                `val`
            ) values
            (
                new.id,
                'VA',
                record.vat_id
            );
        end if;


        if (record.tax_id<>"") then
            insert ignore into blg_taxregistration_##### (
                `id`,
                `key`,
                `val`
            ) values
            (
                new.id,
                'FC',
                record.tax_id
            );
        end if;

        insert ignore into blg_seller_##### (
            `id`,
            `key`,
            `val`
        ) values
        (
            new.id,
            'line1',
            record.firmen_name
        ),
        (
            new.id,
            'line3',
            record.firmen_strasse
        ),
        (
            new.id,
            'postcode',
            record.firmen_plz
        ),
        (
            new.id,
            'city',
            record.firmen_ort
        );

     end for;
END //



CREATE OR REPLACE TRIGGER blg_hdr_#####_au_seller_information
AFTER UPDATE ON blg_hdr_##### FOR EACH ROW
BEGIN
    for record in (
        select 
            id,
            name,
            vat_id,
            tax_id,
            firmen_name,
            firmen_strasse,
            firmen_plz,
            firmen_ort
        from 
            buchungskreise 
        where id = new.buchungskreis
     ) do


        if (record.vat_id<>"") then
            insert ignore into blg_taxregistration_##### (
                `id`,
                `key`,
                `val`
            ) values
            (
                new.id,
                'VA',
                record.vat_id
            );
        end if;


        if (record.tax_id<>"") then
            insert ignore into blg_taxregistration_##### (
                `id`,
                `key`,
                `val`
            ) values
            (
                new.id,
                'FC',
                record.tax_id
            );
        end if;

        insert ignore into blg_seller_##### (
            `id`,
            `key`,
            `val`
        ) values
        (
            new.id,
            'line1',
            record.firmen_name
        ),
        (
            new.id,
            'line3',
            record.firmen_strasse
        ),
        (
            new.id,
            'postcode',
            record.firmen_plz
        ),
        (
            new.id,
            'city',
            record.firmen_ort
        );

     end for;
END //