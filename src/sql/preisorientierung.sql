delimiter ;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('preisorientierung','Preisorientierung','',0,'name','name','name',1,'','','','',0,'tualomultirowmodel','',0,'','','','ERP','',1,'','','listview','XlsxWriter','{GUID}',0,100,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('preisorientierung','id','{#serial}',10000000,1,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('preisorientierung','name','',10000000,0,'',0,0,'','','NO','NO',1,'','varchar','UNI','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('preisorientierung','id','DE','ID','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('preisorientierung','name','DE','Name','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('preisorientierung','id','DE','ID','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('preisorientierung','name','DE','Name','textfield','Allgemein',999,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('preisorientierung','id','id','id',''),
('preisorientierung','name','name','name','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','preisorientierung',0,1,1,1,1);
UNLOCK TABLES;
