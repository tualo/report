DELIMITER //

CREATE OR REPLACE PROCEDURE setReport(
    in reporttype varchar(20),
    in in_json JSON,
    out out_json JSON
) 
COMMENT 'Hauptprozedur zum Erstellen oder Aktualisieren eines Berichts/Belegs aus JSON-Daten

Diese Prozedur verarbeitet einen vollständigen Beleg (Header + Positionen) im JSON-Format
und speichert ihn in den entsprechenden Datenbanktabellen. Sie führt folgende Schritte aus:

1. Validierung und Übersetzung der JSON-Attribute für den Header (blghdr_translations)
2. Prüfung aller Pflichtfelder im Header
3. Speicherung des Headers in der Tabelle blg_hdr_<reporttype>
4. Ermittlung der generierten Report-ID (bei neuen Belegen)
5. Setzen der Report-ID in allen Positionen (falls nicht vorhanden)
6. Validierung und Übersetzung der JSON-Attribute für Positionen (blgpos_translations)
7. Speicherung aller Positionen in der Tabelle blg_pos_<reporttype>
8. Neuberechnung der Kopfsummen via recalculateHeader()
9. Rückgabe des vollständigen gespeicherten Belegs via getReport()

Parameter:
  - reporttype: Typ des Berichts (z.B. "invoice", "order"), bestimmt die verwendeten Tabellen
  - in_json: JSON-Objekt mit Header-Daten und einem Array "positions" für die Positionen
  - out_json: Ausgabeparameter mit dem vollständig gespeicherten Beleg inkl. aller IDs

Voraussetzungen:
  - Tabellen blg_hdr_<reporttype> und blg_pos_<reporttype> müssen existieren
  - Übersetzungstabellen blghdr_translations und blgpos_translations müssen befüllt sein
  - Prozeduren dsx_rest_api_set, recalculateHeader und getReport müssen verfügbar sein

Fehlerbehandlung:
  - Wirft SQLSTATE 45000 bei fehlenden Pflichtfeldern
  - Wirft SQLSTATE 45000 bei Fehlern beim Speichern von Header oder Positionen
  - Alle Fehler enthalten aussagekräftige Fehlermeldungen

Beispiel JSON-Input:
  {
    "customer_id": 123,
    "date": "2026-01-22",
    "total": 100.00,
    "positions": [
      {"article_id": 1, "quantity": 2, "price": 50.00}
    ]
  }

Rückgabe:
  out_json enthält den vollständigen Beleg mit allen generierten IDs und berechneten Werten'
BEGIN
    DECLARE MSG VARCHAR(4000);
    DECLARE dsx_request JSON;
    DECLARE header JSON;
    DECLARE result JSON;
    DECLARE reportid bigint;

    -- Template for DSX request
    SET dsx_request = JSON_OBJECT(
        'tablename',concat('blg_hdr_', reporttype),
        'data', JSON_ARRAY( ),
        'type', 'insert',
        'update', 1 = 1
    );

    -- translate json attributes to column names
    for checkrecord in (select column_name,json_attribute_name,is_required from blghdr_translations) do
        if JSON_VALUE(in_json, concat('$.', checkrecord.json_attribute_name)) is not null then
            set in_json=JSON_SET(in_json, concat('$.', checkrecord.column_name), JSON_VALUE(in_json, concat('$.', checkrecord.json_attribute_name)));
        end if;
        -- check required fields
        if checkrecord.is_required = 1 then
            if JSON_VALUE(in_json, concat('$.', checkrecord.json_attribute_name)) is null then
                SET MSG = concat('Required field missing: ', checkrecord.json_attribute_name);
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
            end if;
        end if;
    end for;
    
     -- insert header
    SET header = JSON_EXTRACT(in_json,'$');
    SET header = JSON_REMOVE(header,'$.positions');
    set dsx_request=JSON_SET(dsx_request,'$.data',JSON_ARRAY(JSON_MERGE(header,JSON_OBJECT())));
    set dsx_request=JSON_SET(dsx_request,'$.tablename',concat('blg_hdr_', reporttype));
    call dsx_rest_api_set(dsx_request, result);
    if JSON_VALUE(result,'$.success')=0 then
        SET MSG = concat('Header could not be saved: ', JSON_VALUE(result,'$.error'));
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
    end if;
    select id into reportid from temp_dsx_rest_data;
    -- if no id was given a new report was created

    -- add reportid to positions if not exists
    SET in_json = setReportAddInNotExistsReportID(in_json, reportid);


    -- insert positions using DSX
    set dsx_request=JSON_SET(dsx_request,'$.data',JSON_EXTRACT(in_json,'$.positions'));
    set dsx_request=JSON_SET(dsx_request,'$.tablename',concat('blg_pos_', reporttype));
    call dsx_rest_api_set(dsx_request, result);
    if JSON_VALUE(result,'$.success')=0 then
        SET MSG = concat('Positions could not be saved: ', JSON_VALUE(result,'$.error'));
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
    end if;

    -- TSE
    call setReportTSE(reporttype, in_json, reportid, result);

    -- Texts
    call setReportTexts(reporttype, in_json, reportid, result);

    -- finally recalculate header
    call recalculateHeader(reporttype, reportid);
    call getReport(reporttype, reportid, out_json);
END //
