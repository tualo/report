Ext.define('Tualo.report.data.field.GrossPrice', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualoreportgrossprice'
    ],
    calculate: function (data) {
        console.log('GrossPrice',data);
        v=data.net*(data.tax/100+1);
        return v;
    },
    critical:true,
    persist: true,
    depends: ['net','tax'],
});