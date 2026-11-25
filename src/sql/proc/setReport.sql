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
    DECLARE defaults JSON;
    DECLARE positions JSON;
    DECLARE position JSON;
    DECLARE vid_references JSON;
    DECLARE vid_reference JSON;
    DECLARE reportid bigint;
    DECLARE positionid bigint;
    DECLARE i int;
    DECLARE j int;
    DECLARE sql_command varchar(1000);
    DECLARE reference_vid LONGTEXT;
    DECLARE reference_type LONGTEXT;

    -- Template for DSX request
    SET dsx_request = JSON_OBJECT(
        'tablename',concat('blg_hdr_', reporttype),
        'data', JSON_ARRAY( ),
        'type', 'insert',
        'update', 1 = 1
    );

    
    call setReportDefault(reporttype,in_json,defaults);
    set in_json = defaults;

    SET positions = JSON_EXTRACT(in_json, '$.positions');
    SET i = 0;
    WHILE i < JSON_LENGTH(positions) DO
        SET position = JSON_EXTRACT(positions, CONCAT('$[', i, ']'));
        SET positionid = JSON_VALUE(position, '$.id');

        IF positionid IS NOT NULL AND positionid > 0 THEN
            SET @report_position_has_references = 0;
            SET sql_command = CONCAT(
                'SELECT EXISTS(SELECT 1 FROM `blg_vid_', REPLACE(reporttype, '`', '``'),
                '` WHERE id = ?) INTO @report_position_has_references'
            );
            PREPARE stmt FROM sql_command;
            EXECUTE stmt USING positionid;
            DEALLOCATE PREPARE stmt;
            IF @report_position_has_references = 1 THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Die Position stammt aus einem Verweis und darf nicht geändert werden.';
            END IF;
        END IF;

        IF JSON_EXISTS(position, '$.vid_references') THEN
            SET vid_references = JSON_EXTRACT(position, '$.vid_references');
            IF JSON_TYPE(vid_references) <> 'ARRAY' THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'vid_references muss ein Array sein.';
            END IF;
            SET j = 0;
            WHILE j < JSON_LENGTH(vid_references) DO
                SET vid_reference = JSON_EXTRACT(vid_references, CONCAT('$[', j, ']'));
                SET reference_vid = JSON_VALUE(vid_reference, '$.vid');
                SET reference_type = JSON_VALUE(vid_reference, '$.vzusatz');
                IF JSON_TYPE(vid_reference) <> 'OBJECT'
                    OR JSON_TYPE(JSON_EXTRACT(vid_reference, '$.vid')) NOT IN ('INTEGER', 'STRING')
                    OR reference_vid IS NULL
                    OR reference_vid NOT REGEXP '^-?[0-9]{1,19}$'
                    OR CAST(reference_vid AS DECIMAL(20,0)) NOT BETWEEN -9223372036854775808 AND 9223372036854775807
                    OR JSON_TYPE(JSON_EXTRACT(vid_reference, '$.vzusatz')) <> 'STRING'
                    OR reference_type IS NULL OR CHAR_LENGTH(reference_type) = 0
                    OR CHAR_LENGTH(reference_type) > 255 THEN
                    SIGNAL SQLSTATE '45000'
                        SET MESSAGE_TEXT = 'vid_references enthält einen ungültigen vid- oder vzusatz-Wert.';
                END IF;
                SET j = j + 1;
            END WHILE;
            IF EXISTS (
                SELECT 1
                FROM JSON_TABLE(vid_references, '$[*]' COLUMNS (
                    vid BIGINT PATH '$.vid',
                    vzusatz VARCHAR(255) PATH '$.vzusatz'
                )) AS ref
                GROUP BY ref.vid, ref.vzusatz
                HAVING COUNT(*) > 1
            ) THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'vid_references enthält doppelte Verweise.';
            END IF;
        END IF;
        SET i = i + 1;
    END WHILE;

    -- translate json attributes to column names
    for checkrecord in (select column_name,json_attribute_name,is_required from blghdr_translations) do
        if JSON_VALUE(in_json, concat('$.', checkrecord.json_attribute_name)) is not null then
            set in_json=JSON_SET(in_json, concat('$.', checkrecord.column_name), JSON_VALUE(in_json, concat('$.', checkrecord.json_attribute_name)));
        end if;

        if JSON_VALUE(in_json, concat('$.', checkrecord.column_name)) is not null then
            set in_json=JSON_SET(in_json, concat('$.', checkrecord.json_attribute_name), JSON_VALUE(in_json, concat('$.', checkrecord.column_name)));
        end if;

        -- check required fields
        if checkrecord.is_required = 1 then
            if JSON_VALUE(in_json, concat('$.', checkrecord.json_attribute_name)) is null then
                SET MSG = concat('Required field missing: ', checkrecord.json_attribute_name);
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
            end if;
        end if;
    end for;

    call debug_message('setReport - after header translation and validation');
    
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


    if JSON_EXISTS(result,'$.temporary_table_name')=0 then
        SET MSG = concat('temporary_table_name not returned by dsx_rest_api_set');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
    end if;

     call debug_message('setReport - after header insert, before retrieving reportid');

    if JSON_VALUE(result,'$.temporary_table_name') is not null then
        set sql_command = concat('select id into @reportid from ', JSON_VALUE(result,'$.temporary_table_name'));
        PREPARE stmt FROM sql_command;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;    
    end if;
    
    SET reportid = @reportid;
    IF reportid IS NULL THEN
        SET MSG = concat('Report ID could not be retrieved after header insert');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
    END IF;

    -- add reportid to positions if not exists
    -- SET in_json = setReportAddInNotExistsReportID(in_json, reportid);


 call debug_message('setReport - after adding reportid to positions, before position translation and validation');

     -- translate json attributes to column names for positions 
    -- insert positions using DSX


    SET positions = JSON_EXTRACT(in_json,'$.positions');
    SET i = 0;
    WHILE i < JSON_LENGTH(positions) DO
        SET position  =  JSON_EXTRACT(positions, concat('$[', i, ']'));
        SET vid_references = JSON_EXTRACT(position, '$.vid_references');
        SET position = JSON_REMOVE(position, '$.vid_references');
        IF JSON_VALUE(position, '$.id') < 0 THEN
            SET position = JSON_REMOVE(position, '$.id');
        END IF;
        if JSON_EXISTS(position, '$.reportnr')=0 OR JSON_VALUE(position, '$.reportnr') is null then
            set position = JSON_SET(position, '$.reportnr', reportid);
            set position = JSON_SET(position, '$.beleg', reportid);
        end if;


        IF 
            JSON_EXISTS(position, concat('$.', 'singleprice')) = 0
            and 
            JSON_EXISTS(position, concat('$.', 'epreis')) = 1
        THEN
            set position = JSON_SET(position, concat('$.', 'singleprice'), JSON_VALUE(position, concat('$.', 'epreis')));
        END IF; 
            

        FOR rec in (select * from blgpos_translations) DO 
            IF ( rec.is_required = 1  and JSON_EXISTS(position, concat('$.', rec.json_attribute_name)) = 0) THEN
                SET MSG = concat(
                        'Required field ',
                        rec.json_attribute_name,
                        ' not found in JSON'
                    );
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = MSG;
            ELSEIF JSON_EXISTS(position, concat('$.', rec.json_attribute_name)) = 1 THEN
                SET position = JSON_SET(
                        position,
                        concat('$.', rec.column_name),
                        JSON_VALUE(position, concat('$.', rec.json_attribute_name))
                    );
            END IF;
        END FOR;


        set dsx_request=JSON_SET(dsx_request,'$.data', JSON_MERGE(json_array(),position) );
        set dsx_request=JSON_SET(dsx_request,'$.tablename',concat('blg_pos_', reporttype));

        
        
        call dsx_rest_api_set(dsx_request, result);
        if JSON_VALUE(result,'$.success')=0 then
            SET MSG = concat('Positions could not be saved: ', JSON_VALUE(result,'$.error'));
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
        end if;

        IF vid_references IS NOT NULL AND JSON_LENGTH(vid_references) > 0 THEN
            IF JSON_VALUE(result, '$.temporary_table_name') IS NULL
                OR JSON_VALUE(result, '$.temporary_table_name') NOT REGEXP '^[A-Za-z0-9_]+$' THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Positions-ID konnte nicht ermittelt werden: temporäre Tabelle fehlt.';
            END IF;

            SET @report_position_id = NULL;
            SET sql_command = CONCAT(
                'SELECT id INTO @report_position_id FROM `',
                JSON_VALUE(result, '$.temporary_table_name'), '`'
            );
            PREPARE stmt FROM sql_command;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
            SET positionid = @report_position_id;
            IF positionid IS NULL THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Positions-ID konnte nicht ermittelt werden.';
            END IF;

            SET sql_command = CONCAT(
                'INSERT INTO `blg_vid_', REPLACE(reporttype, '`', '``'),
                '` (id, vid, vzusatz) ',
                'SELECT ?, ref.vid, ref.vzusatz FROM JSON_TABLE(?, ''$[*]'' COLUMNS (',
                'vid BIGINT PATH ''$.vid'', vzusatz VARCHAR(255) PATH ''$.vzusatz'')) AS ref'
            );
            PREPARE stmt FROM sql_command;
            EXECUTE stmt USING positionid, vid_references;
            DEALLOCATE PREPARE stmt;
        END IF;

        SET i = i + 1;

    END WHILE;

 call debug_message('setReport - after position insert, before TSE, Texts, ReferenceNr, Address, BookingCircle');
    -- TSE
    call setReportTSE(reporttype, in_json, reportid, result);

 call debug_message('setReport - after TSE, before Texts, ReferenceNr, Address, BookingCircle');
    -- Texts
    call setReportTexts(reporttype, in_json, reportid, result);

 call debug_message('setReport - after Texts, before ReferenceNr, Address, BookingCircle');
    -- Bezug
    call setReportReferenceNr(reporttype, in_json, reportid, result);
 call debug_message('setReport - after ReferenceNr, before Address, BookingCircle');
    -- Address
    call setReportAddress(reporttype, in_json, reportid, result);

 call debug_message('setReport - after Address, before BookingCircle');
    -- BookingCircle
    call setReportBookingCircle(reporttype, in_json, reportid, result);

 call debug_message('setReport - after BookingCircle, before recalculateHeader and getReport');
    -- finally recalculate header
    call recalculateHeader(reporttype, reportid);
    call getReport(reporttype, reportid, out_json);
END //
