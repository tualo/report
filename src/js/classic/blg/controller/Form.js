Ext.Loader.setPath('Tualo.report.lazy', './jsreport');
Ext.Loader.setPath('Tualo.report.data.field', './jsreport');

Ext.define('Tualo.report.controller.Form', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.report_panel',

    loadRecord: function (record) {


        // window.CF = this.getView();
        this.getViewModel().set('record', record);
        if (!Ext.isEmpty(record)) {
            this.getView().up().getViewModel().set('isModified', false)
            this.getView().up().getViewModel().set('isNew', false)
            if (typeof this.myPanel == 'undefined') {
                this.myPanel = Ext.create('Tualo.report.lazy.ReportPanel', {});
                this.getView().add(this.myPanel);
            }
            this.myPanel.loadRecord(record);
        }
    }
});