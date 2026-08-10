create table report_states (
    id integer primary key,
    name varchar(50) not null
);

insert ignore into report_states (id,name) values (0,'unbekannt'),(1,'angenommen'),(2,'abgelehnt'),(3,'zurückgezogen');


update blg_hdr_calculation set state=0 where state is null;
update blg_hdr_calculation set state=1 where approved ='Y';
update blg_hdr_calculation set state=2 where approved ='N';

