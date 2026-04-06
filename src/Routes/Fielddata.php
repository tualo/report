<?php

namespace Tualo\Office\Report\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class Fielddata extends \Tualo\Office\Basic\RouteWrapper
{
    public static function register()
    {
        Route::add('/reportdata/(?P<fieldname>\w+)', function ($matches) {
            $db = App::get('session')->getDB();


            try {
                $payload = json_decode(file_get_contents('php://input'), true);
                $db->direct(
                    'call `reportFieldData`({fieldname}, {payload}, @o)',
                    [
                        'fieldname' => $matches['fieldname'],
                        'payload' => json_encode($payload)
                    ]
                );
                App::result('moreResults', $db->moreResults());
                $result = json_decode($db->singleValue('select @o o', [], 'o'), true);
                foreach ($result as $key => $value) {
                    App::result($key, $value);
                }
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            Route::$finished = true;
            App::contenttype('application/json');
        }, ['post'], true);
    }
};
