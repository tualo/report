delimiter //

create table if not exists blg_release_signature_angebot (
    id bigint not null,
    login varchar(255) not null,
    created_at timestamp not null default current_timestamp,
    primary key (id, login)
);
alter table blg_release_signature_angebot add column if not exists `value` decimal(15,6) default 0 //
//

alter table blg_hdr_angebot add column if not exists release_signature tinyint(1) default 0 //
alter table blg_hdr_angebot add column if not exists release_value decimal(15,2) default -1 //

create or replace procedure recalculaterelease(
    in p_type varchar(255),
    in p_id bigint
)
begin
    declare max_value decimal(15,6) default 0;
    -- procedure logic here
    if p_type = 'angebot' then
    
        select max(`value`) into max_value from blg_release_signature_angebot   
        where id = p_id;
        if max_value >= 0 then
            update blg_hdr_angebot  set release_signature = 1, release_value = max_value where id = p_id and release_signature = 0 and netto <= max_value;
        end if;
    end if;
end //

CREATE TRIGGER IF NOT EXISTS blg_release_signature_angebot_ai_released
AFTER INSERT  
ON blg_release_signature_angebot FOR EACH ROW
BEGIN
    
        replace into deferred_sql_tasks (
        taskid,
        sessionuser,
        state,
        createtime,
        sqlstatement,
        hostname
    ) values (
        concat("release_signature_angebot-", new.id),
        getSessionUser(),
        0,
        current_timestamp(),
        concat("call recalculaterelease('angebot',", new.id, "    );"),
        @@hostname
    );
    
    
END //


CREATE TRIGGER IF NOT EXISTS blg_hdr_angebot_ai_release_signature
AFTER INSERT  
ON blg_hdr_angebot FOR EACH ROW
BEGIN
    insert ignore into blg_release_signature_angebot (id, login)
    values (new.id, getSessionUser(), organigramm_zeichnungswert(getSessionUser()));
END //


create or replace procedure  setReleaseAngebot(
    in p_id bigint,
    out res tinyint,
    out msg varchar(100)
)
begin

    declare net decimal(15,5) default 0;
    declare zeichnungswert decimal(10,2) default 0;
    set zeichnungswert = organigramm_zeichnungswert(getSessionUser());

    select netto into net from blg_hdr_angebot where id = p_id;
    
   if zeichnungswert >= net then
       -- User has sufficient release value
       insert ignore into blg_release_signature_angebot (id, login, `value`)
       values (p_id, getSessionUser(), zeichnungswert);
       SET res= 1;
       SET msg='Sie haben das Angebot freigegeben';
   else
       SET res= 0;
       SET msg='Sie haben nicht genügend Zeichnungswert';
   end if;
 

end //
-- #ds-direct-procedure/setReleaseAngebot/{id}
delimiter ;


