
CREATE OR REPLACE PROCEDURE `reportArticleInformation`( in request JSON, out result JSON )
BEGIN

    SET result = JSON_OBJECT('request',request);

    SET result = JSON_INSERT(result,'$.tax', 19);
    SET result = JSON_INSERT(result,'$.singleprice', 19);
    SET result = JSON_INSERT(result,'$.account', 19);

    return result;
END //