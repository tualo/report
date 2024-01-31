<?php
namespace Tualo\Office\Report;

use Tualo\Office\Basic\TualoApplication as App;
class Report  {
    public static function convert(string $type, int $id, string $toType, int $factor=1):mixed{
        $db = App::get('session')->getDB();
        $report = Report::get($type,$id);
        $report['reporttype'] = $toType;
        $report['id'] = -1;
        foreach($report['positions'] as &$pos){
            
            $pos['taxvalue'] = $pos['taxvalue'] * $factor;
            $pos['amount'] = $pos['amount'] * $factor;
            $pos['net'] = $pos['net'] * $factor;
            $pos['gross'] = $pos['gross'] * $factor;

            unset($pos['id']);
            unset($pos['reportnr']);
        }

        $db->direct('set @report={report}',[
            'report'=>json_encode($report)
        ]);
        $db->direct('call setReport({type},@report,@result)',[
            'type'=>$toType,
            'report'=>json_encode($report)
        ]);

        App::result('mr',$db->moreResults());
        $data = json_decode( $db->singleValue('select @result report',[],'report'), true);
        return $data;
    }

    public static function reject(
        string $type, 
        string $reportnumber
    ):mixed{
        $report = self::convert($type,$reportnumber,$type,-1);
        return $report;
    }

    public static function set(
        string $type, 
        array $report
    ):mixed {
        $db = App::get('session')->getDB();
        if (is_null($report)) throw new \Exception('Report not readable');

        if (!isset($report['bookingdate']) || $report['bookingdate']=='') $report['bookingdate'] = (new \DateTime())->format('Y-m-d');
        if (!isset($report['date']) || $report['date']=='') $report['date'] = (new \DateTime())->format('Y-m-d');
        if (!isset($report['payuntildate']) || $report['payuntildate']=='') $report['payuntildate'] = (new \DateTime())->format('Y-m-d');
        if (!isset($report['service_period_stop']) || $report['service_period_stop']=='') $report['service_period_stop'] = (new \DateTime())->format('Y-m-d');
        if (!isset($report['service_period_start']) || $report['service_period_start']=='') $report['service_period_start'] = (new \DateTime())->format('Y-m-d');

        if (!isset($report['_in_warehouse']) || $report['_in_warehouse']=='') $report['_in_warehouse'] = 0;
        if (!isset($report['warehouse']) || $report['warehouse']=='') $report['warehouse'] = 0;
        if (!isset($report['order_id']) || $report['order_id']=='') $report['order_id'] = '';
        if (!isset($report['time']) || $report['time']=='') $report['time'] = (new \DateTime())->format('H:i:s');
        
        App::result('report',$report);
        $db->direct('set @report={report}',[
            'report'=>json_encode($report)
        ]);
        $db->direct('call setReport({type},@report,@result)',[
            'type'=>$type,
            'report'=>json_encode($report)
        ]);
        App::result('mr',$db->moreResults());
        return json_decode( $db->singleValue('select @result report',[],'report'), true);
    }
    
    public static function addReduction(
        string $type, 
        string $reportnumber, 
        float $amount, 
        string $name='Minderung',
        string $note=''
    ):int{
        $db = App::get('session')->getDB();
       
        try{

            $data['betrag']=$amount;
            $data['belegnummer']=$reportnumber;
            $data['name']=$name;
            $data['bemerkung']=$note;

            $db->execute('start transaction');
            $newID = $db->singleValue('select ifnull(max(id),0)+1 c from blg_pay_'.$type.'',[],'c');
            $data['id']=$newID;
            $db->direct('insert into blg_min_'.$type.' (
                id
                name
                belegnummer
                bemerkung
                betrag
            ) values 
            (
                {id}
                {name},
                {belegnummer},
                {bemerkung},
                {betrag}
            )
            where id = {id}',$data);
            $db->execute('commit');
            return $newID;
        }catch(\Exception $e){
            $db->execute('rollback');
            return -1;
        }
    }

