

insert into extjs_base_types (
        vendor, id, classname, xtype_long_classic,
        baseclass, xtype_long_modern, name, description,
        iscolumn,
        isformfield
    )
values
    (
        "Tualo",                              
        "Tualo.report.data.field.TualoTaxValue",        
        "Tualo.report.data.field.TualoTaxValue",  
        "data.field.tualo_report_tax_value",
        "Ext.form.field.Number",              
        "data.field.tualo_report_tax_value",          
        "Tualo.report.data.field.TualoTaxValue",  
        "Report Single Price Field",
        0,
        0
    )
on duplicate key 
 update classname = values(classname), xtype_long_classic  = values(xtype_long_classic),
        baseclass  = values(baseclass), xtype_long_modern  = values(xtype_long_modern), name  = values(name), description  = values(description),
        iscolumn  = values(iscolumn),
        isformfield = values(isformfield)
;


insert into extjs_base_types (
        vendor, id, classname, xtype_long_classic,
        baseclass, xtype_long_modern, name, description,
        iscolumn,
        isformfield
    )
values
    (
        "Tualo",                              
        "Tualo.report.data.field.TualoSinglePrice",        
        "Tualo.report.data.field.TualoSinglePrice",  
        "data.field.tualo_report_single_price",
        "Ext.form.field.Number",              
        "data.field.tualo_report_single_price",          
        "Tualo.report.data.field.TualoSinglePrice",  
        "Report Single Price Field",
        0,
        0
    )
on duplicate key 
 update classname = values(classname), xtype_long_classic  = values(xtype_long_classic),
        baseclass  = values(baseclass), xtype_long_modern  = values(xtype_long_modern), name  = values(name), description  = values(description),
        iscolumn  = values(iscolumn),
        isformfield = values(isformfield)
;


insert into extjs_base_types (
        vendor, id, classname, xtype_long_classic,
        baseclass, xtype_long_modern, name, description,
        iscolumn,
        isformfield
    )
values
    (
        "Tualo",                              
        "Tualo.report.data.field.TualoAccount",        
        "Tualo.report.data.field.TualoAccount",  
        "data.field.tualo_report_account",
        "Ext.form.field.String",              
        "data.field.tualo_report_account",          
        "Tualo.report.data.field.TualoAccount",  
        "Report Account Field",
        0,
        0
    )
on duplicate key 
 update classname = values(classname), xtype_long_classic  = values(xtype_long_classic),
        baseclass  = values(baseclass), xtype_long_modern  = values(xtype_long_modern), name  = values(name), description  = values(description),
        iscolumn  = values(iscolumn),
        isformfield = values(isformfield)
;




insert into extjs_base_types (
        vendor, id, classname, xtype_long_classic,
        baseclass, xtype_long_modern, name, description,
        iscolumn,
        isformfield
    )
values
    (
        "Tualo",                              
        "Tualo.report.data.field.TualoTax",        
        "Tualo.report.data.field.TualoTax",  
        "data.field.tualo_report_tax",
        "Ext.form.field.Number",              
        "data.field.tualo_report_tax",          
        "Tualo.report.data.field.TualoTax",  
        "Report Tax Field",
        0,
        0
    )
on duplicate key 
 update classname = values(classname), xtype_long_classic  = values(xtype_long_classic),
        baseclass  = values(baseclass), xtype_long_modern  = values(xtype_long_modern), name  = values(name), description  = values(description),
        iscolumn  = values(iscolumn),
        isformfield = values(isformfield)
;



insert into extjs_base_types (
        vendor, id, classname, xtype_long_classic,
        baseclass, xtype_long_modern, name, description,
        iscolumn,
        isformfield
    )
values
    (
        "Tualo",                              
        "Tualo.report.data.field.TualoMaterial",        
        "Tualo.report.data.field.TualoMaterial",  
        "data.field.tualo_report_material",
        "Ext.form.field.Number",              
        "data.field.tualo_report_material",          
        "Tualo.report.data.field.TualoMaterial",  
        "Report Material Field",
        0,
        0
    )
on duplicate key 
 update classname = values(classname), xtype_long_classic  = values(xtype_long_classic),
        baseclass  = values(baseclass), xtype_long_modern  = values(xtype_long_modern), name  = values(name), description  = values(description),
        iscolumn  = values(iscolumn),
        isformfield = values(isformfield)
;




insert into extjs_base_types (
        vendor, id, classname, xtype_long_classic,
        baseclass, xtype_long_modern, name, description,
        iscolumn,
        isformfield
    )
values
    (
        "Tualo",                              
        "Tualo.report.data.field.NetFromGross",        
        "Tualo.report.data.field.NetFromGross",  
        "data.field.tualo_report_net_from_gross",
        "Ext.form.field.Number",              
        "data.field.tualo_report_net_from_gross",
        "Tualo.report.data.field.NetFromGross",  
        "Net From Gross Field",
        0,
        0
    )
on duplicate key 
 update classname = values(classname), xtype_long_classic  = values(xtype_long_classic),
        baseclass  = values(baseclass), xtype_long_modern  = values(xtype_long_modern), name  = values(name), description  = values(description),
        iscolumn  = values(iscolumn),
        isformfield = values(isformfield)
;


insert into extjs_base_types (
        vendor, id, classname, xtype_long_classic,
        baseclass, xtype_long_modern, name, description,
        iscolumn,
        isformfield
    )
values
    (
        "Tualo",                              
        "Tualo.report.data.field.SinglePriceFromNet",        
        "Tualo.report.data.field.SinglePriceFromNet",  
        "data.field.tualo_report_singleprice_from_net",
        "Ext.form.field.Number",              
        "data.field.tualo_report_singleprice_from_net",
        "Tualo.report.data.field.SinglePriceFromNet",  
        "Single Price From Net Field",
        0,
        0
    )
on duplicate key 
 update classname = values(classname), xtype_long_classic  = values(xtype_long_classic),
        baseclass  = values(baseclass), xtype_long_modern  = values(xtype_long_modern), name  = values(name), description  = values(description),
        iscolumn  = values(iscolumn),
        isformfield = values(isformfield)
;
