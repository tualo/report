DELIMITER //

CREATE TABLE IF NOT EXISTS `blg_vid_#####` (
  `id` bigint(20) NOT NULL,
  `vid` bigint(20) NOT NULL,
  `vzusatz` varchar(255) NOT NULL,
  PRIMARY KEY (`id`, `vid`, `vzusatz`),
  CONSTRAINT `fk_blg_vid_#####_id` FOREIGN KEY (`id`) REFERENCES `blg_pos_#####` (`id`) ON DELETE CASCADE
) //

SET @vid_migration = IF(
  EXISTS(SELECT 1 FROM `blg_vid_#####` WHERE vid IS NULL OR vzusatz IS NULL),
  'SIGNAL SQLSTATE ''45000'' SET MESSAGE_TEXT = ''blg_vid_##### enthält NULL-Referenzen; Migration nicht möglich''',
  'DO 0'
) //
PREPARE stmt FROM @vid_migration //
EXECUTE stmt //
DEALLOCATE PREPARE stmt //

SET @vid_primary_key = (
  SELECT GROUP_CONCAT(column_name ORDER BY seq_in_index SEPARATOR ',')
  FROM information_schema.statistics
  WHERE table_schema = DATABASE() AND table_name = 'blg_vid_#####' AND index_name = 'PRIMARY'
) //
SET @vid_migration = IF(
  @vid_primary_key = 'id,vid,vzusatz',
  'DO 0',
  'ALTER TABLE `blg_vid_#####` ADD INDEX IF NOT EXISTS `idx_blg_vid_#####_id` (`id`)'
) //
PREPARE stmt FROM @vid_migration //
EXECUTE stmt //
DEALLOCATE PREPARE stmt //

SET @vid_migration = IF(
  @vid_primary_key = 'id,vid,vzusatz',
  'DO 0',
  'ALTER TABLE `blg_vid_#####` DROP PRIMARY KEY, MODIFY `vid` bigint(20) NOT NULL, MODIFY `vzusatz` varchar(255) NOT NULL, ADD PRIMARY KEY (`id`, `vid`, `vzusatz`)'
) //
PREPARE stmt FROM @vid_migration //
EXECUTE stmt //
DEALLOCATE PREPARE stmt //
