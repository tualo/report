Ext.define('Tualo.report.data.field.TualoMaterial', {
    extend: 'Ext.data.field.Number',
    mixins: ['Tualo.report.mixins.field.Query'],
    alias: [
        'data.field.tualo_report_material'
    ],
    depends: [
        'article'
    ],
    critical: true,
    persist: true,
    queriedList: {},


    convert: function (currentValue, record) {
        let doQuery = true;

        console.log('TualoMaterial convert start', record);
        if (!Ext.isEmpty(record.get('article'))) {
            if (typeof record.modified == 'undefined') return currentValue * 1;
            if (record.modified) {
                /*
                if (record.modified.article) doQuery = true;
                if (record.modified.amount) doQuery = true;
                */

                if (
                    this.queriedList[record.get('id')]
                    && this.queriedList[record.get('id')].article == record.get('article')
                    && this.queriedList[record.get('id')].amount == record.get('amount')
                ) {
                    // take care, infinite loop possible 
                    doQuery = false;
                }



                if (doQuery) {
                    this.queriedList[record.get('id')] = {
                        article: record.get('article'),
                        amount: record.get('amount')
                    };

                    try {
                        this.query(record, {
                            article: record.get('article'),
                            amount: record.get('amount')
                        }, 'materialanteil').then(result => {
                            console.log('TualoMaterial query result', result);
                            if (result) {
                                if (record.get('article') == result.queriedValue.article && record.get('amount') == result.queriedValue.amount) {
                                    if (record.get('materialanteil') != result.data.value * 1.0) {

                                        record.set('materialanteil', result.data.value * 1.0);
                                    }
                                }
                            }
                        }).catch(e => {
                            console.log('TualoMaterial query error', e);
                        });
                    } catch (e) {
                        console.log('TualoMaterial query error', e);
                    }
                    if (this.lastQuery == null) this.lastQuery = new Date().getTime();
                }


            }
        }
        return currentValue;
    }
});