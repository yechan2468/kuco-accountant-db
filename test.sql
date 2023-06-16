/*===================
    DATA INSERTION
====================*/
-- EVENT
INSERT INTO event (name, year, semester)
WITH events AS (SELECT '동아리 정기회비', 2023, 1
                FROM dual
                UNION ALL
                SELECT '악기 대여', 2023, 1
                FROM dual
                UNION ALL
                SELECT '악기 공구', 2023, 1
                FROM dual
                UNION ALL
                SELECT '멘토링', 2023, 1
                FROM dual
                UNION ALL
                SELECT '동아리 비품', 2023, 1
                FROM dual
                UNION ALL
                SELECT '동아리 박람회', 2023, 1
                FROM dual
                UNION ALL
                SELECT '동아리 운영', 2023, 1
                FROM dual
                UNION ALL
                SELECT '작은 연주회', 2023, 1
                FROM dual
                UNION ALL
                SELECT '작은 연주회 뒷풀이', 2023, 1
                FROM dual
                UNION ALL
                SELECT '40회 정기연주회', 2023, 1
                FROM dual
                UNION ALL
                SELECT '기타', 2023, 1
                FROM dual)
SELECT *
FROM events;

-- MEMBER
INSERT INTO member (name, department, gisu, student_id, phone_number)
WITH members AS (SELECT '이예찬', '소프트웨어융합학과', 20, 2019102117, 01023115288 FROM dual UNION ALL
                 SELECT '고도규', '소프트웨어융합학과', 20, 2019100200, 01044232222 FROM dual UNION ALL
                 SELECT '이태권', '학과1', 21, 2020100000, 01006830577 FROM dual UNION ALL
                 SELECT '이정현', '학과2', 21, 2020100037, 01041690869 FROM dual UNION ALL
                 SELECT '박은우', '학과2', 21, 2020100013, 01077428089 FROM dual UNION ALL
                 SELECT '박서영', '학과3', 22, 2021101108, 01056458479 FROM dual UNION ALL
                 SELECT '박채원', '학과4', 22, 2021101129, 01020387446 FROM dual UNION ALL
                 SELECT '김준수', '학과5', 22, 2018101109, 01072169759 FROM dual UNION ALL
                 SELECT '이수민', '학과5', 22, 2021103806, 01089450046 FROM dual UNION ALL
                 SELECT '이경서', '학과5', 23, 2022104657, 01004068844 FROM dual UNION ALL
                 SELECT '진성웅', '학과6', 23, 2022104644, 01088578591 FROM dual UNION ALL                
                 SELECT '성민지', '학과7', 23, 2022104671, 01068336446 FROM dual
                 )
SELECT *
FROM members;

-- GUEST
INSERT INTO guest (type, name, phone_number, account)
WITH guests AS (
    SELECT 'amateur', '객원1', 01012341234, '하나12312312312345' FROM dual UNION ALL
    SELECT 'amateur', '객원2', 01023452345, '국민12345612123456' FROM dual UNION ALL
    SELECT 'pro', '객원3', 01034563456, '농협12345678912345' FROM dual UNION ALL
    SELECT 'conductor', '객원4', 01045674567, '신한98765432101234' FROM dual
    )
SELECT * FROM guests;

-- TRANSACTION
INSERT INTO transaction (event_id, name, details)
WITH transactions AS (
    -- event_id=2 : 악기 대여
    SELECT 2, '이태권', '첼로' FROM dual UNION ALL
    SELECT 2, '이정현', '바이올린' FROM dual UNION ALL
    SELECT 2, '박은우', '비올라' FROM dual UNION ALL
    -- event_id=3 : 악기 공구
    SELECT 3, '박서영', '바이올린' FROM dual UNION ALL
    SELECT 3, '박채원', '바이올린' FROM dual UNION ALL
    SELECT 3, '김준수', '바이올린' FROM dual UNION ALL
    SELECT 3, '이수민', '바이올린' FROM dual UNION ALL
    SELECT 3, '이경서', '첼로' FROM dual UNION ALL
    SELECT 3, '진성웅', '바이올린' FROM dual UNION ALL
    SELECT 3, '양찬수 악기점', '바이올린 5 + 첼로 1' FROM dual UNION ALL
    SELECT 3, '성민지', '바이올린' FROM dual UNION ALL
    SELECT 3, '양찬수 악기점', '바이올린 1' FROM dual UNION ALL
    -- event_id=5 : 동아리 비품
    SELECT 3, '회색 플라스틱 의자 5개', '쿠팡' FROM dual UNION ALL
    -- event_id=7 : 동아리 운영
    SELECT 7, '이전 학기 인수인계비', '' FROM dual UNION ALL
    SELECT 7, '동아리 기본지원금', '' FROM dual UNION ALL
    -- event_id=10 : 40회 정기연주회
    SELECT 10, '객원', '오보에 I' FROM dual UNION ALL   -- 16
    SELECT 10, '객원', '오보에 II' FROM dual UNION ALL
    SELECT 10, '객원', '바순 I' FROM dual UNION ALL
    SELECT 10, '객원', '바순 II' FROM dual UNION ALL
    SELECT 10, '객원', '콘트라바순' FROM dual UNION ALL
    SELECT 10, '객원', '트럼펫 I' FROM dual UNION ALL
    SELECT 10, '객원', '트럼펫 II' FROM dual UNION ALL
    SELECT 10, '객원', '트럼본 I' FROM dual UNION ALL
    SELECT 10, '객원', '트럼본 II' FROM dual UNION ALL
    SELECT 10, '객원', '호른 I' FROM dual UNION ALL
    SELECT 10, '객원', '호른 II' FROM dual UNION ALL
    SELECT 10, '객원', '호른 III' FROM dual UNION ALL
    SELECT 10, '객원', '호른 IV' FROM dual UNION ALL
    SELECT 10, '객원', '베이스 드럼' FROM dual UNION ALL
    SELECT 10, '객원', '트라이앵글' FROM dual UNION ALL
    SELECT 10, '객원', '심벌즈' FROM dual UNION ALL
    SELECT 10, '콘서트홀 대관', '미정' FROM dual UNION ALL
    SELECT 10, '합창단 협연', '벨라필콘서트필하모닉 합창단' FROM dual
)
SELECT * FROM transactions;

