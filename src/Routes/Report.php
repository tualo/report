<?php
namespace Tualo\Office\Report\Routes;

use DateTime;
use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route ;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\Report\Report as R;
use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSTable;


class Report implements IRoute{
    public static function register(){
        Route::add('/report/(?P<type>\w+)/(?P<id>[\w\-]+)',function($matches){
            $db = App::get('session')->getDB();
            $type = $matches['type'];
            try{

                $postdata = json_decode(file_get_contents("php://input"),true);
                $db->direct('set @currentRequest = {postdata}',['postdata'=>json_encode($postdata)]);
                
                $data = R::get($type,$matches['id']);

                /*
                $db->direct('call `getReport`({type},{id},@o)',$matches);
                $data = json_decode( $db->singleValue('select @o report',$matches,'report'), true);
                */
                if (is_null($data)) throw new \Exception('Report not found');
                if ($matches['id']<0){
                        if ($postdata && isset($postdata['bezugsnummer'])){
                            $data['referencenr'] = $postdata['bezugsnummer'];
                        }else if ($postdata && isset($postdata['kundennummer'])){
                            $data['referencenr'] = $postdata['kundennummer'];
                        }else if ($postdata && isset($postdata['referencenr'])){
                            $data['referencenr'] = $postdata['referencenr'];
                        }

                        if (!isset($data['address']) || $data['address']==''){
                            $data['address'] = $db->singleValue(
                                'select address from view_editor_relation_'.$type.' where referencenr={referencenr} and costcenter={costcenter}',$data,'address'
                            );
                        }
                    
                }
                App::result('data',$data);

                App::result('success', true);
            }catch(Exception $e){
                App::result('last_sql', $db->last_sql );
                App::result('msg', $e->getMessage());
            }
            Route::$finished=true;
            App::contenttype('application/json');
        },['get','post'],true);

        Route::add('/rejectreport/(?P<type>\w+)/(?P<id>[\w\-]+)',function($matches){
            try{
                $db = App::get('session')->getDB();
                Route::$finished=true;  
                App::contenttype('application/json');
                $report = R::reject($matches['type'],$matches['id']);
                if (is_null($report)) throw new \Exception('Report not found');
                $db->direct('call recalculateHeader({type},{id})',[
                    'type'=>$matches['type'],
                    'id'=>$report['id']
                ]);
                $report = R::get($matches['type'],$report['id']);

                App::result('data',$report);
                App::result('success', true);
            }catch(Exception $e){
                App::result('msg', $e->getMessage());
            }
        },['get'],true);

        Route::add('/report/(?P<type>\w+)/(?P<id>[\w\-]+)',function($matches){
            $db = App::get('session')->getDB();
            $type = $matches['type'];
            try{
                $db->direct('start transaction');
                
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
                    App::result('mr',$db->moreResults());
                    $data = json_decode( $db->singleValue('select @result report',[],'report'), true);
                    App::result('data',$data);
                    App::result('success', true);


                $db->direct('commit');
            }catch(Exception $e){
                $db->direct('rollback');
                App::result('mr',$db->moreResults());
                App::result('last_sql', $db->last_sql );
                App::result('msg', $e->getMessage());
            }
            Route::$finished=true;
            App::contenttype('application/json');
        },['put'],true);
    }
};