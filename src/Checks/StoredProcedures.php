<?php

namespace Tualo\Office\Report\Checks;

use Tualo\Office\Basic\Middleware\Session;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\TualoApplication as App;


class StoredProcedures extends PostCheck {
    public static function test(array $config){
        // print_r($config);
        /*
        select routine_name,md5(routine_definition) md5 from information_schema.routines WHERE routine_schema = database() 
        and routine_name in ('getReport','getReportPayments','getReportPositions','getReportReductions','getReportLocks','setReport','setReportDefaults','setReportHeader','setReportPosition','setReportTSE')
        */
        $def = [
            'getReport'=>'3a0b505dc2aa1b26abfba88b4d33c03e',
            'getReportPayments'=>'b23033b47b22b0239d557753583e4559',
            'getReportPositions'=>'d8467e62cd59ac0409aa080cd4fba0c5',
            'getReportReductions'=>'8e77e1a31b9301ff1e3d91dc518ee7e2',
            'getReportLocks'=>'7150f9793457fe532dad4cabe15b3529',
            'setReport'=>'9b621e0b1287df6f94e8669e4e0117bd',
            'setReportDefaults'=>'2b02fb7daa2bf0279da4b82d8e9ea911',
            'setReportHeader'=>'7127ac7c9c3acc137cbefead2ebbfe80',
            'setReportPosition'=>'a72146349c3271bc48192f80ae044c81',
            'setReportTSE'=>'bb1bec5fef1e0f451c44dad44250662a'
        ];

                        //);
        $clientdb = App::get('clientDB');
        if (is_null($clientdb)) return;
        self::procedureCheck(
            'report',
            $def,
            "please run the following command: `./tm install-sql-report --client ".$clientdb->dbname."`",
            "please run the following command: `./tm install-sql-report --client ".$clientdb->dbname."`"
        );
        
    }
}