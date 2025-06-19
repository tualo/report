Ext.define('Tualo.report.data.field.SinglePriceByGross', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualoreportsinglepricebygross'
    ],
    convert: function (v, rec) {
        console.log('SinglePrice', rec.get('article'), this._queriedArticles, rec.modified);
        let doQuery = false,
            map = rec.getFieldsMap();
        if (!Ext.isEmpty(rec.get('article'))) {
            if (typeof rec.modified == 'undefined') return v * 1;
            /*if (
                rec.isModified('article') &&
                rec.isModified('amount') 
            ) {
                */
            if (rec.get('article') != rec.get('_queriedArticles')) doQuery = true;
            if (map['source_language'] && rec.get('source_language') != this._queriedSource_language) doQuery = true;
            if (map['target_language'] && rec.get('target_language') != this._queriedTarget_language) doQuery = true;
            if (map['amount'] && rec.get('amount') != rec.get('_queriedAmount')) doQuery = true;
            if (map['gebiet'] && rec.get('gebiet') != this._queriedGebiet) doQuery = true;
            // }
        }
        if (doQuery) {
            this.queryArticles(v, rec);
        }
        return v;
    },

    processCombinations: function (rec) {
        let store = rec.store;
        if (typeof store == 'undefined') return;

        let range = store.getRange(),
            combination_id = rec.get('combination_id'),
            combination_config = rec.get('combination_config');

        if (Ext.isEmpty(combination_config)) {
            if (!Ext.isEmpty(combination_id)) {
                range.filter((r) => {
                    return r.get('combination_id') == combination_id;
                }).forEach((r) => {
                    let c = r.get('combination_config');
                    if (c) {

                        r.set({
                            amount: rec.get('amount') * c.result_amount_factor,
                            singleprice: (c.original_price == 1) ?
                                rec.get('singleprice') * c.result_price_factor :
                                c.singleprice * c.result_price_factor,
                        });
                    }
                });
            }
        }
    },

    addCombinations: function (rec) {
        let store = rec.store,
            combination_id = rec.get('combination_id'),
            combination_config = rec.get('combinations'),
            range = store.getRange();
        if (typeof combination_config != 'undefined') {
            if (typeof combination_id == 'undefined') {
                combination_id = Ext.id();
                rec.set('combination_id', combination_id);
            }

            combination_config.forEach((c) => {
                let list = range.filter((r) => {
                    return (r.get('combination_id') == combination_id && r.get('article') == c.resultarticle);
                });

                if (list.length == 0) {

                    let records_to_remove = [];
                    store.getRange().forEach((r) => {
                        if (r.get('article') == "") {
                            records_to_remove.push(r);
                        }
                    });
                    records_to_remove.forEach((r) => {
                        store.remove(r);
                    });

                    store.add({
                        id: Ext.id(),
                        combination_id: combination_id,
                        article: c.resultarticle,
                        amount: rec.get('amount') * c.result_amount_factor,
                        singleprice: (c.original_price == 1) ? rec.get('singleprice') * c.result_price_factor : c.singleprice * c.result_price_factor,
                        combination_config: c,
                    });
                };
            });

        }
    },

    queryArticles: async function (v, rec) {
        //console.log('queryArticles',this,arguments);
        if (!Ext.isEmpty(rec.store)) {
            let params = {};
            if (typeof rec.store.getHeader == 'function') params.header = rec.store.getHeader();
            params.position = rec.data;
            let resData = await fetch('./report/price', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(params)
            });
            let data = await resData.json();
            this._queriedArticles = rec.get('article');
            rec.set('_queriedArticles', rec.get('article'));

            console.log('queryArticles', data, this, rec.store)



            this._queriedSource_language = rec.get('source_language');
            rec.set('_queriedSource_language', rec.get('source_language'));

            this._queriedTarget_language = rec.get('target_language');
            rec.set('_queriedTarget_language', rec.get('target_language'));

            this._queriedAmount = rec.get('amount');
            rec.set('_queriedAmount', rec.get('amount'));

            this._queriedGebiet = rec.get('gebiet');
            rec.set('_queriedGebiet', rec.get('gebiet'));

            if (!data.success) {
                let msg = data.msg;
                if (!msg) msg = "Leider ist ein unbekannter Fehler aufgetreten.";
                Ext.toast({
                    html: msg,
                    title: 'Fehler',
                    width: 200,
                    align: 't'
                });
            }
            if (data.success) {
                /*
                console.log('queryArticles',data.singleprice,rec.data,data);
                console.log('queryArticles singleprice', data.singleprice, rec.get('singleprice'));
                console.log('queryArticles singleprice',data.singleprice!=rec.get('singleprice') , typeof data.singleprice, typeof rec.get('singleprice'));
                console.log('queryArticles tax',data.tax!=rec.get('tax'), typeof data.tax, typeof rec.get('tax') );
                console.log('queryArticles unit',data.unit!=rec.get('unit'), typeof data.unit, typeof rec.get('unit') );
                console.log('queryArticles account',data.account!=rec.get('account'),   typeof data.account, typeof rec.get('account') );
                */
                // rec.suspendEvents();

                if (data.tax * 1.0 != rec.get('tax') * 1.0) {
                    // console.log('queryArticles set tax');
                    rec.set('tax', data.tax * 1.0);
                    // rec.commit(true);
                }

                if (data.singleprice * 1.0 != rec.get('singleprice') * 1.0) {
                    //console.log('queryArticles set singleprice');
                    let factor = 1, c = rec.get('combination_config');
                    if (!Ext.isEmpty(c)) {
                        factor = c.result_price_factor;
                    }
                    rec.set('singleprice', rec.get('gross') / (1 + (rec.get('tax') * 1.0 / 100)) * factor);
                    // rec.commit(true);
                }
                if (data.unit != rec.get('unit')) {
                    // console.log('queryArticles set unit');
                    rec.set('unit', data.unit);
                    // rec.commit(true);
                }
                if (data.account != rec.get('account')) {
                    // console.log('queryArticles set account');
                    rec.set('account', data.account);
                    // rec.commit(true);
                }
                // rec.commit(true);
                if (data.combinations) {
                    rec.set('combinations', data.combinations);
                    this.addCombinations(rec);
                }
                this.processCombinations(rec);
            }
        }
    },

    depends: [
        'article',
        'gross',
        'amount'
    ]

});