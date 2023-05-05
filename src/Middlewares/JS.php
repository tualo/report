<?php

namespace Tualo\Office\Report\Middlewares;
use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\IMiddleware;

class JS implements IMiddleware{
    public static function register(){
        TualoApplication::use('blg_middleware',function(){
            try{

            }catch(\Exception $e){
                TualoApplication::set('maintanceMode','on');
                TualoApplication::addError($e->getMessage());
            }
        },-100); // should be one of the last
    }
}