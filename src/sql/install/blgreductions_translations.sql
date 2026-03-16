DELIMITER;
CREATE TABLE IF NOT EXISTS blgreductions_translations (
    column_name varchar(128) primary key,
    json_attribute_name varchar(128),
    is_required tinyint default 0
);
INSERT IGNORE INTO blgreductions_translations (column_name, json_attribute_name, is_required)
values ('id', 'id', 1);
INSERT IGNORE INTO blgreductions_translations (column_name, json_attribute_name, is_required)
values ('name', 'type', 1);
INSERT IGNORE INTO blgreductions_translations (column_name, json_attribute_name, is_required)
values ('bemerkung', 'note', 1);
INSERT IGNORE INTO blgreductions_translations (column_name, json_attribute_name, is_required)
values ('betrag', 'value', 1);
INSERT IGNORE INTO blgreductions_translations (column_name, json_attribute_name, is_required)
values ('belegnummer', 'reportnr', 1);