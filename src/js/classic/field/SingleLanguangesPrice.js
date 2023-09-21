Ext.define('Tualo.report.data.field.SingleLanguagesPrice', {
        extend: 'Tualo.report.data.field.SinglePrice',
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