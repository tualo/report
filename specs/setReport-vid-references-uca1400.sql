-- Run only against an empty, isolated test database, from the report directory.
-- Requires MariaDB with UCA 1400 collation support.
SET NAMES utf8mb3 COLLATE utf8mb3_uca1400_ai_ci;
SOURCE specs/setReport-vid-references.sql;
