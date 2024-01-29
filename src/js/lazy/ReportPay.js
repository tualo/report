Ext.define('Tualo.report.lazy.ReportPay', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.lazy_reportpay_panel',
    requires: [
      'Ext.form.Panel',
      'Tualo.report.lazy.models.ReportPay',
      'Tualo.report.lazy.controller.ReportPay'
    ],
    config: {
        type: null,
        reportnumber: null
    },
    controller: 'lazy_reportpay_panel',
    viewModel: {
      type: 'lazy_reportpay_panel'
    },
    listeners:{
      boxReady: 'onBoxReady'
    },
    layout: {
        type: 'vbox',
          align: 'stretch'
    },
    items: [
      {
        flex: 1,
        xtype: 'tabpanel',
        /*
        tools: [
          {
            xtype: 'glyphtool',
            glyph: 'trash',
            handler: 'onTrashClick'
          }
        ],
        */
        items: [
          {
            title: 'Übersicht',
            xtype: 'grid',
            bind:{
              store: '{paystore}'
            },
            features    : [
              
            ],
            columns:[
              {
                header: 'Datum',
                xtype: 'datecolumn',
                format: 'd.m.Y',
                dataIndex: 'datum',
                width: 80,
                fixedSummaryType: 'count',
                fixedSummaryRenderer: function(value, summaryData, dataIndex) {
                  return Ext.String.format('{0} {1}', value, value > 1 ? 'Einträge' : 'Eintrag');
                },
                selectedSummaryType: 'count',
                selectedSummaryRenderer: function(value, summaryData, dataIndex) {
                  return Ext.String.format('{0} {1} ausgewählt', value, value > 1 ? 'Einträge' : 'Eintrag');
                }
              },
              {
                header: 'ID',
                dataIndex: 'id',
                width: 80,
                hidden: true
              },
              {
                header: 'Text',
                dataIndex: 'text',
                flex: 1
              },
              {
                header: 'Wert',
                dataIndex: 'value',
                flex: 1,
                xtype: 'numbercolumn',
                format:'0.000,00/i',
                align: 'right',
                fixedSummaryType: 'sum',
                fixedSummaryRenderer: Ext.util.Format.numberRenderer('0.000,00/i'),
                selectedSummaryType: 'sum',
                selectedSummaryRenderer: Ext.util.Format.numberRenderer('0.000,00/i')
  
              }
            ]
          },
          {
            title: 'Kontoauszug',
            xtype: 'tualocontextgridpanel',
            hidden: true,
            bind:{
              store: '{paydetailstore}'
            },
            columns:[
  
              {
                header: 'Datum',
                xtype: 'datecolumn',
                format: 'd.m.Y',
                dataIndex: 'valuta',
                width: 80,
                fixedSummaryType: 'count',
                fixedSummaryRenderer: function(value, summaryData, dataIndex) {
                  return Ext.String.format('{0} {1}', value, value > 1 ? 'Einträge' : 'Eintrag');
                },
                selectedSummaryType: 'count',
                selectedSummaryRenderer: function(value, summaryData, dataIndex) {
                  return Ext.String.format('{0} {1} ausgewählt', value, value > 1 ? 'Einträge' : 'Eintrag');
                }
              },
              {
                header: 'Text',
                dataIndex: 'empfaengername',
                width: 80
              },
              {
                header: 'Text',
                dataIndex: 'verwendungszweck',
                flex: 1
              },
              {
                header: 'Wert',
                dataIndex: 'betrag',
                width: 80,
                xtype: 'numbercolumn',
                format:'0.000,00/i',
                align: 'right',
                fixedSummaryType: 'sum',
                fixedSummaryRenderer: Ext.util.Format.numberRenderer('0.000,00/i'),
                selectedSummaryType: 'sum',
                selectedSummaryRenderer: Ext.util.Format.numberRenderer('0.000,00/i')
  
              }
            ]
          }
        ]
      },
  
  
  
      {
        xtype: 'form',
        bodyPadding: 15,
        reference: 'payform',
        buttons: [
          {
            text: 'Hinzufügen',
            handler: 'addPayment'
          }
        ],
        items:[
          {
            xtype: 'fieldset',
            title: 'Hinzufügen',
            layout:{
              type: 'hbox',
              align: 'strech'
            },
            items: [
              {
                xtype: 'combobox_zahlungsarten_bezeichnung',
                //xtype: 'textfield',
                flex: 1,
                reference: 'paytypeField',
                name: 'paytype',
                value: 'Rechnung',
  
                allowBlank: false,
                listeners: {
                  change: 'onPayTypeChanged'
                }
              },
              {
                xtype: 'combobox',
                listeners: {
                  focusenter: 'onFocus'
                },
                allowBlank: true,
                displayField: 'text',
                valueField: '__id',
                flex: 1,
                bind:{
                  store: '{referenzds}'
                },
                reference: 'referenzdsField',
                name: 'referenzds'
              },
              {
                xtype: 'datefield',
                flex: 1,
                name: 'datum',
                submitFormat: 'Y-m-d',
                format: 'd.m.Y',
                value: new Date()
              },
              {
                xtype: 'textfield',
                flex: 1,
                name: 'bemerkung',
                emptyText: 'Bemerkung',
  
                value: ''
              },
              {
                xtype: 'numberfield',
                flex: 1,
                reference: 'valueField',
                name: 'value',
                value: 0
              }
            ]
          }
  
        ]
  
  
      },
      {
        xtype: 'form',
        bodyPadding: 15,
        hidden: true,
        reference: 'reduceform',
        buttons: [
          {
            text: 'Mindern',
            handler: 'addReduce'
          }
        ],
        items:[
          {
            xtype: 'fieldset',
            title: 'Mindern',
            layout:{
              type: 'hbox',
              align: 'strech'
            },
            items: [
              {
                //xtype: 'combobox_minderungsarten_name',
                xtype: 'textfield',
                flex: 1,
                reference: 'reducetypeField',
                name: 'reducetype',
                value: '',
                allowBlank: false,
                listeners: {
                  change: 'onReducdeTypeChanged'
                }
              },
  
              {
                xtype: 'textfield',
                flex: 1,
                name: 'bemerkung',
                emptyText: 'Bemerkung',
  
                value: ''
              },
              {
                xtype: 'numberfield',
                flex: 1,
                reference: 'valueField',
                name: 'value',
                value: 0
              }
            ]
          }
  
        ]
  
  
      }
    ]
  })
  