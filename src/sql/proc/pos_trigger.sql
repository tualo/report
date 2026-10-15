


CREATE  OR REPLACE TRIGGER `blg_pos_rechnung_bu_gross` 
BEFORE UPDATE ON `blg_pos_rechnung` FOR EACH ROW
BEGIN

   IF (new.steuer <> (new.netto * (0+new.steuersatz/100))) THEN
     SET new.steuer = (new.netto * (0+new.steuersatz/100));
   END IF;
   SET NEW.brutto = new.netto + new.steuer;

END //

CREATE  OR REPLACE TRIGGER `blg_pos_rechnung_bi_gross` 
BEFORE INSERT ON `blg_pos_rechnung` FOR EACH ROW
BEGIN

    IF (new.steuer <> (new.netto * (0+new.steuersatz/100))) THEN
     SET new.steuer = (new.netto * (0+new.steuersatz/100));
   END IF;
   SET NEW.brutto = new.netto + new.steuer;

END //