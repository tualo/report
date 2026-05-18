

CREATE TRIGGER IF NOT EXISTS blg_pos_calculation_ai_header
AFTER INSERT  
ON blg_pos_calculation FOR EACH ROW
BEGIN
    DECLARE v_beleg VARCHAR(255);
    DECLARE v_steuer DECIMAL(15,4);
    DECLARE v_netto DECIMAL(15,4);
    DECLARE v_brutto DECIMAL(15,4);

     SELECT 
            round(ifnull(sum(steuer),0),4) s,
            round(ifnull(sum(netto),0),4) n,
            round(ifnull(sum(brutto),0),4) b 
        INTO v_steuer, v_netto, v_brutto
        FROM 
            blg_pos_calculation
        WHERE 
            beleg = new.beleg;

    update blg_hdr_calculation set 
        steuer = v_steuer,
        netto = v_netto,
        brutto = v_brutto
    where id = new.id;
END //


CREATE TRIGGER IF NOT EXISTS blg_pos_calculation_au_header
AFTER UPDATE  
ON blg_pos_calculation FOR EACH ROW
BEGIN
    DECLARE v_beleg VARCHAR(255);
    DECLARE v_steuer DECIMAL(15,4);
    DECLARE v_netto DECIMAL(15,4);
    DECLARE v_brutto DECIMAL(15,4);

     SELECT 
            round(ifnull(sum(steuer),0),4) s,
            round(ifnull(sum(netto),0),4) n,
            round(ifnull(sum(brutto),0),4) b 
        INTO v_steuer, v_netto, v_brutto
        FROM 
            blg_pos_calculation
        WHERE 
            beleg = new.beleg;

    update blg_hdr_calculation set 
        steuer = v_steuer,
        netto = v_netto,
        brutto = v_brutto
    where id = new.id;
END //


CREATE TRIGGER IF NOT EXISTS blg_pos_calculation_ad_header
AFTER DELETE  
ON blg_pos_calculation FOR EACH ROW
BEGIN
    DECLARE v_beleg VARCHAR(255);
    DECLARE v_steuer DECIMAL(15,4);
    DECLARE v_netto DECIMAL(15,4);
    DECLARE v_brutto DECIMAL(15,4);

     SELECT 
            round(ifnull(sum(steuer),0),4) s,
            round(ifnull(sum(netto),0),4) n,
            round(ifnull(sum(brutto),0),4) b 
        INTO v_steuer, v_netto, v_brutto
        FROM 
            blg_pos_calculation
        WHERE 
            beleg = old.beleg;

    update blg_hdr_calculation set 
        steuer = v_steuer,
        netto = v_netto,
        brutto = v_brutto
    where id = old.id;
END //