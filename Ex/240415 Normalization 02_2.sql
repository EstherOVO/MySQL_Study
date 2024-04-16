USE normalization;

-- 선박 정보를 저장하는 테이블
-- 함수 종속 관계 : shipname → shiptype
CREATE TABLE Ship (
	shipname VARCHAR(255) PRIMARY KEY,
    shiptype VARCHAR(255)
);

-- 항해 정보를 저장하는 테이블
-- 함수 종속 관계 voyageID → shipname, cargo
CREATE TABLE Voyage (
	voyageID INT PRIMARY KEY,
    shipname VARCHAR(255),
    cargo VARCHAR(255),
    -- 공유 컬럼을 외래 키로 지정
    FOREIGN KEY (shipname) REFERENCES Ship (shipname)
);

-- 항해 날짜와 항구 정보를 저장하는 테이블
-- 함수 종속 관계 : { voyageID, date } → port
CREATE TABLE VoyageDetail (
	voyageID INT,
    date DATE,
    port VARCHAR(255),
    PRIMARY KEY (voyageID, date),
    FOREIGN KEY (voyageID) REFERENCES Voyage (voyageID)
);

DESCRIBE Ship;
DESCRIBE Voyage;
DESCRIBE VoyageDetail;

INSERT INTO Ship
VALUES ('한라호', '화물선'), ('백두호', '여객선');
SELECT * FROM Ship;

INSERT INTO Voyage
VALUES (101, '한라호', '화물컨테이너'), (102, '백두호', '고객화물');
SELECT * FROM Voyage;

INSERT INTO VoyageDetail
VALUES (101, '2024-04-15', '부산'), (102, '2024-04-16', '인천');
SELECT * FROM VoyageDetail;

-- 테이블 조인하여 보기
SELECT v.voyageID, v.shipname, s.shiptype, v.cargo, vd.date, vd.port
FROM Voyage v
JOIN VoyageDetail vd ON v.voyageID = vd.voyageID
JOIN Ship s ON v.shipname = s.shipname;