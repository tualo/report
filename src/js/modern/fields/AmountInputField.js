Ext.define('Tualo.report.fields.AmountInputField', {
    alias: 'widget.tualoreportamountinputfield',
    extend: 'Ext.field.Number',

    value: 0,
    maxValue: 9999999,
    minValue: -9999999,
    decimalPrecision: 5,
    selectOnFocus: true,

    renderer: function (value, field) {
        console.log('tualoreportamountinputfield', value, field)
        return value;
    },
    onFocus: function (component, events) {
        this.callParent(arguments);
    },
    onChange: function (fld, newValue, oldValue, eOpts) {
        console.log('AmountInputField onChange', arguments);
        this.callParent(arguments);
    }
});
