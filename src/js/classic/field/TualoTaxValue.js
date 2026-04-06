Ext.define('Tualo.report.data.field.TualoTaxValue', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualo_report_tax_value'
    ],
    calculate: function (data) {
        v = data.gross - data.net;
        return v;
    },
    critical: true,
    persist: true,
    depends: ['net', 'gross'],
});