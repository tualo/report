Ext.define('Tualo.report.lazy.ReportPanel', {
    extend: "Ext.form.Panel",
    requires: [
        'Tualo.report.lazy.controller.ReportPanel',
        'Tualo.report.lazy.models.ReportPanel'
    ],
    bodyPadding: 10,
    alias: 'widget.lazy_report_panel',
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

    dockedItems: [
        {
            xtype: "toolbar",
            dock: "top",
            layout: 'hbox',
            itemId: 'tools',
            cls: "x-panel-header-default",
            listeners: {
                boxready: 'toolbarBoxReady'
            },
            items: [
                '->',
                {
                    xtype: "glyphtool",
                    glyph: "refresh",
                    handler: "refresh",
                    tooltip: "neu Laden",

                },
                {
                    xtype: "glyphtool",
                    glyph: "save",
                    tooltip: "Speichern",
                    handler: "save",

                },
                {
                    xtype: "glyphtool",
                    glyphPrefix: "fas fa-",
                    glyph: "coins",
                    tooltip: "Zahlungen",
                    handler: "pay",

                },
                {
                    xtype: "glyphtool",
                    glyphPrefix: "fa fa-",
                    glyph: "ban",
                    tooltip: "Stornieren",
                    handler: "reject",

                },
                {
                    xtype: "glyphtool",
                    glyphPrefix: "fa fa-",
                    glyph: "eye",
                    tooltip: "Öffnen",
                    itemId: "openView",
                    handler: "openView",

                }
            ]
        }
    ],

    items: [
        {
            xtype: 'panel',
            itemId: 'header',
            //flex: 0.5,
            layout: {
                type: 'hbox',
                align: 'stretch'
            },



            items: [
                {
                    xtype: 'panel',
                    // flex: 1,
                    layout: {
                        type: 'hbox',
                        align: 'stretch'
                    },
                    items: [
                        {
                            xtype: 'fieldset',
                            title: 'Anschrift',
                            layout: {
                                type: 'hbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'textarea',
                                    name: 'address'
                                }
                            ]
                        }
                    ]
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
    loadRecord: function (record) {
        this.getController().loadRecord(record);
    }
});