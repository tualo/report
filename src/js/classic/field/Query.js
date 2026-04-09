
Ext.define('Tualo.report.mixins.field.Query', {
    query: async function (record, queriedValue, type) {
        let params = {};
        if (typeof record.store.getHeader == 'function') params.header = record.store.getHeader();
        params.position = record.data;

        if (
            this.report_lastQuery != null
            && new Date().getTime() - this.report_lastQuery < 1000
        ) {
            throw 'Too many queries';

        }
        this.report_lastQuery = new Date().getTime();

        let request = await fetch(`./reportdata/${type}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(params)
        });
        if (!request.ok) {
            Ext.toast({
                html: `Fehler beim Abrufen ${type} Daten`,
                title: 'Fehler',
                width: 200,
                align: 't'
            });
            return;
        }
        let data = await request.json();
        if (data.success) {
            return {
                queriedValue: queriedValue,
                data: data
            };
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
});