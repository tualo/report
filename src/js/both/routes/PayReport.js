Ext.define('Tualo.routes.PayReport', {
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
    requires: [
        'Tualo.report.data.field.SinglePrice',
        'Tualo.report.data.field.NetPrice',
        'Tualo.report.data.field.Account',
    ],
    url: 'payreport/:type/:reportnumber',
    handler: {
        action: function (type,reportnumber, action) {
            Ext.getApplication().addView('Tualo.report.lazy.ReportPay', {
                type: type,
                reportnumber: reportnumber
            });
        },
        before: function (type,reportnumber, action) {
            action.resume();
        }
    }
});