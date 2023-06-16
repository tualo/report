Ext.define('Tualo.report.lazy.controller.ReportPanel', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.lazy_report_panel',

    loadRecord: function(record){
        this.getViewModel().set('record',record);
        if (!Ext.isEmpty(record)){
            if (this.getViewModel().get('initialized')!=true){
                this.getViewModel().set('initialized',true);
                this.initializeReport( );
            }
        }
    },
    reportData: async function(){
        let config = this.getViewModel().get('config'),
            data = await fetch('./report/get/'+this.getViewModel().get('record').get('tabellenzusatz')+'/'+this.getViewModel().get('record').get('id')).then((response)=>{return response.json()});
        console.log('reportData',data,config.translations);
        if (data.success){
            let positions=[];
            data.data.positions.forEach((item)=>{
                let pos = {...item};
                for(let k in config.translations.pos){
                    let o = config.translations.pos[k][0];
                    pos['blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz')+'__'+o.column_name]=item[k];
                }
                let record = Ext.create('Tualo.DataSets.model.Blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz'),pos);
                positions.push(record);
            });
            console.log('positions',positions);
            this.positionsList.getStore().loadData(positions);
        }
    },


    initializeReport: async function(){
        let config = await fetch('./report/config/'+this.getViewModel().get('record').get('tabellenzusatz')).then((response)=>{return response.json()});
        if (config.success){
            this.getViewModel().set('config',config);
            this.getView().getComponent('header').getComponent('reportheader').add(
                Ext.create({
                    scrollable: 'y',
                    xtype: 'panel',
                    bodyPadding: 10,
                    items: config.header
                })
            );
            if (Ext.isEmpty(Ext.ClassManager.getByAlias('widget.dslist_view_editor_blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz')))){
                Ext.toast('Die Beleg-Liste ist nicht konfiguriert',2000);
                console.info('Die Beleg-Liste ist nicht konfiguriert. Bitte den Datenstamm view_editor_blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz')+' anpassen.');
                return;
            }
            
            
            this.getView().getComponent('reportlist').add(
                this.positionsList= Ext.create({
                    title: null,
                    border: true,
                    xtype: 'dslist_view_editor_blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz'),
                    plugins: {
                        gridfilters: true,
                        cellediting: {
                            clicksToEdit: 1
                        }
                    },
                    store: {
                        type: 'json',
                        model: 'Tualo.DataSets.model.View_editor_blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz'),
                    },
                    bodyPadding: 10
                })
            );

            if (Ext.isEmpty(config.headtext)){
                this.getView().getComponent('reportheader').setHidden(true);
            }else{
                this.getView().getComponent('reportheader').setHidden(false);
                this.getView().getComponent('reportheader').add(Ext.create(config.headtext));
            }
            if (Ext.isEmpty(config.foottext)){
                this.getView().getComponent('reportfooter').setHidden(true);
            }else{
                this.getView().getComponent('reportfooter').setHidden(false);
                this.getView().getComponent('reportfooter').add(Ext.create(config.foottext));
            }
        }
        this.reportData();

    }
});