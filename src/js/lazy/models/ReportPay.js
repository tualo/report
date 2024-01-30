Ext.define('Tualo.report.lazy.models.ReportPay', {
  extend: 'Ext.app.ViewModel',
  alias: 'viewmodel.lazy_reportpay_panel',
  data:{
    locked: false,
    report: null,
    record: null
  },
  formulas: {
    title: function(get){
      var report = get('report');
      if (report){
        return 'Zahlungen für '+report.id+' (Gesamt: '+Ext.util.Format.currency(report.brutto,'€',2)+', Offen: '+Ext.util.Format.currency(report.offen,'€',2)+')';
      }
      return 'Zahlungen';
    },
  }
});
