Ext.Loader.setPath('Tualo.report.lazy', './jsreport');

Ext.define('Tualo.report.controller.Form', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.report_panel',

    loadRecord: function(record){

        

        console.log('controller loadRecord',record);
        this.getViewModel().set('record',record);
        if (!Ext.isEmpty(record)){
            if (record.get('initialized')!=true){
                record.set('initialized',true);
                this.myPanel = Ext.create('Tualo.report.lazy.ReportPanel',{});
                this.getView().add(this.myPanel);
                this.myPanel.loadRecord(record);
            }
        }

        /*
        window.record = record;
        window.report = this;
            if (record.get('initialized')!=true){
                record.set('initialized',true);
                console.log('controller loadRecord',record);
                console.log('controller loadRecord',record.get('tabellenzusatz'));
                console.log('controller loadRecord',record.get('id'));
                this.getView().getComponent('header').getComponent('reportheader').add(
                    Ext.create({
                        scrollable: 'y',
                        title: null,
                        xtype: 'dsform_blg_hdr_'+record.get('tabellenzusatz')
                    })
                );
                     
            }
        }
        */
    }
});