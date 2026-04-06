# Report Field Data – Datenbankgestützte Feldwertermittlung

## Übersicht

Das System ermöglicht es, Feldwerte in Belegpositionen automatisch über datenbankbasierte Prozeduren zu ermitteln. Dazu werden sogenannte **Field-Data-Processes** in der Datenbank registriert, die beim Aufruf eines bestimmten Feldnamens ausgeführt werden. Die Kommunikation zwischen Frontend und Backend erfolgt über eine dedizierte PHP-Route.

---

## Datenbankstruktur

### Tabelle `report_field_data_process`

Verzeichnis aller registrierten Prozesse.

| Spalte          | Typ           | Beschreibung                                 |
|-----------------|---------------|----------------------------------------------|
| `processname`   | VARCHAR(128)  | Name der gespeicherten Prozedur (Primary Key)|
| `active`        | TINYINT(1)    | Prozess aktiv (1) oder inaktiv (0)           |
| `execute_order` | INT           | Reihenfolge der Ausführung                   |
| `created_at`    | TIMESTAMP     | Erstellungszeitpunkt                         |
| `updated_at`    | TIMESTAMP     | Letzter Änderungszeitpunkt                   |

### Tabelle `report_field_data_process_fieldnames`

Verknüpft einen Prozess mit einem oder mehreren Feldnamen.

| Spalte        | Typ          | Beschreibung                                       |
|---------------|--------------|----------------------------------------------------|
| `processname` | VARCHAR(128) | Referenz auf `report_field_data_process.processname` |
| `fieldname`   | VARCHAR(128) | Feldname, für den der Prozess aufgerufen wird       |
| `active`      | TINYINT(1)   | Zuordnung aktiv (1) oder inaktiv (0)               |

### Tabelle `report_field_data_process_reporttypes`

Schränkt einen Prozess auf bestimmte Belegarten ein.

| Spalte        | Typ          | Beschreibung                                       |
|---------------|--------------|----------------------------------------------------|
| `processname` | VARCHAR(128) | Referenz auf `report_field_data_process.processname` |
| `reporttype`  | VARCHAR(20)  | Belegart (z. B. `rechnung`, `krechnung`)           |
| `active`      | TINYINT(1)   | Zuordnung aktiv (1) oder inaktiv (0)               |

---

## Stored Procedure `reportFieldData`

Diese Dispatcher-Prozedur ist der zentrale Einstiegspunkt. Sie sucht alle aktiven, zum Feldnamen und Belegtyp passenden Prozesse und ruft diese sequenziell auf.

```sql
CALL reportFieldData(in fieldName VARCHAR(128), in request JSON, out result JSON)
```

### Parameter

| Parameter   | Richtung | Beschreibung                                                  |
|-------------|----------|---------------------------------------------------------------|
| `fieldName` | IN       | Name des angefragten Feldes (z. B. `account`, `tax`)          |
| `request`   | IN       | JSON-Objekt mit `header` (Belegkopf) und `position` (Zeile)  |
| `result`    | OUT      | JSON-Objekt mit dem ermittelten Wert und Statusinformationen  |

### Request-Struktur

```json
{
  "header": {
    "reporttype": "rechnung"
  },
  "position": {
    "article": "ART-001",
    "amount": 5,
    "singleprice": null,
    "tax": null,
    "account": null
  }
}
```

### Result-Struktur

```json
{
  "value": "0000",
  "modified": true,
  "message": "account set to default_account"
}
```

### Ablauf

1. Alle Einträge in `report_field_data_process` werden geprüft, die:
   - zum `fieldname` passen (via `report_field_data_process_fieldnames`),
   - zur `reporttype` im `header` passen (via `report_field_data_process_reporttypes`),
   - und bei denen sowohl Prozess als auch Zuordnungen `active = 1` sind.
2. Die gefundenen Prozesse werden gemäß `execute_order` aufgerufen.
3. Das Ergebnis jedes Prozesses wird per `JSON_MERGE_PATCH` in das Gesamtergebnis übernommen – spätere Prozesse können frühere überschreiben.

---

## Eigene Prozesse registrieren

### 1. Stored Procedure anlegen

Die Prozedur erhält den aktuellen Request als JSON und liefert ein JSON-Objekt zurück:

```sql
CREATE OR REPLACE PROCEDURE `meinProzess`(in request JSON, out result JSON)
BEGIN
    SET result = JSON_OBJECT();
    -- Eigene Logik ...
    SET result = JSON_INSERT(result, '$.value', 'meinWert');
    SET result = JSON_INSERT(result, '$.modified', 1=1);
    SET result = JSON_INSERT(result, '$.message', 'Wert gesetzt');
END //
```

### 2. Prozess registrieren

```sql
INSERT IGNORE INTO report_field_data_process (processname, active, execute_order)
VALUES ('meinProzess', 1, 10);
```

### 3. Feldname zuweisen

```sql
INSERT IGNORE INTO report_field_data_process_fieldnames (processname, fieldname, active)
VALUES ('meinProzess', 'meinFeld', 1);
```

