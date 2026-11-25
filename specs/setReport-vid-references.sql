-- Run only against an empty, isolated test database, from the report directory.
CREATE TABLE blghdr_translations (column_name VARCHAR(100), json_attribute_name VARCHAR(100), is_required BOOLEAN);
CREATE TABLE blgpos_translations (column_name VARCHAR(100), json_attribute_name VARCHAR(100), is_required BOOLEAN);
CREATE TABLE blg_pos_test (id BIGINT PRIMARY KEY AUTO_INCREMENT, beleg BIGINT);
CREATE TABLE blg_vid_test (
    id BIGINT NOT NULL,
    vid BIGINT NOT NULL,
    vzusatz VARCHAR(255) NOT NULL,
    PRIMARY KEY (id, vid, vzusatz),
    FOREIGN KEY (id) REFERENCES blg_pos_test (id) ON DELETE CASCADE
);
CREATE TABLE test_header_writes (id INT NOT NULL);

DELIMITER //
CREATE PROCEDURE setReportDefault(IN typ VARCHAR(20), IN input JSON, OUT output JSON)
BEGIN
    SET output = input;
END //
CREATE PROCEDURE debug_message(IN msg TEXT) BEGIN END //
CREATE PROCEDURE dsx_rest_api_set(IN request JSON, OUT result JSON)
BEGIN
    DECLARE pos_id BIGINT;
    DROP TEMPORARY TABLE IF EXISTS temp_report_test;
    CREATE TEMPORARY TABLE temp_report_test (id BIGINT);
    IF JSON_VALUE(request, '$.tablename') = 'blg_hdr_test' THEN
        INSERT INTO test_header_writes VALUES (1);
        INSERT INTO temp_report_test VALUES (100);
    ELSE
        SET pos_id = JSON_VALUE(request, '$.data[0].id');
        IF pos_id IS NULL THEN
            INSERT INTO blg_pos_test (beleg) VALUES (100);
            SET pos_id = LAST_INSERT_ID();
        ELSE
            CALL assert_test(pos_id > 0, 'Negative ID was passed to DSX');
            INSERT INTO blg_pos_test (id, beleg) VALUES (pos_id, 100)
                ON DUPLICATE KEY UPDATE beleg = VALUES(beleg);
        END IF;
        INSERT INTO temp_report_test VALUES (pos_id);
    END IF;
    SET result = JSON_OBJECT('success', 1, 'temporary_table_name', 'temp_report_test');
