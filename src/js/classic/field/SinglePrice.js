Ext.define('Tualo.report.data.field.SinglePrice', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualoreportsingleprice'
    ],
    convert: function (v,rec) {
        console.log('SinglePrice',rec);
        console.log('SinglePrice',this,v,rec);
        if (
            (rec.get('article')!=this._queriedArticles) ||
            (rec.get('source_language')!=this._queriedSource_language) ||
            (rec.get('target_language')!=this._queriedTarget_language) ||
            (rec.get('amount')!=this._queriedAmount) ||
            (rec.get('gebiet')!=this._queriedGebiet)
        ) {
            this.queryArticles(v,rec);
        }
        return v;
    },

    queryArticles: async function(v,rec){
        console.log('queryArticles',this,arguments);
        if (!Ext.isEmpty(rec.store)){
            let params = {};
            if (typeof rec.store.getHeader == 'function') params.header=rec.store.getHeader();
            params.position = rec.data;
            let resData = await fetch('./report/price',{
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(params)
            });
            let data = await resData.json();
            this._queriedArticles=rec.get('article');
            this._queriedSource_language=rec.get('source_language');
            this._queriedTarget_language=rec.get('target_language');
            this._queriedAmount=rec.get('gebiet');
            this._queriedGebiet=rec.get('amount');
            if(data.success){
                console.log('queryArticles',data.singleprice,rec.data,data);

                console.log('queryArticles singleprice',data.singleprice!=rec.get('singleprice') , typeof data.singleprice, typeof rec.get('singleprice'));
                console.log('queryArticles tax',data.tax!=rec.get('tax'), typeof data.tax, typeof rec.get('tax') );
                console.log('queryArticles unit',data.unit!=rec.get('unit'), typeof data.unit, typeof rec.get('unit') );
                console.log('queryArticles account',data.account!=rec.get('account'),   typeof data.account, typeof rec.get('account') );

                if (data.singleprice!=rec.get('singleprice')){ 
                    rec.set('singleprice',data.singleprice);
                    // rec.commit(true);
                }
                if (data.tax!=rec.get('tax')){ 
                    rec.set('tax',data.tax);
                    // rec.commit(true);
                }
                if (data.unit!=rec.get('unit')){ 
                    rec.set('unit',data.unit);
                    // rec.commit(true);
                }
                if (data.account!=rec.get('account')){ 
                    rec.set('account',data.account);
                    // rec.commit(true);
                }
            }
        }
    },
    
    depends: [
        'article'/*,
        'source_language',
        'target_language',
        'gebiet',
        'amount'*/
    ]
    
});