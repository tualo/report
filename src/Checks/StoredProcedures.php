<?php

namespace Tualo\Office\Report\Checks;

use Tualo\Office\Basic\Middleware\Session;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\TualoApplication as App;


class StoredProcedures extends PostCheck {
    public static function test(array $config){
        // print_r($config);
        $def = [
            'getReport'=>'0a0049d380ef45a1f59e942d087ec9aa',
            'getReportPayments'=>'a7b5272fd37b469b5763192812d1e847',
            'getReportPositions'=>'',
            'getReportReductions'=>'',
            'getReportLocks'=>'',
            'setReport'=>'',
            'setReportDefaults'=>'',
            'setReportHeader'=>'',
            'setReportPosition'=>'',
            'setReportTSE'=>''
        ];

                        //);
        $clientdb = App::get('clientDB');
        if (is_null($clientdb)) return;
        self::procedureCheck(
            $def,
            "please run the following command: `./tm reportinstallsql --client ".$clientdb->dbname."`",
            "please run the following command: `./tm reportinstallsql --client ".$clientdb->dbname."`"
        );
        
    }
}