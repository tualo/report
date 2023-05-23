Ext.define('Tualo.report.Panel', {
    extend: "Ext.form.Panel",
    alias: [
        'widget.report_panel',
        'widget.dsreport',
        'widget.cmp_belege_report_editorform',
        'widget.cmp_belege_report_editor'
    ],
    controller: 'report_panel',
	viewModel: {
		type: 'report_panel'
	},
    bind: {
        disabled: "{disabled}"
    },
    config: {
        record: null,
    },
    bodyPadding: 10,
    layout: 'fit',
    items: [

        /*
        
        */
    ],
    loadRecord: function(record){
        this.getController().loadRecord(record);
    }
});
