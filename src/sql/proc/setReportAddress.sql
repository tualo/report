delimiter //

CREATE OR REPLACE PROCEDURE setReportAddress( in reporttype varchar(20), in in_json JSON, in reportid bigint, out result JSON )
COMMENT '
'
BEGIN

    DECLARE dsx_request JSON;
    DECLARE MSG VARCHAR(4000);

    SET result = JSON_OBJECT(
        'success', 1,
        'message', 'Referencenr data processed successfully'
    );

    IF JSON_EXISTS(in_json,'$.referencenr') THEN 
      set dsx_request=JSON_OBJECT(
          'tablename',concat('xxx'),
          'data', JSON_ARRAY( ),
          'type', 'insert',
          'update', 1 = 1
      );

        set dsx_request=JSON_SET(dsx_request,'$.data',
          JSON_ARRAY(
            JSON_OBJECT(
              "id",reportid,
              "adresse", JSON_VALUE(in_json,'$.address')
            )
          )
        );
        set dsx_request=JSON_SET(dsx_request,'$.tablename',concat('blg_adr_', reporttype));
        call dsx_rest_api_set(dsx_request, result);
        if JSON_VALUE(result,'$.success')=0 then
            SET MSG = concat('Referencenr could not be saved: ', JSON_VALUE(result,'$.error'));
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
        end if;

    END IF;

END //