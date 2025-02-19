Ext.define('Tualo.report.lazy.models.Reminder', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.lazy_report_reminder',
    data: {
        locked: false,
        report: null,
        reminder_level: 1,
        referencenr: null,
        type: null,
        costcenter: 0
    },
    formulas: {
        title: function (get) {
            var referencenr = get('referencenr');
            if (referencenr) {
                return get('reminder_level') + '. Mahnung für ' + referencenr;
                // +' (Gesamt: '+Ext.util.Format.currency(report.brutto,'€',2)+', Offen: '+Ext.util.Format.currency(report.offen,'€',2)+')';
            }
            return 'Mahnung';
        },

    }
});
