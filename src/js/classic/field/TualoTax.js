
Ext.define('Tualo.report.data.field.TualoTax', {
    extend: 'Ext.data.field.Number',
    mixins: ['Tualo.report.mixins.field.Query'],
    alias: [
        'data.field.tualo_report_tax'
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

                if (
                    this.queriedList[record.get('id')] &&
                    this.queriedList[record.get('id')].article == record.get('article')
                ) {
                    // take care, infinite loop possible 
                    doQuery = false;
                }


                if (doQuery) {
                    this.queriedList[record.get('id')] = {
                        article: record.get('article')
                    };
                    this.query(record, record.get('article'), 'tax').then(result => {
                        if (result) {
                            if (
                                record.get('article') == result.queriedValue
                            ) {
                                record.set('tax', result.tax * 1.0);
                            }
                        }
                    });
                }


            }
        }
        return currentValue;
    }
});
