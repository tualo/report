Ext.define('Tualo.report.lazy.controller.Reminder', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.lazy_report_reminder',
    onBoxReady: function () {

        let cls = {
            xtype: 'lazy_report_panel',
        },
            stage = this.getView(),
            c = Ext.create(cls || {});


        let record = Ext.create('Ext.data.Model', {
            tabellenzusatz: 'ms' + this.getViewModel().get('reminder_level'),
            id: -1,
            referencenr: this.getViewModel().get('referencenr'),
            bezugsnummer: this.getViewModel().get('referencenr'),
            costcenter: this.getViewModel().get('costcenter')
        });

        c.on('report_ready', this.onReportReady, this)

        stage.add(c);
        stage.setActiveItem(c);
        c.loadRecord(record);
        setTimeout(() => {
            c.loadRecord(record);

        }, 1000);
    },
    onReportReady: function (report) {
        console.log('onReportReady', arguments);
        this._reportCmp = report;
        this.queryOpenPositions();
    },
    queryOpenPositions: function () {
        let type = this.getViewModel().get('type'),
            my_store = Ext.create('Tualo.DataSets.store.View_blg_list_' + type),
            tabellenzusatz = 'ms' + this.getViewModel().get('reminder_level');

        my_store.setFilters([{
            property: 'bezugsnummer',
            operator: 'eq',
            value: this.getViewModel().get('referencenr')
        },
        {
            property: 'kostenstelle',
            operator: 'eq',
            value: this.getViewModel().get('costcenter')
        },
        {
            property: 'offen',
            operator: '!=',
            value: 0
        },
        {
            property: 'overdue',
            operator: '=',
            value: 1
        }
        ]);

        my_store.load({
            scope: this,
            callback: function () {
                let positions = [];

                my_store.getRange().forEach((row) => {
                    positions.push(Ext.create('Tualo.DataSets.model.View_editor_blg_pos_' + tabellenzusatz, {
                        article: row.get('belegnummer'),
                        note: row.get('reference'),
                        account: '0000',
                        amount: 1,
                        singleprice: row.get('offen'),
                        tax: 0,
                        net: row.get('offen'),
                        gross: row.get('offen'),



                        vdatum: row.get('datum'),
                        vfaelligam: row.get('faelligam'),
                        vzusatz: type,
                        vid: row.get('belegnummer')
                    }))
                });

                console.log('positions', positions);
                this._reportCmp.positionsList.getStore().loadData(positions);
            }
        });
    }
});