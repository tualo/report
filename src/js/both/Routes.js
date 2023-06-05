Ext.define('Tualo.routes.Report', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'report_fa_1',
                    path: '#report/fa/1'
                }
            ]
        }
    },
    url: 'report/:type/:id',
    handler: {
        action: function (type, id) {
            /*
            type = 'views';
            let tablenamecase = tablename.toLocaleUpperCase().substring(0, 1) + tablename.toLowerCase().slice(1);
            console.log('Tualo.DataSets.' + type + '.' + tablenamecase, arguments);
            let opt = {};
            if (typeof id != 'undefined') {
                opt.loadId = id;
            }
            TualoOffice.getApplication().addView('Tualo.DataSets.' + type + '.' + tablenamecase, tablename, true, opt);
            */
        },
        before: function (type, id, action) {

            /*
            console.log('Tualo.routes.Cmp_ds', arguments, 'reject');
            action.stop();
            let tablenamecase = tablename.toLocaleUpperCase().substring(0,1) + tablename.toLowerCase().slice(1);
            let id = null;
            if (typeof xid.resume=='function'){ action=xid; }else{ id = xid;}
            action.resume();
            */
        }
    }
});