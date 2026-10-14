Ext.define('Tualo.report.data.field.NetByPriceType', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualo_report_net_by_price_type'
    ],
    calculate: function (data) {
        console.log('NetByPriceType', data);
        let v = data.net;
        if (data.pricetype == 'brutto') {
            v = Math.round(data.singleprice * (data.tax / 100 + 1) * 100) / 100 * data.amount;
        }
        if (data.pricetype == 'netto') {
            v = data.singleprice * data.amount;
        }
        return v;
    },
    critical: true,
    persist: true,
    depends: ['singleprice', 'amount', 'pricetype'],
});