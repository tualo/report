Ext.define('Tualo.report.data.field.MarginPrice', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualo_report_marginprice'
    ],
    calculate: function (data) {
        v = data.singleprice - purpurchaseprice;
        return v;
    },
    critical: true,
    persist: true,
    depends: ['singleprice', 'singlemargin'],
});

