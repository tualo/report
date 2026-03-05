Ext.define('Tualo.report.data.field.MarginPrice', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualo_report_marginprice'
    ],
    calculate: function (data) {
        v = data.singleprice - data.purpurchaseprice;
        return v;
    },
    critical: true,
    persist: true,
    depends: ['singleprice', 'purpurchaseprice'],
});

Ext.define('Tualo.report.data.field.MarginTotalPrice', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualo_report_margintotalprice'
    ],
    calculate: function (data) {
        v = data.singlemargin * data.amount;
        return v;
    },
    critical: true,
    persist: true,
    depends: ['amount', 'singlemargin'],
});


