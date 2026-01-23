DELIMITER //

CREATE OR REPLACE FUNCTION `setReportAddInNotExistsReportID`(
    in_json JSON,
    reportid bigint
) RETURNS JSON 
COMMENT 'Hilfsfunktion zum Setzen der Report-ID in JSON-Positionen

Diese Funktion verarbeitet ein JSON-Objekt mit Belegpositionen und stellt sicher, dass jede Position
eine gültige reportnr (Belegnummer) besitzt. Falls keine reportnr gesetzt ist, wird entweder die
übergebene reportid oder eine vorhandene beleg-Nummer verwendet.

Zusätzlich werden JSON-Attribute basierend auf der Tabelle blgpos_translations in die entsprechenden
Spaltennamen übersetzt und Pflichtfelder validiert.

Parameter:
  - in_json: JSON-Objekt mit einem Array "positions", das die Belegpositionen enthält
  - reportid: Die zu verwendende Report-ID, falls keine andere Nummer vorhanden ist

Rückgabe:
  - Modifiziertes JSON-Objekt mit gesetzten reportnr-Werten und übersetzten Attributnamen

Fehlerbehandlung:
  - Wirft SQLSTATE 45000, wenn erforderliche Felder in blgpos_translations fehlen

Beispiel JSON-Struktur:
  {
    "positions": [
      {"id": 1, "reportnr": null, "beleg": null, ...},
      {"id": 2, "reportnr": 123, "beleg": null, ...}
    ]
  }' 
BEGIN
    DECLARE MSG VARCHAR(4000);

    -- set report id in positions, if not set
    for position in (
        select 
            seq,
            id,
            reportnr,
            beleg
        from 
            json_table(
                in_json,
                '$.positions[*]'
                columns (
                    seq for ordinality,
                    id bigint path '$.id',
                    reportnr bigint path '$.reportnr',
                    beleg bigint path '$.beleg'
                )
            ) as seq
    ) do

        if position.reportnr is null then
            if position.beleg is null then
                -- wenn nichts gesetzt ist, dann die reportid verwenden, neuer beleg
                set in_json=JSON_SET(in_json, concat('$.positions[', position.seq -1, '].reportnr'), reportid );
            else
                set in_json=JSON_SET(in_json, concat('$.positions[', position.seq -1, '].reportnr'), position.beleg);  
            end if;
        end if;

        
        -- translate json attributes to column names in positions
        FOR rec in (select * from blgpos_translations) DO 
            IF ( rec.is_required = 1  and JSON_EXISTS(in_json, concat('$.positions[', position.seq -1, '].', rec.json_attribute_name)) = 0) THEN
                SET MSG = concat(
                        'Required field ',
                        rec.json_attribute_name,
                        ' not found in JSON'
                    );
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = MSG;
            ELSEIF JSON_EXISTS(in_json, concat('$.positions[', position.seq -1, '].', rec.json_attribute_name)) = 1 THEN
                SET in_json = JSON_SET(
                        in_json,
                        concat('$.positions[', position.seq -1, '].', rec.column_name),
                        JSON_VALUE(in_json, concat('$.positions[', position.seq -1, '].', rec.json_attribute_name))
                    );
            END IF;
        END FOR;

    end for;

    RETURN in_json;

END //
