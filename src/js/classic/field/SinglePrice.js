Ext.define('Tualo.report.data.field.SinglePrice', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualoreportsingleprice'
    ],
    convert: function (v,rec) {
        console.log('SinglePrice',this,v,rec);
        if(rec.get('article')!=this._queriedArticles) this.queryArticles(v,rec);
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
            if(data.success){
                if (data.singleprice!=rec.get('singleprice')) rec.set('singleprice',data.singleprice);
                if (data.tax!=rec.get('tax')) rec.set('tax',data.tax);
                if (data.account!=rec.get('account')) rec.set('account',data.account);
            }
        }
    },
    
    depends: [
        'article'
    ]
    
});