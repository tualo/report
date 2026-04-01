<?php

namespace Tualo\Office\Report\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class ConvertList extends \Tualo\Office\Basic\RouteWrapper
{
    public static function register()
    {
        Route::add('/report-convertlist/(?P<reportindex>\w+)', function ($matches) {

            $db = App::get('session')->getDB();
            try {
                App::result('data', $db->direct('select * from blg_config_converts  where bid1={reportindex}', $matches));
                App::result('success', true);
            } catch (Exception $e) {
                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
