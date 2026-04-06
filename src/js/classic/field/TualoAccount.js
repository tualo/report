
Ext.define('Tualo.report.data.field.TualoAccount', {
    extend: 'Ext.data.field.String',
    alias: [
        'data.field.tualo_report_account'
    ],
    depends: [
        'article'
    ],
    critical: true,
    persist: true,
    queriedList: {},
    convert: function (currentValue, record) {
        let doQuery = false;
        if (!Ext.isEmpty(record.get('article'))) {
            if (typeof record.modified == 'undefined') return currentValue * 1;
            if (record.modified) {
                if (record.modified.article) doQuery = true;
                if (record.modified.amount) doQuery = true;

                if (this.queriedList[record.get('id')]
                    && this.queriedList[record.get('id')].article == record.get('article')) {
                    // take care, infinite loop possible 
                    doQuery = false;
                }

                console.log('TualoAccount convert', record);

                if (doQuery) {
                    this.queriedList[record.get('id')] = {
                        article: record.get('article')
                    };
                    this.query(record, record.get('article'), 'account').then(result => {
                        if (result) {
                            if (record.get('article') == result.queriedValue) {
                                record.set('account', result.account);
                            }
                        }
                    });
                }


            }
        }
        return currentValue;
    }
});