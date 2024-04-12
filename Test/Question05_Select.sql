USE class_db;
  
-- 1. 모든 회원의 이름과 그들이 등록한 강습 클래스의 이름을 조회하세요.
SELECT m.member_name AS `회원명`, c.class_name `강의명`, t.trainer_name `담당 트레이너`
FROM member m
JOIN enrollment e ON m.member_ID = e.member_ID
JOIN class c ON e.class_ID = c.class_ID
JOIN trainer t ON c.trainer_ID = t.trainer_ID
ORDER BY m.member_name;

-- 2. 트레이너별로 담당하는 강습 클래스의 수를 조회하세요.
SELECT t.trainer_ID AS `트레이너 ID`, t.trainer_name AS `트레이너명`, count(c.class_ID) `강좌수`
FROM trainer t
JOIN class c USING (trainer_ID)
GROUP BY c.trainer_ID
ORDER BY count(c.class_ID) DESC;

-- 3. 현재 등록된 모든 강습 중에서 오전에 시작하는 강습들만 조회하세요.
SELECT class_name, class_start_time, class_end_time
FROM class WHERE class_start_time < '12:00:00'
ORDER BY class_start_time;

-- 4. 각 회원이 등록한 강습 클래스 중 가장 늦게 시작하는 클래스의 이름과 시작 시간을 조회하세요.
SELECT m.member_name, c.class_name, c.class_start_time
FROM member m
JOIN enrollment e ON m.member_ID = e.member_ID
JOIN class c ON e.class_ID = c.class_ID
ORDER BY c.class_start_time DESC
LIMIT 1;