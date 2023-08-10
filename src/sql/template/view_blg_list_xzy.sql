DELIMITER ;

LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('view_blg_list_#####','##### (Liste)','',0,'belegnummer','belegnummer','belegnummer',1,'','','','',0,'tualomultirowmodel','',0,'','cmp_belege_report_editorform','','ERP','',1,'','','listview','XlsxWriter','',0,100,NULL,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('view_blg_list_#####','belegnummer','-1',10000000,0,'',1,0,'','','NO','NO',1,'\'\'','bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,'NULL',''),
('view_blg_list_#####','belegnummer_anzeige','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(32)',32,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,NULL,''),
('view_blg_list_#####','bezahlt','',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,NULL,''),
('view_blg_list_#####','bezugsnummer','',10000000,0,'',0,0,'','','NO','NO',1,'','varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,NULL,''),
('view_blg_list_#####','brutto','',10000000,0,'',0,0,'','','YES','NO',1,'','decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,0,NULL,''),
('view_blg_list_#####','buchungsdatum','',10000000,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,NULL,''),
('view_blg_list_#####','datum','',10000000,0,'',0,0,'','','NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,NULL,''),
('view_blg_list_#####','faelligam','',10000000,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,NULL,''),
('view_blg_list_#####','gedruckt','',10000000,0,'',0,0,'','','YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,NULL,''),
('view_blg_list_#####','gedruckt_am','',10000000,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,NULL,''),
('view_blg_list_#####','geschaeftsstelle','100',0,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('view_blg_list_#####','id','-1',0,0,'',0,0,'','','NO','NO',1,'','bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,'',''),
('view_blg_list_#####','kostenstelle','0',0,0,'',0,0,'','','NO','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('view_blg_list_#####','kundennummer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO','NO',1,NULL,'varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_blg_list_#####','minderung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_blg_list_#####','netto',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_blg_list_#####','offen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'decimal','','decimal(15,6)',NULL,15,6,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_blg_list_#####','referenz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_blg_list_#####','report_config_id','4',0,0,'',0,0,'','','NO','NO',1,'','varchar','','varchar(1)',1,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,'NULL',''),
('view_blg_list_#####','steuer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'decimal','','decimal(12,5)',NULL,12,5,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_blg_list_#####','tabellenzusatz','#####',0,0,'',0,0,'','','NO','NO',1,'','varchar','','varchar(7)',7,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,'NULL',''),
('view_blg_list_#####','zahlart',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'varchar','','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_blg_list_#####','zeit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_blg_list_#####','zeitraum_bis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_blg_list_#####','zeitraum_von',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES','NO',1,NULL,'date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,NULL,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('view_blg_list_#####','belegnummer','DE','Belegnummer','gridcolumn','',0,'deNatualRenderer','deNatualRenderer','count',0,1,'',0,1.00,'','','',NULL),
('view_blg_list_#####','belegnummer_anzeige','DE','belegnummer_anzeige','gridcolumn','',1,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','bezahlt','DE','bezahlt','gridcolumn','',2,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','bezugsnummer','DE','Bezug','gridcolumn','',4,'','','',1,1,'',0,1.00,'','','',NULL),
('view_blg_list_#####','brutto','DE','Brutto','coloredmoneycolumn2','',3,'euroRenderer','euroRenderer','sum',0,1,'',0,1.00,'','end','',NULL),
('view_blg_list_#####','buchungsdatum','DE','buchungsdatum','gridcolumn','',5,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','datum','DE','Datum','datecolumn','',6,'','','',0,1,'',0,1.00,'','','',NULL),
('view_blg_list_#####','faelligam','DE','faelligam','gridcolumn','',7,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','gedruckt','DE','gedruckt','gridcolumn','',8,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','gedruckt_am','DE','gedruckt_am','gridcolumn','',9,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','geschaeftsstelle','DE','geschaeftsstelle','gridcolumn','',10,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','id','DE','id','gridcolumn','',11,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','kostenstelle','DE','kostenstelle','gridcolumn','',12,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','kundennummer','DE','Bezug','gridcolumn','',13,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','minderung','DE','minderung','gridcolumn','',14,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','netto','DE','Netto','coloredmoneycolumn2','',15,'euroRenderer','euroRenderer','sum',0,1,'',0,1.00,'','end','',NULL),
('view_blg_list_#####','offen','DE','offen','gridcolumn','',16,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','referenz','DE','referenz','gridcolumn','',17,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','report_config_id','DE','report_config_id','gridcolumn','',18,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','steuer','DE','steuer','gridcolumn','',19,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','tabellenzusatz','DE','tabellenzusatz','gridcolumn','',20,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','zahlart','DE','zahlart','gridcolumn','',21,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','zeit','DE','zeit','gridcolumn','',22,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','zeitraum_bis','DE','zeitraum_bis','gridcolumn','',23,'','','',1,0,'',0,1.00,'','','',NULL),
('view_blg_list_#####','zeitraum_von','DE','zeitraum_von','gridcolumn','',24,'','','',1,0,'',0,1.00,'','','',NULL);
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
UNLOCK TABLES;
