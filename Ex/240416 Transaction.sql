-- TCL 활용 연습문제
USE tcl;

-- 다음 테이블을 생성하고, TCL을 활용하여 트랜잭션 연습하세요.

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2)
);

INSERT INTO products (product_name, quantity, price)
VALUES ('Laptop', 10, 990.00),
('Phone', 20, 290.00),
('Tablet', 15, 450.00);

SELECT @@transaction_isolation;

/* 연습 문제 1 : 가격 업데이트 및 재고 감소

- 모든 제품의 가격을 10% 인상하세요. 
- 'Phone'의 재고를 5개 감소시키세요
- 트랜잭션을 커밋하여 변경사항을 확정하세요. */

SELECT * FROM products;

START TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

UPDATE products SET price = price + (price * 0.1);
UPDATE products SET quantity = quantity - 5 WHERE product_name LIKE 'Phone';

COMMIT;

SELECT * FROM products;

/* 연습문제 2 : SAVEPOINT와 ROLLBACK

- 'Phone'의 가격을 15% 인상하세요.
- 이후 SAVEPOINT를 설정하세요.
- 'Tablet'의 재고를 10개 감소시키세요.
- 'Tablet' 재고 감소 후 문제가 발생했다고 가정하고 
- SAVEPOINT 이후의 변경 사항을 롤백하세요.
- 반영된 트랜잭션을 커밋하여 변경사항을 확정하세요. */

SELECT * FROM products;

START TRANSACTION;

UPDATE products SET price = price + (price * 0.15) WHERE product_name LIKE 'Phone';
SAVEPOINT spoint;

UPDATE products SET quantity = quantity - 10 WHERE product_name = 'Tablet';

ROLLBACK TO spoint;

COMMIT;