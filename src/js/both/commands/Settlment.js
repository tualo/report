Ext.define('Tualo.report.commands.Settlement', {
    statics: {
        glyph: 'money-check-dollar',
        title: 'Zahlungsausgleich',
        tooltip: 'Zahlungsausgleich'
    },
    extend: 'Ext.panel.Panel',
    alias: 'widget.report_settlement_command',
    layout: 'fit',
    items: [

        {
            xtype: 'panel',
            itemId: 'mainpanel',
            layout: {
                type: 'vbox',
                align: 'center'
            },
            items: [
                {
                    xtype: 'component',
                    itemId: 'displaydata',
                    cls: 'lds-container-compact',

                    html: '<i class="fa-solid fa-money-check-dollar" style="font-size: 4rem;"></i>'
                        + '<div><h3>Ausziffern</h3>'
                        + '<span>Klicken Sie auf weiter, um zu beginnen.</span></div>'
                }
            ]
        },

    ],
    loadRecord: function (record, records, selectedrecords) {
        this.record = record;
        this.records = records;
        this.selectedrecords = selectedrecords;
        if (this.selectedrecords.length != 2) {
            Ext.History.back(); å
        }
        let sum = 0;
        this.selectedrecords.forEach((rec) => {
            sum += rec.get('offen');
        });



        let text_data = [];

        text_data.push('Beleg ' + this.selectedrecords[0].get('id') + ' offen: ' + this.selectedrecords[0].get('offen') + ' wird mit Beleg ' + this.selectedrecords[1].get('id') + ' ausgeglichen.');
        text_data.push('Beleg ' + this.selectedrecords[1].get('id') + ' offen: ' + this.selectedrecords[1].get('offen') + ' wird mit Beleg ' + this.selectedrecords[0].get('id') + ' ausgeglichen.');

        this.getComponent('mainpanel').getComponent('displaydata').setHtml(
            [
                '<i class="fa-solid fa-money-check-dollar" style="font-size: 4rem;"></i>',
                '<div>',
                '<h3>Ausziffern</h3>',
                '<p>Beleg ' + this.selectedrecords[0].get('id') + ' offen: ' + this.selectedrecords[0].get('offen') + ' wird mit Beleg ' + this.selectedrecords[1].get('id') + ' ausgeglichen.</p>',
                '<p>Beleg ' + this.selectedrecords[1].get('id') + ' offen: ' + this.selectedrecords[1].get('offen') + ' wird mit Beleg ' + this.selectedrecords[0].get('id') + ' ausgeglichen.</p>',
                '<p>Es verbleiben ' + sum + ' € zu zahlen.</p>',
                '</div>'
            ].join('')
        );


    },
    getNextText: function () {
        return 'Ausziffern';
    },
    run: async function () {
        let me = this;
        me.getComponent('mainpanel').getComponent('displaydata').hide();
        // me.getComponent('waitpanel').show();

        let res = await (await fetch('./reducereport/' + this.selectedrecords[0].get('tabellenzusatz') + '/' + this.selectedrecords[0].get('id'), {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                value: this.selectedrecords[1].get('offen') * -1,
                name: 'Auszifferung',
                note: this.selectedrecords[1].get('id')
            })
        })).json();
        if (res.success !== true) {
            Ext.toast({
                html: res.msg,
                title: 'Fehler',
                align: 't',
                iconCls: 'fa fa-warning'
            });
            return;
        }

        res = await (await fetch('./reducereport/' + this.selectedrecords[1].get('tabellenzusatz') + '/' + this.selectedrecords[1].get('id'), {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                value: this.selectedrecords[0].get('offen') * -1,
                name: 'Auszifferung',
                note: this.selectedrecords[0].get('id')
            })
        })).json();
        if (res.success !== true) {
            Ext.toast({
                html: res.msg,
                title: 'Fehler',
                align: 't',
                iconCls: 'fa fa-warning'
            });
            return;
        }
        this.selectedrecords[0].store.load();
        // Ext.History.back();
        return res;
    }
});
