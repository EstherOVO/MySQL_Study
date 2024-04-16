USE tcl;

CREATE TABLE lock_demo (
	id INT,
    data VARCHAR(255)
);

INSERT INTO lock_demo VALUES (1, '데이터1'), (2, '데이터2');

START TRANSACTION;

UPDATE lock_demo SET data = '수정' WHERE id = 1;

COMMIT;