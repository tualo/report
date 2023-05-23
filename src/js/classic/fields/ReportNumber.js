Ext.define('Tualo.report.fields.reportnumber',  {
    alias: 'widget.tualoreportnumber',
    extend: 'Ext.form.field.Display',
    
    renderer: function(value, field){
        console.log('tualoreportnumber',value,field)
      return value;
    }
});
