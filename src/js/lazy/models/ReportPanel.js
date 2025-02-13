Ext.define('Tualo.report.lazy.models.ReportPanel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.lazy_report_panel',
    data: {
        saving: false,
        initialized: false,
        record: null,
        loadedRecord: null,
        config: null
    },
    formulas: {
        disabled: function (get) {
            return Ext.isEmpty(get('record')) || get('saving');
        }
    }
});