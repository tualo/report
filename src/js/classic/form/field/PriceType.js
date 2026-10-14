Ext.define('Tualo.report.form.fields.PriceType', {
    extend: 'Ext.form.field.ComboBox',
    alias: ['widget.tualo_report_pricetype'],
    store: {
        type: 'array',
        fields: ['id', 'name'],
        data: [
            [
                'netto', 'Netto'
            ],
            [
                'brutto', 'Brutto'
            ]
        ]
    },
    constructor: function (config) {
        this.callParent([config]);
        console.log('tualo_report_form_pricetype');
        window.tt = this;
        //tt.reportView.down('reportlist');
    },
    onChange: function (newValue, oldValue) {
        let grid = this.reportList,
            range = this.reportList.getStore().getRange();
        console.log('PriceType changed from', arguments);
        grid.columns.forEach(column => {
            if (['net', 'singleprice'].indexOf(column.dataIndex) > -1) {
                column.setVisible(newValue === 'netto');
            }
            if (['gross', 'singleprice_gross'].indexOf(column.dataIndex) > -1) {
                column.setVisible(newValue !== 'netto');
            }
        });
        range.forEach((rec) => {
            rec.set('pricetype', newValue);
        })
    },
    typeAhead: true,
    valueField: 'id',
    displayField: 'name'
});
