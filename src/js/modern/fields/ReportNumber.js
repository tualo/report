Ext.define('Tualo.report.fields.Reportnumber',  {
    alias: 'widget.tualoreportnumber',
    extend: 'Ext.field.Display',
    
    renderer: function(value, field){
        console.log('tualoreportnumber',value,field)
      return value;
    }
});
