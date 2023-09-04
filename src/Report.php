<?php
namespace Tualo\Office\Report;

use Tualo\Office\Basic\TualoApplication as App;
class Report  {
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
        }catch(\Exception $e){
        }


        return $data;
    }
}