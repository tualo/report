DELIMITER //

CREATE OR REPLACE FUNCTION `appendReportID`(
    in_json JSON,
    reportid bigint
) RETURNS JSON 
COMMENT 'Funktion zum Anhängen der reportnr an JSON-Objekte in einem Array
Diese Funktion verarbeitet ein JSON-Array von Objekten und stellt sicher, dass jedes Objekt
eine gültige reportnr (Belegnummer) besitzt. Falls keine reportnr gesetzt ist,

wird die übergebene reportid verwendet. 
Parameter:
  - in_json: JSON-Array von Objekten, die die Belegpositionen enthalten
  - reportid: Die zu verwendende Report-ID, falls keine andere Nummer vorhanden ist
Rückgabe:
  - Modifiziertes JSON-Array mit gesetzten reportnr-Werten
Fehlerbehandlung:
  - Wirft SQLSTATE 45000, wenn der input kein Array ist
Beispiel JSON-Struktur:
  [
    {"id": null,  ...},
    {"id": 2,  ...}
  ]'    

BEGIN
DECLARE MSG VARCHAR(4000);
    IF JSON_TYPE(in_json) <> 'ARRAY' THEN
        SET MSG = concat(
                'the input json is not an array but ', JSON_TYPE(in_json), ' from appendReportID'
            );
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = MSG;
    END IF;
     -- set report id in positions, if not set
    for position in (
        select 
            seq,
            reportnr
        from 
            json_table(
                in_json,
                '$[*]'
                columns (
                    seq for ordinality,
                    reportnr bigint path '$.id'
                )
            ) as seq
    ) do
        if position.reportnr is null then
            set in_json=JSON_SET(in_json, concat('$[', position.seq -1, '].id'), reportid );
        end if;
    end for;
    return in_json;
END //


CREATE OR REPLACE FUNCTION `appendReportNr`(
    in_json JSON,
    reportid bigint
) RETURNS JSON 
COMMENT 'Funktion zum Anhängen der reportnr an JSON-Objekte in einem Array
Diese Funktion verarbeitet ein JSON-Array von Objekten und stellt sicher, dass jedes Objekt
eine gültige reportnr (Belegnummer) besitzt. Falls keine reportnr gesetzt ist,

wird die übergebene reportid verwendet. 
Parameter:
  - in_json: JSON-Array von Objekten, die die Belegpositionen enthalten
  - reportid: Die zu verwendende Report-ID, falls keine andere Nummer vorhanden ist
Rückgabe:
  - Modifiziertes JSON-Array mit gesetzten reportnr-Werten
Fehlerbehandlung:
  - Wirft SQLSTATE 45000, wenn der input kein Array ist
Beispiel JSON-Struktur:
  [
    {"id": 1, "reportnr": null, ...},
    {"id": 2, "reportnr": 123, ...}
  ]'    

BEGIN
DECLARE MSG VARCHAR(4000);
    IF JSON_TYPE(in_json) <> 'ARRAY' THEN
        SET MSG = concat(
                'the input json is not an array but ', JSON_TYPE(in_json), ' from appendReportNr'
            );
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = MSG;
    END IF;
     -- set report id in positions, if not set
    for position in (
        select 
            seq,
            reportnr
        from 
            json_table(
                in_json,
                '$[*]'
                columns (
                    seq for ordinality,
                    reportnr bigint path '$.reportnr'
                )
            ) as seq
    ) do
        if position.reportnr is null then
            set in_json=JSON_SET(in_json, concat('$[', position.seq -1, '].reportnr'), reportid );
        end if;
    end for;
    return in_json;
END //