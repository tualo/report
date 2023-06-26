<?php
namespace Tualo\Office\Report\Routes;
use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route ;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class Configure implements IRoute{
    public static function replacements($sql,$config){
        $sql = str_replace('#####',$config['tabellenzusatz'],$sql);
        $sql = str_replace('#BEZ#',$config['adress_bezug'],$sql);
        $sql = str_replace('#BEZUG#',$config['adress_bezug'],$sql);
        $sql = str_replace('#BLG_CONFIG_ID#',$config['adress_bezug'],$sql);
        $sql = str_replace('#id_column#',$config['bezug_id'],$sql);

        $sql = str_replace('#BEZUG_ID_REF#','bezug.`'.$config['bezug_id'].'`',$sql);
        

        $db = App::get('session')->getDB();
        if ($db->singleValue(
            'select column_name from ds_column a
                join blg_config b on a.table_name=b.adress_bezug
                    and a.column_name = b.bezug_kst
                    and a.existsreal=1
                    and b.id = {id}
            ',$config,'column_name'
        )){
            $sql = str_replace('#KST_REF#',',`'.$config['bezug_kst'].'`',$sql);
            $sql = str_replace('#BEZUG_KST_REF0#',',bezug.`'.$config['bezug_kst'].'`',$sql);
        }else{
            $sql = str_replace('#KST_REF#','',$sql);
            $sql = str_replace('#BEZUG_KST_REF0#',',0',$sql);
        }
        return $sql;
    }

    public static function register(){
        Route::add('/report/configure/(?P<type>\w+)',function($matches){
            $db = App::get('session')->getDB();


            try{
                $templates = ['0001.sql','0002.sql','0003.sql','0100.sql','view_editor_blg_hdr_xzy.sql','view_editor_blg_pos_xzy.sql'];
                $config=$db->directSingleHash('select * from blg_config where tabellenzusatz={type}',$matches);
                if ($config===false) throw new Exception('no config found');
                foreach($templates as $template){
                    $commands = $db->explode_by_delimiter(file_get_contents(dirname(__DIR__,1).'/sql/template/'.$template));
                    foreach($commands as $command){
                        $db->direct(self::replacements($command,$config));
                    }
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