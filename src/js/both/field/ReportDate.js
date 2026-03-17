Ext.define('Tualo.report.data.field.Date', {
    extend: 'Ext.data.field.Date',
    alias: [
        'data.field.tualo_report_date'
    ],
    dateFormat: 'Y-m-d',
    dateWriteFormat: 'Y-m-d',
    dateReadFormat: 'Y-m-d',
    allowNull: false
});
