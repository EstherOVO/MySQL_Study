-- 데이터 삽입, 추가, 삭제 연습 문제 
-- healthcare_management_db2 스키마에서 진행해 주세요.
DROP SCHEMA IF EXISTS healthcare_management_db2; 
CREATE SCHEMA IF NOT EXISTS healthcare_management_db2;
USE healthcare_management_db2;

CREATE TABLE patients (
    patient_ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    phone_number VARCHAR(15)
);

CREATE TABLE appointments (
    appointment_ID INT AUTO_INCREMENT PRIMARY KEY,
    patient_ID INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    type VARCHAR(50) NOT NULL,
    FOREIGN KEY (patient_ID) REFERENCES patients (patient_ID)
);


CREATE TABLE medical_records (
    record_ID INT AUTO_INCREMENT PRIMARY KEY,
    patient_ID INT,
    visit_date DATE NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    prescription VARCHAR(255),
    FOREIGN KEY (patient_ID) REFERENCES patients (patient_ID)
);

-- 문제 1 : 'patients' 테이블에 새로운 환자 추가하기
-- 이름 : "John Smith", 생년월일 : "1985-02-20", 성별 : "M", 전화번호 : "123-456-7890"
INSERT INTO `healthcare_management_db2`.`patients`
VALUES (NULL, 'John Smith', '1985-02-20', 'M', '123-456-789');

-- 문제 2 : 'appointments' 테이블에 새로운 예약 추가하기
-- 환자 ID : 1, 예약 날짜 : "2023-04-20", 예약 시간 : "10:00", 진료 유형 : "General Checkup"
INSERT INTO `healthcare_management_db2`.`appointments`
VALUES (NULL, 1, '2023-04-20', '10:00', 'General Checkup');

-- 문제 3 : 'medical_records' 테이블에 새로운 의료 기록 추가하기
-- 환자 ID : 1, 방문 날짜 : "2023-04-10", 진단 : "Common Cold", 처방 : "Rest and hydration"
INSERT INTO `healthcare_management_db2`.`medical_records`
VALUES (NULL, 1, '2023-04-10', 'Common Cold', 'Rest and hydration');

-- 문제 4 : 'patients' 테이블에서 환자의 전화번호 업데이트하기
-- 환자 ID가 1인 환자의 전화번호를 "987-654-3210"으로 변경하기
UPDATE `healthcare_management_db2`.`patients` SET phone_number = '987-654-3210' WHERE patient_ID = 1;

-- 문제 5 : 'appointments' 테이블에서 예약 시간 변경하기
-- 환자 ID가 1이고 예약 날짜가 "2023-04-20"인 예약의 시간을 "14:00"으로 변경하기
UPDATE `healthcare_management_db2`.`appointments` SET appointment_time = '14:00' WHERE appointment_date = '2023-04-20';

-- 문제 6 : 'medical_records' 테이블에서 진단 정보 업데이트하기
-- 환자 ID가 1이고, 방문 날짜가 "2023-04-10"인 기록의 진단을 "Seasonal Allergies"로 변경하기
UPDATE `healthcare_management_db2`.`medical_records` SET diagnosis = 'Seasonal Allergies'
WHERE patient_ID = 1 AND visit_date = '2023-04-10';

-- 문제 7 : 'appointments' 테이블에서 특정 날짜의 모든 예약 삭제하기
-- 예약 날짜가 "2023-04-20"인 모든 예약 삭제하기
DELETE FROM `healthcare_management_db2`.`appointments` WHERE appointment_date = '2023-04-20';

-- 문제 8  'medical_records' 테이블에서 특정 진단을 가진 모든 기록 삭제하기
-- 진단이 "Seasonal Allergies"인 모든 의료 기록 삭제하기
DELETE FROM `healthcare_management_db2`.`medical_records` WHERE diagnosis = 'Seasonal Allergies';

-- 문제 9 : 'patients' 테이블에서 특정 환자 삭제하기
-- 환자 ID가 1인 환자 삭제하기
DELETE FROM `healthcare_management_db2`.`patients` WHERE patient_ID = 1;

-- 문제 10 : 'patients' 테이블에 여러 환자 동시에 추가하기
-- 환자 정보 : ("Alice Johnson", "1992-08-24", "F", "555-1234"), ("Bob Williams", "1980-03-15", "M", "555-5678")
INSERT INTO `healthcare_management_db2`.`patients`
VALUES (1, 'Alice Johnson', '1992-08-24', 'F', '555-1234'), (2, 'Bob Williams', '1980-03-15', 'M', '555-5678');

SELECT * FROM `healthcare_management_db2`.`patients`;
SELECT * FROM `healthcare_management_db2`.`appointments`;
SELECT * FROM `healthcare_management_db2`.`medical_records`;