LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('view_editor_relation_#####','Belegeditor (Bezugsdropdown)','',0,'display','display','display',0,'','','','',0,'','',0,'','','','Belegarten','',1,'','','','','',0,10,NULL,'',0,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('view_editor_relation_#####','address',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_relation_#####','adresse_feld',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,0,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',0,NULL,NULL,''),
('view_editor_relation_#####','anzeige_feld',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,0,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',0,NULL,NULL,''),
('view_editor_relation_#####','costcenter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('view_editor_relation_#####','display',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_relation_#####','id',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(22)',22,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_editor_relation_#####','kostenstelle',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,0,NULL,'tinyint','','int(1)',NULL,10,0,NULL,'select,insert,update,references',0,NULL,NULL,''),
('view_editor_relation_#####','kundennummer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,0,NULL,'varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',0,NULL,NULL,''),
('view_editor_relation_#####','referencenr',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('view_editor_relation_#####','id','id','display','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
UNLOCK TABLES;