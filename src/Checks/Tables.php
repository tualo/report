<?php

namespace Tualo\Office\Report\Checks;

use Tualo\Office\Basic\Middleware\Session;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\TualoApplication as App;


class Tables  extends PostCheck
{


    public static function test(array $config)
    {
        $tables = [
            'artikelgruppen' => ['anzahl_1' => 'decimal(15,5)', 'anzahl_12' => 'decimal(15,5)', 'anzahl_6' => 'decimal(15,5)', 'artikelnummer' => 'varchar(20)', 'averkaufszeitraum_bis' => 'date', 'averkaufszeitraum_von' => 'date', 'avgpreis_1' => 'decimal(15,5)', 'avgpreis_12' => 'decimal(15,5)', 'avgpreis_6' => 'decimal(15,5)', 'bemerkung' => 'varchar(4000)', 'bestandsartikel' => 'tinyint(4)', 'einheit' => 'varchar(20)', 'gebinde' => 'tinyint(4)', 'gruppe' => 'varchar(255)', 'gruppen_id' => 'int(11)', 'ingebrauch' => 'tinyint(4)', 'innenauftrag_suffix' => 'varchar(4)', 'insert_date' => 'date', 'kommission' => 'tinyint(4)', 'konto_id' => 'int(11)', 'kostenstelle' => 'int(11)', 'kundennummer' => 'varchar(255)', 'kurztext' => 'varchar(30)', 'login' => 'varchar(255)', 'max_anzahl' => 'int(11)', 'max_height' => 'decimal(15,6)', 'max_length' => 'decimal(15,6)', 'max_thickness' => 'decimal(15,6)', 'max_weight' => 'decimal(15,6)', 'mdeartikel' => 'tinyint(4)', 'mde_sortierung' => 'int(11)', 'offenerposten' => 'tinyint(4)', 'plugin' => 'varchar(255)', 'prio' => 'int(11)', 'sartikelnummer' => 'varchar(255)', 'status' => 'tinyint(4)', 'system' => 'tinyint(4)', 'upoc' => 'varchar(20)', 'verkaufszeitraum_bis' => 'date', 'verkaufszeitraum_von' => 'date', 'warengruppe' => 'varchar(100)', 'zielregion' => 'varchar(20)', 'zusatztext' => 'varchar(4000)'],
            'bfkonten' => ['gueltig' => 'date', 'gueltig_von' => 'date', 'id' => 'int(11)', 'konto' => 'varchar(100)', 'konto_1' => 'varchar(100)', 'konto_10' => 'varchar(100)', 'konto_2' => 'varchar(100)', 'konto_3' => 'varchar(100)', 'konto_4' => 'varchar(100)', 'konto_5' => 'varchar(100)', 'konto_6' => 'varchar(100)', 'konto_7' => 'varchar(100)', 'konto_8' => 'varchar(100)', 'konto_9' => 'varchar(100)', 'name' => 'varchar(100)', 'sap_schluessel' => 'varchar(5)', 'sap_schluessel_1' => 'varchar(5)', 'sap_schluessel_10' => 'varchar(5)', 'sap_schluessel_2' => 'varchar(5)', 'sap_schluessel_3' => 'varchar(5)', 'sap_schluessel_4' => 'varchar(5)', 'sap_schluessel_5' => 'varchar(5)', 'sap_schluessel_6' => 'varchar(5)', 'sap_schluessel_7' => 'varchar(5)', 'sap_schluessel_8' => 'varchar(5)', 'sap_schluessel_9' => 'varchar(5)', 'steuer' => 'decimal(15,2)', 'steuer_1' => 'decimal(15,2)', 'steuer_10' => 'decimal(15,2)', 'steuer_2' => 'decimal(15,2)', 'steuer_3' => 'decimal(15,2)', 'steuer_4' => 'decimal(15,2)', 'steuer_5' => 'decimal(15,2)', 'steuer_6' => 'decimal(15,2)', 'steuer_7' => 'decimal(15,2)', 'steuer_8' => 'decimal(15,2)', 'steuer_9' => 'decimal(15,2)'],
            'bfkonten_zuordnung' => ['gruppe' => 'varchar(255)', 'gueltig' => 'date', 'konto_id' => 'int(11)'],
            'buchungskonten' => ['aktiv' => 'tinyint(4)', 'konto' => 'varchar(100)', 'name' => 'varchar(255)'],
            'mengeneinheiten' => ['faktor' => 'decimal(15,6)', 'id' => 'int(11)', 'name' => 'varchar(20)', 'symbol' => 'varchar(20)'],
            'preiskategorien' => ['id' => 'int(11)', 'name' => 'varchar(255)', 'status' => 'tinyint(4)'],
            'staffeln' => ['bis' => 'int(11)', 'bruttopreis' => 'decimal(15,6)', 'epreis' => 'decimal(15,6)', 'gebiet' => 'varchar(50)', 'gld' => 'decimal(12,5)', 'gruppe' => 'varchar(255)', 'json_formel' => 'varchar(4000)', 'mpreis' => 'decimal(15,6)', 'preis' => 'decimal(15,6)', 'preiskategorie' => 'int(11)', 'von' => 'int(11)', 'zeitraum_bis' => 'date', 'zeitraum_von' => 'date'],
            'warengruppen' => ['beleggruppierung' => 'varchar(20)', 'bestandsflag' => 'tinyint(4)', 'detailgruppe' => 'varchar(100)', 'farbe' => 'varchar(20)', 'ia_kennung' => 'char(2)', 'id' => 'int(11)', 'inventur' => 'tinyint(4)', 'leerzeile' => 'tinyint(4)', 'provision' => 'varchar(4)', 'skonto' => 'varchar(4)', 'sperre' => 'varchar(4)', 'status' => 'varchar(4)', 'suffix' => 'varchar(4)', 'touch' => 'varchar(4)', 'upoc' => 'varchar(20)', 'warengruppe' => 'varchar(100)', 'warenhauptgruppe' => 'int(11)', 'wgsort' => 'int(11)'],
            'warenhauptgruppen' => ['id' => 'int(11)', 'name' => 'varchar(255)'],
            'blg_config' => []
        ];
        self::tableCheck('report', $tables);
    }
}
