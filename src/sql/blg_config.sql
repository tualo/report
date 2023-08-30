delimiter ;

LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('blg_config','Belegarten','',0,'name','name','name',1,'false','false','','',0,'tualomultirowmodel','',0,'','','','Warenwirtschaft','',1,'','','listview','XlsxWriter','{GUID}',0,100,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('blg_config','adress_bezug','adressen',0,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','aktiv',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','ausgangslager','1',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','auto_append_formel','0',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','auto_lock','-1',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','belegnummer_bis','99999999',0,0,'',0,0,'','','YES','NO',1,'','bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','belegnummer_von','0',0,0,'',0,0,'','','YES','NO',1,'','bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','bestandspruefung','1',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','bezug_anzeigen','0',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','bezug_id','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(36)',36,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','bezug_kst','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(36)',36,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','brutto_anzeigen','0',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','bw_faktor','1',0,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','eingangslager','1',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','epreis_genauigkeit','5',0,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','filter_warengruppe','*',0,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(3)',3,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','fusstext','1',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','gegenkonto_bezug','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','gesperrt','0',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','id','{#serial}',100000,1,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','konten_bezug','',0,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','kopftext','1',0,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','lager_faktor','-1',0,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','layout',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','login',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','mengen_genauigkeit',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','name','',0,0,'',0,0,'','','NO','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','nur_kostenstelle_zusammenfassen',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','periodensperre','1',0,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','preisorientierung','netto',0,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','preis_bezug','preis',0,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','pv_report_class','',0,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','tabellenzusatz','',0,0,'',0,0,'','','YES','NO',1,'','varchar','UNI','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('blg_config','transitlager','0',0,0,'',0,0,'','','YES','NO',1,'','int','MUL','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,NULL,''),
('blg_config','use_history_pk',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('blg_config','belegnummer_bis','DE','Beleg-Nr. bis','gridcolumn','',3,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('blg_config','belegnummer_von','DE','Beleg-Nr. von','gridcolumn','',2,'','','',1,1,'',0,1.00,'ASC','left','',NULL),
('blg_config','id','DE','ID','gridcolumn','',4,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('blg_config','name','DE','Name','gridcolumn','',1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('blg_config','tabellenzusatz','DE','Tabellenzusatz','gridcolumn','',5,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('blg_config','adress_bezug','DE','Bezugstamm','combobox_ds_tabelle','Allgemein/Beleg',3,0,1,1,'',1.00,''),
('blg_config','ausgangslager','DE','Ausgangslager','checkbox','Optionen/Bestand',10,0,1,1,'',1.00,''),
('blg_config','auto_append_formel','DE','Formeln automatisch hinzufügen','checkbox','Optionen/Artikel',13,0,1,1,'',1.00,''),
('blg_config','auto_lock','DE','autom. nach dem Speichern sperren','checkbox','Optionen/Auswahl',12,0,1,1,'',1.00,''),
('blg_config','belegnummer_bis','DE','Beleg-Nr. bis','numberfield','Allgemein/Beleg',5,1,1,0,'',1.00,''),
('blg_config','belegnummer_von','DE','Beleg-Nr. von','numberfield','Allgemein/Beleg',4,1,1,0,'',1.00,''),
('blg_config','bezug_anzeigen','DE','im Datenstamm anzeigen','checkbox','Optionen/Auswahl',15,0,1,1,'',1.00,''),
('blg_config','bezug_id','DE','bezug_id','textfield','Allgemein/Beleg',38,0,1,1,'',1.00,''),
('blg_config','bezug_kst','DE','bezug_kst','textfield','Allgemein/Beleg',41,0,1,1,'',1.00,''),
('blg_config','brutto_anzeigen','DE','Gesamt-Brutto anzeigen','checkbox','Optionen/Auswahl',14,0,1,1,'',1.00,''),
('blg_config','bw_faktor','DE','BW-Faktor','numberfield','Statistik/Auswertung',19,0,1,1,'',1.00,''),
('blg_config','eingangslager','DE','Eingangslager','checkbox','Optionen/Bestand',9,0,1,1,'',1.00,''),
('blg_config','epreis_genauigkeit','DE','Nachkommastellen E-Preis','numberfield','Optionen/Auswahl',16,0,1,1,'',1.00,''),
('blg_config','filter_warengruppe','DE','Warengruppen-Filter','combobox_warengruppen_warengruppe','Optionen/Artikel',23,0,1,1,'',1.00,''),
('blg_config','fusstext','DE','Fusstext','checkbox','Optionen/Auswahl',8,0,1,1,'',1.00,''),
('blg_config','gegenkonto_bezug','DE','gegenkonto_bezug','displayfield','Allgemein',40,1,1,1,'',1.00,''),
('blg_config','gesperrt','DE','gesperrt','displayfield','Allgemein',34,1,1,1,'',1.00,''),
('blg_config','id','DE','ID','displayfield','Allgemein/Beleg',0,0,1,1,'',1.00,''),
('blg_config','konten_bezug','DE','Kontensteuerung','combobox_steuergruppen_field_steuergruppe','Optionen/Artikel',36,0,1,1,'',1.00,''),
('blg_config','kopftext','DE','Kopftext','checkbox','Optionen/Auswahl',7,0,1,1,'',1.00,''),
('blg_config','lager_faktor','DE','Bewegungsrichtung-Bestand','numberfield','Optionen/Bestand',28,0,1,1,'',1.00,''),
('blg_config','name','DE','Name','textfield','Allgemein/Beleg',1,0,1,1,'',1.00,''),
('blg_config','periodensperre','DE','autom. bei Periodenwechsel sperren','checkbox','Optionen/Auswahl',11,0,1,1,'',1.00,''),
('blg_config','preisorientierung','DE','preisorientierung','combobox_preisorientierung_name','Optionen/Artikel',22,0,1,1,'',1.00,''),
('blg_config','preis_bezug','DE','Preisbezug','textfield','Optionen/Artikel',27,0,1,1,'',1.00,''),
('blg_config','pv_report_class','DE','Berichtsklasse','textfield','Statistik/Auswertung',20,0,1,1,'',1.00,''),
('blg_config','tabellenzusatz','DE','Tabellenzusatz','textfield','Allgemein/Beleg',2,0,1,1,'',1.00,''),
('blg_config','transitlager','DE','Transitlager','combobox_lager_id','Optionen/Bestand',24,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('blg_config','ID','id','name','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,1,99999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"blg_config__transitlager\":\"lager__id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"transitlager\":\"id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"transitlager\":\"id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"transitlager\":\"id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"transitlager\":\"id\"}','fk_blg_config_transitlager',0,0,0,999,'',0,''),
('blg_config','lager','{\"transitlager\":\"id\"}','fk_blg_config_transitlager',0,0,0,999,'',1,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,1,99999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"blg_config__preisorientierung\":\"preisorientierung__name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"preisorientierung\":\"name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"preisorientierung\":\"name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"preisorientierung\":\"name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"preisorientierung\":\"name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',0,''),
('blg_config','preisorientierung','{\"preisorientierung\":\"name\"}','fk_blg_config_preisorientierung',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
INSERT INTO `ds_addcommands` (`table_name`, `xtype`, `location`, `position`, `label`, `iconCls`) VALUES ('blg_config','ds_report_ddl_command','toolbar',1,'','x-fa fa-plus');
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','blg_config',1,1,0,1,1);
UNLOCK TABLES;
