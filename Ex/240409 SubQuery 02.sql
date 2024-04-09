USE sakila;

-- 문제 1. 총 결제 금액이 $100을 초과하는 모든 고객의 이름과 성을 조회하세요.
-- 사용 테이블: customer (customer_id, first_name, last_name), payment (payment_id, customer_id, amount)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment GROUP BY customer_id HAVING sum(amount) > 100)
ORDER BY first_name;

-- 문제 2. 5개 이상의 영화를 대여한 모든 고객의 이름과 성을 조회하세요.
-- 사용 테이블: customer (customer_id, first_name, last_name), rental (rental_id, customer_id)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM rental GROUP BY customer_id HAVING count(rental_id) > 5)
ORDER BY first_name;

-- 문제 3. 5편 이상의 영화에 출연한 모든 배우의 이름과 성을 조회하세요.
-- 사용 테이블: actor (actor_id, first_name, last_name), film_actor (actor_id, film_id)
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor GROUP BY actor_id HAVING count(film_id) >= 5)
ORDER BY first_name;

-- 문제 4. 평균 영화 길이보다 긴 모든 영화의 제목을 조회하세요.
-- 사용 테이블: film (film_id, title, length)
SELECT title, length
FROM film
WHERE length > (SELECT avg(length) FROM film)
ORDER BY length;

-- 문제 5. 평균 대여 비용보다 높은 대여 비용을 가진 모든 영화의 제목과 대여 비용을 조회하세요.
-- 사용 테이블: film (film_id, title, rental_rate)
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT avg(rental_rate) FROM film)
ORDER BY rental_rate;

-- 문제 6. 각 영화에 출연한 배우의 수와 함께 영화 제목을 조회하세요. (SELECT절 사용)
-- 사용 테이블: film (film_id, title), film_actor (actor_id, film_id)
SELECT title, (SELECT count(actor_id) FROM film_actor WHERE film.film_id = film_actor.film_id )
FROM film
ORDER BY film_id;

-- 문제 7. 단일 고객이 가장 많이 대여한 영화 수를 조회하세요. (FROM절 사용)
-- 사용 테이블: rental (rental_id, customer_id)
SELECT *
FROM (SELECT acount(rental_id) FROM rental GROUP BY customer_id) AS rent_count;