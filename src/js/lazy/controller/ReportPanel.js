Ext.define('Tualo.report.lazy.controller.ReportPanel', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.lazy_report_panel',

    createConvertMenu: function () {
        let me = this;
        if (me.getViewModel().get('record').get('tabellenzusatz').length >= 3) {
            Tualo.Ajax.request({
                url: './report-convertlist/' + me.getViewModel().get('record').get('tabellenzusatz'),
                params: {
                },
                scope: me,
                json: function (o) {
                    if (o.success) {
                        let btn = me.lookupReference('convertBTN'),
                            menu = btn.getMenu();
                        menu.removeAll();
                        o.data.forEach(function (elm) {
                            menu.add({
                                text: elm.bezeichnung,
                                scope: me,
                                handler: function (btn) {

                                    Ext.MessageBox.confirm('Frage', elm.frage, async function (btn) {
                                        if (btn == 'yes') {
                                            let resData = await fetch('./report-convert/' + me.getViewModel().get('record').get('tabellenzusatz') + '/' + me.getViewModel().get('record').get('id') + '/' + elm.totype);
                                            let data = await resData.json();
                                            if (data.success) {
                                                window.open('#ds/view_blg_list_' + elm.totype + '/id/' + data.data.id, '_blank');
                                            } else {
                                                let msg = data.msg;
                                                if (!msg) msg = "Leider ist ein unbekannter Fehler aufgetreten.";
                                                Ext.toast({
                                                    html: msg,
                                                    title: 'Fehler',
                                                    width: 200,
                                                    align: 't'
                                                });
                                            }
                                        }
                                    }, me);

                                }
                            });
                            btn.setHidden(false);
                        });
                    }
                }
            });
        } else {
            let btn = me.lookupReference('convertBTN');
            btn.setHidden(true);
        }
    },

    onFormFieldChanged: function (fld, oldValue, newValue) {

        let me = this, sel = null, view = this.getView();
        if (fld.name == 'referencenr') {
            console.log('onFormFieldChanged', arguments, fld.getStore().isLoaded());
            if (
                (typeof fld.picker != 'undefined') &&
                (typeof fld.picker.getSelection == 'function')
            ) {
                sel = fld.picker.getSelection();
                console.log('onFormFieldChanged !!!', arguments, fld.name);
                if ((sel.length > 0) && (sel[0].get('referencenr') != null)) {
                    if (sel[0].get('__rownumber') == 0) return;

                    view.getForm().setValues({
                        referencenr: sel[0].get('referencenr'),
                        costcenter: sel[0].get('costcenter'),
                        address: sel[0].get('address')
                    });

                }
            }
        }
    },

    getAddress: function (referencenr) {

        let flds = Ext.ComponentQuery.query('[name=referencenr]'),
            hdr = this.getView().getComponent('header').getComponent('reportheader');

        for (let i = 0; i < flds.length; i++) {
            let fld = flds[i];

            if (hdr.down(fld)) {

                let store = fld.getStore(),
                    r = store.findRecord('referencenr', referencenr, 0, false, false, true);
                if (r) {
                    console.log(r.get('address'));
                    return r.get('address');
                }
            }
        };
        return null;
    },

    loadRecord: function (record) {
        this.getViewModel().set('record', record);
        this.getViewModel().set('loadedRecord', record.data);

        if (!Ext.isEmpty(record)) {
            if (typeof this.positionsList == 'undefined') {
                this.initializeReport();
                this.getViewModel().set('initialized', true);
            } else {
                this.reportData(
                    this.getViewModel().get('record').get('tabellenzusatz'),
                    this.getViewModel().get('record').get('id')
                );
            }
        }
    },
    getReportHeader: function () {
        let view = this.getView(),
            original = this.getViewModel().get('loadedRecord'),
            o = { ...view.getForm().getValues(false, false, false, true), ...original };
        for (let k in o) {
            if (o.hasOwnProperty(k)) {
                if (o[k] == null) delete o[k];
                if (o[k] instanceof Date) o[k] = Ext.util.Format.date(o[k], 'Y-m-d');
            }
        }
        return o;
        //return this.getView().getForm().getValues(false, false, false, true);
    },
    save: async function () {
        let view = this.getView(),
            original = this.getViewModel().get('loadedRecord'),
            o = { ...view.getForm().getValues(false, false, false, true), ...original };
        view.setDisabled(true);
        for (let k in o) {
            if (o.hasOwnProperty(k)) {
                if (o[k] == null) delete o[k];
                if (o[k] instanceof Date) o[k] = Ext.util.Format.date(o[k], 'Y-m-d');
            }
        }
        o.texts = []

        if (this.headtextElement) {
            console.log('headtextElement', this.headtextElement, this.headtextElement.getValue())
            o.texts.push(
                {
                    type: 'head',
                    typ: 'head',
                    text: this.headtextElement.getValue()
                }
            )
        }

        if (this.foottextElement) {
            console.log('headtextElement', this.foottextElement, this.foottextElement.getValue())
            o.texts.push(
                {
                    type: 'foot',
                    typ: 'foot',
                    text: this.foottextElement.getValue()
                }
            )
        }
        //        this.getView().getComponent('reportheader')

        o.positions = [];
        this.positionsList.getStore().each((item) => {

            let d = item.getData();
            if (
                d.amount != null
                && d.tax != null
            ) {
                for (let k in d) {
                    if (d.hasOwnProperty(k)) {
                        if (d[k] == null) delete d[k];
                        if (d[k] instanceof Date) d[k] = Ext.util.Format.date(d[k], 'Y-m-d');
                    }
                }
                if ((d.id == 0) && (d.amount == 0)) {
                    // ignore emtpy lines

                } else {
                    if (d.id != 0) d.__id = d.id; // keep the original pos id
                    if (!Ext.isEmpty(d.article))
                        o.positions.push(d);
                }
            }
        });


        let data = await fetch(
            './report/' + this.getViewModel().get('record').get('tabellenzusatz') + '/' + this.getViewModel().get('record').get('id'),
            {
                method: 'PUT',
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(o)
            }
        ).then((response) => { return response.json() });
        view.setDisabled(false);
        if (data.success) {

            //this.loadRecord(data.data);
            this.getViewModel().get('record').set(data.data);
            this.reportData(this.getViewModel().get('record').get('tabellenzusatz'), data.data.id);
            view.up().up().getViewModel().set('viewTypeOnLoad', 'form');
            view.up().up().getComponent('list').getStore().load({
                callback: function () {
                    setTimeout(() => {
                        let r = view.up().up().getComponent('list').getStore().findExact('id', data.data.id);
                        view.up().up().getComponent('list').getSelectionModel().select(r);
                    }, 500);
                }
            });
        } else {

            Ext.toast({
                html: data.msg,
                title: 'Fehler beim Speichern',
                align: 't'
            }, 2000);
        }

    },
    openPresets: function () {
        let me = this,
            wnd = Ext.create('Ext.Window', {
                title: 'Artikelvorgaben',
                width: 600,
                height: 600,
                layout: {
                    type: 'vbox',
                    align: 'stretch'
                },
                items: [{
                    xtype: 'textfield',
                    emptyText: "Suchen ...",
                    triggers: {
                        bar: {
                            weight: 0,
                            cls: Ext.baseCSSPrefix + "form-clear-trigger",
                            handler: function (field) {
                                field.setValue("");
                                let store = field.up('window').getComponent('list').getStore(),
                                    params = store.getProxy().getExtraParams();
                                if (Ext.isEmpty(params)) { params = {}; };
                                delete params.filter_by_search;
                                delete params.search;
                                store.getProxy().setExtraParams(params);
                                store.load();
                                // field.up('window').getController().setViewType("list");
                            }
                        }
                    },
                    listeners: {
                        specialkey: function (field, e) {
                            if (e.getKey() == e.ENTER) {
                                let store = field.up('window').getComponent('list').getStore();
                                store.getProxy().setExtraParam("filter_by_search", 1);
                                //                store.getProxy().setExtraParam("fulltext",2);
                                store.getProxy().setExtraParam("search", field.getValue());
                                store.load();
                                // field.up('window').getController().setViewType("list");
                            }
                        }
                    },
                }, {


                    title: null,
                    itemId: 'list',
                    xtype: 'dslist_view_editor_blg_sets_artikel',
                    store: {
                        type: 'view_editor_blg_sets_artikel_store',
                        autoLoad: true,
                    },
                    listeners: {
                        scope: this,
                        itemdblclick: function (view, use_record) {
                            console.log('itemdblclick', view, use_record);
                            let records = this.positionsList.getSelection(),
                                data = use_record.data;
                            if (records.length > 0) {
                                let record = records[0];

                                record.set(data);
                                try {
                                    record.set('article', data.artikel);
                                    record.set('notes', data.bemerkung);
                                    record.set('amount', data.amount);
                                    record.set('singleprice', data.epreis);
                                    record.set('unit', data.einheit);
                                    record.set('tax', 19);
                                } catch (e) {
                                    console.error(e);
                                }
                            } else {

                                let record = Ext.create('Tualo.DataSets.model.View_editor_blg_pos_' + me.getViewModel().get('record').get('tabellenzusatz'), data);
                                record.set('article', data.artikel);
                                record.set('notes', data.bemerkung);
                                record.set('amount', data.amount);
                                record.set('singleprice', data.epreis);
                                record.set('unit', data.einheit);
                                record.set('tax', 19);

                                this.positionsList.getStore().add(record);

                            }
                            view.up('window').close();
                        }
                    },
                    flex: 1,
                }]
            });
        wnd.show();
        let size0 = Ext.getApplication().getMainView().getSize();
        wnd.setPosition(size0.width * 0.025, size0.height * 0.10);
        size0.width = size0.width * 0.95;
        size0.height = size0.height * 0.75;
        wnd.setSize(size0);

    },
    reportData: async function (tabellenzusatz, id) {
        let view = this.getView();
        view.getForm().reset(true);
        if (this.positionsList)
            this.positionsList.getStore().removeAll();

        if (typeof tabellenzusatz == 'undefined') return;

        if (id < 0) {
            if (
                view.getViewModel().get('record').get('bezugsnummer') == "" ||
                view.getViewModel().get('record').get('bezugsnummer') == null) {


                view.getViewModel().get('record').set('bezugsnummer', view.getViewModel().get('record').get('kundennummer'));

            }



        }
        let config = this.getViewModel().get('config'),
            data = await fetch('./report/' + tabellenzusatz + '/' + id, {
                method: 'POST',
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(this.getViewModel().get('record').getData())
            }).then((response) => { return response.json() });
        if (data.success) {
            let positions = [];
            let record = Ext.create('Tualo.DataSets.model.View_editor_blg_hdr_' + tabellenzusatz, data.data);

            console.log(record.data, view.getForm().getValues());

            if (Ext.isEmpty(record.data.address)) {

                record.data.address = this.getAddress(record.data.referencenr);
            }
            view.getForm().setValues(record.data);

            data.data.positions.forEach((item) => {
                let pos = { ...item };
                for (let k in config.translations.pos) {
                    let o = config.translations.pos[k][0];
                    pos[o.column_name] = item[k];
                }
                let precord = Ext.create('Tualo.DataSets.model.View_editor_blg_pos_' + tabellenzusatz, pos);
                positions.push(precord);
            });

            if (this.headtextElement) {
                console.log('defaultheadtext', config.defaultheadtext);
                window.headtextElement = this.headtextElement;
                this.headtextElement.setValue(config.defaultheadtext);
            }
            if (this.foottextElement) {
                this.foottextElement.setValue(config.defaultfoottext);
            }


            data.data.texts.forEach((item) => {
                if (item.type == 'head') {
                    if (this.headtextElement) {
                        this.headtextElement.setValue(item.text);
                    }
                }
                if (item.type == 'foot') {
                    if (this.foottextElement) {
                        this.foottextElement.setValue(item.text);
                    }
                }
            });

            if (positions.length == 0) {
                positions.push(Ext.create('Tualo.DataSets.model.View_editor_blg_pos_' + tabellenzusatz, {}));
            }

            this.positionsList.getStore().loadData(positions);

            this.getView().fireEvent('report_ready', this);
        }
    },


    removeUneccessaryFields: function (list) {
        list.forEach((item) => {
            delete item['bind'];
            // delete item['listeners'];
            if (item.items) {
                item.items = this.removeUneccessaryFields(item.items);
            }
        });
        return list;
    },
    hideSaveButton: function () {
        try {
            let toolbar_items = this.getView().up().up().down('toolbar').items;
            toolbar_items.each((item) => {
                if (
                    (item.glyph == 'save') ||
                    (item.glyph == 'history')
                ) {
                    item.setHidden(true);
                }
            });
        } catch (e) { }
    },
    initializeReport: async function () {
        // this.hideSaveButton();

        if (this.getViewModel().get('initializeReport') === true) return;
        this.getViewModel().set('initializeReport', true);
        this.createConvertMenu();

        console.log('initializeReport', this.getViewModel().get('record').get('tabellenzusatz'));
        let config = await fetch('./reportconfig/' + this.getViewModel().get('record').get('tabellenzusatz')).then((response) => { return response.json() });
        if (config.success) {
            this.getViewModel().set('config', config);

            if (Ext.isEmpty(Ext.ClassManager.getByAlias('widget.dslist_view_editor_blg_pos_' + this.getViewModel().get('record').get('tabellenzusatz')))) {
                Ext.toast('Die Beleg-Liste ist nicht konfiguriert', 2000);
                console.info('Die Beleg-Liste ist nicht konfiguriert. Bitte den Datenstamm view_editor_blg_pos_' + this.getViewModel().get('record').get('tabellenzusatz') + ' anpassen.');
                return;
            }
            if (Ext.isEmpty(Ext.ClassManager.getByAlias('widget.dslist_view_editor_blg_hdr_' + this.getViewModel().get('record').get('tabellenzusatz')))) {
                Ext.toast('Der Belegkopf ist nicht konfiguriert', 2000);
                console.info('Der Belegkopf ist nicht konfiguriert. Bitte den Datenstamm view_editor_blg_hdr_' + this.getViewModel().get('record').get('tabellenzusatz') + ' anpassen.');
                return;
            }




            let hdr = Ext.create({
                scrollable: 'y',
                xtype: 'panel',
                defaults: {
                    labelWidth: 150,
                },
                items: this.removeUneccessaryFields(config.header),
                // bodyPadding: 10
            });

            this.getView().getComponent('header').getComponent('reportheader').removeAll();
            this.getView().getComponent('header').getComponent('reportheader').add(
                hdr
            );


            this.getView().getComponent('reportlist').add(
                this.positionsList = Ext.create({
                    title: null,
                    border: true,
                    xtype: 'dslist_view_editor_blg_pos_' + this.getViewModel().get('record').get('tabellenzusatz'),
                    features: {
                        ftype: 'summary',
                        dock: 'bottom'
                    },
                    plugins: {
                        gridfilters: true,
                        cellediting: {
                            clicksToEdit: 1,
                            listeners: {
                                edit: function (editor, fld) {
                                    this.grid.checkAutoNewRow(fld.rowIdx);
                                    this.grid.fireEvent('edited', fld.record, fld);
                                    return true;
                                }
                            }
                        }
                    },
                    store: {
                        type: 'json',
                        getHeader: this.getReportHeader.bind(this),
                        model: 'Tualo.DataSets.model.View_editor_blg_pos_' + this.getViewModel().get('record').get('tabellenzusatz'),
                    },

                    listeners: {
                        "drop": "onDropGrid"
                        /*
                            itemcontextmenu: function (view, record, item, index, e) {
                                e.stopEvent();
                                let me = this;
                                alert('contextmenu');
                            }*/
                    }
                })
            );
            console.log('this.positionsList', this.positionsList);

            if (Ext.isEmpty(config.headtext)) {
                this.getView().getComponent('reportheader').setHidden(true);
            } else {
                this.getView().getComponent('reportheader').setHidden(false);
                console.log('headtext config', config.headtext);
                let cpm = Ext.create(config.headtext);
                this.headtextElement = cpm;
                this.getView().getComponent('reportheader').add(cpm);
            }
            if (Ext.isEmpty(config.foottext)) {
                this.getView().getComponent('reportfooter').setHidden(true);
            } else {
                this.getView().getComponent('reportfooter').setHidden(false);
                let cpm = Ext.create(config.foottext);
                this.foottextElement = cpm;
                this.getView().getComponent('reportfooter').add(cpm);
            }

            if (config.renderer) {
                this.getViewModel().set('renderer', config.renderer);
                let menuItems = [],
                    viewEye = this.getView().getComponent('tools').getComponent('openView');
                config.renderer.forEach((item) => {
                    menuItems.push({
                        text: item.label,
                        pug_template: item.pug_template,
                        useremote: item.useremote
                    });

                });

                if (menuItems.length > 1) {
                    if (viewEye) {
                        if (typeof viewEye.setMenu === 'function') {
                            viewEye.setMenu(
                                Ext.create('Ext.menu.Menu', {
                                    items: menuItems
                                }), true);
                        }
                    }
                }
            }
        }
        this.reportData(this.getViewModel().get('record').get('tabellenzusatz'), this.getViewModel().get('record').get('id'));

    },

    openView: function () {
        console.log(arguments, this.getViewModel().get('renderer'))
        let me = this,
            renderer = this.getViewModel().get('renderer');

        if (renderer.length == 1) {
            me.openViewRenderer(renderer[0]);
        } else {
        }
        // window.open('./'+typ+'/view_blg_list_'+me.getViewModel().get('record').get('tabellenzusatz') +'/report_2025_content/3
    },

    openViewRenderer: function (renderer) {
        let me = this,
            typ = renderer.useremote ? 'remote/pdf' : 'pugreportpdf';
        window.open('./' + typ + '/view_blg_list_' + me.getViewModel().get('record').get('tabellenzusatz') + '/' + renderer.pug_template + '/' + me.getViewModel().get('record').get('id'), '_blank');

    },


    reject: function () {
        let me = this;
        Ext.Msg.show({
            title: 'Stornieren?',
            message: 'Möchten Sie diesen Beleg wirklich stornieren?',
            buttons: Ext.Msg.YESNOCANCEL,
            icon: Ext.Msg.QUESTION,
            fn: async function (btn) {
                if (btn === 'yes') {
                    let report = await fetch(
                        './rejectreport/' + me.getViewModel().get('record').get('tabellenzusatz') + '/' + me.getViewModel().get('record').get('id') + '',
                        {
                            method: 'GET'
                        }
                    ).then((response) => { return response.json() });
                    if (report.success) {
                        me.getViewModel().get('record').set('id', report.data.id);
                        me.reportData(me.getViewModel().get('record').get('tabellenzusatz'), me.getViewModel().get('record').get('id'));
                    }
                } else if (btn === 'no') {
                    console.log('No pressed');
                } else {
                    console.log('Cancel pressed');
                }
            }
        });


    },
    pay: function () {
        Ext.getApplication().redirectTo('payreport/' + this.getViewModel().get('record').get('tabellenzusatz') + '/' + this.getViewModel().get('record').get('id'));
    },


    onDropGrid: function () {
        this.numberRows();
    },

    numberRows: function () {
        var i,
            grid = this.getView(),
            model = this.getViewModel(),
            store = this.getStore(),
            records = store.getRange(),
            min = Number.POSITIVE_INFINITY,
            fld_name = model.get('reorderfield');
        if (!Ext.isEmpty(fld_name)) {
            //vc.getView().getComponent('list').getStore().getRange();


            for (i = 0; i < records.length; i++) {
                min = Math.min(min, records[i].get(fld_name));
            }
            min = 0;

            for (i = 0; i < records.length; i++) {
                console.log('onDropGrid', records[i], fld_name, min + i);
                records[i].set(fld_name, min + i);
            }
        }
    },
});