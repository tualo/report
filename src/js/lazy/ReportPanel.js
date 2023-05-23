Ext.define('Tualo.report.lazy.ReportPanel',{
    extend: "Ext.form.Panel",
    requires:[
        'Tualo.report.lazy.controller.ReportPanel',
        'Tualo.report.lazy.models.ReportPanel'
    ],
    bodyPadding: 10,
    
    controller: 'lazy_report_panel',
	viewModel: {
		type: 'lazy_report_panel'
	},
    bind: {
        disabled: "{disabled}"
    },
    config: {
        record: null,
    },
    bodyPadding: 10,
    layout: {
        type: 'vbox',
        align: 'stretch'
    },

    items: [
        {
            xtype: 'panel',
            itemId: 'header',
            flex: 0.5,
            layout: {
                type: 'hbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'textarea',
                    flex: 1
                },
                {
                    xtype: 'panel',
                    flex: 2,
                    itemId: 'reportheader',
                    scrollable: 'y',
                    items: [],
                }
            ]
        },
        {
            xtype: 'panel',
            itemId: 'reportheader',
            layout: 'fit',
            flex: 0.5,
            hidden: true
        },
        {
            xtype: 'panel',
            itemId: 'reportlist',
            layout: 'fit',
            flex: 1,
            //html: 'table',
        },
        {
            xtype: 'panel',
            itemId: 'reportfooter',
            layout: 'fit',
            flex: 0.5,
            hidden: true
        },
        {
            xtype: 'panel',
            // flex: 1,
            html: 'sum footer',
            hidden: true
        }
    ],
    loadRecord: function(record){
        this.getController().loadRecord(record);
    }
});