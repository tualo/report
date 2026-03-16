DELIMITER;


CREATE TABLE IF NOT EXISTS blgpos_translations (
    column_name varchar(128) primary key,
    json_attribute_name varchar(128),
    is_required tinyint default 0
);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('id', 'id', 1);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('beleg', 'reportnr', 1);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('pos', 'position', 1);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('artikel', 'article', 1);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('anzahl', 'amount', 1);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('epreis', 'singleprice', 1);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('konto', 'account', 0);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('steuersatz', 'tax', 0);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('steuer', 'taxvalue', 0);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('netto', 'net', 0);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('brutto', 'gross', 0);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('zusatztext', 'additionaltext', 0);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('bemerkung', 'notes', 0);
INSERT IGNORE INTO blgpos_translations (column_name, json_attribute_name, is_required)
values ('referenz', 'reference', 0);