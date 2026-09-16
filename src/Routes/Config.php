<?php

namespace Tualo\Office\Report\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class Config extends \Tualo\Office\Basic\RouteWrapper
{
    public static function register()
    {
        Route::add('/reportconfig/(?P<type>\w+)', function ($matches) {
            $db = App::get('session')->getDB();
            try {


                $header = json_decode($db->singleValue('select json_extract(js,"$[0].items") x from view_ds_formtabs_pertable where table_name = "view_editor_blg_hdr_' . $matches['type'] . '"', [], 'x'), true);
                App::result('header', $header);
                $matches['table_name'] = 'blg_txt_' . $matches['type'];


                $sql_template = '
                    select 
                        xtype,
                        json_merge( json_object("xtype",xtype),ifnull( ds_form_field_additional_config.config,"{}")) json
                    from 
                        ds_column_form_label 
                        join blg_config on concat("blg_txt_",blg_config.tabellenzusatz)=ds_column_form_label.table_name
                            and fusstext=1
                        left join ds_form_field_additional_config
                            on (ds_form_field_additional_config.table_name,ds_form_field_additional_config.column_name) = (ds_column_form_label.table_name,ds_column_form_label.column_name)
                where 
                    ds_column_form_label.table_name={table_name} and ds_column_form_label.column_name="text"';
                $texts = json_decode($db->singleValue($sql_template, $matches, 'json'), true);

                App::result('foottext', $texts);

                $sql_template = '
                    select 
                        xtype,
                        json_merge( json_object("xtype",xtype),ifnull( ds_form_field_additional_config.config,"{}")) json
                    from 
                        ds_column_form_label 
                        join blg_config on concat("blg_txt_",blg_config.tabellenzusatz)=ds_column_form_label.table_name
                            and kopftext=1
                        left join ds_form_field_additional_config
                            on (ds_form_field_additional_config.table_name,ds_form_field_additional_config.column_name) = (ds_column_form_label.table_name,ds_column_form_label.column_name)
                where 
                    ds_column_form_label.table_name={table_name} and ds_column_form_label.column_name="text"';
                $texts = json_decode($db->singleValue($sql_template, $matches, 'json'), true);
                App::result('headtext', $texts);

                App::result('translations', [
                    'hdr' => $db->directHash('select * from blghdr_translations', [], 'json_attribute_name'),
                    'pos' => $db->directHash('select * from blgpos_translations', [], 'json_attribute_name')
                ]);

                App::result('renderer', $db->direct('select pug_template,label,useremote from ds_renderer where table_name={table_name}', ['table_name' => 'view_blg_list_' . $matches['type']],));

                try {
                    App::result('defaultheadtext', $db->singleValue('select txt from blg_config_headtext where belegid in (select id from blg_config where tabellenzusatz={tabellenzusatz})', ['tabellenzusatz' => '' . $matches['type']], 'txt') ?: '');
                    App::result('defaultfoottext', $db->singleValue('select txt from blg_config_foottext where belegid in (select id from blg_config where tabellenzusatz={tabellenzusatz})', ['tabellenzusatz' => '' . $matches['type']], 'txt') ?: '');
                } catch (Exception $e) {
                    App::result('defaultheadtext', '');
                    App::result('defaultfoottext', '');
                }



                App::result('success', true);
            } catch (Exception $e) {

                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
                //App::result('dq', implode("\n",$GLOBALS['debug_query']));

            }

            Route::$finished = true;
            App::contenttype('application/json');
        }, ['get', 'post'], true);
    }
};
