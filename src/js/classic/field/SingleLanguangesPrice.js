Ext.define('Tualo.report.data.field.SingleLanguagesPrice', {
        extend: 'Ext.data.field.Number',
        alias: [
            'data.field.tualoreportsinglelanguagesprice'
        ],
        depends: [
            'article',
            'source_language',
            'target_language',
            'amount'
        ]
    }
);