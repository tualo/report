DELIMITER ;

LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('view_editor_blg_pos_#####','Belegeditor (Positionen)','pos',0,'beleg','artikel','pos',0,'','','','',0,'cellmodel','',0,'','','','Belegarten','',1,'','','','','',0,10000,NULL,'Tualo.DataSets.ListViewAutoNew',0,'Tualo.report.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('view_editor_blg_pos_#####','account','',0,0,'',0,0,'','','NO','',0,'','int','','int(11)',0,10,0,'','select,insert,update,references',0,0,'','tualoreportaccount'),
('view_editor_blg_pos_#####','additionaltext',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(4000)',4000,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','amount',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','anzahl',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','article',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','artikel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','beleg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO','NO',1,NULL,'bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','bemerkung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'varchar','','varchar(4000)',4000,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','bereich',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'varchar','','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','bezugsnebenkosten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','brutto',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','einheit','Stk.',0,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('view_editor_blg_pos_#####','einheit_#####ktor',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',0,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',0,0,NULL,''),
('view_editor_blg_pos_#####','einheit_faktor','1',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,'',''),
('view_editor_blg_pos_#####','einheit_symbol','Stk.',0,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('view_editor_blg_pos_#####','einspeiserkennzeichen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','ekpreis','0',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,'',''),
('view_editor_blg_pos_#####','ekpreis_summe','0',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,'',''),
('view_editor_blg_pos_#####','epreis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','fremdbezeichnung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','gewicht',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','gldpreis','0',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,'',''),
('view_editor_blg_pos_#####','gldpreis_summe','0',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,'',''),
('view_editor_blg_pos_#####','gross','0',0,0,'',0,0,'','','NO','',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,'','tualoreportgrossprice'),
('view_editor_blg_pos_#####','handwerkeranteil','0',0,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,0,'',''),
('view_editor_blg_pos_#####','id',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO','NO',1,NULL,'bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','kombiartikel','0',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('view_editor_blg_pos_#####','konto',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','net','0',0,0,'',0,0,'','','NO','',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,'','tualoreportnetprice'),
('view_editor_blg_pos_#####','netto',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','notes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(4000)',4000,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','pos',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','preistyp',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','referenz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','singleprice','0',0,0,'',0,0,'','','NO','',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,'','tualoreportsingleprice'),
('view_editor_blg_pos_#####','steuer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','steuersatz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','tax',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','taxvalue','',0,0,'',0,0,'','','NO','',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,'','tualoreporttaxvalue'),
('view_editor_blg_pos_#####','unit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','vdatum','{DATE}',0,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('view_editor_blg_pos_#####','vid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','vzusatz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','zid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','zusatztext',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'varchar','','varchar(4000)',4000,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_blg_pos_#####','zzusatz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('view_editor_blg_pos_#####','account','DE','Konto','gridcolumn','',8,'','','',1,1,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','additionaltext','DE','additionaltext','gridcolumn','',43,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','amount','DE','Anzahl','gridcolumn','tualoreportamountinputfield',2,'','','sum',0,1,'',0,1.00,'','end','',NULL),
('view_editor_blg_pos_#####','anzahl','DE','Anzahl','numbercolumn','numberfield',11,'','','',0,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','article','DE','Artikel/Leistung','column_view_editor_artikelgruppen_gruppe','combobox_view_editor_artikelgruppen_gruppe',0,'','','count',0,1,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','artikel','DE','Artikel/Leistung','column_view_editor_artikelgruppen_gruppe','dsform_view_editor_artikelgruppen',10,'','','',0,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','beleg','DE','beleg','gridcolumn','',18,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','bemerkung','DE','Bemerkung','gridcolumn','textarea',1,'','','',0,1,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','bereich','DE','bereich','gridcolumn','',19,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','bezugsnebenkosten','DE','bezugsnebenkosten','gridcolumn','',20,'','','',1,0,'',0,1.00,'','','',NULL),
('view_editor_blg_pos_#####','brutto','DE','Brutto','datecolumn','numberfield',15,'','','',0,0,'',0,1.00,'','','',NULL),
('view_editor_blg_pos_#####','einheit','DE','einheit','gridcolumn','',21,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','einheit_#####ktor','DE','einheit_#####ktor','gridcolumn','',17,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','einheit_faktor','DE','einheit_faktor','gridcolumn','',41,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','einheit_symbol','DE','einheit_symbol','gridcolumn','',22,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','einspeiserkennzeichen','DE','einspeiserkennzeichen','gridcolumn','',23,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','ekpreis','DE','ekpreis','gridcolumn','',24,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','ekpreis_summe','DE','ekpreis_summe','gridcolumn','',25,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','epreis','DE','E-Preis','numbercolumn','numberfield',12,'','','',0,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','fremdbezeichnung','DE','fremdbezeichnung','gridcolumn','',27,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','gewicht','DE','gewicht','gridcolumn','',28,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','gldpreis','DE','gldpreis','gridcolumn','',29,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','gldpreis_summe','DE','gldpreis_summe','gridcolumn','',30,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','gross','DE','Brutto','gridcolumn','',7,'euroRenderer','euroRenderer','sum',0,1,'',0,1.00,'','end','',NULL),
('view_editor_blg_pos_#####','handwerkeranteil','DE','handwerkeranteil','gridcolumn','',31,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','id','DE','id','gridcolumn','',32,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','kombiartikel','DE','kombiartikel','gridcolumn','',33,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','konto','DE','konto','gridcolumn','',26,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','net','DE','Netto','numbercolumn','',4,'euroRenderer','euroRenderer','sum',0,1,'',0,1.00,'','end','',NULL),
('view_editor_blg_pos_#####','netto','DE','Netto','numbercolumn','numberfield',13,'','','',0,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','notes','DE','notes','gridcolumn','',42,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','pos','DE','pos','gridcolumn','',34,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','preistyp','DE','preistyp','gridcolumn','',35,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','referenz','DE','referenz','gridcolumn','',36,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','singleprice','DE','E-Preis','numbercolumn','tualoreportsinglepriceinputfield',3,'','euroRenderer','',0,1,'',0,1.00,'','end','',NULL),
('view_editor_blg_pos_#####','steuer','DE','Steuer','numbercolumn','numberfield',14,'','','',0,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','steuersatz','DE','Steuersatz','numbercolumn','numberfield',16,'','','',0,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','tax','DE','Steuersatz','gridcolumn','',6,'','fullPercentRenderer','',0,1,'',0,1.00,'','end','',NULL),
('view_editor_blg_pos_#####','taxvalue','DE','Steuer','gridcolumn','',5,'euroRenderer','euroRenderer','sum',0,1,'',0,1.00,'','end','',NULL),
('view_editor_blg_pos_#####','unit','DE','Einheit','gridcolumn','combobox_mengeneinheiten_name',9,'','','',1,1,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','vdatum','DE','vdatum','gridcolumn','',37,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','vid','DE','vid','gridcolumn','',44,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','vzusatz','DE','vzusatz','gridcolumn','',45,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','zid','DE','zid','gridcolumn','',38,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','zusatztext','DE','zusatztext','gridcolumn','',39,'','','',1,0,'',0,1.00,'','start','',NULL),
('view_editor_blg_pos_#####','zzusatz','DE','zzusatz','gridcolumn','',40,'','','',1,0,'',0,1.00,'','start','',NULL);
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
