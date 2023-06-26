LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`) VALUES ('view_editor_blg_pos_#####','Belegeditor-Positionen','pos',0,'artikel','artikel','pos',1,'','','','',0,'cellmodel','',0,'','','','Belegarten','',1,'','','listview','XlsxWriter','{GUID}',0,100,NULL,'Tualo.DataSets.ListView',1);
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`) VALUES ('view_editor_blg_pos_#####','anzahl',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','decimal','','decimal(15,5)',NULL,15,5,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','artikel',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','beleg',NULL,10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','bemerkung',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(4000)',4000,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','bereich',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','bezugsnebenkosten',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','brutto',NULL,10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','einheit',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','einheit_#####ktor',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','einheit_symbol',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','einspeiserkennzeichen',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','ekpreis',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','ekpreis_summe',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','epreis',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','fremdbezeichnung',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','gewicht',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','gldpreis',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','gldpreis_summe',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','handwerkeranteil',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','id',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','kombiartikel',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','tinyint','','int(4)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','konto',NULL,10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','netto',NULL,10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','pos',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','preistyp',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','tinyint','','int(4)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','referenz',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','steuer',NULL,10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','steuersatz',NULL,10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','vdatum',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(10)',10,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','zid',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','zusatztext',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(4000)',4000,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL),
('view_editor_blg_pos_#####','zzusatz',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('view_editor_blg_pos_#####','anzahl','DE','Anzahl','numbercolumn','numberfield',1,'','','',0,1,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','artikel','DE','Artikel/Leistung','column_view_editor_artikelgruppen_gruppe','dsform_view_editor_artikelgruppen',0,'','','',0,1,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','beleg','DE','beleg','gridcolumn','',8,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','bemerkung','DE','Bemerkung','gridcolumn','textarea',2,'','','',0,1,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','bereich','DE','bereich','gridcolumn','',9,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','bezugsnebenkosten','DE','bezugsnebenkosten','gridcolumn','',10,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','brutto','DE','Brutto','numbercolumn','numberfield',7,'','','',0,1,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','einheit','DE','einheit','gridcolumn','',11,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','einheit_#####ktor','DE','einheit_#####ktor','gridcolumn','',12,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','einheit_symbol','DE','einheit_symbol','gridcolumn','',13,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','einspeiserkennzeichen','DE','einspeiserkennzeichen','gridcolumn','',14,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','ekpreis','DE','ekpreis','gridcolumn','',15,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','ekpreis_summe','DE','ekpreis_summe','gridcolumn','',16,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','epreis','DE','E-Preis','numbercolumn','numberfield',3,'','','',0,1,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','fremdbezeichnung','DE','fremdbezeichnung','gridcolumn','',17,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','gewicht','DE','gewicht','gridcolumn','',18,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','gldpreis','DE','gldpreis','gridcolumn','',19,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','gldpreis_summe','DE','gldpreis_summe','gridcolumn','',20,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','handwerkeranteil','DE','handwerkeranteil','gridcolumn','',21,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','id','DE','id','gridcolumn','',22,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','kombiartikel','DE','kombiartikel','gridcolumn','',23,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','konto','DE','konto','gridcolumn','',24,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','netto','DE','Netto','numbercolumn','numberfield',4,'','','',0,1,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','pos','DE','pos','gridcolumn','',25,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','preistyp','DE','preistyp','gridcolumn','',26,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','referenz','DE','referenz','gridcolumn','',27,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','steuer','DE','Steuer','numbercolumn','numberfield',5,'','','',0,1,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','steuersatz','DE','Steuersatz','numbercolumn','numberfield',6,'','','',0,1,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','vdatum','DE','vdatum','gridcolumn','',28,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','zid','DE','zid','gridcolumn','',29,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','zusatztext','DE','zusatztext','gridcolumn','',30,'','','',1,0,'',0,1.00,'','','',''),
('view_editor_blg_pos_#####','zzusatz','DE','zzusatz','gridcolumn','',31,'','','',1,0,'',0,1.00,'','','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','view_editor_blg_pos_#####',1,0,0,0,0);
UNLOCK TABLES;
