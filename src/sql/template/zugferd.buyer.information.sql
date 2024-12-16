DELIMITER //


CREATE OR REPLACE TRIGGER blg_hdr_#####_ai_buyer_information
AFTER INSERT ON blg_hdr_##### FOR EACH ROW
BEGIN
        for record in (
        select 
            r.line1,
            r.line2,
            r.line3,
            r.postcode,
            r.city
        from 
            view_readtable_buyer_relation_##### r
            join blg_#BEZ#_##### b
                on  (r.referencenr,r.costcenter) = (b.kundennummer,b.kostenstelle)

        where b.id = new.id
     ) do


        insert ignore into blg_buyer_##### (
            `id`,
            `key`,
            `val`
        ) values
        (
            new.id,
            'line1',
            record.line1
        ),
        (
            new.id,
            'line2',
            record.line2
        ),
        (
            new.id,
            'line3',
            record.line3
        ),
        (
            new.id,
            'postcode',
            record.postcode
        ),
        (
            new.id,
            'city',
            record.city
        );

     end for;
END //



CREATE OR REPLACE TRIGGER blg_hdr_#####_au_buyer_information
AFTER UPDATE ON blg_hdr_##### FOR EACH ROW
BEGIN
    for record in (
        select 
            r.line1,
            r.line2,
            r.line3,
            r.postcode,
            r.city
        from 
            view_readtable_buyer_relation_##### r
            join blg_#BEZ#_##### b
                on  (r.referencenr,r.costcenter) = (b.kundennummer,b.kostenstelle)

        where b.id = new.id
     ) do


        insert ignore into blg_buyer_##### (
            `id`,
            `key`,
            `val`
        ) values
        (
            new.id,
            'line1',
            record.line1
        ),
        (
            new.id,
            'line2',
            record.line2
        ),
        (
            new.id,
            'line3',
            record.line3
        ),
        (
            new.id,
            'postcode',
            record.postcode
        ),
        (
            new.id,
            'city',
            record.city
        );

     end for;
END //