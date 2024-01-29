Ext.define('Tualo.report.lazy.controller.ReportPay', {
  extend: 'Ext.app.ViewController',
  alias: 'controller.lazy_reportpay_panel',
  onReferenzDSBeforeLoad: function(store,opt,eopts){
    var model = this.view.getViewModel();
    var params = opt.getParams();
    if (typeof params=='undefined'){
       params={}
    }

    params.paytype = this.lookupReference('paytypeField').getValue();

    opt.setParams(params);
    return true;
  },
  onReferenzDSLoad: function(store){
    var range = store.getRange();
    var fld = this.lookupReference('referenzdsField');
    if(fld){
      fld.select(fld.getStore().getAt(0));
    }
    return true;
  },
  onPayTypeChanged: function(){
    var model = this.view.getViewModel();
    model.getStore('referenzds').load();
  },

  onReducdeTypeChanged: function(){

  },

  onBeforeLoad: function(store,opt,eopts){
    var model = this.view.getViewModel();
    var params = opt.getParams();
    if (typeof params=='undefined'){
       params={}
    }
    params.belegnummer = model.get('reportnumbers').join('-');
    params.b = model.get('reportindex');
    opt.setParams(params);

    return true;
  },


  onLoad: function(store,records,opts){
    console.log(store,records,opts);
    var sum = 0;
    var range = store.getRange();
    for(var i=0;i< range.length;i++){
      sum+=range[i].get('value');
    }
    this.lookupReference('valueField').setValue(sum);
  },

  onBeforeDetailLoad: function(store,opt,eopts){
    var model = this.view.getViewModel();
    var params = opt.getParams();
    if (typeof params=='undefined'){
       params={}
    }
    params.belegnummer = model.get('reportnumbers').join('-');
    params.b = model.get('reportindex');
    opt.setParams(params);

    return true;
  },

  onDetailLoad: function(store,records,opts){
  },

  onFocus: function(){
    var model = this.view.getViewModel();
    model.getStore('referenzds').load();
  },
  onBoxReady: function(){

    let view = this.getView(),
        model = view.getViewModel();

    model.set('locked',true);
    console.log('onBoxReady',view.type,view.reportnumber);
    let fn = async ()=>
    {
      let data = await fetch(
          './report/'+view.type+'/'+view.reportnumber,
          {
              method: 'GET'
          }
      ).then((response)=>{return response.json()});

      model.set('locked',false);
    };
    fn();

    /*
    if (typeof this.view.reportindex==='undefined'){
      model.set('locked',true);
      Ext.MessageBox.alert('Achtung','Sie müssen eine Belegart angeben.');
    }else{
      model.set('reportindex',this.view.reportindex);
    }

    if (typeof this.view.reportnumbers==='undefined'){
      this.view.reportnumbers=[];
      if (typeof this.view.belegnummer!=='undefined'){
        this.view.reportnumbers = [this.view.belegnummer];
      }else{

      }
    }

    if (typeof this.view.reportnumbers.join=='undefined'){
      this.view.reportnumbers=[this.view.reportnumbers];
    }

    if (this.view.reportnumbers.length==0){
      model.set('locked',true);
      Ext.MessageBox.alert('Achtung','Sie müssen einen Beleg angeben.');
    }else{
      model.set('reportnumbers',this.view.reportnumbers);
    }
    model.getStore('paystore').load();
    model.getStore('paydetailstore').load();

    this.lookupReference('paytypeField').focus();
    this.fixTitle();
    */
  },
  fixTitle: function(){
    var model = this.view.getViewModel();
    var topwindow=this.getView().up('window');
    if (topwindow){

    }else if (typeof this.view.up().setTitle=='function'){
      topwindow=this.view.up()

    }
    topwindow.setTitle('Zahlungsdetails zu '+model.get('reportnumbers').join('-'));
  },
  onTrashClick: function() {
    Ext.MessageBox.confirm('Löschen','Möchten Sie wirklich die Kontoauszugsbuchungen löschen?',this.onConfirmedTrash,this);
  },
  onConfirmedTrash: function(btn){
    var model = this.view.getViewModel();
    if (btn=='yes'){
      var p = {
        cmp:'cmp_belege',
        p: 'v3/pay/remove',
        reportnumbers: Ext.JSON.encode(model.get('reportnumbers')),
        reportindex: model.get('reportindex')
      }
      Tualo.Ajax.request({
        showWait: true,
        params: p,
        scope: this,
        json: function(o){
          if(o.success){
            this.view.fireEvent('changed', model.get('reportnumbers'))
          }else{
            Ext.MessageBox.alert('Fehler',o.msg);
          }
          model.getStore('paystore').load();
        }
      });
    }
  },
  addPayment: function(){
    var model = this.view.getViewModel();
    var me = this;
    var f = this.lookupReference('payform').getForm().getValues();
    if (this.lookupReference('payform').isValid()){
      if (f.value!=0){
        var p = {
          cmp:'cmp_belege',
          p: 'v3/pay/save',
          referenceDS: f.referenzds,
          
          value: parseFloat(f.value.replace(',','.')),
          date: Ext.util.Format.date(f.datum,'Y-m-d'),
          paytype: f.paytype,
          note: f.bemerkung,
          reportnumbers: Ext.JSON.encode(model.get('reportnumbers')),
          reportindex: model.get('reportindex')
        }
        Tualo.Ajax.request({
          showWait: true,
          params: p,
          json: function(o){
            if(o.success){
              me.view.fireEvent('changed', model.get('reportnumbers'))
            }else{
              Ext.MessageBox.alert('Fehler',o.msg);
            }
            model.getStore('paystore').load();
          }
        });
      }
    }
  },
  addReduce: function(){
    var model = this.view.getViewModel();
    var me = this;
    var f = this.lookupReference('reduceform').getForm().getValues();
    if (this.lookupReference('reduceform').isValid()){
      if (f.value!=0){
        var p = {
          cmp:'cmp_belege',
          p: 'v3/pay/reduce',
          value: parseFloat(f.value.replace(',','.')),
          reducetype: f.reducetype,
          note: f.bemerkung,
          reportnumbers: Ext.JSON.encode(model.get('reportnumbers')),
          reportindex: model.get('reportindex')
        }
        Tualo.Ajax.request({
          showWait: true,
          params: p,
          json: function(o){
            if(o.success){
              me.view.fireEvent('changed', model.get('reportnumbers'))
            }else{
              Ext.MessageBox.alert('Fehler',o.msg);
            }
            model.getStore('paystore').load();
          }
        });
      }
    }
  }

});
