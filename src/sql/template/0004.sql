DELIMITER //


alter table blg_pos_##### add column if not exists listenpreis_vk decimal(15,5) default 0 //
alter table blg_pos_##### add column if not exists listenpreis_ek decimal(15,5) default 0 //