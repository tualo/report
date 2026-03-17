delimiter //

CREATE TABLE IF NOT EXISTS blg_ds_templates (
    template_type varchar(255) not null,
    template_name varchar(255) not null,
    template longtext not null,
    primary key ( template_name)
) //

CREATE OR REPLACE PROCEDURE callReportDSSetup(in reporttype varchar(20)) 
BEGIN 


    FOR ds IN (SELECT template FROM blg_ds_templates WHERE template_type = 'ds') DO
        SET @SQL = replace(ds.template,'_rechnung',reporttype);
        SET @SQL = replace(@SQL,'Rechnung',(select max(name) from blg_config where tabellenzusatz = reporttype));
        PREPARE stmt FROM @SQL;
        execute stmt;
        DEALLOCATE PREPARE stmt;
    END FOR;

END //