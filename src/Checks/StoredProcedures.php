<?php

namespace Tualo\Office\Report\Checks;

use Tualo\Office\Basic\Middleware\Session;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\TualoApplication as App;


class StoredProcedures extends PostCheck
{
    public static function test(array $config)
    {
        // print_r($config);
        /*
        select routine_name,md5(routine_definition) md5 from information_schema.routines WHERE routine_schema = database() 
        and routine_name in ('getReport','getReportPayments','getReportPositions','getReportReductions','getReportLocks','setReport','setReportDefaults','setReportHeader','setReportPosition','setReportTSE')
        */
        $def = [
            'getReport' => '1474b327465f7b11bd4e4de2876e2484',
            'getReportPayments' => '3bd43a9909b25d2f7e2f6afa8dc5255a',
            'getReportPositions' => '6253cb4d814889bfe6ad6b7107c498ac',
            'getReportReductions' => '2c1d342d86da56c5c661732c9ed30136',
            'getReportLocks' => '53f41a525bce4b69b77ed6c66669db82',
            'setReport' => '1f7e7e5dcb228e57d57aa55a9489e973',
            'setReportDefaults' => '4668d06bc97e7ab4134e09a996727de2',
            'setReportHeader' => '406111d94654461257333bdd355a57c5',
            'setReportPosition' => '6e6581f68c1a405dfbc6c922e48e8035',
            'setReportTSE' => '93112627a04333a7b3f16867e7aa5bf5'
        ];

        //);
        $clientdb = App::get('clientDB');
        if (is_null($clientdb)) return;
        self::procedureCheck(
            'report',
            $def,
            "please run the following command: `./tm install-sql-report --client " . $clientdb->dbname . "`",
            "please run the following command: `./tm install-sql-report --client " . $clientdb->dbname . "`"
        );
    }
}
