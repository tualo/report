delimiter ;

insert ignore into ds_class (class_name) values ('Belegarten'),('ERP');

CREATE VIEW IF NOT EXISTS `view_editor_artikelgruppen` AS 
select `artikelgruppen`.`gruppe` AS `gruppe` from `artikelgruppen`;


LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`) VALUES ('view_editor_artikelgruppen','Beleg-Artikelgruppen-Dropdown','',0,'gruppe','gruppe','gruppe',0,'','','','',0,'tualomultirowmodel','',0,'','','','Belegarten','',1,'','','','','',0,0,1,'',0);
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`) VALUES ('view_editor_artikelgruppen','gruppe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('view_editor_artikelgruppen','gruppe','DE','Artikel','displayfield','Allgemein',999,0,1,0,'1',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('view_editor_artikelgruppen','gruppe','gruppe','gruppe','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('_default_','view_editor_artikelgruppen',1,0,0,0,0);
UNLOCK TABLES;
