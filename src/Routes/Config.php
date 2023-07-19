<?php
namespace Tualo\Office\Report\Routes;
use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route ;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class Config implements IRoute{
    public static function register(){
        Route::add('/reportconfig/(?P<type>\w+)',function($matches){
            $db = App::get('session')->getDB();
            try{
                

                $header = json_decode( $db->singleValue('select json_extract(js,"$[0].items") x from view_ds_formtabs_pertable where table_name = "view_editor_blg_hdr_'.$matches['type'].'"',[],'x'), true );
                App::result('header', $header);
                $matches['table_name'] = 'blg_txt_'.$matches['type'];
                $texts = json_decode($db->singleValue('select json_object("xtype",xtype) json from ds_column_form_label 
                    join blg_config on concat("blg_txt_",blg_config.tabellenzusatz)=ds_column_form_label.table_name
                        and fusstext=1
                where table_name={table_name} and column_name="text" ',$matches,'json'),true);
                App::result('foottext', $texts);
                $texts = json_decode($db->singleValue('select json_object("xtype",xtype) json from ds_column_form_label 
                    join blg_config on concat("blg_txt_",blg_config.tabellenzusatz)=ds_column_form_label.table_name
                        and kopftext=1
                where table_name={table_name} and column_name="text" ',$matches,'json'),true);
                App::result('headtext', $texts);


                App::result('translations', [
                    'hdr'=> $db->directHash('select * from blghdr_translations',[],'json_attribute_name'),
                    'pos'=> $db->directHash('select * from blgpos_translations',[],'json_attribute_name')
                ]);

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