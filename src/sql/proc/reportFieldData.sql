DELIMITER //

create table if not exists `report_field_data_process` (
    `processname` varchar(128) not null,
    `active` tinyint(1) default 0,
    `created_at` timestamp default current_timestamp,
    `updated_at` timestamp default current_timestamp on update current_timestamp,
    primary key (`processname`)
) // 

alter table `report_field_data_process` add column if not exists `execute_order` int default 0 after `active` //

create table if not exists `report_field_data_process_reporttypes` (
    `processname` varchar(128) not null,
    `reporttype` varchar(20) not null,
    `active` tinyint(1) default 0,
    `created_at` timestamp default current_timestamp,
    `updated_at` timestamp default current_timestamp on update current_timestamp,
    constraint `fk_report_field_data_process_reporttypes_processname` foreign key (`processname`) 
    references `report_field_data_process` (`processname`) on delete cascade on update cascade,

    /*
    constraint `fk_report_field_data_process_reporttypes_reporttype` foreign key (`reporttype`) 
    references `blg_config` (`tabellenzusatz`) on delete cascade on update cascade,
    */
    primary key (`processname`, `reporttype`)
) // 


create table if not exists `report_field_data_process_fieldnames` (
    `processname` varchar(128) not null,
    `fieldname` varchar(128) not null,
    `active` tinyint(1) default 0,
    `created_at` timestamp default current_timestamp,
    `updated_at` timestamp default current_timestamp on update current_timestamp,
    constraint `fk_report_field_data_process_fieldnames_processname` foreign key (`processname`) 
    references `report_field_data_process` (`processname`) on delete cascade on update cascade,
    primary key (`processname`, `fieldname`)
) // 


CREATE OR REPLACE PROCEDURE `reportFieldProcessDefaultAccount`( in request JSON, out result JSON) 
COMMENT 'sets default account if not set, do not overwrite this process. just create a new one with same name and add your own logic, then set this process to inactive'
BEGIN
    SET result = JSON_OBJECT();
    SET result = JSON_INSERT(result, '$.value', '0000');
    IF (JSON_EXISTS(request, '$.position.account') = 1) and JSON_VALUE(request, '$.position.account') is not null then
        SET result = JSON_INSERT(result, '$.value', JSON_VALUE(request, '$.position.account'));
        SET result = JSON_INSERT(result, '$.message', 'account already set, no default account set');
    ELSE
        SET result = JSON_INSERT(result, '$.value', '0000');
    END IF;

    SET result = JSON_INSERT(result, '$.modified', 1=1);
    SET result = JSON_INSERT(result, '$.message', 'account set to default_account');
END //


CREATE OR REPLACE PROCEDURE `reportFieldProcessDefaultSinglePrice`( in request JSON, out result JSON) 
COMMENT 'sets default single price if not set, do not overwrite this process. just create a new one with same name and add your own logic, then set this process to inactive'
BEGIN
    SET result = JSON_OBJECT();
    IF (JSON_EXISTS(request, '$.position.singleprice') = 1) and JSON_VALUE(request, '$.position.singleprice') is not null then
        SET result = JSON_INSERT(result, '$.value', JSON_VALUE(request, '$.position.singleprice'));
        SET result = JSON_INSERT(result, '$.message', 'singleprice already set, no default singleprice set');
    ELSE
        SET result = JSON_INSERT(result, '$.value', 9.99);
    END IF;

    SET result = JSON_INSERT(result, '$.modified', 1=1);
    SET result = JSON_INSERT(result, '$.message', 'singleprice set to default_singleprice');

END //




CREATE OR REPLACE PROCEDURE `reportFieldProcessDefaultTax`( in request JSON, out result JSON) 
COMMENT 'sets default tax if not set, do not overwrite this process. just create a new one with same name and add your own logic, then set this process to inactive'
BEGIN
    SET result = JSON_OBJECT();
    IF (JSON_EXISTS(request, '$.position.tax') = 1) and JSON_VALUE(request, '$.position.tax') is not null then
        SET result = JSON_INSERT(result, '$.value', JSON_VALUE(request, '$.position.tax'));
        SET result = JSON_INSERT(result, '$.message', 'tax already set, no default tax set');
    ELSE
        SET result = JSON_INSERT(result, '$.value', 19);
    END IF;
    SET result = JSON_INSERT(result, '$.modified', 1=1);
    SET result = JSON_INSERT(result, '$.message', 'tax set to default_tax');
END //


insert ignore into report_field_data_process (processname, active, execute_order) values ('reportFieldProcessDefaultAccount', 1, 0) //
insert ignore into report_field_data_process (processname, active, execute_order) values ('reportFieldProcessDefaultSinglePrice', 1, 0) //
insert ignore into report_field_data_process (processname, active, execute_order) values ('reportFieldProcessDefaultTax', 1, 0) //

insert ignore into report_field_data_process_fieldnames (processname,fieldname, active) values ('reportFieldProcessDefaultAccount', 'account', 1) //
insert ignore into report_field_data_process_fieldnames (processname,fieldname, active) values ('reportFieldProcessDefaultSinglePrice', 'singleprice', 1) //
insert ignore into report_field_data_process_fieldnames (processname,fieldname, active) values ('reportFieldProcessDefaultTax', 'tax', 1) //

insert ignore into report_field_data_process_reporttypes (processname, reporttype, active) values ('reportFieldProcessDefaultAccount', 'rechnung', 1) //
insert ignore into report_field_data_process_reporttypes (processname, reporttype, active) values ('reportFieldProcessDefaultSinglePrice', 'rechnung', 1) //
insert ignore into report_field_data_process_reporttypes (processname, reporttype, active) values ('reportFieldProcessDefaultTax', 'rechnung', 1) //

insert ignore into report_field_data_process_reporttypes (processname, reporttype, active) values ('reportFieldProcessDefaultAccount', 'krechnung', 1) //
insert ignore into report_field_data_process_reporttypes (processname, reporttype, active) values ('reportFieldProcessDefaultSinglePrice', 'krechnung', 1) //
insert ignore into report_field_data_process_reporttypes (processname, reporttype, active) values ('reportFieldProcessDefaultTax', 'krechnung', 1) //


CREATE OR REPLACE PROCEDURE `reportFieldData`(in fieldName VARCHAR(128), in request JSON, out result JSON) 
BEGIN
    SET result = JSON_OBJECT();
    SET result = JSON_INSERT(result, '$.modified', 0=1);
    SET result = JSON_INSERT(result, '$.message', 'no process found for fieldname');
    SET result = JSON_INSERT(result, '$.value', JSON_VALUE(request, concat('$.position.', fieldName)));
    for process in (
        select 
            p.processname 
        
        from
            report_field_data_process p 
            join report_field_data_process_fieldnames f
                on p.processname = f.processname
                    and f.fieldname = fieldName 
                    and f.active = 1
                    and p.active = 1
            join report_field_data_process_reporttypes r
                on r.processname = p.processname
                    and r.reporttype = JSON_VALUE(request, '$.header.reporttype') 
                    and r.active = 1
    ) do
        SET result = JSON_INSERT(result, '$.message', CONCAT('process found for fieldname: ', process.processname));
        SET request = JSON_INSERT(request, '$.fieldName', fieldName);

        SET @SQL = CONCAT('call `', process.processname, '`(', quote(request), ', @o)');
        PREPARE stmt
        FROM @SQL;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        select @o;
        SET result = JSON_MERGE_PATCH(result, @o);
    end for;
END //