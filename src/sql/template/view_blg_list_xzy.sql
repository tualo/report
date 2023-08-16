
CREATE OR REPLACE PROCEDURE `fibuconv_plenty`( )
BEGIN 

    declare incorrect_string_type int default 0;
    declare incorrect_column_type int default 0;
    declare incorrect_table_type int default 0;
    declare incorrect_column_count int default 0;
    declare incorrect_cursor int default 0;

    DECLARE incorrect_string CONDITION FOR SQLSTATE '22007';
    DECLARE incorrect_column CONDITION FOR SQLSTATE '42S22';
    DECLARE incorrect_cursor_e2 CONDITION FOR SQLSTATE '24000';
    DECLARE incorrect_columncount CONDITION FOR SQLSTATE '21S01';
    

    DECLARE CONTINUE HANDLER FOR incorrect_column SET incorrect_column_type = 1;
    DECLARE CONTINUE HANDLER FOR incorrect_columncount SET incorrect_column_count = 1;
    DECLARE CONTINUE HANDLER FOR incorrect_string SET incorrect_string_type = 1;
    DECLARE CONTINUE HANDLER FOR incorrect_cursor_e2 SET incorrect_cursor = 1;

    /*

    DECLARE incorrect_table CONDITION FOR SQLSTATE '42S02';
    DECLARE incorrect_cursor_e CONDITION FOR SQLSTATE '24099';
    
    DECLARE incorrect_columncount CONDITION FOR SQLSTATE '42000';
    

    DECLARE CONTINUE HANDLER FOR incorrect_cursor_e SET incorrect_cursor = 1;
    DECLARE CONTINUE HANDLER FOR incorrect_cursor_e2 SET incorrect_cursor = 1;
    DECLARE CONTINUE HANDLER FOR incorrect_column SET incorrect_column_type = 1;
    DECLARE CONTINUE HANDLER FOR incorrect_columncount SET incorrect_column_count = 1;
    DECLARE CONTINUE HANDLER FOR incorrect_table SET incorrect_table_type = 1;
    */
