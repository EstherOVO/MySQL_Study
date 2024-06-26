# ▨ 데이터베이스(Database) ▨

## :pushpin: 데이터베이스(Database)

- 체계적으로 조직된 데이터의 집합
- 다양한 형태(텍스트, 숫자, 파일 등)로 저장 가능
- 서로 관련성이 있어서 의미 있는 정보 형성
- 여러 사용자가 동시에 접근이 가능하고, 작업을 수행한다.
- 안정성과 무결성(Integrity) : 데이터의 정확성과 일관성을 유지
- 제약조건(Constraint)이라고 하는 특성을 가진다.
- 보안, 백업 및 복구 등을 보장

## :pushpin: 데이터베이스의 구성 요소
- 데이터 : 저장된 원시정보
- DBMS(DataBase Management System) : 데이터베이스를 관리하는 소프트웨어
- MySQL, Oracle, PostgeresSQL, MariaDB 등
- 데이터베이스 서버 : DBMS가 실행되는 컴퓨터 시스템
- 스키마(Schema) : DB의 구조를 정의하는 메타 데이터 집합

## :pushpin: 데이터 모델(Data Model)
- 현실 세계의 정보를 시스템 내에서 어떻게 구조화하고, 조직화할지에 대한 청사진
- 예시) 도서관 DB : 책-제목, 저자, 출판연도(책에 대한 메타 데이터)

1. 개념적 데이터 모델(Conceptual) : 높은 수준의 추상화
    - 비전문가나 일반인들도 요구사항을 이해하고 분석할 수 있게 설계
2. **논리적 데이터 모델(Logical)**
    - 개념적 데이터 모델에서 더 구체화
    - 데이터의 속성이나 키(Key), 관계 등을 명시
    - 특정 DBMS에 의존하지 않고 명시
3. 물리적 데이터 모델(Physical)
    - 특정 DBMS에 저장이 될 수 있게 논리적 데이터 모델을 디테일하게 설계
    - DBA(데이터베이스 관리자) 또는 개발자가 사용

- 데이터 모델의 종류
1. 계층형 데이터 모델(Hierarchical 부모-자식 관계 / 트리 구조)
2. 네트워크형 데이터 모델(Network 다대다 관계 표현 / 구조가 복잡해짐)
3. **관계형 데이터 모델(Relational 가장 널리 사용되는 모델)**
4. 객체 지향 데이터 모델(Obhect 데이터를 객체로 표현)
5. NoSQL(Not Only SQL) : 비관계형 데이터 모델(문서, 키-값, 그래프 등), 유연성, 확장성

## :pushpin: 논리적 데이터 모델의 구성요소
- 엔티티(Entity) : 실제 세계의 객체 → 데이터베이스에서 테이블로 표시
  - 각 엔티티는 속성(Attribute)를 가지고 있다.
- 속성(Attribute) : 엔티티의 특성 → DB에서는 테이블의 컬럼(열, Column)으로 구현
  - 엔티티를 설명하는 데이터
- 관계(Relationship) : 엔티티-엔티티 간의 연관성 / 상호작용 → DB에서는 외래키로 표현
- 키(Key) : 데이터의 무결성을 유지하기 위해 사용되는 속성
  - **기본 키(Primary Key) : 테이블의 행을 고유하게 식별하는 키 Null 불가**
  - **외래 키(Foreign Key) : 다른 테이블의 행(기본 키)을 참조하는 키(관계 정의 시 사용)** 
  - 후보 키 : 데이터베이스의 모든 행을 유일하게 식별할 수 있는 속성들의 집합
  - 대체 키 : 후보 키 중 기본 키로 선택되지 않은 키
  - 복합 키 : 두 개 이상의 속성을 조합하여 만든 키

## :pushpin: 관계형 데이터베이스 모델
- 수학의 관계대수(Relational Algebra)에서 영감을 받아 데이터의 집합(릴레이션)을 테이블로 표현한 모델
  - 테이블 : 데이터를 저장하는 기본 단위(릴레이션)
  - 행(Row) : 테이블에서 개별 데이터 항목(튜플, 레코드)
  - 열(Column) : 테이블에서 데이터의 속성(Attribute, 필드)
  - 도메인(Domain) : 속성이 가질 수 있는 범위, 집합(Data Type)
  - 스키마 : 데이터베이스의 구조적인 설계(구조와 제약조건을 정의하는 SQL문)