END //
CREATE PROCEDURE setReportTSE(IN typ VARCHAR(20), IN input JSON, IN id BIGINT, OUT result JSON) BEGIN END //
CREATE PROCEDURE setReportTexts(IN typ VARCHAR(20), IN input JSON, IN id BIGINT, OUT result JSON) BEGIN END //
CREATE PROCEDURE setReportReferenceNr(IN typ VARCHAR(20), IN input JSON, IN id BIGINT, OUT result JSON) BEGIN END //
CREATE PROCEDURE setReportAddress(IN typ VARCHAR(20), IN input JSON, IN id BIGINT, OUT result JSON) BEGIN END //
CREATE PROCEDURE setReportBookingCircle(IN typ VARCHAR(20), IN input JSON, IN id BIGINT, OUT result JSON) BEGIN END //
CREATE PROCEDURE recalculateHeader(IN typ VARCHAR(20), IN id BIGINT) BEGIN END //
CREATE PROCEDURE getReport(IN typ VARCHAR(20), IN id BIGINT, OUT result JSON) BEGIN SET result = JSON_OBJECT('id', id); END //
CREATE PROCEDURE assert_test(IN condition_value BOOLEAN, IN message_text VARCHAR(255))
BEGIN
    IF NOT COALESCE(condition_value, FALSE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = message_text;
    END IF;
END //
DELIMITER ;

SOURCE src/sql/proc/setReport.sql;

DELIMITER //
CREATE PROCEDURE test_vid_references()
BEGIN
    DECLARE rejected BOOLEAN DEFAULT FALSE;
    DECLARE writes_before INT;
    DECLARE error_text TEXT;

    CALL setReport('test', '{"positions":[
        {"id":-1,"vid_references":[{"vid":11,"vzusatz":"calculation"},{"vid":"12","vzusatz":"calculation"}]},
        {"id":-1,"vid_references":[{"vid":21,"vzusatz":"other"}]},
        {"id":-1,"vid_references":[]},
        {"id":-1}
    ]}', @output);
    CALL assert_test((SELECT COUNT(*) = 3 FROM blg_vid_test), 'Expected three references');
    CALL assert_test((SELECT COUNT(*) = 2 FROM blg_vid_test WHERE id = 1 AND vid IN (11, 12)), 'Grouped references have wrong position ID');
    CALL assert_test((SELECT COUNT(*) = 1 FROM blg_vid_test WHERE id = 2 AND vid = 21 AND vzusatz = 'other'), 'Single reference missing');
    CALL assert_test((SELECT COUNT(*) = 0 FROM blg_vid_test WHERE id IN (3, 4)), 'Unexpected references');

    SELECT COUNT(*) INTO writes_before FROM test_header_writes;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLSTATE '45000'
        BEGIN
            SET rejected = TRUE;
            GET DIAGNOSTICS CONDITION 1 error_text = MESSAGE_TEXT;
        END;
        CALL setReport('test', '{"positions":[{"id":1}]}', @output);
    END;
    CALL assert_test(rejected AND error_text LIKE '%stammt aus einem Verweis%', 'Referenced position update was not rejected');
    CALL assert_test((SELECT COUNT(*) = writes_before FROM test_header_writes), 'Header was written before rejecting position');
    CALL assert_test((SELECT COUNT(*) = 3 FROM blg_vid_test), 'Existing references changed');

    SET rejected = FALSE;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLSTATE '45000' SET rejected = TRUE;
        CALL setReport('test', '{"positions":[{"id":-1,"vid_references":null}]}', @output);
    END;
    CALL assert_test(rejected, 'Non-array references were accepted');
    CALL assert_test((SELECT COUNT(*) = writes_before FROM test_header_writes), 'Header was written before invalid references were rejected');

    SET rejected = FALSE;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLSTATE '45000' SET rejected = TRUE;
        CALL setReport('test', '{"positions":[{"id":-1,"vid_references":[{"vid":"abc","vzusatz":"calculation"}]}]}', @output);
    END;
    CALL assert_test(rejected, 'Invalid vid was accepted');

    SET rejected = FALSE;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLSTATE '45000' SET rejected = TRUE;
        CALL setReport('test', '{"positions":[{"id":-1,"vid_references":[
            {"vid":11,"vzusatz":"calculation"},{"vid":"11","vzusatz":"calculation"}
        ]}]}', @output);
    END;
    CALL assert_test(rejected, 'Duplicate references were accepted');
    CALL assert_test((SELECT COUNT(*) = writes_before FROM test_header_writes), 'Header was written before duplicate references were rejected');

    CALL setReport('test', '{"positions":[{"id":3}]}', @output);
    CALL setReport('test', '{"positions":[{"id":3,"vid_references":[{"vid":31,"vzusatz":"calculation"}]}]}', @output);
    CALL assert_test((SELECT COUNT(*) = 1 FROM blg_vid_test WHERE id = 3 AND vid = 31), 'Reference was not saved for existing position');
    SET rejected = FALSE;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLSTATE '45000' SET rejected = TRUE;
        CALL setReport('test', '{"positions":[{"id":3}]}', @output);
    END;
    CALL assert_test(rejected, 'Position was not locked after adding a reference');

    DELETE FROM blg_pos_test WHERE id = 1;
    CALL assert_test((SELECT COUNT(*) = 0 FROM blg_vid_test WHERE id = 1), 'References were not cascaded on delete');
END //
DELIMITER ;
CALL test_vid_references();