    public static function addPayment(
        string $type, 
        string $reportnumber, 
        float $amount, 
        string $date='',
        string $paymenttype='Überweisung',
    ):int{
        $db = App::get('session')->getDB();
       
        if ($date=='') $date = date('Y-m-d'.time());
        try{
            $data['datum']=$date;
            $data['betrag']=$amount;
            $data['belegnummer']=$reportnumber;
            $data['art']=$paymenttype;

            $db->execute('start transaction');
            $newID = $db->singleValue('select ifnull(max(id),0)+1 c from blg_pay_'.$type.'',[],'c');
            $data['id']=$newID;
            $db->direct('insert into blg_pay_'.$type.' (
                id,
                datum,
                belegnummer,
                art,
                betrag
            ) values 
            (
                {id},
                {datum},
                {belegnummer},
                {art},
                {betrag}
            )
            ',$data);
            $db->execute('commit');
            return $newID;
        }catch(\Exception $e){
            App::result('sql',$db->last_sql);
            App::result('error',$e->getMessage());
            $db->execute('rollback');
            return -1;
        }
    }


    public static function recalculateHeader(string $type, int $id):bool{
        $db = App::get('session')->getDB();
        try{
            $db->direct('call recalculateHeader({type},{id})',[
                'type'=>$type,
                'id'=>$id
            ]);
            return true;
        }catch(\Exception $e){
            return false;
        }
    }


    public static function setHeader(string $type, int $id, array $data):bool{
        $db = App::get('session')->getDB();
        $data['id']=$id;
        try{
            $columns = array_keys($data);
            $flds = $db->singleValue('select group_concat(concat(column_name,"={",column_name,"}") separator ",") c from  ds_column where table_name="blg_hdr_'.$type.'" and existsreal=1 and column_name in ("'.implode('","',$columns).'") ',[],'c');
            $db->direct('update blg_hdr_'.$type.' set '.$flds.' where id = {id}',$data);
            return true;
        }catch(\Exception $e){
            return false;
        }
    }

    public static function get(string $type, int $id):mixed{
        $db = App::get('session')->getDB();
        $db->direct('call `getReport`({type},{id},@o)',[
            'type'=>$type,
            'id'=>$id
        ]);
        $data = json_decode( $db->singleValue('select @o report',[],'report'), true);
        if (is_null($data)) throw new \Exception('Report not found');

        try{
            $fusstextspalten = $db->direct('select * from view_blg_brieffusstextspalten');
            foreach($fusstextspalten as &$row){
                $zn = json_decode($row['zeilen'],true);
                $zr = [];
                foreach($zn as &$z){
                    if ( 
                        ($z['buchungskreis_id'] == $data['companycode']) && 
                        ($z['start_am'] <= $data['bookingdate']) && 
                        ($data['bookingdate'] <= $z['ende_am']) 
                    ){
                        $zr[] = $z;
                    }
                        
                }
                $row['zeilen'] = $zr;
            }
            $data['report_footer'] = $fusstextspalten;
        }catch(\Exception $e){
        }
        try{
            $data['girocode'] = $db->singleValue('select `getGiroCodeText'.$type.'`({id}) c',$data,'c');
        }catch(\Exception $e){
        }
        try{
            $data['report_title'] = $db->singleValue('select name from blg_config where tabellenzusatz = {reporttype}',$data,'name');
        }catch(\Exception $e){
        }
        try{
            $data['report_taxes'] = $db->direct('select * from view_report_blg_taxes_'.$type.' where beleg = {id}',$data,'');
        }catch(\Exception $e){
        }
        try{
            $data['report_images'] = [];
        }catch(\Exception $e){
        }
        try{
            $data['report_images'] = $db->direct('select * from  blg_images_'.$type.' where beleg = {id}',$data,'');
        }catch(\Exception $e){
        }
        try{
            $data['sender_address'] = $db->singleValue('select zusatztext from geschaeftsstellen where id={office}',$data,'zusatztext');
            if ($data['sender_address']===false){
                $data['sender_address'] = $db->singleValue('select max(zusatztext) from geschaeftsstellen',$data,'zusatztext');
            }
        }catch(\Exception $e){
        }


        return $data;
    }
}