## :pushpin: 스키마와 상태
- 스키마(Schema) : DB의 구조나 설계
  - 구체적인 데이터 항목이나 값은 포함하지 않음
  - 데이터베이스 설계과정 초기에 정의되고, 시간이 지나도 상대적으로 변경되지 않음
- 상태(Status) : 특정 시점에 데이터베이스에 실제로 저장된 데이터베이스의 집합
  - 시간에 따라 변할 수 있고, 지속적으로 업데이트된다.
  - DB의 일관성과 무결성을 유지하기 위해 스키마의 규칙과 제약조건을 따라야 한다.
  - 동적인 특성, 변화하는 데이터의 실체

## :pushpin: 3 Schema Architecture
1. 내부 스키마 : DB의 물리적 저장 구조 / 최하위 수준의 추상화
    - 인덱스, 압축, 암호화 등 DBA(데이터베이스 관리자)가 다루는 영역
2. 개념 스키마 : DB의 전체적인 논리적 구조 / 중간 수준의 추상화
    - 데이터의 관계, 데이터의 제약조건 등 DB 설계자, 분석자가 다루는 영역
3. 외부 스키마 : 사용자 관점에서 보는 DB의 일부분
    - 애플리케이션이 접근하는 View, 최종 사용자, 응용 프로그램 개발자가 다루는 영역

## :pushpin: 데이터베이스 설계 과정
- 프로젝트의 진행 단계
  - 폭포수(waterfall 모델)
    - 소프트웨어 공학에서 전통적으로 사용되는 모델
    - 각 단계를 순차적으로 진행 : 앞 단계가 끝나면 다음 단계 수행
      1. 프로젝트 계획
      2. 업무 분석
      3. 시스템 설계
      4. 프로그램 구현
      5. 테스트
      6. 유지 보수
- 데이터베이스의 생명 주기
  1. 요구사항 분석
      - 실제 사용할 사용자들의 요구사항을 듣고, 관리해야 할 데이터의 종류를 이해하고 분석해서 DB 구축의 범위 지정
  2. 설계
      - 분석된 요구사항을 기초로 데이터베이스 스키마를 도출
        - 개념적 모델링 : 요구사항에 중요한 개념을 Entity로 도출하여 Entity와 Relation의 도면 → ERD(ERDiagram)
        - 논리적 모델링 : 각 개념(Entit)을 관계 데이터 테이블로 구체화 매핑(Mapping)
        - 물리적 모델링 : DB의 객체, 인덱스, 뷰 등을 정의
  3. 구현
      - 설계된 스키마를 DBMS에서 생성
  4. 테스트
      - 생성된 데이터베이스가 요구사항을 만족시키는지 검증 및 필요한 경우 설계 수정
  5. 유지보수
      - 데이터베이스를 운영하고, 운영 중 발생하는 사항에 대해 변경, 최적화, 모니터링 진행

## :pushpin: 요구사항 분석
- 담당자와 인터뷰를 하거나 설문조사 등을 통하여 요구사항을 수집
- 실제 문서를 수집하여 분석
- 기존에 존재하는 DB를 분석 
- 워크숍을 열어 사용자, 개발자, 분석가(이해 관계자) 등이 참여하여 요구사항을 정의 및 합의
- 업무와 연관된 모든 부분을 살펴보고 분석

