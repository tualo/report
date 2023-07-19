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
    getReportHeader: function(){
        return this.getView().getForm().getValues();
    },  
    reportData: async function(){
        let config = this.getViewModel().get('config'),
            data = await fetch('./report/get/'+this.getViewModel().get('record').get('tabellenzusatz')+'/'+this.getViewModel().get('record').get('id')).then((response)=>{return response.json()});

        if (data.success){


            let positions=[];
            this.getView().getForm().setValues(data.data);
            data.data.positions.forEach((item)=>{
                let pos = {...item};
                for(let k in config.translations.pos){
                    let o = config.translations.pos[k][0];
                    pos[ o.column_name]=item[k];
                }
                let record = Ext.create('Tualo.DataSets.model.View_editor_blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz'),pos);
                positions.push(record);
            });
            console.log('positions',positions);
            this.positionsList.getStore().loadData(positions);
        }
    },


    removeUneccessaryFields: function(list){
        list.forEach((item)=>{
            delete item['bind'];
            delete item['listeners'];
            if (item.items){
                item.items = this.removeUneccessaryFields(item.items);
            }
        });
        return list;
    },
    initializeReport: async function(){
        console.log('initializeReport',this.getViewModel().get('record'),this.getViewModel().get('record').get('tabellenzusatz'));
        let config = await fetch('./reportconfig/'+this.getViewModel().get('record').get('tabellenzusatz')).then((response)=>{return response.json()});
        if (config.success){
            this.getViewModel().set('config',config);
            
            if (Ext.isEmpty(Ext.ClassManager.getByAlias('widget.dslist_view_editor_blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz')))){
                Ext.toast('Die Beleg-Liste ist nicht konfiguriert',2000);
                console.info('Die Beleg-Liste ist nicht konfiguriert. Bitte den Datenstamm view_editor_blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz')+' anpassen.');
                return;
            }
            if (Ext.isEmpty(Ext.ClassManager.getByAlias('widget.dslist_view_editor_blg_hdr_'+this.getViewModel().get('record').get('tabellenzusatz')))){
                Ext.toast('Der Belegkopf ist nicht konfiguriert',2000);
                console.info('Der Belegkopf ist nicht konfiguriert. Bitte den Datenstamm view_editor_blg_hdr_'+this.getViewModel().get('record').get('tabellenzusatz')+' anpassen.');
                return;
            }

            let hdr = Ext.create({
                scrollable: 'y',
                xtype: 'panel',
                defaults: {
                    labelWidth: 150,
                },
                items: this.removeUneccessaryFields(config.header),
                // bodyPadding: 10
            });
            this.getView().getComponent('header').getComponent('reportheader').add(
                hdr
            );

            console.log(config,hdr);
            
            
            this.getView().getComponent('reportlist').add(
                this.positionsList= Ext.create({
                    title: null,
                    border: true,
                    xtype: 'dslist_view_editor_blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz'),
                    plugins: {
                        gridfilters: true,
                        cellediting: {
                            clicksToEdit: 1,
                            listeners: {
                                edit: function(editor, fld){
                                    this.grid.checkAutoNewRow(fld.rowIdx);
                                    this.grid.fireEvent('edited',fld.record,fld);
                                    return true;
                                }
                            }
                        }
                    },
                    store: {
                        type: 'json',
                        getHeader: this.getReportHeader.bind(this),
                        model: 'Tualo.DataSets.model.View_editor_blg_pos_'+this.getViewModel().get('record').get('tabellenzusatz'),
                    },
                    // bodyPadding: 10
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