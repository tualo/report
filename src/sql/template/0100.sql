DELIMITER //


CREATE OR REPLACE PROCEDURE setupReportDS( in reporttype varchar(20))
BEGIN
    set @name = concat('view_editor_artikelgruppen');
    call fill_ds(@name);
    call fill_ds_column(@name);
    call fill_ds_reference_tables(@name);

    set @name = concat('view_report_blg_adr_',reporttype);
    call fill_ds(@name);
    call fill_ds_column(@name);
    call fill_ds_reference_tables(@name);
    
    set @name = concat('view_report_blg_taxes_',reporttype);
    call fill_ds(@name);
    call fill_ds_column(@name);
    call fill_ds_reference_tables(@name);

    set @name = concat('view_point_of_sale_belege_',reporttype);
    call fill_ds(@name);
    call fill_ds_column(@name);
    call fill_ds_reference_tables(@name);


    set @name = concat('view_report_blg_pos_',reporttype);
    call fill_ds(@name);
    call fill_ds_column(@name);
    call fill_ds_reference_tables(@name);


    set @name = concat('view_report_blg_hdr_',reporttype);
    call fill_ds(@name);
    call fill_ds_column(@name);
    call fill_ds_reference_tables(@name);


    set @name = concat('view_editor_blg_pos_',reporttype);
    call fill_ds(@name);
    call fill_ds_column(@name);
    call fill_ds_reference_tables(@name);

    set @name = concat('view_editor_blg_hdr_',reporttype);
    call fill_ds(@name);
    call fill_ds_column(@name);
    call fill_ds_reference_tables(@name);


    insert ignore into ds_column_list_label
    (
        table_name,
        column_name,
        language,
        label,
        editor,
        hidden,
        active
    )
    select 
        table_name,
        column_name,
        'DE' language,
        column_name label,
        'texteditor' editor,
        0 hidden,
        1 active
    from 
        ds_column
    where 
        table_name=concat('view_editor_blg_pos_',reporttype)
        and column_name in ('bemerkung')
    union 
        select 
            table_name,
            column_name,
            'DE' language,
            column_name label,
            'number2' editor,
            0 hidden,
            1 active
        from 
            ds_column
        where 
            table_name=concat('view_editor_blg_pos_',reporttype)
            and column_name in ('artikel','anzahl','epreis','netto','brutto','steuersatz','steuer')
            
    union 
        select 
            table_name,
            column_name,
            'DE' language,
            column_name label,
            'number2' editor,
            0 hidden,
            1 active
        from 
            ds_column
        where 
            table_name=concat('view_editor_blg_pos_',reporttype)
            and column_name in ('artikel')
    ;

END //


