USE world;

-- 문제 1 : country 테이블에서 각 대륙(Continent)별 국가 수를 계산하세요.
SELECT Continent, count(Continent) FROM country GROUP BY Continent;

-- 문제 2 : country 테이블에서 각 대륙별 총 인구수(Population)를 계산하고, 총 인구수가 많은 대륙부터 내림차순으로 정렬하세요.
SELECT Continent, sum(Population) FROM country GROUP BY Continent ORDER BY sum(Population) DESC;

-- 문제 3 : city 테이블에서 각 국가 코드(CountryCode)별로 가장 인구가 많은 도시의 인구수를 조회하세요. 상위 5개 결과만 보여주세요.
 SELECT CountryCode, sum(Population) FROM city GROUP BY CountryCode ORDER BY sum(Population) DESC LIMIT 5;
 
-- 문제 4 : countrylanguage 테이블에서 각 언어(Language)가 사용되는 국가 수를 계산하고, 가장 많이 사용되는 언어부터 내림차순으로 정렬하여 상위 3개 언어를 조회하세요.
SELECT Language, count(Language) FROM countrylanguage GROUP BY Language ORDER BY count(Language) DESC LIMIT 3;

-- 문제 5 : country 테이블에서 모든 국가의 총 인구수(Population)를 계산하세요.
SELECT sum(Population) FROM country;

-- 문제 6 : country 테이블에서 GDP(국내 총생산, GNP * Population)가 가장 높은 상위 5개 국가를 조회하세요.
SELECT Name, sum(GNP * Population) FROM country GROUP BY Name ORDER BY sum(GNP * Population) DESC LIMIT 5;

-- 문제 7 : country 테이블에서 정부 형태(GovernmentForm)별 평균 생명 기대치(LifeExpectancy)를 계산하고, 생명 기대치가 높은 순으로 정렬하세요.
SELECT GovernmentForm, round(avg(LifeExpectancy), 2) FROM country GROUP BY GovernmentForm ORDER BY round(avg(LifeExpectancy), 2) DESC;

-- 문제 8 : country 테이블에서 각 대륙별로 평균 인구수가 5000만 이상인 대륙과 해당 평균 인구수를 조회하세요.
SELECT Continent, round(avg(Population), 2) FROM country GROUP BY Continent HAVING round(avg(Population), 2) >= 50000000;

-- 문제 9 : countrylanguage 테이블에서 언어별로 사용하는 국가 수가 5개 이상인 언어와 해당 국가 수를 조회하세요.
SELECT Language, count(Language) FROM countrylanguage GROUP BY Language HAVING count(Language) >= 5;

-- 문제 10 : country 테이블에서 각 대륙별로 총 GNP가 100만 이상인 대륙과 해당 총 GNP를 조회하세요.
SELECT Continent, sum(GNP) FROM country GROUP BY Continent HAVING sum(GNP) >= 1000000;

-- 문제 11 : country 테이블에서 대륙(Continent)과 정부 형태(GovernmentForm)별로 국가 수를 집계하고, 
-- 대륙별 국가 수 및 전체 국가 수를 포함한 결과를 조회하세요.
SELECT Continent, GovernmentForm, count(Name) FROM country GROUP BY Continent, GovernmentForm WITH ROLLUP;