-- ACCOUNT
INSERT INTO account (transaction_id, amount, transaction_date)
WITH accounts AS (
    ---- 악기 대여
    -- 이태권
    SELECT 1, 50000, NULL FROM dual UNION ALL
    -- 이정현
    SELECT 2, 50000, NULL FROM dual UNION ALL
    -- 박은우
    SELECT 3, 50000, NULL FROM dual UNION ALL
    ---- 악기 공구
    -- 박서영
    SELECT 4, 260000, NULL FROM dual UNION ALL
    -- 박채원
    SELECT 5, 260000, NULL FROM dual UNION ALL
    -- 김준수
    SELECT 6, 260000, NULL FROM dual UNION ALL
    -- 이수민
    SELECT 7, 260000, NULL FROM dual UNION ALL
    -- 이경서
    SELECT 8, 670000, NULL FROM dual UNION ALL
    -- 진성웅
    SELECT 9, 260000, NULL FROM dual UNION ALL
    -- 양찬수 악기점
    SELECT 10, -1970000, NULL FROM dual UNION ALL
    -- 성민지
    SELECT 11, 260000, NULL FROM dual UNION ALL
    -- 양찬수 악기점
    SELECT 12, -260000, NULL FROM dual UNION ALL
    ---- 동아리 비품
    SELECT 13, -15500, TO_DATE('2023-04-16', 'YYYY-MM-DD') FROM dual UNION ALL
    -- 이전 학기 인수인계비
    SELECT 14, 10000000, NULL FROM dual UNION ALL
    -- 동아리 기본지원금
    SELECT 15, 350000, NULL FROM dual
)
SELECT * FROM accounts;

-- BUDGET
INSERT INTO budget (transaction_id, amount, transaction_date)
WITH budgets AS (
    ---- 40회 정기연주회
    SELECT 16, -150000, NULL FROM dual UNION ALL
    SELECT 17, -150000, NULL FROM dual UNION ALL
    SELECT 18, -250000, NULL FROM dual UNION ALL
    SELECT 19, -200000, NULL FROM dual UNION ALL
    SELECT 20, -300000, NULL FROM dual UNION ALL
    SELECT 21, -250000, NULL FROM dual UNION ALL
    SELECT 22, -150000, NULL FROM dual UNION ALL
    SELECT 23, -250000, NULL FROM dual UNION ALL
    SELECT 24, -200000, NULL FROM dual UNION ALL
    SELECT 25, -300000, NULL FROM dual UNION ALL
    SELECT 26, -200000, NULL FROM dual UNION ALL
    SELECT 27, -200000, NULL FROM dual UNION ALL
    SELECT 28, -150000, NULL FROM dual UNION ALL
    SELECT 29, -200000, NULL FROM dual UNION ALL
    SELECT 30, -200000, NULL FROM dual UNION ALL
    SELECT 31, -200000, NULL FROM dual UNION ALL
    SELECT 32, -1200000, NULL FROM dual UNION ALL
    SELECT 33, -1000000, NULL FROM dual
)
SELECT * FROM budgets;

--FEE
BEGIN
    INSERT INTO fee (member_id, transaction_id) VALUES (3, 1);
    INSERT INTO fee (member_id, transaction_id) VALUES (4, 2);
    INSERT INTO fee (member_id, transaction_id) VALUES (5, 3);
    INSERT INTO fee (member_id, transaction_id) VALUES (6, 4);
    INSERT INTO fee (member_id, transaction_id) VALUES (7, 5);
    INSERT INTO fee (member_id, transaction_id) VALUES (8, 6);
    INSERT INTO fee (member_id, transaction_id) VALUES (9, 7);
    INSERT INTO fee (member_id, transaction_id) VALUES (10, 8);
    INSERT INTO fee (member_id, transaction_id) VALUES (11, 9);
    INSERT INTO fee (member_id, transaction_id) VALUES (12, 11);
END;

-- GUEST PAY
BEGIN
    INSERT INTO guest_pay (guest_id, transaction_id) VALUES (1, 16);
    INSERT INTO guest_pay (guest_id, transaction_id) VALUES (2, 17);
END;

-- PARTICIPATION LIST
BEGIN
    INSERT INTO participation_list (member_id, event_id) VALUES (1, 10);
    INSERT INTO participation_list (member_id, event_id) VALUES (2, 10);
    INSERT INTO participation_list (member_id, event_id) VALUES (3, 10);
    INSERT INTO participation_list (member_id, event_id) VALUES (4, 10);
    INSERT INTO participation_list (member_id, event_id) VALUES (5, 10);
    INSERT INTO participation_list (member_id, event_id) VALUES (6, 10);
    INSERT INTO participation_list (member_id, event_id) VALUES (7, 10);
    INSERT INTO participation_list (member_id, event_id) VALUES (8, 10);
    INSERT INTO participation_list (member_id, event_id) VALUES (9, 10);
    INSERT INTO participation_list (member_id, event_id) VALUES (10, 10);
    INSERT INTO participation_list (member_id, event_id) VALUES (11, 10);
END;