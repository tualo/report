Ext.define('Tualo.report.data.field.SinglePrice', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualoreportsingleprice'
    ],
    convert: function (v,rec) {
        console.log('SinglePrice',rec.get('article'),this._queriedArticles);
        let doQuery = false,
            map = rec.getFieldsMap();
        if (!Ext.isEmpty(rec.get('article'))){
            if (rec.get('article')!=rec.get('_queriedArticles')) doQuery=true;
            if (map['source_language'] && rec.get('source_language')!=this._queriedSource_language) doQuery=true;
            if (map['target_language'] && rec.get('target_language')!=this._queriedTarget_language) doQuery=true;
            if (map['amount'] && rec.get('amount')!=rec.get('_queriedAmount')) doQuery=true;
            if (map['gebiet'] && rec.get('gebiet')!=this._queriedGebiet) doQuery=true;
        }
        if (doQuery) {
            this.queryArticles(v,rec);
        }
        return v;
    },

    queryArticles: async function(v,rec){
        //console.log('queryArticles',this,arguments);
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
            rec.set('_queriedArticles',rec.get('article'));

            this._queriedSource_language=rec.get('source_language');
            rec.set('_queriedSource_language',rec.get('source_language'));

            this._queriedTarget_language=rec.get('target_language');
            rec.set('_queriedTarget_language',rec.get('target_language'));

            this._queriedAmount=rec.get('amount');
            rec.set('_queriedAmount',rec.get('amount'));

            this._queriedGebiet=rec.get('gebiet');
            rec.set('_queriedGebiet',rec.get('gebiet'));
            
            if(!data.success){
                let msg = data.msg;
                if (!msg) msg = "Leider ist ein unbekannter Fehler aufgetreten.";
                Ext.toast({
                    html: msg,
                    title: 'Fehler',
                    width: 200,
                    align: 't'
                });
            }
            if(data.success){
                /*
                console.log('queryArticles',data.singleprice,rec.data,data);
                console.log('queryArticles singleprice', data.singleprice, rec.get('singleprice'));
                console.log('queryArticles singleprice',data.singleprice!=rec.get('singleprice') , typeof data.singleprice, typeof rec.get('singleprice'));
                console.log('queryArticles tax',data.tax!=rec.get('tax'), typeof data.tax, typeof rec.get('tax') );
                console.log('queryArticles unit',data.unit!=rec.get('unit'), typeof data.unit, typeof rec.get('unit') );
                console.log('queryArticles account',data.account!=rec.get('account'),   typeof data.account, typeof rec.get('account') );
                */
                if (data.singleprice!=rec.get('singleprice')){ 
                    //console.log('queryArticles set singleprice');
                    rec.set('singleprice',data.singleprice);
                    // rec.commit(true);
                }
                if (data.tax!=rec.get('tax')){ 
                    // console.log('queryArticles set tax');
                    rec.set('tax',data.tax);
                    // rec.commit(true);
                }
                if (data.unit!=rec.get('unit')){ 
                    // console.log('queryArticles set unit');
                    rec.set('unit',data.unit);
                    // rec.commit(true);
                }
                if (data.account!=rec.get('account')){ 
                    // console.log('queryArticles set account');
                    rec.set('account',data.account);
                    // rec.commit(true);
                }
            }
        }
    },
    
    depends: [
        'article',
        //'source_language',
        //'target_language',
        //'gebiet',
        'amount'
    ]
    
});