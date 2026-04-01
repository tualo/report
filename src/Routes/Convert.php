<?php

namespace Tualo\Office\Report\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route;
use Tualo\Office\Report\Report as R;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class Convert extends \Tualo\Office\Basic\RouteWrapper
{
    public static function register()
    {
        Route::add('/report-convert/(?P<fromtype>\w+)/(?P<fromid>\w+)/(?P<totype>\w+)', function ($matches) {

            $db = App::get('session')->getDB();
            try {
                $data = R::convert($matches['fromtype'], $matches['fromid'], $matches['totype']);
                App::result('data', $data);
                App::result('success', true);
            } catch (Exception $e) {
                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
