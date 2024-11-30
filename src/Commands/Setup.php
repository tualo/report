<?php
namespace Tualo\Office\Report\Commands;
use Garden\Cli\Cli;
use Garden\Cli\Args;
use phpseclib3\Math\BigInteger\Engines\PHP;
use Tualo\Office\Basic\ISetupCommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\CommandLineInstallSessionSQL;
use Tualo\Office\Basic\BaseSetupCommand as BaseSetup;

class Setup extends BaseSetup implements ISetupCommandline{

    public static function getCommandName(): string { return 'report'; }
    public static function getCommandDescription(): string { return 'perform a complete report setup'; }
    public static function setup(Cli $cli){
        $cli->command(self::getCommandName())
            ->description(self::getCommandDescription())
            ->opt('client', 'only use this client', true, 'string');
    }
    public static function run(Args $args) { 
        $clientName = $args->getOpt('client');
        if( is_null($clientName) ) $clientName = '';
        
        PostCheck::formatPrintLn(['blue'], "Installing all needed SQL procedures for report module");
        PostCheck::formatPrintLn(['blue'], "==========================================================");
        

        /*
        exec(implode(' ',['which','scss']),$result,$return_code);
        $sass_cmd = $result[0];

        exec(implode(' ',['which','sencha']),$result,$return_code);
        $sencha_cmd = $result[0];


        $installCommands = [
            'configuration --section scss --key cmd --value '.$sass_cmd,
            'configuration --section ext-compiler --key sencha_compiler_command --value '. $sencha_cmd,
            // 'configuration --section ext-compiler --key requires --value "exporter"',
        ];
        foreach($installCommands as $cmdString){
            self::performInstall($cmdString,'');
        }
        */

        $installCommands = [
            'install-sessionsql-bsc-main',
            'install-sql-sessionviews',
            'install-sql-bsc-main-ds',
            'install-sql-bsc-menu',
            'install-sql-ds-main',
            'install-sql-ds',
            'install-sql-ds-dsx',
            'install-sql-ds-privacy',
            'install-sql-ds-docsystem',
            'install-sql-tualojs',
            'install-sql-monaco',
            'install-sql-dashboard',
            'install-sql-bootstrap'
            // 'compile'
        ];
 
        foreach($installCommands as $cmdString){
            self::performInstall($cmdString,$clientName);
        }

    }
}
