
create or replace view  view_blg_additional_information_rechnung as
with base as (
-- create or replace view  view_blg_additional_information_rechnung as
    select 
        h.id,
        j.job_number,
        j.job_name,
        h.jobid,
        j.order_date,
        j.order_number,
        j.delivery_date,
        a.skonto,
        a.skontotage,
        a.zahlungsziel,
        a.kundenkonto,
        concat(
            'Ihre Zahlungsbedingungen:  ',
            if(a.skontotage=0 or a.skonto=0,'', concat(a.skontotage,' Tage mit ', a.skonto ,'% Skonto oder ')),
            a.zahlungsziel,' Tage netto'
        ) as zahlungsbedingungen,
        json_object(
            'id', primary_contact.id,
            'vorname', primary_contact.vorname,
            'nachname', primary_contact.nachname,
            'telefon', primary_contact.telefon,
            'email', primary_contact.email
        ) as primary_contact,
        json_object(
            'id', supervisor.id,
            'vorname', supervisor.vorname,
            'nachname', supervisor.nachname,
            'telefon', supervisor.telefon,
            'email', supervisor.email
        ) as supervisor,
        json_object(
            'id', manager.id,
            'vorname', manager.vorname,
            'nachname', manager.nachname,
            'telefon', manager.telefon,
            'email', manager.email
        ) as manager,
        json_object(
            'id', view_session_loginnamen.login,
            'vorname', view_session_loginnamen.vorname,
            'nachname', view_session_loginnamen.nachname
        ) as ansprechpartner
    from 
        blg_hdr_rechnung h
        join tualo_job j
            on h.jobid = j.id
            and h.id = getRequestParameterBigInteger('id')
        join adressen a
            on (j.kundennummer,j.kostenstelle) = (a.kundennummer,a.kostenstelle)
        left join mitarbeiter primary_contact
            on primary_contact.id = j.primary_contact
        left join mitarbeiter supervisor
            on supervisor.id = j.supervisor
        left join mitarbeiter manager
            on manager.id = j.manager
        left join view_session_loginnamen
            on view_session_loginnamen.login = h.login
)
select
    base.*
from base
    
;


create or replace view  view_blg_additional_information_angebot as
with base as (
-- create or replace view  view_blg_additional_information_rechnung as
    select 
        h.id,
        j.job_number,
        j.job_name,
        h.jobid,
        j.order_date,
        j.order_number,
        j.delivery_date,
        a.skonto,
        a.skontotage,
        a.zahlungsziel,
        a.kundenkonto,
        concat(
            'Ihre Zahlungsbedingungen:  ',
            if(a.skontotage=0 or a.skonto=0,'', concat(a.skontotage,' Tage mit ', a.skonto ,'% Skonto oder ')),
            a.zahlungsziel,' Tage netto'
        ) as zahlungsbedingungen,
        json_object(
            'id', primary_contact.id,
            'vorname', primary_contact.vorname,
            'nachname', primary_contact.nachname,
            'telefon', primary_contact.telefon,
            'email', primary_contact.email
        ) as primary_contact,
        json_object(
            'id', supervisor.id,
            'vorname', supervisor.vorname,
            'nachname', supervisor.nachname,
            'telefon', supervisor.telefon,
            'email', supervisor.email
        ) as supervisor,
        json_object(
            'id', manager.id,
            'vorname', manager.vorname,
            'nachname', manager.nachname,
            'telefon', manager.telefon,
            'email', manager.email
        ) as manager,
        json_object(
            'id', view_session_loginnamen.login,
            'vorname', view_session_loginnamen.vorname,
            'nachname', view_session_loginnamen.nachname
        ) as ansprechpartner
    from 
        blg_hdr_angebot h
        join tualo_job j
            on h.jobid = j.id
            and h.id = getRequestParameterBigInteger('id')
        join adressen a
            on (j.kundennummer,j.kostenstelle) = (a.kundennummer,a.kostenstelle)
        left join mitarbeiter primary_contact
            on primary_contact.id = j.primary_contact
        left join mitarbeiter supervisor
            on supervisor.id = j.supervisor
        left join mitarbeiter manager
            on manager.id = j.manager
        left join view_session_loginnamen
            on view_session_loginnamen.login = h.login
)
select
    base.*
from base
    
;