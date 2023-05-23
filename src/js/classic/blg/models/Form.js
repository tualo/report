Ext.define('Tualo.report.models.Form', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.report_panel',
    data:{
        saving: false,
        initialized: false,
        record: null
    },
    formulas: {
        disabled: function(get){
            return Ext.isEmpty(get('record')) || get('saving');
        }
    }
});