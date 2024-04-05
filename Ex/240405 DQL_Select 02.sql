-- world 데이터베이스에서 문제를 풀어보세요.
USE world;

-- 문제 1 : Country 테이블에서 모든 국가의 이름(Name)과 대륙(Continent)을 조회하세요.
SELECT Name, Continent From country;
SELECT * FROM CountryLanguage;
SELECT * From country;
SHOW CREATE TABLE CountryLanguage;

-- 문제 2 : City 테이블에서 도시 이름(Name)이 'Seoul', 'Tokyo', 'New York'인 도시의 모든 정보를 조회하세요.
SELECT * FROM city WHERE Name IN ('Seoul', 'Tokyo', 'New York');

-- 문제 3 : Country 테이블에서 인구(Population)가 100000000 이상인 국가의 이름(Name), 대륙(Continent), 인구(Population)를 조회하세요.
SELECT Name, Continent, Population FROM country WHERE Population >= 100000000;

-- 문제 4 : Country 테이블에서 국가의 독립 연도(IndepYear)가 1900년 이후인 국가의 이름(Name)과 독립 연도(IndepYear)를 조회하세요.
SELECT Name, IndepYear FROM country WHERE IndepYear >= 1900;

-- 문제 5 : CountryLanguage 테이블에서 'French'를 공식 언어(Official Language)로 사용하는 국가의 국가 코드(CountryCode)와 언어(Language)를 조회하세요.
-- 공식 언어 여부는 'IsOfficial' 열을 참조하세요.
SELECT CountryCode, Language FROM countrylanguage WHERE Language = 'French' AND IsOfficial = 'T';

-- 문제 6 : Country 테이블에서 'Europe' 대륙에 속하며 인구가 50000000 이상인 국가의 이름(Name)과 인구(Population)를 조회하세요.
SELECT Name, Population FROM country WHERE Continent = 'Europe' AND Population >= 50000000;

-- 문제 7 : City 테이블에서 인구(Population)가 8000000 이상인 도시의 이름(Name), 국가 코드(CountryCode), 인구(Population)를 조회하세요.
SELECT Name, CountryCode, Population FROM city WHERE Population >= 8000000;

-- 문제 8: CountryLanguage 테이블에서 'English'를 공식 언어로 사용하지 않는 국가의 국가 코드(CountryCode)와 언어(Language)를 조회하세요.
-- 단, 언어 사용 비율(Percentage)이 50% 이상인 경우만 포함하세요.
SELECT CountryCode, Language FROM countrylanguage WHERE NOT (Language = 'English' AND IsOfficial = 'T') AND Percentage >= 50.0;

-- 문제 9 : Country 테이블에서 GNP가 200000 이상이며 생명 기대치(LifeExpectancy)가 75 이상인 국가의 이름(Name), GNP, 생명 기대치(LifeExpectancy)를 조회하세요.
SELECT Name, GNP, LifeExpectancy FROM country WHERE GNP >= 200000 AND LifeExpectancy >= 75.0;

-- 문제 10 : Country 테이블에서 정부 형태(GovernmentForm)가 'Republic'을 포함하며,
-- 독립 연도(IndepYear)가 1900년 이전인 국가의 이름(Name)과 정부 형태(GovernmentForm), 독립 연도(IndepYear)를 조회하세요.
SELECT Name, GovernmentForm, IndepYear FROM country WHERE GovernmentForm LIKE '%Republic%' AND IndepYear < 1900;

-- 문제 11 : Country 테이블에서 'Asia', 'Africa', 'Europe' 대륙에 속하는 국가의 이름(Name), 대륙(Continent), 인구(Population)를 조회하세요.
SELECT Name, Continent, Population FROM country WHERE Continent IN ('Asia', 'Africa', 'Europe');

-- 문제 12 : City 테이블에서 도시 이름(Name)이 'S'로 시작하고, 인구(Population)가 1000000 이상인 도시의 이름(Name), 국가 코드(CountryCode), 인구(Population)를 조회하세요.
SELECT Name, CountryCode, Population FROM city WHERE Name LIKE 'S%' AND Population >= 1000000;