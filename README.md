# report

## Positionsverweise

`setReport` übernimmt optionale `vid_references`-Arrays an Positionen, z. B.
`[{"vid": 123, "vzusatz": "calculation"}]`, in `blg_vid_<belegart>`.
Positionen mit gespeicherten Verweisen können über `setReport` nicht mehr
geändert werden. Ein leeres Array legt keine Verweise an.

Für bestehende Belegarten muss das Report-Setup erneut ausgeführt werden,
damit `0005.sql` die Tabelle anlegt bzw. ihren Primärschlüssel erweitert.
Vorhandene Zeilen mit `NULL` in `vid` oder `vzusatz` müssen vor der Migration
korrigiert werden; sie werden nicht automatisch verändert.

## Druckgenauigkeit des Einzelpreises

Positionen können `singleprice_print_precision` enthalten: die Mindestzahl
der Nachkommastellen für den Druck des Netto-Einzelpreises. Beim Erzeugen aus
einer Kalkulation wird sie so gewählt, dass der gedruckte Preis multipliziert
mit der Menge auf Cent gerundet den Positionsnettobetrag ergibt (mindestens
zwei, höchstens 15 Stellen). Dies gilt auch für periodische Einzelpreise.
Bei einer Menge von null wird die Standardgenauigkeit 2 verwendet; ein von
null abweichender Positionsbetrag lässt sich daraus nicht zurückrechnen.
Die Druckvorlage kann das Feld zum Formatieren von `singleprice` verwenden.

Das Feld wird in `blg_pos_<belegart>` gespeichert und beim Lesen des Reports
wieder ausgegeben. Für bestehende Belegarten muss das Report-Setup erneut
ausgeführt werden; bestehende Positionen erhalten den Standardwert 2.
Die Speicherung von `epreis` bleibt auf fünf Nachkommastellen begrenzt.
Benötigt der exakte Einzelpreis mehr Stellen, warnt die Kalkulationsansicht:
Das Genauigkeitsfeld selbst bewahrt keine beim Speichern verlorenen Preisstellen.
