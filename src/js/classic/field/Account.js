// old, please use TualoAccount instead
Ext.define('Tualo.report.data.field.Account', {
    extend: 'Ext.data.field.String',
    alias: [
        'data.field.tualoreportaccount'
    ],

    depends: [
        'article'
    ],
    calculate: function (data) {
        console.log('account', v, rec);
        return data;
    }
});


