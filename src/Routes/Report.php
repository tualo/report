<?php
namespace Tualo\Office\Report\Routes;
use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route ;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class Report implements IRoute{
    public static function register(){
        Route::add('/report/get/(?P<type>\w+)/(?P<id>\w+)',function($matches){
            $db = App::get('session')->getDB();
            $type = $matches['type'];
            
            try{
                App::result('data',json_decode( $db->singleValue('select `getReport_'.$type.'`({id}) as report',$matches,'report'), true));
                App::result('success', true);
                
            }catch(Exception $e){
        
                App::result('last_sql', $db->last_sql );
                App::result('msg', $e->getMessage());
                //App::result('dq', implode("\n",$GLOBALS['debug_query']));
        
            }

            Route::$finished=true;
            App::contenttype('application/json');
        },['get','post'],true);


    }
};