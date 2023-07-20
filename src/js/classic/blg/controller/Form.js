Ext.Loader.setPath('Tualo.report.lazy', './jsreport');
Ext.Loader.setPath('Tualo.report.data.field', './jsreport');

Ext.define('Tualo.report.controller.Form', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.report_panel',

    loadRecord: function(record){

        

        console.log('controller loadRecord',record);
        this.getViewModel().set('record',record);
        if (!Ext.isEmpty(record)){
            if (typeof this.myPanel=='undefined'){
                this.myPanel = Ext.create('Tualo.report.lazy.ReportPanel',{});
                this.getView().add(this.myPanel);
            }
            this.myPanel.loadRecord(record);
        }
    }
});