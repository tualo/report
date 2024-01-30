DELIMITER ;
create or replace view `view_editor_blg_pay_rechnung` as select `blg_pay_rechnung`.`id` AS `id`,`blg_pay_rechnung`.`datum` AS `date`,`blg_pay_rechnung`.`belegnummer` AS `reportnr`,`blg_pay_rechnung`.`art` AS `type`,`blg_pay_rechnung`.`betrag` AS `value` from `blg_pay_rechnung`;
