Ext.define('Tualo.report.data.field.Account', {
    extend: 'Ext.data.field.String',
    alias: [
        'data.field.tualoreportaccount'
    ],
    calculate: function (data) {
        console.log('account',v,rec);
        return data;
    }
});