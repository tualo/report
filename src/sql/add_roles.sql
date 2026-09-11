with base as (
select 'blg_adr_' b
union 
select 'blg_pos_' b
union 
select 'blg_hdr_' b
union 
select 'blg_txt_' b
union 
select 'blg_bkr_' b
), tn  as (
    select lower(tabellenzusatz) tn,adress_bezug from blg_config
), list as (
select 
    concat(base.b,tn.tn) tnx 
from
    tn,base
union 
select 
    concat('blg_',tn.adress_bezug,'_',tn.tn) tnx 
from
    tn,base
)
select 
concat("insert into ds_access (role,table_name,`read`,`write`,`delete`,`append`) values ('buchhaltung',",quote(list.tnx),",1,1,0,1) on duplicate key update `read`=values(`read`),`write`=values(`write`),`append`=values(`append`) ",char(59)) s
from list;


update ds set modelbaseclass='Tualo.DataSets.model.Basic' where modelbaseclass = 'tualo.datasets.model.basic';
update ds set base_store_class='Tualo.DataSets.data.Store' where base_store_class = 'tualo.datasets.data.store';

update ds_column set default_value=replace(table_name,'view_blg_list_','') where table_name like 'view_blg_list%' and column_name='tabellenzusatz' and default_value<>replace(table_name,'view_blg_list_','');

CREATE OR REPLACE  FUNCTION `getNewPositionID`() RETURNS bigint(20)
    DETERMINISTIC
BEGIN
    DECLARE res BIGINT;
    select concat( 
        rpad( UNIX_TIMESTAMP()  - 1780000000 ,9 ,'0')  ,
        lpad( cast( round(1000 * RAND()) as int) ,4 ,'0')
    ) into res;
    RETURN res;
END

update ds_column set default_value='{:getNewPositionID()}' where column_name='id'  and table_name in (
    
    select concat('blg_pos_',lower(tabellenzusatz)) tn from blg_config
) and (default_value IS NOT NULL or default_value='')