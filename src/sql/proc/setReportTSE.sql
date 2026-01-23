delimiter //

CREATE OR REPLACE PROCEDURE setReportTSE( in reporttype varchar(20), in in_json JSON, in reportid bigint, out result JSON )
COMMENT 'Prozedur zum Setzen von TSE-Daten für einen Bericht/Beleg
Diese Prozedur verarbeitet TSE-Daten im JSON-Format und speichert sie in der entsprechenden
Datenbanktabelle blg_tse_<reporttype>.
Parameter:
  - reporttype: Typ des Berichts (z.B. "invoice", "order"), bestimmt die verwendete Tabelle
  - in_json: JSON-Objekt mit TSE-Daten
  - reportid: Die Report-ID des zugehörigen Belegs
  - result: Ausgabeparameter mit dem Ergebnis der Operation
Voraussetzungen:
  - Tabelle blg_tse_<reporttype> muss existieren
  - Prozedur dsx_rest_api_set muss verfügbar sein
Fehlerbehandlung:
  - Wirft SQLSTATE 45000 bei Fehlern beim Speichern der TSE-Daten
  - Fehler enthalten aussagekräftige Fehlermeldungen'

BEGIN

    DECLARE dsx_request JSON;
    DECLARE MSG VARCHAR(4000);

    SET result = JSON_OBJECT(
        'success', 1,
        'message', 'TSE data processed successfully'
    );

    IF JSON_EXISTS(in_json,'$.tse') THEN 

        set dsx_request=JSON_SET(dsx_request,'$.data',appendReportNr(JSON_EXTRACT(in_json,'$.tse'), reportid));
        set dsx_request=JSON_SET(dsx_request,'$.tablename',concat('blg_tse_', reporttype));
        call dsx_rest_api_set(dsx_request, result);
        if JSON_VALUE(result,'$.success')=0 then
            SET MSG = concat('TSE could not be saved: ', JSON_VALUE(result,'$.error'));
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
        end if;

    END IF;

END //