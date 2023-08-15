LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('mengeneinheiten','Mengeneinheiten','',0,'name','name','name',1,'','','','',0,'tualomultirowmodel','',0,'','','','Artikel','',1,'','','listview','XlsxWriter','Mengeneinheiten-{DATETIME}',0,100,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('mengeneinheiten','faktor','',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL,''),
('mengeneinheiten','id','{#serial}',10000000,0,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('mengeneinheiten','name','',10000000,0,'',0,0,'','','NO','NO',1,'','varchar','UNI','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('mengeneinheiten','symbol','',10000000,0,'',0,0,'','','NO','NO',1,'','varchar','','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('mengeneinheiten','faktor','DE','Faktor','gridcolumn','',3,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('mengeneinheiten','id','DE','ID','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('mengeneinheiten','name','DE','Name','gridcolumn','',1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('mengeneinheiten','symbol','DE','Symbol','gridcolumn','',2,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('mengeneinheiten','faktor','DE','Faktor','numberfield','Allgemein',999,0,1,1,'',1.00,''),
('mengeneinheiten','id','DE','ID','displayfield','Allgemein',999,1,1,1,'',1.00,''),
('mengeneinheiten','name','DE','Name','textfield','Allgemein',999,0,1,1,'',1.00,''),
('mengeneinheiten','symbol','DE','Symbol','textfield','Allgemein',999,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('mengeneinheiten','name','id','name','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','mengeneinheiten',0,0,0,0,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('buchungskonten','Buchungskonten','',0,'konto','konto','konto',1,'','','','',0,'tualomultirowmodel','',0,'','','','Belegarten','',1,'','','listview','XlsxWriter','{GUID}',0,100,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('buchungskonten','agenda_bezeichnung',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('buchungskonten','agenda_hauptfunktion',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(3)',3,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('buchungskonten','agenda_kontoart',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(3)',3,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('buchungskonten','agenda_langbezeichnung',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('buchungskonten','agenda_nebenfunktion',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(3)',3,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('buchungskonten','agenda_sammelkonto',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(3)',3,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('buchungskonten','agenda_steuersatz',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL,''),
('buchungskonten','agenda_steuerschluessel',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(2)',2,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('buchungskonten','aktiv','Ja',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('buchungskonten','konto','',10000000,0,'',1,0,'','','NO','NO',1,'','varchar','PRI','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('buchungskonten','kostenstelle',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('buchungskonten','name',' ',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('buchungskonten','aktiv','DE','Aktiv','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('buchungskonten','konto','DE','Konto','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('buchungskonten','name','DE','Bezeichnung','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('buchungskonten','agenda_bezeichnung','DE','agenda_bezeichnung','textfield','Allgemein',999,0,1,1,'',1.00,''),
('buchungskonten','agenda_hauptfunktion','DE','agenda_hauptfunktion','textfield','Allgemein',999,0,1,1,'',1.00,''),
('buchungskonten','agenda_kontoart','DE','agenda_kontoart','textfield','Allgemein',999,0,1,1,'',1.00,''),
('buchungskonten','agenda_langbezeichnung','DE','agenda_langbezeichnung','textfield','Allgemein',999,0,1,1,'',1.00,''),
('buchungskonten','agenda_nebenfunktion','DE','agenda_nebenfunktion','textfield','Allgemein',999,0,1,1,'',1.00,''),
('buchungskonten','agenda_sammelkonto','DE','agenda_sammelkonto','textfield','Allgemein',999,0,1,1,'',1.00,''),
('buchungskonten','agenda_steuersatz','DE','agenda_steuersatz','textfield','Allgemein',999,0,1,1,'',1.00,''),
('buchungskonten','agenda_steuerschluessel','DE','agenda_steuerschluessel','textfield','Allgemein',999,0,1,1,'',1.00,''),
('buchungskonten','aktiv','DE','Aktiv','combobox_ja_nein_name','Allgemein',999,0,1,1,'',1.00,''),
('buchungskonten','konto','DE','Konto','textfield','Allgemein',0,0,1,1,'',1.00,''),
('buchungskonten','kostenstelle','DE','kostenstelle','displayfield','Allgemein',999,0,1,1,'',1.00,''),
('buchungskonten','name','DE','Bezeichnung','textfield','Allgemein',999,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('buchungskonten','konto','konto','konto',''),
('buchungskonten','kontobezeichnung','konto','bezeichnung','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','buchungskonten',1,1,1,1,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('warenhauptgruppen','Warenhauptgruppen','',0,'name','name','name',1,'','','','',0,'cellmodel','',0,'','','','ERP','',1,'','','listview','XlsxWriter','{GUID}',0,100,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('warenhauptgruppen','id','{#serial}',10000000,1,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('warenhauptgruppen','name','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','UNI','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('warenhauptgruppen','id','DE','ID','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('warenhauptgruppen','name','DE','Name','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('warenhauptgruppen','id','DE','ID','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('warenhauptgruppen','name','DE','Name','textfield','Allgemein',999,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('warenhauptgruppen','id','id','name','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','warenhauptgruppen',0,1,1,1,1);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('warengruppen','Warengruppen','wgsort',0,'warengruppe','warengruppe','wgsort',1,'','','','',0,'cellmodel','',0,'','','','ERP','',1,'','','listview','XlsxWriter','Warengruppen-{DATETIME}',0,1000,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('warengruppen','beleggruppierung','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','bestandsflag','0',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('warengruppen','detailgruppe','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','farbe','rgb(200,200,210)',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','ia_kennung',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','char','','char(2)',2,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','id','{#serial}',10000000,0,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('warengruppen','inventur','',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('warengruppen','leerzeile','0',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('warengruppen','provision','Nein',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(4)',4,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','skonto','Nein',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(4)',4,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','sperre','Nein',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(4)',4,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','status','Ja',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(4)',4,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','suffix','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(4)',4,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','touch','Nein',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(4)',4,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','warengruppe','',10000000,0,'',0,0,'','','NO','NO',1,'','varchar','UNI','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('warengruppen','warenhauptgruppe','1',10000000,0,'',0,0,'','','YES','NO',1,'','int','MUL','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('warengruppen','wgsort','99',10000000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('warengruppen','beleggruppierung','DE','Beleggruppierung','gridcolumn','',13,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','bestandsflag','DE','bestandsflag','gridcolumn','',7,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','detailgruppe','DE','detailgruppe','gridcolumn','',15,'','','',1,0,'',0,1.00,'ASC','left','',NULL),
('warengruppen','farbe','DE','Farbe','rgbcolorcolumn','',5,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','ia_kennung','DE','IA - Kennung','gridcolumn','',14,'','','',1,0,'',0,1.00,'ASC','left','',NULL),
('warengruppen','id','DE','ID','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','inventur','DE','inventur','gridcolumn','',16,'','','',1,0,'',0,1.00,'ASC','left','',NULL),
('warengruppen','leerzeile','DE','leerzeile','gridcolumn','',6,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','provision','DE','provision','gridcolumn','',11,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','skonto','DE','skonto','gridcolumn','',10,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','sperre','DE','Sperre','gridcolumn','',9,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','status','DE','Aktiv','gridcolumn','',4,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','suffix','DE','suffix','gridcolumn','',8,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','touch','DE','touch','gridcolumn','',12,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','warengruppe','DE','Warengruppe','gridcolumn','',2,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','warenhauptgruppe','DE','Warenhauptgruppe','column_warenhauptgruppen_id','',3,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('warengruppen','wgsort','DE','Position','tualocolumnnumber0','',1,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('warengruppen','beleggruppierung','DE','Beleggruppierung','displayfield','Allgemein',14,1,0,0,'',1.00,''),
('warengruppen','bestandsflag','DE','bestandsflag','displayfield','Allgemein',8,1,0,0,'',1.00,''),
('warengruppen','detailgruppe','DE','detailgruppe','displayfield','Allgemein',15,1,0,0,'',1.00,''),
('warengruppen','farbe','DE','Farbe','tualocolors','Allgemein',5,1,1,1,'',1.00,''),
('warengruppen','ia_kennung','DE','IA - Kennung','textfield','Allgemein',6,1,0,0,'',1.00,''),
('warengruppen','id','DE','ID','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('warengruppen','inventur','DE','inventur','displayfield','Allgemein',16,1,0,0,'',1.00,''),
('warengruppen','leerzeile','DE','leerzeile','displayfield','Allgemein',7,1,0,0,'',1.00,''),
('warengruppen','provision','DE','provision','displayfield','Allgemein',12,1,0,0,'',1.00,''),
('warengruppen','skonto','DE','skonto','displayfield','Allgemein',11,1,0,0,'',1.00,''),
('warengruppen','sperre','DE','Sperre','displayfield','Allgemein',10,1,0,0,'',1.00,''),
('warengruppen','status','DE','Aktiv','combobox_ja_nein_name','Allgemein',4,1,1,1,'',1.00,''),
('warengruppen','suffix','DE','suffix','displayfield','Allgemein',9,1,0,0,'',1.00,''),
('warengruppen','touch','DE','touch','displayfield','Allgemein',13,1,0,0,'',1.00,''),
('warengruppen','warengruppe','DE','Warengruppe','textfield','Allgemein',2,0,1,1,'',1.00,''),
('warengruppen','warenhauptgruppe','DE','Warenhauptgruppe','combobox_warenhauptgruppen_id','Allgemein',3,1,1,1,'',1.00,''),
('warengruppen','wgsort','DE','Position','displayfield','Allgemein',1,1,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('warengruppen','warengruppe','warengruppe','warengruppe','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,1,99999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warengruppen__warenhauptgruppe\":\"warenhauptgruppen__id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warenhauptgruppe\":\"id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warenhauptgruppe\":\"id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warenhauptgruppe\":\"id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warenhauptgruppe\":\"id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',0,''),
('warengruppen','warenhauptgruppen','{\"warenhauptgruppe\":\"id\"}','fk_waregruppen_warenhauptgruppe',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','warengruppen',0,0,0,0,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('bfkonten','Kontenmatrix','',0,'name','name','',1,'','','','',0,'cellmodel','',0,'','','','Belegarten','',1,'','','listview','XlsxWriter','{GUID}',0,100,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('bfkonten','gueltig','2099-12-31',10000000,0,'',1,0,'','','NO','NO',1,'','date','PRI','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'NULL',''),
('bfkonten','gueltig_von','2020-01-01',10000000,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'NULL',''),
('bfkonten','id','{#serial}',999,100,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','konto','8400',0,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','konto_1','8400',0,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','konto_10','8400',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','konto_2','8400',0,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','konto_3','8400',0,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','konto_4','8400',0,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','konto_5','8400',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','konto_6','8400',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','konto_7','8400',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','konto_8','8400',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','konto_9','8400',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'NULL',''),
('bfkonten','name','',0,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel_1','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel_10','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel_2','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel_3','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel_4','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel_5','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel_6','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel_7','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel_8','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','sap_schluessel_9','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer','0',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuersatz',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer_1','0',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer_10','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer_2','0',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer_3','0',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer_4','0',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer_5','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer_6','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer_7','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer_8','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten','steuer_9','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,2)',NULL,15,2,NULL,'select,insert,update,references',1,0,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('bfkonten','gueltig','DE','gültig bis','datecolumn','',1,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten','gueltig_von','DE','gültig von','datecolumn','',0,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten','id','DE','ID','gridcolumn','',2,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto','DE','Konto (normalbesteuert)','column_buchungskonten_konto','combobox_buchungskonten_konto',4,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto_1','DE','Konto (steuerfrei)','column_buchungskonten_konto','combobox_buchungskonten_konto',7,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto_10','DE','Konto (PRAP)','column_buchungskonten_konto','combobox_buchungskonten_konto',28,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto_2','DE','Konto (organschaft)','column_buchungskonten_konto','combobox_buchungskonten_konto',31,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto_3','DE','Konto (kreditoren)','column_buchungskonten_konto','combobox_buchungskonten_konto',22,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto_4','DE','Konto (steuerbefreit)','column_buchungskonten_konto','combobox_buchungskonten_konto',13,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto_5','DE','Konto (verbrauch)','column_buchungskonten_konto','combobox_buchungskonten_konto',16,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto_6','DE','Konto (verbrauch_steuerfrei)','column_buchungskonten_konto','combobox_buchungskonten_konto',19,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto_7','DE','Konto (WE-Verrechnung)','column_buchungskonten_konto','combobox_buchungskonten_konto',25,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto_8','DE','Konto (systemticketprovisio)','column_buchungskonten_konto','combobox_buchungskonten_konto',34,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','konto_9','DE','Konto (steuerfrei non-eu)','column_buchungskonten_konto','combobox_buchungskonten_konto',10,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten','name','DE','Bezeichnung','gridcolumn','',3,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel','DE','SAP (normalbesteuert)','gridcolumn','textfield',6,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel_1','DE','SAP (steuerfrei)','gridcolumn','textfield',9,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel_10','DE','SAP (PRAP)','gridcolumn','textfield',30,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel_2','DE','SAP (organschaft)','gridcolumn','textfield',33,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel_3','DE','SAP (kreditoren)','gridcolumn','textfield',24,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel_4','DE','SAP (steuerbefreit)','gridcolumn','textfield',15,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel_5','DE','SAP (verbrauch)','gridcolumn','textfield',18,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel_6','DE','SAP (verbrauch_steuerfrei)','gridcolumn','textfield',21,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel_7','DE','SAP (WE-Verrechnung)','gridcolumn','textfield',27,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel_8','DE','SAP (systemticketprovisio)','gridcolumn','textfield',36,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','sap_schluessel_9','DE','SAP (steuerfrei non-eu)','gridcolumn','textfield',12,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer','DE','Steuer (normalbesteuert)','tualocolumnnumber2','number2',5,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer_1','DE','Steuer (steuerfrei)','tualocolumnnumber2','number2',8,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer_10','DE','Steuer (PRAP)','tualocolumnnumber2','number2',29,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer_2','DE','Steuer (organschaft)','tualocolumnnumber2','number2',32,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer_3','DE','Steuer (kreditoren)','tualocolumnnumber2','number2',23,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer_4','DE','Steuer (steuerbefreit)','tualocolumnnumber2','number2',14,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer_5','DE','Steuer (verbrauch)','tualocolumnnumber2','number2',17,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer_6','DE','Steuer (verbrauch_steuerfrei)','tualocolumnnumber2','number2',20,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer_7','DE','Steuer (WE-Verrechnung)','tualocolumnnumber2','number2',26,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer_8','DE','Steuer (systemticketprovisio)','tualocolumnnumber2','number2',35,'','','',1,1,'',0,1.00,'','','','NULL'),
('bfkonten','steuer_9','DE','Steuer (steuerfrei non-eu)','tualocolumnnumber2','number2',11,'','','',0,1,'',0,1.00,'','','','NULL');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('bfkonten','gueltig','DE','gueltig','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('bfkonten','id','DE','ID','displayfield','Allgemein/Satz',0,0,1,1,'',1.00,''),
('bfkonten','konto','DE','Konto','combobox_buchungskonten_konto','Allgemein/1 normalbesteuert',5,0,1,1,'',1.00,''),
('bfkonten','konto_1','DE','Konto','combobox_buchungskonten_konto','Allgemein/2 EU - St.frei',9,0,1,1,'',1.00,''),
('bfkonten','konto_2','DE','Konto','combobox_buchungskonten_konto','Allgemein/3 STL. Organschaft',7,0,1,1,'',1.00,''),
('bfkonten','konto_3','DE','Konto','combobox_buchungskonten_konto','Allgemein/Kreditoren',3,0,1,1,'',1.00,''),
('bfkonten','konto_4','DE','konto_4','displayfield','Allgemein',11,1,0,1,'',1.00,''),
('bfkonten','name','DE','Bezeichnung','textfield','Allgemein/Satz',2,0,1,1,'',1.00,''),
('bfkonten','steuer','DE','Steuersatz','numberfield','Allgemein/1 normalbesteuert',6,0,1,1,'',1.00,''),
('bfkonten','steuer_1','DE','Steuersatz','numberfield','Allgemein/2 EU - St.frei',10,0,1,1,'',1.00,''),
('bfkonten','steuer_2','DE','Steuersatz','numberfield','Allgemein/3 STL. Organschaft',8,0,1,1,'',1.00,''),
('bfkonten','steuer_3','DE','Steuersatz','numberfield','Allgemein/Kreditoren',4,0,1,1,'',1.00,''),
('bfkonten','steuer_4','DE','steuer_4','displayfield','Allgemein',12,1,0,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('bfkonten','ID','id','name','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,1,99999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto\":\"buchungskonten__konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_1\":\"buchungskonten__konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_10\":\"buchungskonten__konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_2\":\"buchungskonten__konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_3\":\"buchungskonten__konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_4\":\"buchungskonten__konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_5\":\"buchungskonten__konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_6\":\"buchungskonten__konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_7\":\"buchungskonten__konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_8\":\"buchungskonten__konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"bfkonten__konto_9\":\"buchungskonten__konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto\":\"konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_1\":\"konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_10\":\"konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_2\":\"konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_3\":\"konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_4\":\"konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_5\":\"konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_6\":\"konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_7\":\"konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_8\":\"konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_9\":\"konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto\":\"konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_1\":\"konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_10\":\"konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_2\":\"konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_3\":\"konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_4\":\"konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_5\":\"konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_6\":\"konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_7\":\"konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_8\":\"konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_9\":\"konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto\":\"konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_1\":\"konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_10\":\"konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_2\":\"konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_3\":\"konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_4\":\"konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_5\":\"konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_6\":\"konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_7\":\"konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_8\":\"konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_9\":\"konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto\":\"konto\"}','fk_bfkonten_konto',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_1\":\"konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_10\":\"konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_2\":\"konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_3\":\"konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_4\":\"konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_5\":\"konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_6\":\"konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_7\":\"konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_8\":\"konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto_9\":\"konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',0,''),
('bfkonten','buchungskonten','{\"konto\":\"konto\"}','fk_bfkonten_konto',0,0,0,999,'',1,''),
('bfkonten','buchungskonten','{\"konto_1\":\"konto\"}','fk_bfkonten_konto_1',0,0,0,999,'',1,''),
('bfkonten','buchungskonten','{\"konto_10\":\"konto\"}','fk_bfkonten_konto_10',0,0,0,999,'',1,''),
('bfkonten','buchungskonten','{\"konto_2\":\"konto\"}','fk_bfkonten_konto_2',0,0,0,999,'',1,''),
('bfkonten','buchungskonten','{\"konto_3\":\"konto\"}','fk_bfkonten_konto_3',0,0,0,999,'',1,''),
('bfkonten','buchungskonten','{\"konto_4\":\"konto\"}','fk_bfkonten_konto_4',0,0,0,999,'',1,''),
('bfkonten','buchungskonten','{\"konto_5\":\"konto\"}','fk_bfkonten_konto_5',0,0,0,999,'',1,''),
('bfkonten','buchungskonten','{\"konto_6\":\"konto\"}','fk_bfkonten_konto_6',0,0,0,999,'',1,''),
('bfkonten','buchungskonten','{\"konto_7\":\"konto\"}','fk_bfkonten_konto_7',0,0,0,999,'',1,''),
('bfkonten','buchungskonten','{\"konto_8\":\"konto\"}','fk_bfkonten_konto_8',0,0,0,999,'',1,''),
('bfkonten','buchungskonten','{\"konto_9\":\"konto\"}','fk_bfkonten_konto_9',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','bfkonten',1,1,1,1,1);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('artikelgruppen','Artikel','',0,'gruppe','gruppe','gruppe',1,'','','','',0,'tualomultirowmodel','',0,'','','','ERP','',1,'','','listview','XlsxWriter','Artikelgruppe-{DATETIME}',0,10000,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('artikelgruppen','artikelnummer','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','averkaufszeitraum_bis','2099-12-31',10000000,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','averkaufszeitraum_von','2000-01-01',10000000,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','bemerkung','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(4000)',4000,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','bestandsartikel','0',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','einheit','STK',10000000,0,'',0,0,'','','YES','NO',1,'','int','MUL','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','gebinde','0',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','gruppe','',10000000,0,'',0,0,'','','NO','NO',1,'','varchar','UNI','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','gruppen_id','{#serial}',10000000,1,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','ingebrauch','0',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','innenauftrag_suffix',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(4)',4,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','insert_date','{DATE}',10000000,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','kommission','0',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','konto_id','',10000000,0,'',1,0,'','','YES','NO',1,'','int','MUL','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','kostenstelle','0',10000000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','kundennummer','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','kurztext','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(30)',30,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','login','{:getSessionUser()}',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','max_anzahl','999999',10000000,0,'',0,0,'','','YES','NO',1,'','int','MUL','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','max_height','999999',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','max_length','9999',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','max_thickness','99999',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','max_weight','9999',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','mdeartikel','0',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','mde_sortierung','0',10000000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','offenerposten','0',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','MUL','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','plugin','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','prio','0',10000000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','sartikelnummer','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','status','1',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','MUL','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','system','0',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','verkaufszeitraum_bis','2099-12-31',10000000,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','verkaufszeitraum_von','2000-01-01',10000000,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,NULL,''),
('artikelgruppen','warengruppe','Standard',10000000,0,'',0,0,'','','NO','NO',1,'','varchar','MUL','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','zielregion',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('artikelgruppen','zusatztext','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(4000)',4000,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('artikelgruppen','artikelnummer','DE','Artikelnummer','gridcolumn','',3,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','averkaufszeitraum_bis','DE','Verkaufszeitraum bis','gridcolumn','',26,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','averkaufszeitraum_von','DE','Verkaufszeitraum von','gridcolumn','',25,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','bemerkung','DE','Bemerkung','gridcolumn','',14,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','bestandsartikel','DE','Bestandsartikel','gridcolumn','',5,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','einheit','DE','Einheit','gridcolumn','',12,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','gebinde','DE','Gebinde','gridcolumn','',8,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','gruppe','DE','Name','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','gruppen_id','DE','ID','gridcolumn','',27,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','ingebrauch','DE','in Gebrauch','gridcolumn','',30,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','insert_date','DE','Anlage','gridcolumn','',29,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','kommission','DE','Kommission','gridcolumn','',6,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','konto_id','DE','Kontengruppe','column_bfkonten_id','',0,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','kostenstelle','DE','Lieferant-KST','gridcolumn','',16,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','kundennummer','DE','Lieferant','gridcolumn','',15,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','kurztext','DE','Kurztext','gridcolumn','',1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','login','DE','Login','gridcolumn','',28,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','max_anzahl','DE','max. erlaubte Menge','gridcolumn','',11,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','max_height','DE','max. Höhe (mm)','tualocolumnnumber0','number0',17,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','max_length','DE','max. Länge (mm)','tualocolumnnumber0','number0',18,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','max_thickness','DE','Stärke (mm)','tualocolumnnumber0','number0',20,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','max_weight','DE','max. Gewicht (g)','tualocolumnnumber0','number0',19,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','mdeartikel','DE','in MDE verwenden','checkcolumn','',22,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','mde_sortierung','DE','Sortierung (MDE)','gridcolumn','',21,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','offenerposten','DE','offener Posten','gridcolumn','',7,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','plugin','DE','Plugin','gridcolumn','',2,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','prio','DE','Prio','gridcolumn','',31,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','status','DE','Aktiv','checkcolumn','',4,'','','',0,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','system','DE','Systemartikel','gridcolumn','',9,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','verkaufszeitraum_bis','DE','Verkaufszeitraum bis','gridcolumn','',24,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','verkaufszeitraum_von','DE','Verkaufszeitraum von','gridcolumn','',23,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('artikelgruppen','warengruppe','DE','Warengruppe','gridcolumn','',10,'','','',1,1,'',0,1.00,'','','','NULL'),
('artikelgruppen','zusatztext','DE','Zusatztext','gridcolumn','',13,'','','',1,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('artikelgruppen','artikelnummer','DE','Artikelnummer','textfield','Allgemein/Angaben',4,1,1,1,'',1.00,''),
('artikelgruppen','averkaufszeitraum_bis','DE','Verkaufszeitraum bis','datefield','Allgemein/Admin-Zeitraum',28,1,1,1,'',1.00,''),
('artikelgruppen','averkaufszeitraum_von','DE','Verkaufszeitraum von','datefield','Allgemein/Admin-Zeitraum',27,1,1,1,'',1.00,''),
('artikelgruppen','bemerkung','DE','Bemerkung','textarea','Allgemein/Optionen',16,1,1,1,'',1.00,''),
('artikelgruppen','bestandsartikel','DE','Bestandsartikel','checkbox','Allgemein/Optionen',8,1,1,1,'',1.00,''),
('artikelgruppen','einheit','DE','Einheit','combobox_mengeneinheiten_name','Allgemein/Angaben',7,0,1,1,'',1.00,''),
('artikelgruppen','gebinde','DE','Gebinde','checkbox','Allgemein/Optionen',11,1,1,1,'',1.00,''),
('artikelgruppen','gruppe','DE','Name','textfield','Allgemein/Angaben',0,0,1,1,'',1.00,''),
('artikelgruppen','gruppen_id','DE','ID','displayfield','Allgemein/Satzinformationen',29,0,1,1,'',1.00,''),
('artikelgruppen','ingebrauch','DE','in Gebrauch','displayfield','Allgemein/Satzinformationen',32,0,1,1,'',1.00,''),
('artikelgruppen','innenauftrag_suffix','DE','innenauftrag_suffix','displayfield','Allgemein',34,1,0,0,'',1.00,''),
('artikelgruppen','insert_date','DE','Anlage','tualodatedisplayfield','Allgemein/Satzinformationen',31,0,1,1,'',1.00,''),
('artikelgruppen','kommission','DE','Kommission','checkbox','Allgemein/Optionen',9,1,1,1,'',1.00,''),
('artikelgruppen','konto_id','DE','Kontengruppe','combobox_bfkonten_id','Allgemein/Angaben',1,0,1,0,'',1.00,'\'\''),
('artikelgruppen','kostenstelle','DE','Lieferant-KST','displayfield','Allgemein/Lieferant',18,1,1,1,'',1.00,''),
('artikelgruppen','kundennummer','DE','Lieferant','combobox_kadressen_name','Allgemein/Lieferant',17,1,1,1,'',1.00,''),
('artikelgruppen','kurztext','DE','Kurztext','textfield','Allgemein/Angaben',2,1,1,1,'',1.00,''),
('artikelgruppen','login','DE','Login','displayfield','Allgemein/Satzinformationen',30,0,1,1,'',1.00,''),
('artikelgruppen','max_anzahl','DE','max. erlaubte Menge','number0','Allgemein/Optionen',13,1,1,1,'',1.00,''),
('artikelgruppen','max_height','DE','max. Höhe (mm)','number0','Allgemein/Klassifikation',19,1,1,1,'',1.00,''),
('artikelgruppen','max_length','DE','max. Länge (mm)','number0','Allgemein/Klassifikation',20,1,1,1,'',1.00,''),
('artikelgruppen','max_thickness','DE','Stärke (mm)','number0','Allgemein/Klassifikation',22,1,1,1,'',1.00,''),
('artikelgruppen','max_weight','DE','max. Gewicht (g)','number0','Allgemein/Klassifikation',21,1,1,1,'',1.00,''),
('artikelgruppen','mdeartikel','DE','in MDE verwenden','checkbox','Allgemein/MDE',24,1,1,0,'',1.00,''),
('artikelgruppen','mde_sortierung','DE','Sortierung (MDE)','displayfield','Allgemein/MDE',23,1,1,1,'',1.00,''),
('artikelgruppen','offenerposten','DE','offener Posten','checkbox','Allgemein/Optionen',10,1,1,1,'',1.00,''),
('artikelgruppen','plugin','DE','Plugin','textfield','Allgemein/Angaben',3,1,1,1,'',1.00,''),
('artikelgruppen','prio','DE','Prio','displayfield','Allgemein/Satzinformationen',33,1,1,1,'',1.00,''),
('artikelgruppen','sartikelnummer','DE','sartikelnummer','displayfield','Allgemein',35,1,0,0,'',1.00,''),
('artikelgruppen','status','DE','Aktiv','checkbox','Allgemein/Angaben',5,0,1,1,'',1.00,''),
('artikelgruppen','system','DE','Systemartikel','checkbox','Allgemein/Optionen',12,1,1,1,'',1.00,''),
('artikelgruppen','verkaufszeitraum_bis','DE','Verkaufszeitraum bis','datefield','Allgemein/Zeitraum',26,1,1,1,'',1.00,''),
('artikelgruppen','verkaufszeitraum_von','DE','Verkaufszeitraum von','datefield','Allgemein/Zeitraum',25,1,1,1,'',1.00,''),
('artikelgruppen','warengruppe','DE','Warengruppe','combobox_warengruppen_warengruppe','Allgemein/Angaben',6,0,1,1,'',1.00,''),
('artikelgruppen','zielregion','DE','Zielregion','combobox_zielregionen_zielregion','Allgemein/Klassifikation',14,1,1,1,'',1.00,''),
('artikelgruppen','zusatztext','DE','Zusatztext','textarea','Allgemein/Optionen',15,1,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('artikelgruppen','gruppe','gruppe','gruppe','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,1,99999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__name\"}','fk_artikelgruppen_einheit',0,0,1,99999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',1,0,1,99999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"artikelgruppen__einheit\":\"mengeneinheiten__id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"artikelgruppen__konto_id\":\"bfkonten__id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"artikelgruppen__warengruppe\":\"warengruppen__warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"einheit\":\"id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"konto_id\":\"id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"warengruppe\":\"warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"einheit\":\"id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"konto_id\":\"id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"warengruppe\":\"warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"einheit\":\"id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"konto_id\":\"id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"warengruppe\":\"warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"einheit\":\"id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',0,''),
('artikelgruppen','bfkonten','{\"konto_id\":\"id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('artikelgruppen','warengruppen','{\"warengruppe\":\"warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',0,''),
('artikelgruppen','mengeneinheiten','{\"einheit\":\"id\"}','fk_artikelgruppen_einheit',0,0,0,999,'',1,''),
('artikelgruppen','bfkonten','{\"konto_id\":\"id\"}','fk_artikelgruppen_konto_id',0,0,0,999,'',1,''),
('artikelgruppen','warengruppen','{\"warengruppe\":\"warengruppe\"}','fk_artikelgruppen_warengruppe',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','artikelgruppen',0,0,0,0,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('bfkonten_zuordnung','Kontenzuweisung','',0,'gruppe','gruppe','gruppe',1,'','','','',0,'tualomultirowmodel','',0,'','','','ERP','',1,'','','listview','XlsxWriter','{GUID}',0,10000,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('bfkonten_zuordnung','gruppe','',10000000,0,'',1,0,'','','NO','NO',1,'','varchar','PRI','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('bfkonten_zuordnung','gueltig','2099-12-31',10000000,0,'',1,0,'','','NO','NO',1,'','date','PRI','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,NULL,''),
('bfkonten_zuordnung','konto_id','',10000000,0,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('bfkonten_zuordnung','gruppe','DE','Artikel','column_artikelgruppen_gruppe','',0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('bfkonten_zuordnung','gueltig','DE','gültig bis','tualodedatedisplaycolumn','',0,'','','',0,1,'',0,1.00,'','','','NULL'),
('bfkonten_zuordnung','konto_id','DE','Kontengruppe','column_bfkonten_id','',0,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('bfkonten_zuordnung','gruppe','DE','Artikel','combobox_artikelgruppen_gruppe','Allgemein',0,0,1,1,'',1.00,''),
('bfkonten_zuordnung','gueltig','DE','gültig bis','tualodatedisplayfield','Allgemein',0,0,1,1,'',1.00,''),
('bfkonten_zuordnung','konto_id','DE','Kontengruppe','combobox_bfkonten_id','Allgemein',0,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,1,99999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"bfkonten_zuordnung__gruppe\":\"artikelgruppen__gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"gruppe\":\"gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"gruppe\":\"gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"gruppe\":\"gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"gruppe\":\"gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',0,''),
('bfkonten_zuordnung','artikelgruppen','{\"gruppe\":\"gruppe\"}','fk_bfkonten_zuordnung_artikelgruppen_gruppe',0,0,0,999,'',1,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\",\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,1,99999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\",\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"bfkonten_zuordnung__gueltig\":\"bfkonten__gueltig\",\"bfkonten_zuordnung__konto_id\":\"bfkonten__id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"gueltig\":\"gueltig\",\"konto_id\":\"id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"gueltig\":\"gueltig\",\"konto_id\":\"id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"gueltig\":\"gueltig\",\"konto_id\":\"id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"gueltig\":\"gueltig\",\"konto_id\":\"id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',0,''),
('bfkonten_zuordnung','bfkonten','{\"gueltig\":\"gueltig\",\"konto_id\":\"id\"}','fk_bfkonten_zuordnung_artikelgruppen_konto_id',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','bfkonten_zuordnung',1,1,1,1,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('staffeln','Preise','',0,'gruppe','gruppe','preis',1,'','','','',0,'cellmodel','',0,'','','','ERP','',1,'latin1','','listview','XlsxWriter','Preise-{DATETIME}',0,100,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('staffeln','bis','100000',10000000,0,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('staffeln','bruttopreis','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,'NULL',''),
('staffeln','epreis','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,'NULL',''),
('staffeln','gebiet','.',10000000,0,'',1,0,'','','YES','NO',1,'','varchar','','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('staffeln','gld','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,'NULL',''),
('staffeln','gruppe','',10000000,0,'',1,0,'','','NO','NO',1,'','varchar','PRI','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('staffeln','json_formel','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(4000)',4000,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('staffeln','mpreis','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,'NULL',''),
('staffeln','preis','0',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,'NULL',''),
('staffeln','preiskategorie','1',10000000,0,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'NULL',''),
('staffeln','von','-100000',10000000,0,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('staffeln','zeitraum_bis','2099-12-31',10000000,0,'',1,0,'','','NO','NO',1,'','date','PRI','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'NULL',''),
('staffeln','zeitraum_von','2020-01-01',10000000,0,'',1,0,'','','NO','NO',1,'','date','PRI','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'NULL','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('staffeln','bis','DE','Bis','numbercolumn','',4,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('staffeln','bruttopreis','DE','Preis (brutto)','moneycolumn5','numberfield',6,'','','',1,1,'',0,1.00,'','','','NULL'),
('staffeln','epreis','DE','Einkaufspreis','coloredmoneycolumn2','',8,'','','',1,1,'',0,1.00,'','','',NULL),
('staffeln','gebiet','DE','gebiet','gridcolumn','',0,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('staffeln','gld','DE','gld','gridcolumn','',11,'','','',1,0,'',0,1.00,'','','',NULL),
('staffeln','gruppe','DE','Artikel','gridcolumn','',1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('staffeln','json_formel','DE','Formel','gridcolumn','',7,'','','',1,1,'',0,1.00,'','','','NULL'),
('staffeln','mpreis','DE','mpreis','gridcolumn','',12,'','','',1,0,'',0,1.00,'','','',NULL),
('staffeln','preis','DE','Preis','moneycolumn5','',5,'','','',0,1,'',0,1.00,'','','',NULL),
('staffeln','preiskategorie','DE','Kategorie','column_preiskategorien_id','',2,'','','',1,1,'',0,1.00,'','','','NULL'),
('staffeln','von','DE','Von','numbercolumn','',3,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('staffeln','zeitraum_bis','DE','Zeitraum bis','datecolumn','',10,'','','',1,1,'',0,1.00,'','','','NULL'),
('staffeln','zeitraum_von','DE','Zeitraum von','datecolumn','',9,'','','',1,1,'',0,1.00,'','','','NULL');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('staffeln','bis','DE','Bis','numberfield','Allgemein',6,1,1,0,'',1.00,''),
('staffeln','bruttopreis','DE','Bruttopreis','numberfield','Allgemein/Angaben',8,1,1,1,'',1.00,''),
('staffeln','epreis','DE','Einkaufspreis','number5','Allgemein/Angaben',9,1,1,1,'',1.00,''),
('staffeln','gebiet','DE','Gebiet','textfield','Allgemein',10,1,1,0,'',1.00,''),
('staffeln','gld','DE','gld','displayfield','Allgemein',12,1,0,0,'',1.00,''),
('staffeln','gruppe','DE','Gruppe','displayfield','Allgemein/Angaben',0,0,1,0,'',1.00,''),
('staffeln','json_formel','DE','Formel','tualojsonformel','Allgemein',7,1,1,1,'',1.00,''),
('staffeln','mpreis','DE','mpreis','displayfield','Allgemein',11,1,0,0,'',1.00,''),
('staffeln','preis','DE','Preis','number5','Allgemein/Angaben',1,0,1,0,'',1.00,''),
('staffeln','preiskategorie','DE','Preiskategorie','combobox_preiskategorien_id','Allgemein',4,1,1,0,'',1.00,''),
('staffeln','von','DE','Von','numberfield','Allgemein',5,1,1,0,'',1.00,''),
('staffeln','zeitraum_bis','DE','Zeitraum bis','datefield','Allgemein',3,1,1,0,'',1.00,''),
('staffeln','zeitraum_von','DE','Zeitraum von','datefield','Allgemein',2,1,1,0,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',1,0,1,99999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"staffeln__gruppe\":\"artikelgruppen__gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"gruppe\":\"gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"gruppe\":\"gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"gruppe\":\"gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"gruppe\":\"gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',0,''),
('staffeln','artikelgruppen','{\"gruppe\":\"gruppe\"}','fk_staffeln_gruppe',0,0,0,999,'',1,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,1,99999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"staffeln__preiskategorie\":\"preiskategorien__id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"preiskategorie\":\"id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"preiskategorie\":\"id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"preiskategorie\":\"id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"preiskategorie\":\"id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',0,''),
('staffeln','preiskategorien','{\"preiskategorie\":\"id\"}','fk_staffeln_preiskategorie',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','staffeln',0,0,0,0,0);
UNLOCK TABLES;
