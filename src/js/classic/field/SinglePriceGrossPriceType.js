Ext.define('Tualo.report.data.field.SinglePriceGrossPriceType', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualo_report_single_price_gross_price_type'
    ],
    calculate: function (data) {
        console.log('SinglePriceGrossPriceType', data);
        let v = data.singlegrossprice;
        return v;
    },
    critical: true,
    persist: true,
    depends: ['net', 'tax', 'pricetype'],
});