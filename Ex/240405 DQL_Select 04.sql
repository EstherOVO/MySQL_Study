-- world 데이터베이스 사용하세요.
USE world;

-- 문제 1 : Country 테이블에서 국가의 이름(Name)과 수도(Capital)를 조회하세요. 단, 이름 컬럼의 이름은 '나라' 수도의 컬럼 이름을 '수도'로 표시하세요.
SELECT Name AS '나라', Capital AS '수도' FROM Country;

-- 문제 2 : City 테이블에서 인구가 1백만 이상인 도시들을 인구 순서대로 내림차순으로 정렬하여 상위 10개 도시의 이름(Name)과 인구(Population)를 조회하세요.
SELECT Name, Population FROM city WHERE Population > 1000000 ORDER BY Population DESC LIMIT 10;

-- 문제 3 : Country 테이블에서 'Asia' 대륙에 속한 국가들을 GNP가 높은 순서대로 내림차순 정렬하여 상위 5개 국가의 이름(Name)과 GNP를 조회하세요.
SELECT Name, GNP FROM country WHERE Continent = 'Asia' ORDER BY GNP DESC LIMIT 5;

-- 문제 4 : CountryLanguage 테이블에서 'English'를 공식 언어로 사용하는 국가의 국가 코드(CountryCode)를 조회하세요. 단, 공식 언어 여부는 'IsOfficial' 컬럼을 사용하세요.
SELECT CountryCode FROM countrylanguage WHERE LANGUAGE = 'English' AND IsOfficial = 'T';

-- 문제 5 : Country 테이블에서 인구가 5천만 이상 1억 미만인 국가들을 인구 순서대로 오름차순 정렬하여 국가의 이름(Name)과 인구(Population)를 조회하세요.
SELECT Name, Population FROM country WHERE Population BETWEEN 50000000 AND 100000000 ORDER BY Population;

-- 문제 6 : Country 테이블에서 생명 기대치(LifeExpectancy)가 80 이상인 국가들의 이름(Name)과 생명 기대치를 조회하세요. 결과를 생명 기대치가 낮은 순으로 오름차순 정렬하세요.
SELECT Name, LifeExpectancy FROM country WHERE LifeExpectancy >= 80 ORDER BY LifeExpectancy;

-- 문제 7 : Country 테이블에서 정부 형태(GovernmentForm)가 'Republic'인 국가들을 국가 이름(Name)으로 알파벳순으로 정렬하여 조회하세요.
SELECT * FROM country WHERE GovernmentForm LIKE '%Republic%' ORDER BY Name;

-- 문제 8 : Country 테이블에서 대륙(Continent)을 기준으로 고유한 대륙 이름을 조회하세요.
SELECT DISTINCT Continent FROM country; 

-- 문제 9 : CountryLanguage 테이블에서 고유한 언어(Language) 목록을 조회하세요.
SELECT DISTINCT Language FROM countrylanguage;

-- 문제 10 : Country 테이블에서 대륙(Continent) 순으로 고유한 정부 형태(GovernmentForm)를 조회하세요.
SELECT DISTINCT GovernmentForm FROM country ORDER BY Continent;