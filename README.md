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
