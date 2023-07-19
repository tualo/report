Ext.define('Tualo.report.data.field.TaxValue', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualoreporttaxvalue'
    ],
    calculate: function (data) {
        v=data.gross - data.net;
        return v;
    },
    critical:true,
    persist: true,
    depends: ['net','gross'],
});