/*
    alter table fibuconv_uploaded_files add incorrect_string_type tinyint default 0;
    alter table fibuconv_uploaded_files add incorrect_column_type tinyint default 0;
    alter table fibuconv_uploaded_files add incorrect_table_type tinyint default 0;
    alter table fibuconv_uploaded_files add incorrect_column_count tinyint default 0;
    alter table fibuconv_uploaded_files add detected_type varchar(255) default null;
    alter table fibuconv_uploaded_files add detected_charset varchar(255) default null;

    alter table fibuconv_uploaded_files add processed_report tinyint default 0;
*/
FOR files IN (
    select * from  fibuconv_uploaded_files where 
        detected_type='plenty2018'
        and filename like '%DATEV_2022%'
    -- and id  in ('145a1bfc-cc10-11ea-9001-0cc47a979684')
) DO
    -- alter table fibuconv_uploaded_files add incorrect_string_type tinyint default 0;
        select files.id,files.filename,incorrect_string_type,files.detected_charset;
        set incorrect_string_type = 0;
        if (files.detected_charset='utf16le') then
            set @d = ( select HTML_UnEncode(from_base64(CONVERT(data  USING utf16le))) names from fibuconv_uploaded_files_data where  id = files.id );
        end if;
        if (files.detected_charset='latin1') then
            set @d = ( select HTML_UnEncode(from_base64(CONVERT(data  USING latin1))) names from fibuconv_uploaded_files_data where  id = files.id );
        end if;
        if (files.detected_charset='utf8') then
            set @d = ( select HTML_UnEncode(from_base64( data )) names from fibuconv_uploaded_files_data where  id = files.id );
        end if;

        select incorrect_string_type;


    if (incorrect_string_type = 0) then
        drop table if exists sample;
        drop table if exists mat_sample;
        drop table if exists temp_csv_lines;
        drop table if exists temp_csv_columns;
        call csv_to_table(@d,char(10),char(59),'sample');

        set incorrect_column_type = 0;
        set incorrect_column_count = 0;
        set incorrect_table_type=0;
        set incorrect_cursor=0;

        select files.id,files.filename,incorrect_string_type,'x' x;
        -- create table mat_sample as select * from sample;
        select files.id,files.filename,incorrect_string_type,'y' x;
        select incorrect_column_type;
        if (incorrect_column_type=0 and incorrect_column_count=0 and incorrect_table_type=0) then
        select `Rechn.-Nr. (Belegfeld 1)` from sample;
            for reports in (

                    select 
                    json_object(
                        "id", `Rechn.-Nr. (Belegfeld 1)`,
                        "date", str_to_date(`Belegdatum`,'%d.%m.%Y %H:%i'),
                        "time", cast(str_to_date(`Belegdatum`,'%d.%m.%Y %H:%i') as time),
                        
                        "bookingdate", str_to_date(`Belegdatum`,'%d.%m.%Y %H:%i'),
                        "service_period_start", str_to_date(`Belegdatum`,'%d.%m.%Y %H:%i'),
                        "service_period_stop", str_to_date(`Belegdatum`,'%d.%m.%Y %H:%i'),
                        "warehouse", 0,
                        "reference", `Order ID (Belegfeld 2)`,
                        "filename",files.filename,
                        "fileid",files.id,
                        "zusatzinfo", `Zusatzinfo Inhalt`,
                        "zusatzinfo2", `Zusatzinfo Inhalt 2`,
                        "zahlungsart", zahlungsart,
                        "paymentid", 
                            if( 
                                    zahlungsart in (
                                            'Amazon Pay',
                                            'Amazon Payments',
                                            'eBay Payment',
                                            'Kaufland.de Payment',
                                            'Metro Paypal',
                                            'OTTO Payment',
                                            'idealo Direktkauf',
                                            'Paypal',
                                            'Paypal Plus (Lastschrift, Kreditkarte, Kauf auf Rechnung)',
                                            'PayPal Express'
                                    ) ,
                                    `Zusatzinfo Inhalt`,
                                    if( 
                                    zahlungsart in (
                                            'PayPal Plus'
                                    ) ,
                                    `Zusatzinfo Inhalt 2`,null
                                    )
                            ),
                            
                            
                            
                            
                        "referencenr", kundennummer,
                        "costcenter", kostenstelle,
                        "iso", `Rechnungsanschrift Land ISO`,
                        "address", concat(`Firma`,char(10),`Vorname`,' ',`Nachname`),
                        "companycode", "0000",
                        "office", 1,
                        "positions",
                            json_arrayagg(
                                    pos
                            )

                    ) c
                    from (
                        select 
                            adressen.kundennummer,
                            adressen.kostenstelle,
                            sample.*,
                            json_object(
                                "id", `Rechn.-Nr. (Belegfeld 1)` * 1000 + row_number() over (partition by `Rechn.-Nr. (Belegfeld 1)`  order by `Gegenkonto (Erlöskonto)`),
                                "article", `Zusatzinfo Art 2`,
                                "position", row_number() over ( partition by `Rechn.-Nr. (Belegfeld 1)` order by `Gegenkonto (Erlöskonto)`),
                                "account", `Gegenkonto (Erlöskonto)`,
                                "amount", 1.00000,
                                "notes", null,
                                "additionaltext", "",
                                "singleprice", if(`Soll-Haben`='S',1,-1) * ( german_to_decimal(`Rechnungsbetrag (brutto in Systemwährung)`) - german_to_decimal(`MwSt in Systemwährung`) ),
                                "tax", 19.00000,
                                "net", if(`Soll-Haben`='S',1,-1) * ( german_to_decimal(`Rechnungsbetrag (brutto in Systemwährung)`) - german_to_decimal(`MwSt in Systemwährung`) ),
                                "taxvalue", if(`Soll-Haben`='S',1,-1) * german_to_decimal(`MwSt in Systemwährung`),
                                "gross", if(`Soll-Haben`='S',1,-1) * german_to_decimal(`Rechnungsbetrag (brutto in Systemwährung)`)
                            ) pos
                        from sample join adressen 
                        on `Kunde ID`=adressen.kundennummer
                        and postid = md5(concat(
                            trim(ifnull(sample.kunde,'')),
                            trim(ifnull(sample.firma,'')),
                            trim(ifnull(sample.vorname,'')),
                            trim(ifnull(sample.nachname,'')),
                            trim(ifnull(sample.`rechnungsanschrift land iso`,''))
                        ))
                    ) sample
                    group by `Rechn.-Nr. (Belegfeld 1)`


            ) do
                    select reports.c;
                    call setReport('plenty',reports.c,@o);

            end for;
                if (incorrect_table_type=0) then    
                    update fibuconv_uploaded_files set processed_report=1;
                end if;


        end if; -- incorrect column
    end if; -- incorrect type

END FOR;




END //