Ext.define('Tualo.report.lazy.controller.ReportPay', {
  extend: 'Ext.app.ViewController',
  alias: 'controller.lazy_reportpay_panel',
  
  initializeReport: function(){
    let me= this,
        view = me.getView(),
        model = view.getViewModel(),
        report = model.get('report'),
        payform = view.getComponent('payform'),
        paylist = view.getComponent('paylist');

    if (Ext.isEmpty(Ext.ClassManager.getByAlias('widget.dslist_view_editor_blg_pay_'+view.type))){
      Ext.toast('Die Zahlungen-Liste ist nicht konfiguriert',2000);
      console.info('Die Zahlungen-Liste ist nicht konfiguriert. Bitte den Datenstamm view_editor_blg_pay_'+view.type+' anpassen.');
      return;
    }
    if (Ext.isEmpty(Ext.ClassManager.getByAlias('widget.dsform_view_editor_blg_pay_'+view.type))){
      Ext.toast('Das Zahlungen-Formular ist nicht konfiguriert',2000);
      console.info('Das Zahlungen-Formular ist nicht konfiguriert. Bitte den Datenstamm view_editor_blg_pay_'+view.type+' anpassen.');
      return;
    }

    me.form = Ext.create('widget.dsform_view_editor_blg_pay_'+view.type,{
      title: null,
      buttons: [
        {
          text: 'Schliessen',
          handler: function(){
            Ext.getApplication().redirectTo(-1);
          }

        },
        {
          text: 'Hinzufügen',
          handler: 'addPayment'
        }
      ]
    });
    me.store = Ext.create('Tualo.DataSets.store.View_editor_blg_pay_'+view.type,{
      title: null,
      autoLoad: false,
    });
    me.list = Ext.create('widget.dslist_view_editor_blg_pay_'+view.type,{
      title: null,
      store: me.store,
    });
    payform.removeAll();
    payform.add(me.form);
    paylist.removeAll();
    paylist.add(me.list);
    me.store.filter([
      {
        property: 'reportnr',
        value: report.id,
        operator: '='
      }
    ]);
    me.store.load();

  },
  loadReport: async function(){
    let view = this.getView(),
        model = view.getViewModel();
    let data = await fetch( './report/'+view.type+'/'+view.reportnumber, { method: 'GET' } ).then((response)=>{return response.json()});
      if (data.success==true){
        model.set('report',data.data);
        Ext.create('Tualo.DataSets.model.View_editor_blg_pay_'+view.type,{})
        this.initializeReport();
        model.set('locked',false);
      }
  },
  onBoxReady: function(){

    let view = this.getView(),
        model = view.getViewModel();

    model.set('locked',true);
    this.loadReport();
  },
  
  addPayment: async function(){
    let me = this,
        view = me.getView(),
        o=me.form.getValues();
    if (o.paytype==''){
      Ext.toast('Bitte eine Zahlungsart wählen',2000);
      return;
    }
    if (o.date==''){
      Ext.toast('Bitte ein Datum auswählen',2000);
      return;
    }
    if (o.value==''){
      Ext.toast('Bitte einer Wert eingeben',2000);
      return;
    }
    if (typeof o.date=='string'){
      o.date = o.date.split('.').reverse().join('-');
    }
    o.value = o.value.replace(',','.');

    let data = await fetch( './payreport/'+view.type+'/'+view.reportnumber, { method: 'PUT',body:JSON.stringify(o) } ).then((response)=>{return response.json()});
    if (data.success==true){
    }
    me.list.getStore().load();
    me.loadReport(  );
  }
 
});
