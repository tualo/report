Ext.define('Tualo.routes.report.Setup',{
    statics: {
        load: async function() {
            return [
                {
                    name: 'Setup Report',
                    path: '#reportsetup/:{type}'
                }
            ]
        }
    }, 
    url: 'reportsetup/:{type}',
    handler: {
        action: function( values ){

            let fn = async function(){
                const formData = new FormData();
                formData.append("table_name",values.table_name);

                let res = await fetch('./reportsetup/'+values.type,{
                    method: "POST",
                    body: formData,
                    }).then((res)=>{ return res.json() });
                Ext.util.History.back();
            }

            fn();

            Ext.toast({
                html: 'Die Belegart wird aufgefrischt',
                title: values.table_name,
                align: 't',
                iconCls: 'fa fa-check'
            });

        },
        before: function ( values, action) {
            action.resume();
        }

    }
});