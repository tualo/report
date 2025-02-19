Ext.define('Tualo.routes.Reminder', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'report_fa_1',
                    path: '#report/reminder/fa/1'
                }
            ]
        }
    },
    requires: [
        'Tualo.report.data.field.SinglePrice',
        'Tualo.report.data.field.NetPrice',
        'Tualo.report.data.field.Account',
    ],
    url: 'reportreminder(\/:{type}\/:{referencenr}\/:{costcenter}\/:{reminder_level})',
    handler: {
        action: function (values, action) {
            Ext.getApplication().addView('Tualo.report.lazy.Reminder', {
                type: values.type,
                referencenr: values.referencenr,
                costcenter: values.costcenter,
                reminder_level: values.reminder_level
            });
        },
        before: function (values, action) {
            action.resume();
        }
    }
});