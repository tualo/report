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
        $db = App::get('session')->getDB();

        $sql = str_replace('#####',$config['tabellenzusatz'],$sql);
        $sql = str_replace('#BEZ#',$config['adress_bezug'],$sql);
        $sql = str_replace('#BEZUG#',$config['adress_bezug'],$sql);
        $sql = str_replace('#BLG_CONFIG_ID#',$config['adress_bezug'],$sql);
        $sql = str_replace('#id_column#',$config['bezug_id'],$sql);

        $db->direct('UNLOCK TABLES');
        $sql = str_replace('#BEZDISPLAY#',$db->singleValue(
            'select displayfield from ds where table_name={tn}',['tn'=>$config['adress_bezug']],'displayfield'
        ),$sql);
        

        $sql = str_replace('#BEZUG_ID_REF#','bezug.`'.$config['bezug_id'].'`',$sql);
        $db->direct('UNLOCK TABLES');

        if ($db->singleValue(
            'select column_name from ds_column a
                join blg_config b on a.table_name=b.adress_bezug
                    and a.column_name = b.bezug_kst
                    and a.existsreal=1
                    and b.id = {id}
            ',$config,'column_name'
        )){
            $sql = str_replace('#KST_REF#',',`'.$config['bezug_kst'].'`',$sql);
            $sql = str_replace('#KST_REF0#','`'.$config['bezug_kst'].'`',$sql);
            $sql = str_replace('#BEZUG_KST_REF0#',',bezug.`'.$config['bezug_kst'].'`',$sql);
        }else{
            $sql = str_replace('#KST_REF#','',$sql);
            $sql = str_replace('#BEZUG_KST_REF0#',',0',$sql);
            $sql = str_replace('#KST_REF0#','0',$sql);
        }
        if (isset($_REQUEST['force']) && ($_REQUEST['force']==1)){
            $sql = str_replace('INSERT IGNORE INTO ','REPLACE INTO ',$sql);
        }
        return $sql;
    }

    public static function register(){
        Route::add('/reportsetup/(?P<type>\w+)',function($matches){
            $db = App::get('session')->getDB();


            try{
                $templates = [
                    '0001.sql',
                    '0002.sql',
                    '0003.sql',
                    '0100.sql' ,
                    'view_editor_blg_hdr_xzy.sql',
                    'view_editor_blg_pos_xzy.sql' ,
                    'view_editor_relation_xyz.sql' ,
                    'view_blg_list_xzy.sql',
                    'view_report_blg_taxes_xyz.sql',
                    'view_report_blg_taxes_xyz.sql',
                    'zugferd.seller.information.sql',
                    'zugferd.buyer.information.sql'
                ];
                
                $config=$db->directSingleHash('select * from blg_config where tabellenzusatz={type}',$matches);
                if ($config===false) throw new Exception('no config found');

                $config['tabellenzusatz']=strtolower($config['tabellenzusatz']);
                $sqls=[];
                if (isset($_REQUEST['force']) && ($_REQUEST['force']==1)){
                    $db->direct('delete from ds_column_list_label where table_name={tn}',['tn'=>'view_editor_blg_pos_'.$config['tabellenzusatz']]);
                    $db->direct('delete from ds_column_form_label where table_name={tn}',['tn'=>'view_editor_blg_hdr_'.$config['tabellenzusatz']]);
                    $db->direct('delete from ds_column_form_label where table_name={tn}',['tn'=>'view_editor_relation_'.$config['tabellenzusatz']]);
                    $db->direct('delete from ds_column_list_label where table_name={tn}',['tn'=>'view_blg_list_'.$config['tabellenzusatz']]);

                    $db->direct('delete from ds where table_name={tn}',['tn'=>'view_blg_list_'.$config['tabellenzusatz']]);
                    $db->direct('delete from ds where table_name={tn}',['tn'=>'view_editor_blg_hdr_'.$config['tabellenzusatz']]);
                    $db->direct('delete from ds where table_name={tn}',['tn'=>'view_editor_blg_pos_'.$config['tabellenzusatz']]);
                    $db->direct('delete from ds where table_name={tn}',['tn'=>'view_editor_relation_'.$config['tabellenzusatz']]);
                    
                }
                foreach($templates as $template){
                    $commands = $db->explode_by_delimiter(file_get_contents(dirname(__DIR__,1).'/sql/template/'.$template));
                    $sqls[$template]=[];
                    foreach($commands as $command){
                        $sqls[$template][] = self::replacements($command,$config);
                        $db->direct('UNLOCK TABLES');
                        $db->direct(self::replacements($command,$config));
                    }
                }
                App::result('success', true);
                App::result('commands', $sqls);
               
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