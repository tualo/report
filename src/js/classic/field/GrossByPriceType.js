Ext.define('Tualo.report.data.field.GrossByPriceType', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualo_report_gross_by_price_type'
    ],
    calculate: function (data) {
        console.log('GrossPrice', data.pricetype, data);
        let v = data.gross;
        if (data.pricetype == 'netto') {
            v = data.net * (data.tax / 100 + 1);
        }
        if (data.pricetype == 'brutto') {
            v = data.singlegrossprice * data.amount;
        }
        return v;
    },
    critical: true,
    persist: true,
    depends: ['net', 'tax', 'pricetype'],
});