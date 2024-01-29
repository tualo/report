Ext.define('Tualo.report.lazy.models.ReportPay', {
  extend: 'Ext.app.ViewModel',
  alias: 'viewmodel.lazy_reportpay_panel',
  data:{
    locked: false,
    reportindex: 0,
    reportnumbers: []
    
  },
  formulas: {

  },
  stores: {
    referenzds: {
      listeners:{
        beforeload: 'onReferenzDSBeforeLoad',
        load: 'onReferenzDSLoad'

      },
      autoLoad: false,
      autoSync: false,
      remoteFilter: false,
      remoteSort: false,
      pageSize: 500,
      fields: [
        { name: '__id', type: 'string' },
        { name: 'text', type: 'string' }
      ],
      proxy: {
        type: 'ajax',
        noCache: false,
        url: './index.php?p=v3/pay/referenzds',

        extraParams: {
          TEMPLATE: 'NO',
          cmp: 'cmp_belege'
        },
        reader: {
          type: 'json',
          rootProperty: 'data',
          idProperty: '__id'
        }
      }
    },
    paystore: {
      listeners:{
        beforeload: 'onBeforeLoad',
        load: 'onLoad'
      },
      autoLoad: false,
      autoSync: false,
      remoteFilter: false,
      remoteSort: false,
      pageSize: 500,
      fields: [
        { name: 'id', type: 'string' },
        { name: 'text', type: 'string' },
        { name: 'datum', type: 'date' },
        { name: 'value', type: 'number' }
      ],
      proxy: {
        type: 'ajax',
        noCache: false,
        url: './index.php?p=v3/pay/read',

        extraParams: {
          TEMPLATE: 'NO',
          cmp: 'cmp_belege',
          
        },
        reader: {
          type: 'json',
          rootProperty: 'data',
          idProperty: 'id'
        }
      }
    },
    paydetailstore: {
      listeners:{
        beforeload: 'onBeforeDetailLoad',
        load: 'onDetailLoad'
      },
      autoLoad: false,
      autoSync: false,
      remoteFilter: false,
      remoteSort: false,
      pageSize: 500,
      fields: [
        { name: 'id', type: 'string' },
        { name: 'bankkonto', type: 'string' },
        { name: 'empfaengername', type: 'string' },
        { name: 'verwendungszweck', type: 'string' },
        { name: 'valuta', type: 'date' },
        { name: 'betrag', type: 'number' }
      ],
      proxy: {
        type: 'ajax',
        noCache: false,
        url: './index.php?p=v3/pay/read',
        extraParams: {
          TEMPLATE: 'NO',
          cmp: 'cmp_belege',

          detail: 1
        },
        reader: {
          type: 'json',
          rootProperty: 'data',
          idProperty: 'id'
        }
      }
    }
  }
});
