DELIMITER // 

CREATE TABLE IF NOT EXISTS blghdr_translations (
    column_name varchar(128),
    json_attribute_name varchar(128),
    primary key (column_name, json_attribute_name),
    is_required tinyint default 0
) //
alter table blghdr_translations drop primary key //
alter table blghdr_translations
add primary key (column_name, json_attribute_name) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('id', 'id', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('geschaeftsstelle', 'office', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('login', 'login', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('tabellenzusatz', 'reporttype', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('preisorientierung', 'kindofbill', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('referenz', 'reference', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('an_lager', '_in_warehouse', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('von_lager', 'warehouse', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('zeitraum_von', 'service_period_start', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('zeitraum_bis', 'service_period_stop', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('zeit', 'time', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('buchungsdatum', 'bookingdate', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('datum', 'date', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('faelligam', 'payuntildate', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('faelligam', 'bookingdate', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('create_timestamp', 'create_timestamp', 1) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('steuernummer', 'taxid', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('zahlart', 'paytype', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('mandatsreferenz', 'separeference', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('hardwareid', 'hardwareid', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('netto', 'netto', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('brutto', 'brutto', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('steuer', 'steuer', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('zbeleg_zusatz', 'zbeleg_zusatz', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('zbeleg', 'zbeleg', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('svkunde', 'svkunde', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('svmodel', 'svmodel', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('netto', 'net', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('brutto', 'gross', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('bezahlt', 'payed', 0) //
INSERT IGNORE INTO blghdr_translations (column_name, json_attribute_name, is_required)
values ('offen', 'open', 0) //