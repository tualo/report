<?php

namespace Tualo\Office\Report\Commands;

use Garden\Cli\Cli;
use Garden\Cli\Args;
use phpseclib3\Math\BigInteger\Engines\PHP;
use Tualo\Office\Basic\ICommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;

class ImportDSTemplates implements ICommandline
{

    public static function getCommandName(): string
    {
        return 'import-ds-report-templates';
    }

    public static function setup(Cli $cli)
    {
        $cli->command(self::getCommandName())
            ->description('install report ds templates')
            ->opt('client', 'only use this client', true, 'string');
    }


    public static function setupClients(string $msg, string $clientName, string $file, callable $callback)
    {
        $_SERVER['REQUEST_URI'] = '';
        $_SERVER['REQUEST_METHOD'] = 'none';
        App::run();

        $session = App::get('session');
        $sessiondb = $session->db;
        $dbs = $sessiondb->direct('select username db_user, password db_pass, id db_name, host db_host, port db_port from macc_clients ');
        foreach ($dbs as $db) {
            if (($clientName != '') && ($clientName != $db['db_name'])) {
                continue;
            } else {
                App::set('clientDB', $session->newDBByRow($db));
                PostCheck::formatPrint(['blue'], $msg . '(' . $db['db_name'] . '):  ');
                $callback($file);
                PostCheck::formatPrintLn(['green'], "\t" . ' done');
            }
        }
    }

    public static function run(Args $args)
    {

        $files = [

            'blg_adr_rechnung.ds.sql',
            'blg_hdr_rechnung.ds.sql',
            'blg_min_rechnung.ds.sql',
            'blg_pay_rechnung.ds.sql',
            'blg_pos_rechnung.ds.sql',
            'blg_signum_rechnung.ds.sql',
            'blg_txt_rechnung.ds.sql',
            'view_blg_list_rechnung.ds.sql',
            'view_editor_blg_hdr_rechnung.ds.sql',
            'view_editor_blg_pos_rechnung.ds.sql',
            'view_editor_relation_rechnung.ds.sql',
            'view_report_blg_adr_rechnung.ds.sql',
            'view_report_blg_brieffusstextspalten_ids_rechnung.ds.sql',
            'view_report_blg_brieffusstextspalten_rechnung.ds.sql',
            'view_report_blg_hdr_rechnung.ds.sql',
            'view_report_blg_hdrtitle_rechnung.ds.sql',
            'view_report_blg_lohn_rechnung.ds.sql',
            'view_report_blg_pos_rechnung.ds.sql',
            'view_report_blg_senderadr_rechnung.ds.sql',
            'view_report_blg_taxes_rechnung.ds.sql',
            'view_report_blg_txt_rechnung.ds.sql'


        ];


        foreach ($files as $file => $msg) {
            $installSQL = function (string $file) {

                $filename = dirname(__DIR__) . '/sql/' . $file . '.sql';
                $sql = file_get_contents($filename);


                $statement = 'insert ignore into blg_ds_templates (template_type, template_name, template) values ({template_type}, {template_name}, {template})';
                try {
                    App::get('clientDB')->execute($statement, [
                        'template_type' => 'ds',
                        'template_name' => $file,
                        'template' => $sql
                    ]);
                    App::get('clientDB')->moreResults();
                } catch (\Exception $e) {
                    echo PHP_EOL;
                    PostCheck::formatPrintLn(['red'], $e->getMessage());
                }
            };
            $clientName = $args->getOpt('client');
            if (is_null($clientName)) $clientName = '';
            self::setupClients($msg, $clientName, $file, $installSQL);
        }
    }
}
