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
        let doQuery = true;

        console.log('TualoTax convert start', record);
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
                        }, 'tax').then(result => {
                            console.log('TualoTax query result', result);
                            if (result) {
                                if (record.get('article') == result.queriedValue.article && record.get('amount') == result.queriedValue.amount) {
                                    if (record.get('tax') != result.data.value * 1.0) {
                                        record.set('tax', result.data.value * 1.0);
                                    }
                                }
                            }
                        }).catch(e => {
                            console.log('TualoTax query error', e);
                        });
                    } catch (e) {
                        console.log('TualoTax query error', e);
                    }
                    if (this.lastQuery == null) this.lastQuery = new Date().getTime();
                }


            }
        }
        return currentValue;
    }
    /*
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
    }*/
});


Ext.define('Tualo.report.data.field.TualoTaxOnArtikel', {
    extend: 'Ext.data.field.Number',
    mixins: ['Tualo.report.mixins.field.Query'],
    alias: [
        'data.field.tualo_report_tax_on_artikel'
    ],
    depends: [
        'artikel'
    ],
    critical: true,
    persist: true,
    queriedList: {},

    convert: function (currentValue, record) {
        let doQuery = true;

        console.log('TualoTax convert start', record);
        if (!Ext.isEmpty(record.get('artikel'))) {
            if (typeof record.modified == 'undefined') return currentValue * 1;
            if (record.modified) {
                /*
                if (record.modified.article) doQuery = true;
                if (record.modified.amount) doQuery = true;
                */

                if (
                    this.queriedList[record.get('id')]
                    && this.queriedList[record.get('id')].article == record.get('article')
                    && this.queriedList[record.get('id')].amount == record.get('anzahl')
                ) {
                    // take care, infinite loop possible 
                    doQuery = false;
                }



                if (doQuery) {
                    this.queriedList[record.get('id')] = {
                        article: record.get('artikel'),
                        amount: record.get('anzahl')
                    };

                    try {
                        this.query(record, {
                            article: record.get('artikel'),
                            amount: record.get('anzahl')
                        }, 'tax').then(result => {
                            console.log('TualoTax query result', result);
                            if (result) {
                                if (record.get('artikel') == result.queriedValue.article && record.get('anzahl') == result.queriedValue.amount) {
                                    if (record.get('steuersatz') != result.data.value * 1.0) {
                                        record.set('steuersatz', result.data.value * 1.0);
                                    }
                                }
                            }
                        }).catch(e => {
                            console.log('TualoTax query error', e);
                        });
                    } catch (e) {
                        console.log('TualoTax query error', e);
                    }
                    if (this.lastQuery == null) this.lastQuery = new Date().getTime();
                }


            }
        }
        return currentValue;
    }
    /*
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
    }*/
});
