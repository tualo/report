delimiter ;
insert into extjs_base_types (
        vendor, id, classname, xtype_long_classic,
        baseclass, xtype_long_modern, name, description,
        iscolumn,
        isformfield
    )
values
    (
        "Tualo",                              "Tualo.report.fields.NetInputField",        "Tualo.report.fields.NetInputField",  "widget.tualoreportnetinputfield",
        "Ext.form.field.Number",              "widget.tualoreportnetinputfield",          "Tualo.report.fields.NetInputField",  "Report Net Field",
        0,
        1
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
        "Tualo",                              "Tualo.report.fields.SinglePriceInputField",        "Tualo.report.fields.SinglePriceInputField",  "widget.tualoreportsinglepriceinputfield",
        "Ext.form.field.Number",              "widget.tualoreportsinglepriceinputfield",          "Tualo.report.fields.SinglePriceInputField",  "Report Single Price Field",
        0,
        1
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
        "Tualo",                              "Tualo.report.fields.AmountInputField",        "Tualo.report.fields.AmountInputField",  "widget.tualoreportamountinputfield",
        "Ext.form.field.Number",              "widget.tualoreportamountinputfield",          "Tualo.report.fields.AmountInputField",  "Report Amount Field",
        0,
        1
    )
on duplicate key 
 update classname = values(classname), xtype_long_classic  = values(xtype_long_classic),
        baseclass  = values(baseclass), xtype_long_modern  = values(xtype_long_modern), name  = values(name), description  = values(description),
        iscolumn  = values(iscolumn),
        isformfield = values(isformfield)
;