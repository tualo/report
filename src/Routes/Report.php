<?php
namespace Tualo\Office\Report\Routes;

use DateTime;
use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route ;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class Report implements IRoute{
    public static function register(){
        Route::add('/report/(?P<type>\w+)/(?P<id>[\w\-]+)',function($matches){
            $db = App::get('session')->getDB();
            $type = $matches['type'];
            try{
                $db->direct('call `getReport`({type},{id},@o)',$matches);
                $data = json_decode( $db->singleValue('select @o report',$matches,'report'), true);
                if (is_null($data)) throw new \Exception('Report not found');
                App::result('data',$data);

                App::result('success', true);
            }catch(Exception $e){
                App::result('last_sql', $db->last_sql );
                App::result('msg', $e->getMessage());
            }
            Route::$finished=true;
            App::contenttype('application/json');
        },['get'],true);

        Route::add('/report/(?P<type>\w+)/(?P<id>[\w\-]+)',function($matches){
            $db = App::get('session')->getDB();
            $type = $matches['type'];
            try{
                $report = json_decode( file_get_contents('php://input'), true);
                if (is_null($report)) throw new \Exception('Report not readable');

                if (!isset($report['bookingdate']) || $report['bookingdate']=='') $report['bookingdate'] = (new DateTime())->format('Y-m-d');
                if (!isset($report['date']) || $report['date']=='') $report['date'] = (new DateTime())->format('Y-m-d');
                if (!isset($report['payuntildate']) || $report['payuntildate']=='') $report['payuntildate'] = (new DateTime())->format('Y-m-d');
                if (!isset($report['service_period_stop']) || $report['service_period_stop']=='') $report['service_period_stop'] = (new DateTime())->format('Y-m-d');
                if (!isset($report['service_period_start']) || $report['service_period_start']=='') $report['service_period_start'] = (new DateTime())->format('Y-m-d');

                if (!isset($report['_in_warehouse']) || $report['_in_warehouse']=='') $report['_in_warehouse'] = 0;
                if (!isset($report['warehouse']) || $report['warehouse']=='') $report['warehouse'] = 0;
                if (!isset($report['order_id']) || $report['order_id']=='') $report['order_id'] = '';
                if (!isset($report['time']) || $report['time']=='') $report['time'] = (new DateTime())->format('H:i:s');
                
                

                App::result('report',$report);
                
                $db->direct('set @report={report}',[
                    'report'=>json_encode($report)
                ]);
                $db->direct('call setReport({type},@report,@result)',[
                    'type'=>$matches['type'],
                    'report'=>json_encode($report)
                ]);
                $mr = $db->moreResults();
                $data = json_decode( $db->singleValue('select @result report',[],'report'), true);
                App::result('data',$data);
                App::result('success', true);
            }catch(Exception $e){
                App::result('last_sql', $db->last_sql );
                App::result('msg', $e->getMessage());
            }
            Route::$finished=true;
            App::contenttype('application/json');
        },['put'],true);
    }
};