### 4. Belegart zuweisen

```sql
INSERT IGNORE INTO report_field_data_process_reporttypes (processname, reporttype, active)
VALUES ('meinProzess', 'rechnung', 1);
```

> **Hinweis:** Bestehende Prozesse (z. B. `reportFieldProcessDefaultAccount`) sollten **nicht überschrieben** werden. Stattdessen einen neuen Prozess mit höherem `execute_order` anlegen oder den Standardprozess deaktivieren (`active = 0`).

---

## Mitgelieferte Standardprozesse

| Prozessname                         | Feldname      | Standardwert | Beschreibung                                      |
|-------------------------------------|---------------|--------------|---------------------------------------------------|
| `reportFieldProcessDefaultAccount`  | `account`     | `0000`       | Setzt Standardkonto, wenn keines gesetzt ist       |
| `reportFieldProcessDefaultSinglePrice` | `singleprice` | `9.99`    | Setzt Standardeinzelpreis, wenn keiner gesetzt ist |
| `reportFieldProcessDefaultTax`      | `tax`         | `19`         | Setzt Standardsteuersatz, wenn keiner gesetzt ist  |

Diese Prozesse sind für die Belegarten `rechnung` und `krechnung` vorregistriert.

---

## PHP-Route

**Datei:** `src/Routes/Fielddata.php`

```
POST /reportdata/{fieldname}
```

### Beschreibung

Nimmt den Belegkopf und die Belegposition als JSON-Body entgegen, ruft die Datenbankprozedur `reportFieldData` auf und gibt das Ergebnis zurück.

### Request

```
POST /reportdata/account
Content-Type: application/json

{
  "header": { "reporttype": "rechnung" },
  "position": { "article": "ART-001", "amount": 2 }
}
```

### Response

```json
{
  "success": true,
  "value": "0000",
  "modified": true,
  "message": "account set to default_account"
}
```

---

## ExtJS-Integration: Mixin `Tualo.report.mixins.field.Query`

**Datei:** `src/js/classic/field/Query.js`

Dieses Mixin stellt die Methode `query()` bereit und wird in ExtJS-Model-Felddefinitionen eingebunden, um automatisch Feldwerte über die PHP-Route zu ermitteln.

### Verwendung in einem Model-Feld

```javascript
Ext.define('MeinNamespace.data.field.MeinFeld', {
    extend: 'Ext.data.field.Number',
    mixins: ['Tualo.report.mixins.field.Query'],
    alias: ['data.field.mein_feld'],
    depends: ['article', 'amount'],
    critical: true,
    persist: true,
    convert: function (currentValue, record) {
        let doQuery = false;
        if (record.modified && record.modified.article) doQuery = true;

        if (doQuery) {
            this.query(record, { article: record.get('article') }, 'meinFeld')
                .then(result => {
                    if (result) {
                        record.set('meinFeld', result.data.value);
                    }
                });
        }
        return currentValue;
    }
});
```

### Methode `query(record, queriedValue, type)`

| Parameter      | Typ    | Beschreibung                                                           |
|----------------|--------|------------------------------------------------------------------------|
| `record`       | Record | Aktueller ExtJS-Record der Belegposition                               |
| `queriedValue` | Object | Beliebige Vergleichswerte zur Stale-Check-Absicherung nach dem Fetch   |
| `type`         | String | Feldname – wird als URL-Segment an `/reportdata/{type}` übergeben      |

Die Methode liest den Belegkopf aus `record.store.getHeader()` (falls vorhanden) und die Positionsdaten aus `record.data`. Das zusammengesetzte Objekt wird per `POST` an `/reportdata/{type}` gesendet.

### Mitgelieferte Feld-Implementierungen

| Klasse                                    | Alias                         | Feldname      |
|-------------------------------------------|-------------------------------|---------------|
| `Tualo.report.data.field.TualoSinglePrice` | `data.field.tualo_report_single_price` | `singleprice` |
| `Tualo.report.data.field.TualoTax`        | `data.field.tualo_report_tax` | `tax`         |

---

## Datenfluss

```
ExtJS Model-Feld (convert)
    │
    │  Änderung in 'article' oder 'amount' erkannt
    ▼
Tualo.report.mixins.field.Query#query()
    │
    │  POST /reportdata/{fieldname}
    │  Body: { header: {...}, position: {...} }
    ▼
PHP Route: /reportdata/{fieldname}
    │
    │  CALL reportFieldData(fieldname, request, @result)
    ▼
MariaDB Stored Procedure reportFieldData
    │
    │  Iteriert über passende Prozesse (Feldname + Belegart)
    │  Ruft je Prozess: CALL prozessname(request, @o)
    ▼
Registrierter Prozess (z. B. reportFieldProcessDefaultTax)
    │
    │  Ermittelt Wert, gibt JSON zurück
    ▼
PHP Route gibt JSON zurück
    │
    │  { success: true, value: ..., modified: ..., message: ... }
    ▼
ExtJS Model-Feld setzt record.set(fieldname, result.data.value)
```
