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
        return $data;
    }
}