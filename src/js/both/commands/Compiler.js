Ext.define('Tualo.report.commands.Compiler', {
    statics:{
      glyph: 'server',
      title: 'Kompilieren',
      tooltip: 'Kompilieren'
    },
    extend: 'Ext.panel.Panel',
    alias: 'widget.report_compiler_command',
    layout: 'fit',
    items: [
      {
        xtype: 'form',
        itemId: 'syncform',
        bodyPadding: '25px',
        items: [
          {
            xtype: 'label',
            text: 'Durch klicken auf *Erstellen* wird die Belegstruktur neu erstellt.',
          }

        
        ]
      },{
        hidden: true,
        xtype: 'panel',
        itemId: 'waitpanel',
        layout:{
          type: 'vbox',
          align: 'center'
        },
        items: [
          {
            xtype: 'component',
            cls: 'lds-container',
            html: '<div class="lds-grid"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>'
            +'<div><h3>Die Belegstruktur wird erstellt</h3>'
            +'<span>Einen Moment bitte ...</span></div>'
          }
        ]
      }
    ],
    loadRecord: function(record,records,selectedrecords){
      this.record = record;
      this.records = records;
      this.selectedrecords = selectedrecords;
  
    },
    getNextText: function(){
      return 'Erstelllen';
    },
    run: async function(){
      let me = this;
      me.getComponent('syncform').hide();
      me.getComponent('waitpanel').show();
      let res= await (await fetch('./reportsetup/'+me.record.get('tabellenzusatz') )).json();
      if (res.success !== true){
        Ext.toast({
            html: res.msg,
            title: 'Fehler',
            align: 't',
            iconCls: 'fa fa-warning'
        });
      }
      return res;
    }
  });