## :pushpin: 설계 - 개념적 모델링
- 수집되고 분석된 요구사항에서 업무의 핵심 개념을 추출
- ER(Entity-Realtion) 모델
  1. Entity
      - 개체를 추출 : 요구사항 분석에서 수집된 중요한 `명사`들을 찾아서 Entity 후보로 선정
      - 특징
        - 유일한 식별자에 의해 식별이 가능하다.
        - 업무 프로세스에서 사용하는 개념이어야 한다.
        - 실제로 존재하거나 추상적인 것 모두를 포함한다.
        - 다른 Entity와 구별되어야 한다.
        - 자신의 특징을 나타내는 속성을 포함해야 한다.
      - 이름
        - 가능하면 현업에서 사용하는 용어를 사용한다.
        - 가능하면 약어를 사용하지 않아야 한다.
  2. Attrubute
      - 단순 속성 ↔ 복합속성
      - 단순 속성 : 더 이상 분할되지 않는 속성(예 : 이름)
      - 복합 속성 : 여러 개의 단순 속성으로 속성된 속성(예 : first_name, last_name)
      - 유도 속성 : 다른 속성으로부터 계산되는 속성
      - 다중 속성 : 하나의 Entity가 여러 개 값을 가질 수 있는 속성(예 : 전화번호, 이메일 등)
      - 관계 추출
        - 반드시 비지니스에 필요하고 저장, 관리해야 하는 정보
        - 하나의 속성은 하나의 값만 가지게 해야 한다.
  3. Relationship
      - Entity 간의 상호 연관이 있는 상태
      - 추출 : 요구사항 문장에서 개체(명사, 개념)간에 의미 있는 `동사`를 찾아냄

## :pushpin: 설계 - 논리적 모델링
- 개념적 모델링에서 만든 ER 다이어그램을 DBMS에 맞게 매핑하여 실제 데이터베이스에 구현하기 위한 모델을 만드는 과정
  - 개념적 모델링에서 추출하지 않은 상세 속성들을 모두 추출
  - 정규화, 표준화 등을 수행
