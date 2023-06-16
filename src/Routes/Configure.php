<?php
namespace Tualo\Office\Report\Routes;
use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route ;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class Configure implements IRoute{
    public static function register(){
        Route::add('/report/configure/(?P<type>\w+)',function($matches){
            $db = App::get('session')->getDB();
            try{
                $templates = ['0001.sql','0002.sql','0003.sql','0100.sql'];
                foreach($templates as $template){
                    $db->direct(file_get_contents(basename(__DIR__).'/sql/template/'.$template),$matches);
                }
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