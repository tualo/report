Ext.define('Tualo.report.fields.SinglePriceInputField',  {
    alias: 'widget.tualoreportsinglepriceinputfield',  
    extend: 'Ext.field.Number',

    value: 0,
    maxValue:  9999999,
    minValue: -9999999,
    decimalPrecision: 5,
    selectOnFocus: true,

    renderer: function(value, field){

        console.log('tualoreportsinglepriceinputfield',value,field)
      return value;
    },
    onFocus: function(component,events) {
        //var grid = component.up('grid'),
        //    plugin = grid.findPlugin('cellediting');
        console.log('onFocus',arguments);
        this.callParent(arguments);
    },
    onChange: function(fld, newValue, oldValue, eOpts){

        let grid = this.up('grid'),
            plugin = grid.findPlugin('cellediting'),
            record = plugin.getActiveRecord();

            
        console.log('NetInputField onChange',arguments);
        this.callParent(arguments);
    }
});