- 논리적 모델링 연습
  - 온라인 도구(무료)
    - [ERD cloud](https://www.erdcloud.com/)
    - [dbdiagram.io](https://dbdiagram.io/)
  - MySQL 워크벤치 모델링 도구

## :pushpin: 설계 - 물리적 모델링
- 모델링 된 논리적 설계를 바탕으로 실제 데이터베이스 시스템에서 사용될 물리적 구조 설계
- 연습
  - MySQL 워크벤치 모델링 도구
    1. 새 모델 생성 : File - New Model
    2. 다이어그램 생성 : Add Diagram
    3. 다이어그램 작성 및 테이블 작성 : ER 다이어그램 작성하기
    4. 테이블 생성 : Database - Foward Engineer

## :pushpin: 정규화
- 데이터베이스 설계 기법
  - 데이터베이스 중복 최소화하고 → 중복 감소
  - 무결성을 유지하기 위해 → 삽입, 삭제, 갱신 이상 제거
  - 데이터를 구조화하는 과정 → 구조 개선
- 이상현상(anomaly)
  - 잘못 설계된 테이블에서 데이터 조작(삽입(Insert), 삭제(Delete), 갱신(Update))을 하게 될 경우, 테이블의 일관성이 훼손되고 무결성이 깨지는 현상
  1. 삽입 이상(Insertion Anomaly)
      - 튜플(행) 삽입 시 부득이하게 null 값이 입력되거나, 중복 데이터 삽입
  2. 갱신 이상(Update Anomaly)
      - 데이터베이스 속성의 최신 상태가 반영이 되지 않아 일관성이 깨짐
  3. 삭제 이상(Deletion Anomaly)
      - 튜플(행) 삭제 시 항목에 연결된 유용한 데이터까지 연쇄 삭제

## :pushpin: 함수 종속성(Functional Dependency)
- 한 속성의 값이 다른 속성의 값에 의해 결정될 수 있음
- 어떤 속성 A의 값을 알면 다른 속성 B의 값이 유일하게 정해지는 의존 관계
  - "속성 A는 속성 B를 결정한다."
    - `A → B` (표기)
    - A는 B의 결정자(determine)
- 함수 종속성의 종류
  1. 완전 함수 종속
      - 속성 B(종속자)가 속성 A(결정자)에 함수적으로 종속되어 있고, B의 어떤 부분 집합으로도 A를 결정할 수 없을 때
      - `A → B` 또는 `{A, B} → C`
  2. 부분 함수 종속
      - 종속자(비(非) 기본 키)가 결정자(기본 키)가 아닌 다른 속성에 종속되거나, 결정자를 구성하는 속성(복합 키) 중 일부에만 종속된 경우
      - `{A, B} → C`일 때, `A → C`가 성립하거나, `B → C`도 성립하는 경우
  3. 이행 함수 종속
      - 한 속성이 다른 속성에 간접적으로 종속되어 있는 상황
      - `A → B`, `B → C` 가 성립할 때, `A → C` 이행적 종속
  4. 결정자 함수 종속
      - 함수 종속의 결정자가 후보 키가 아닌 경우
      - `(A, B, C) : A → B, C → A`가 성립하면, A와 C 모두 결정자 두 속성 모두 후보 키가 아니고, 후보 키의 일부가 됨
  5. 다중 값 종속
      - 한 속성이 다른 속성에 대해 여러 값을 독립적으로 가질 수 있을 경우
  6. 조인 종속
      - 릴레이션을 분해했다가, 다시 결합했을 때 원래의 릴레이션으로 복원 가능한 경우

## :pushpin: 제1정규형(1NF : 1st Normal Form)
- 모든 속성이 `원자값`을 가져야 한다.
  - 원자값 : 분할이 불가능한 기본 데이터 단위
- 모든 컬럼은 유일한 이름을 가져야 한다.
- 한 컬럼 내의 모든 데이터는 같은 데이터 타입이어야 한다.
- 테이블 내 각 행(튜플)은 고유해야 하고, 고유한 식별자(기본 키)가 사용된다.

## :pushpin: 제2정규형(2NF : 2nd Normal Form)
- 릴레이션이 제1정규형을 만족해야 한다.
- 기본 키가 아닌 속성이 기본 키에 완전 함수 종속일 때 제2정규형
- (부분 함수 종속성을 제거)

## :pushpin: 제3정규형(3NF : 3rd Normal Form)
- 릴레이션이 제2정규형을 만족해야 한다.
- 기본 키가 아닌 속성이 기본 키에 비이행적으로 종속할 때 제3정규형
- `A → B, B → C, A → C`
- (이행 함수 종속성을 제거)

## :pushpin: Boyce-Codd(보이스 코드) 정규형(BCNF)
- 제3정규형의 특별한 케이스
  - 제3정규형보다 조금 더 엄격
- 릴레이션이 제3정규형을 만족해야 한다.
- 모든 결정자가 후보 키여야 한다.

## :pushpin: 정규화의 한계
- 설계 및 구현 복잡성이 증가 : 유지보수 및 실사용이 어려워진다.
- 조회 성능 저하 : 정규화를 통한 테이블 분해에서 정보를 얻기 위해 여러 테이블을 조인해야 한다. → 조인 과정에서 복잡도가 증가되고, 성능이 저하된다.

## :pushpin: 비정규화
- 비정규화
  - 정규화의 한계를 극복하기 위해 의도적으로 중복을 허용하거나, 테이블 구조를 단순화하는 과정
  - 적절하게 사용하면 성능을 향상시킬 수 있지만, 데이터 무결성 문제가 발생할 수 있다.
  - 개발자나 DBA가 비정규화 테이블을 사용하고자 하는 유혹이 있지만, 적절하고 신중하게 잘 결정해야 한다(trade-off 존재).

## :pushpin: 제4 & 5정규형(4NF & 5NF : 4th & 5th Normal Form)
- 일반적으로 제3정규형 또는 BCNF 정규형까지 정규화한다.
- 제4정규형() : 다치 종속성 제거
- 제5정규형() : 조인 종속성 제거

## :pushpin: 트랜잭션(Transaction)
- DBMS에서 데이터를 다루는 논리적 작업 단위
- 단일 SQL 문이거나, 여러 개의 SQL 문으로 작성
- 작업 단위는 모두 함께 성공적으로 완료되거나, 아무것도 수행되지 않은 상태가 되어야 한다(All Or Nothing).
- 여러 작업들이 있을 때 작업 분리 단위, 데이터 복구 작업 단위
- 예시) 은행 계좌 간에 금액을 이체하는 상황
  - A 계좌에서 B 계좌로 10,000원을 전송
    - 작업 단위
      1. A 계좌에서 10,000원 인출
      2. B 계좌에 10,000원 입금
    - 반드시 작업단위 2개가 다 성공적으로 완료되거나 아예 수행이 되지 않아야 함
- 트랜잭션의 4가지 성질(ACID)
  1. Atomicity(원자성) : 모든 작업은 하나의 단위로 처리
      - All Or Nothing → 더 이상 쪼개지지 않아야 함
  2. Consistency(일관성) : DB 상태가 작업 전후로 일관성 유지
      - 트랜잭션이 완료된 후 DB의 모든 무결성 제약조건 만족
  3. Isolation(고립성) : 각 트랜잭션은 서로 독립적
      - 각 작업단위는 서로 영향을 주지 않고, 중간 단위를 볼 수 없음
  4. Durability(지속성) : 성공적인 트랜잭션은 영구적으로 유지
      - 시스템 장애가 나더라도, 완료된 작업단위는 영구 반영되어야 함

## :pushpin: 트랜잭션 제어 언어(TCL, Transaction Control Language)
- DBMS에서 트랜잭션을 관리하는 SQ L문
  1. COMMIT : 트랜잭션 종료(변경사항 영구적 반영)
  2. ROLLBACK : 트랜잭션을 마지막 COMMIT 상태로 복원
  3. SAVEPOINT : 트랜잭션 내 중간 지점을 설정(해당 중간 지점까지 ROLLBACK 가능)
- 트랜잭션의 시작을 알리는 명령어
  - START TRANSATION
- 트랜잭션의 끝
  - COMMIT 또는 ROLLBACK → 종료
  - DDL(CREATE, ALTER, DROP, ...) 문을 만나면 자동으로 종료
- autocommit
  - SQL 문을 실행할 때 자동으로 COMMIT을 수행
  - 활성화 되어있으면 각 SQL 문이 별도의 트랜잭션으로 간주
  - 즉시 데이터베이스에 영구적인 변경을 적용

## 동시성과 락(Lock)
- 트랜잭션이 동시에 실행될 때 데이터베이스의 일관성을 해치지 않도록 데이터의 접근을 제어하는 기능
- 락(Lock)
  - 트랜잭션이 데이터를 읽거나 변경할 때 데이터에 표시하는 잠금장치
  - 다른 트랜잭션이 접근하지 못하도록 막아 대기 상태로 만든다.
- 락의 종류
  1. 공유 락(Shared Lock)
      - 여러 트랜잭션이 동시에 데이터를 읽을 수 있도록 허용
      - 공유 락이 걸린 데이터를 다른 트랜잭션도 읽을 수 있지만, 수정은 불가하다.
  2. 베타 락(Exclusive Lock)
      - 락을 건 해당 트랜잭션만 접근과 수정이 가능하다.
      - 다른 트랜잭션은 읽기, 수정이 불가하다.

## 트랜잭션 고립 수준
- 여러 트랜잭션이 동시에 DB에 접근할 때 관리 방법을 정의
- 고립 수준 종류
  1. READ UNCOMMITED
      - 가장 낮은 수준
      - 커밋되지 않은 변경사항을 다른 트랜잭션이 읽을 수 있음
      - Dirty Read 발생
  2. READ COMMITED
      - 커밋된 데이터만 읽을 수 있음
      - 다른 트랜잭션에서 데이터를 수정하고 커밋하고 현재 트랜잭션에서 다시 조회하면 다른 데이터가 읽어짐
  3. REPATABLE READ
      - MySQL의 기본 고립 수준
      - 트랜잭션이 시작되어 종료될 때까지
      - 처음 읽은 데이터의 일관성이 보장
  4. SERIALIZABLE
      - 가장 높은 고립 수준
      - 모든 트랜잭션이 순차적으로 실행되는 것 처럼 보임
- 고립 수준에 따라 성능과 데이터 일관성의 trade-off 발생
- 일반적으로 고립 수준이 높을수록 높은 일관성을 유지하지만, 동시성이 감소하고 성능에 부정적 영향을 끼친다.
- 고립 수준이 낮을수록 일관성에 문제가 발생한다.