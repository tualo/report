CREATE OR REPLACE TRIGGER blg_hdr_rechnung_bi_defaults
BEFORE INSERT ON blg_hdr_rechnung FOR EACH ROW
BEGIN

    IF not exists(
        select 1 from buchungskreise where id = new.buchungskreis
    ) then
        set new.buchungskreis = (select id from buchungskreise limit 1);
    end if;
    
END;