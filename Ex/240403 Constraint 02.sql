-- 문제 1 : Patients 테이블을 생성하세요.
-- 이때 모든 환자의 생년월일(DOB)은 1900년 이후여야 한다는 제약조건을 추가합니다.

-- 문제 2 : Doctors 테이블을 생성하세요.
-- 이때 Specialization 열은 비어 있지 않아야 하며(NOT NULL), 의사의 이메일(Email)은 고유해야 합니다(UNIQUE).

-- 문제 3 : Appointments 테이블을 생성하세요.
-- 이 테이블은 Patients와 Doctors 테이블에 대한 외래 키 제약 조건을 포함해야 합니다.
-- PatientID와 DoctorID에 외래 키 제약 조건을 추가하고,
-- AppointmentDate는 2020년 이후여야 한다는 CHECK 제약조건을 추가합니다.

CREATE DATABASE healthcare_management_db;

USE healthcare_management_db;
CREATE TABLE patients (
	patient_ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    dob DATE CHECK (dob >= '1900-01-01'),
    gender ENUM('남', '여'),
    phone_number VARCHAR(20) UNIQUE
);

CREATE TABLE doctors (
	doctor_ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    specialization VARCHAR(255) NOT NULL,
    hire_date DATE DEFAULT (CURRENT_DATE())
);

CREATE TABLE appointments (
	appointment_ID INT AUTO_INCREMENT PRIMARY KEY,
    patient_ID INT,
    doctor_ID INT,
    status ENUM('예약완료', '진료완료', '예약취소'),
    appointment_date DATE CHECK (appointment_date >= '2020-01-01'),
    FOREIGN KEY (patient_ID) REFERENCES patients(patient_ID),
    FOREIGN KEY (doctor_ID) REFERENCES doctors(doctor_ID)
);

DESCRIBE patients;
DESCRIBE doctors;
DESCRIBE appointments;

SELECT * FROM patients;
SELECT * FROM doctors;
SELECT * FROM appointments;

DELETE FROM patients;
DELETE FROM doctors;
DELETE FROM doctors;
