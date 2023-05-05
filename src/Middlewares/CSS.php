<?php

namespace Tualo\Office\Report\Middlewares;
use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\IMiddleware;

class CSS implements IMiddleware{
    public static function register(){
        TualoApplication::use('blg_css_middleware',function(){
            try{
                //TualoApplication::stylesheet("./dssytle/shake.css" ,100000);
            }catch(\Exception $e){
                TualoApplication::set('maintanceMode','on');
                TualoApplication::addError($e->getMessage());
            }
        },-100); // should be one of the last
    }
}