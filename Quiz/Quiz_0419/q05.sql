USE quiz;

-- 주문이 발생할 때마다(order 테이블에 INSERT 이벤트가 발생한 이후에)
-- 자동으로 실행되는 order_logs에 기록을 남기는 트리거를 만드세요.
-- * AFTER INSERT 이벤트가 발생하는 경우 새로운 속성은 NEW.컬럼명 으로 접근합니다.

CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
	customer_name VARCHAR(100),
	order_date DATE,
	order_amount DECIMAL(10, 2)
);

CREATE TABLE order_logs (
	log_id INT AUTO_INCREMENT PRIMARY KEY,
	order_id INT,
	log_message VARCHAR(255),
	log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 1. 트리거를 생성하세요
DELIMITER //
CREATE TRIGGER order_trg 
	AFTER INSERT
    ON orders
    FOR EACH ROW
BEGIN
	INSERT INTO order_logs (order_id, log_message) VALUES (NEW.order_id, '주문');
END //
DELIMITER ;

-- 2. `orders` 테이블에 데이터를 삽입하세요.
INSERT INTO orders (customer_name, order_date, order_amount) VALUES ('홍길동', curdate(), 10000);

-- 3. `order_logs` 테이블에 자동으로 트리거가 작동하였는지 확인하세요.
SELECT * FROM orders;
SELECT * FROM order_logs;