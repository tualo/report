Ext.define('Tualo.report.lazy.Reminder', {
    extend: "Ext.panel.Panel",
    requires: [
        'Tualo.report.lazy.controller.Reminder',
        'Tualo.report.lazy.models.Reminder',
        'Tualo.report.lazy.ReportPanel'
    ],
    controller: 'lazy_report_reminder',
    viewModel: {
        type: 'lazy_report_reminder'
    },
    bodyPadding: 10,
    bind: {
        title: '{title}'
    },
    listeners: {
        boxready: 'onBoxReady'
    },
    layout: 'card',
    initConfig: function (config) {
        console.log(config);
        this.callParent(config);
        this.getViewModel().set('type', config.type);
        this.getViewModel().set('referencenr', config.referencenr);
        this.getViewModel().set('reminder_level', config.reminder_level || 1);
        this.getViewModel().set('costcenter', config.costcenter || 0);
    },
    items: []
});