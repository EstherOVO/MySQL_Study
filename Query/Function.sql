-- 사용자 정의 변수
SET @myVariable1 = 5;
SET @myVariable2 = 3;
SELECT @myVariable1;
SELECT @myVariable1 + @myVariable2;

-- 내장함수
-- 1. 제어흐름 함수
-- 1) IF : 조건 → 참일 때, 거짓일 때
SELECT IF (100 > 200, '참', '거짓');

-- 2) CASE : 다양한 조건 평가 → 다중 분기
SET @myNumber = 1;	-- 평가할 값
SELECT CASE @myNumber
	WHEN 1 THEN '일'
    WHEN 2 THEN '이'
    WHEN 3 THEN '삼'
    ELSE '기타 등등'
END AS 'CASE문 결과';

-- 3) ifnull : 첫 번째 인자가 null인 경우 두 번째 인자 반환, 아닐 경우 첫 번째 인자 반환
SET @myValue = NULL;
SELECT ifnull(@myValue1, '널'), ifnull(1, '널');

-- 4) nullif : 두 인자가 같으면 null, 다르면 인자1 반환
SELECT nullif(100, 100), nullif(200, 100);

-- ---------------------------------------

-- 2. 문자열 함수
-- 1) concat : 두 개 이상의 문자열을 결합
SELECT concat('hello', ', ', 'mySQL', '!');

-- 2) concat_ws : 구분자를 포함해서 결합(첫 번째 인자가 구분자)
SELECT concat_ws('-', '2024', '04', '11');
SELECT concat_ws('/', '2024', '04', '11');

-- 3) substring : 문자열의 특정 부분 추출(자바와 다른 점은 자바는 인덱스가 0부터 시작, mySQL은 1부터 시작)
SELECT substring("Hello, mySQL", 1, 5);

-- 4) left / right : 왼쪽에서부터 추출 / 오른쪽에서부터 추출
SELECT left('Hello, mySQL', 5);
SELECT right('Hello, mySQL', 5);

-- 5) length : 문자열의 길이
SELECT length('Hello, mySQL');
SELECT length('안녕하세요');	-- 한글은 한 글자마다 길이가 3씩 인식(3 * 5 = 15)
SELECT char_length('안녕하세요');	-- byte에 상관없이 문자열 개수 반환

-- 6) replace : 문자열에서 특정 부분을 다른 문자열로 대체
SELECT replace('안녕하세요.', '안녕', '평안');

-- 7) trim : 문자열 시작과 끝의 공백 제거(중간 공백은 제거 안 됨)
SELECT trim('       안녕하세요       ');	-- 양쪽 공백 제거
SELECT ltrim('       안녕하세요       ');	-- 왼쪽 공백 제거
SELECT rtrim('       안녕하세요       ');	-- 오른쪽 공백 제거

-- 8) upper / lower : 대문자 / 소문자 변환
SELECT upper('Hello, mySQL!');
SELECT lower('Hello, mySQL!');

-- 9) lpad / rpad : 빈 곳을 문자열로 채움(문자열, 길이, 채울 문자열)
SELECT lpad('안녕하세요', 7, '#');
SELECT rpad('안녕하세요', 7, '#');

-- 10) repaet : 문자열을 횟수만큼 반복
SELECT repeat('안녕', 5);

-- 11) reverse : 문자열을 뒤집음
SELECT reverse('안녕하세요');

-- 12) space : 공백을 반환
SELECT concat('안녕', space(10), '하세요.');

-- 13) format : 숫자를 1000 단위마다 콤마 표시 → 소수점 자릿수 표현(숫자, 소수점 자릿수)
SELECT format(10000000.123456, 3);

-- 14) bin, hex, oct : 각각 2진수, 16진수, 8진수
SELECT bin(10), hex(10), oct(10), 10;

-- ---------------------------------------

-- 3. 수학 함수
-- 1) abs : 절대값
SELECT abs(100), abs(-100);

