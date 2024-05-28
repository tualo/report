Ext.define('Tualo.report.data.field.NetPrice', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualoreportnetprice'
    ],
    calculate: function (data) {
        console.log('NetPrice',data);
        v=data.singleprice*data.amount;
        return v;
    },
    critical:true,
    persist: true,
    depends: ['amount','singleprice'],
});