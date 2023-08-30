delimiter ;

CREATE  VIEW IF NOT EXISTS `steuergruppen_field` AS select `steuergruppen`.`steuergruppe` AS `name`,`steuergruppen`.`feld` AS `feld` from `steuergruppen` union select 'steuerschluessel' AS `name`,'steuerschluessel' AS `feld`;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('steuergruppen_field','Steuergruppe-Feld','',0,'name','name','name',1,'','','','',0,'cellmodel','',0,'','','','ERP','',1,'','','listview','XlsxWriter','{GUID}',0,100,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('steuergruppen_field','feld',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('steuergruppen_field','name','',0,0,'',0,0,'','','NO','NO',1,'','varchar','','varchar(25)',25,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('steuergruppen_field','name','DE','Name','gridcolumn','',1,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('steuergruppen_field','Steuergruppe','name','name','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','steuergruppen_field',0,0,0,0,1);
UNLOCK TABLES;
