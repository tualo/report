Ext.define('Tualo.report.data.field.TimestampID', {
    extend: 'Ext.data.field.Number',
    alias: [
        'data.field.tualo_report_timestampid'
    ],
    convert: function (v, rec) {
        if (Ext.isEmpty(v)) {
            v = new Date().getTime();
            // append a random number to avoid duplicates
            v = v + Math.floor(Math.random() * 10000);
            rec.set('timestampid', v);
        }
        return v;
    }
});