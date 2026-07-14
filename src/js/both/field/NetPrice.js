Ext.define('Tualo.report.data.field.NetPrice', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualoreportnetprice'
    ],
    calculate: function (data) {
        console.log('NetPrice', data);
        v = data.singleprice * data.amount;
        return v;
    },
    critical: true,
    persist: true,
    depends: ['amount', 'singleprice'],
});

Ext.define('Tualo.report.data.field.NetFromGross', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualo_report_net_from_gross'
    ],
    calculate: function (data) {
        console.log('NetFromGross', data);
        v = (data.gross / (data.tax / 100 + 1));
        return v;
    },
    critical: true,
    persist: true,
    depends: ['tax', 'gross'],
});

Ext.define('Tualo.report.data.field.SinglePriceFromNet', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualo_report_singleprice_from_net'
    ],
    calculate: function (data) {
        console.log('SinglePriceFromNet', data);
        v = (data.net / (data.amount));
        return v;
    },
    critical: true,
    persist: true,
    depends: ['net', 'amount'],
});