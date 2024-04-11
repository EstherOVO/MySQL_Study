USE sakila;

-- 문제 1 : film 테이블에서 길이(length)가 120분 이상인 영화의 제목(title)과 길이를 조회하되, '긴 영화', '짧은 영화'로 분류하세요. 
SELECT title, IF (length >= 120, '긴 영화', '짧은 영화') FROM film ORDER BY title;

-- 문제 2 : actor 테이블에서 첫 번째 이름(first_name)과 성(last_name)을 합쳐서 전체 이름을 조회하세요.
SELECT concat_ws(' ', first_name, last_name) FROM actor;

-- 문제 3 : film 테이블에서 영화 제목(title)의 길이를 조회하세요.
SELECT title, length(title) FROM film;

-- 문제 4 : rental 테이블에서 각 대여에 대한 대여 시작일(rental_date)과 반납 예정일(return_date) 사이의 일수를 계산하세요. 
SELECT datediff(return_date, rental_date) FROM rental;

-- 문제 5 : payment 테이블에서 모든 결제 금액을 달러 자리까지 반올림하여 조회하세요.
SELECT round(sum(amount)) FROM payment;

-- 문제 6 : 모든 영화 제목에서 공백을 '-'로 변환하세요. 
SELECT replace(title, ' ', '-') FROM film;

-- 문제 7 : customer 테이블에서 last_update 필드의 날짜를 'YYYY-MM-DD' 형식으로 조회하세요.
SELECT date_format(last_update, '%Y-%m-%d') FROM customer;

-- 문제 8 : film 테이블에서 description의 첫 50자만을 조회하세요. 만약 description이 50자보다 짧다면, 원래의 description을 그대로 조회하세요. 
SELECT substring(description, 1, 50) FROM film;