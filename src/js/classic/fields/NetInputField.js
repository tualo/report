Ext.define('Tualo.report.fields.NetInputField',  {
    alias: 'widget.tualoreportnetinputfield',  
    extend: 'Ext.form.field.Number',

    value: 0,
    maxValue:  9999999,
    minValue: -9999999,
    decimalPrecision: 5,

    renderer: function(value, field){
        console.log('tualoreportnetinputfield',value,field)
      return value;
    },
    onChange: function(fld, newValue, oldValue, eOpts){
        window.fld=this;
        console.log('NetInputField onChange',arguments);
        this.callParent(arguments);
    }
});
