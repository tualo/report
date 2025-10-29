<?php

namespace Tualo\Office\Report\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class Price extends \Tualo\Office\Basic\RouteWrapper
{
    public static function register()
    {
        Route::add('/report/price', function ($matches) {
            $db = App::get('session')->getDB();


            try {
                $payload = json_decode(file_get_contents('php://input'), true);
                $db->direct('call `reportArticleInformation`({payload},@o)', ['payload' => json_encode($payload)]);
                $db->moreResults();
                $result = json_decode($db->singleValue('select @o o', [], 'o'), true);
                foreach ($result as $key => $value) {
                    App::result($key, $value);
                }
                App::result('success', true);

                try {

                    $db->direct('call `reportArticleCombinations`({payload},@o)', ['payload' => json_encode($payload)]);
                    $db->moreResults();
                    $result = json_decode($db->singleValue('select @o o', [], 'o'), true);
                    if (!is_null($result)) {
                        foreach ($result as $index => $row) {
                            $p = $payload;
                            $p['position']['article'] = $row['resultarticle'];
                            $db->direct('call `reportArticleInformation`({payload},@o)', ['payload' => json_encode($p)]);
                            $db->moreResults();
                            $x = json_decode($db->singleValue('select @o o', [], 'o'), true);
                            $result[$index]['singleprice'] = $x['singleprice'];
                        }
                        App::result('combinations', $result);
                    }
                } catch (Exception $e) {
                    App::result('combination_msg', $e->getMessage());
                }
            } catch (Exception $e) {
                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
            Route::$finished = true;
            App::contenttype('application/json');
        }, ['post', 'get'], true);
    }
};
