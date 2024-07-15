DELIMITER //  

CREATE OR REPLACE PROCEDURE `reportArticleCombinations`( in request JSON, out result JSON )
BEGIN


    SET result = JSON_OBJECT();

    SET @SQL = concat('select 
        json_arrayagg(
        json_object(
            "triggerarticle",triggerartikel,
            "resultarticle",resultartikel,
            "result_amount_factor",resultfaktor,
            "result_price_factor",resultpfaktor,
            "original_price",originalpreis
        )) as obj
    into 
        @obj
    from 
        kombiartikel 
    where triggerartikel = ',QUOTE(JSON_VALUE(request,'$.position.article')));

select @SQL;

    PREPARE stmt FROM @SQL;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET result = @obj;

END //