-- 2) ceil / floor / round : 올림 / 내림 / 반올림
SELECT ceil(23.4), floor(23.4), round(23.4), round(23.5);

-- 3) pow(숫자, 거듭제곱 수) : 거듭제곱
SELECT pow(2, 10), power(2, 10);

-- 4) sqrt(숫자) : 제곱근
SELECT sqrt(16);

-- 5) rand : 0이상 1미만 랜덤 수를 반환
SELECT rand(), floor(1 + rand() * 6);	-- 1 ~ 6까지 정수를 구하고 싶을 때

-- 6) mod(숫자, 나눌 숫자) : 나머지 연산
SELECT mod(10, 3);

-- 7) log / log10 : 자연로그 / 상용로그
SELECT log(2.71828), log10(100);

-- 8) pi : 원주율
SELECT pi();

-- 9) conv(숫자, 이전 진수, 변환할 진수) : 진법변환
SELECT conv(10, 10, 2), conv(1010, 2, 10), conv('A', 16, 2);

-- ---------------------------------------

-- 4. 날짜 및 시간 함수
-- 1) now : 현재 날짜 시간 반환
-- curdate(= current_date) / curtime(= current_time) : 현재 날짜 / 현재 시간만 반환
SELECT now(), curdate(), current_date(), curtime(), current_time();

-- 2) date : 날짜-시간 값에서 날짜만
-- time : 날짜-시간 값에서 시간만
SELECT date('2024-04-11 10:42:22'), time('2024-04-11 10:42:22');

-- 3) year, month, day / hour, minute, second : 연월일 / 시분초
SELECT year(now()), month(now()), day(now());
SELECT hour(now()), minute(now()), second(now());

-- 4) date_format(날짜시간, '포맷')
SELECT date_format(now(), '%Y년-%m월-%d일 %H시 %i분 %s초');

-- 5) datediff(날짜1, 날짜2) : 두 날짜 간의 차이 반환
-- timediff(시간1, 시간2) : 두 시간 간의 차이 반환
SELECT datediff('2024-04-11', '2023-12-25');
SELECT timediff('11:04:00', '16:30:00');

-- 6) last_day(날짜) : 그 달의 마지막 날짜를 구함
SELECT last_day('2024-02-01'), last_day('2025-02-01');

-- 7) weekday(날짜) : 요일 반환(월요일이 0 ~ 주일이 6)
SELECT weekday(now());		-- 월요일이 0부터 시작
SELECT dayofweek(now());	-- 주일이 1부터 시작

-- 8) adddate(날짜, 차이) : 날짜를 더한 날짜를 반환 ↔ subdate
SELECT adddate(now(), INTERVAL 100 DAY);	-- 오늘부터 100일을 더한 날짜
SELECT subdate(now(), INTERVAL 100 DAY);	-- 오늘부터 100일을 뺀 날짜

-- 9) addtime(날짜 시간, 시간) : 해당 날짜시간 기준으로 시간을 더한 결과 반환
SELECT addtime(now(), '20:30:30');
SELECT subtime(now(), '20:30:30');

-- 10) quater(날짜) : 4분기 중 몇 분기인지 반환
SELECT quarter(now());

-- 11) time_to_sec(시간) : 시간을 초 단위로 반환
SELECT time_to_sec('02:30:00');

-- ---------------------------------------

-- 5. 시스템 정보 함수
-- 1) version : 현재 mySQL 버전
SELECT version();

-- 2) user : 현재 사용자 이름과 호스트명
SELECT user();

-- 3) database : 현재 사용 중인 데이터베이스(스키마) 이름을 반환
SELECT database();

-- 4) connection_id : 현재 연결에 할당하는 고유 식별번호 반환
SELECT connection_id();

-- 5) sleep : 쿼리의 실행을 n초 간 멈춘다.
SELECT sleep(3);
SELECT '3초 후에 보여요.';

-- 6) 시스템 변수 : @@시스템변수이름
SELECT @@autocommit, @@max_connections;

-- 공식 문서 참조 : https://dev.mysql.com/doc/refman/8.0/en/functions.html