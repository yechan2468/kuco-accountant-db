-- 행사 정보 insert
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


INSERT INTO member (name, department, gisu, student_id, phone_number)
WITH members AS (SELECT '이예찬', '소프트웨어융합학과', 20, 2019102117, 01023115288
                 FROM dual
                 UNION ALL
                 SELECT '고도규', '소프트웨어융합학과', 20, 2019100200, 01044232222
                 FROM dual)
SELECT *
FROM members;

DECLARE
    eid NUMBER;
BEGIN
    SELECT event_id
    INTO eid
    FROM event
    WHERE name = '동아리 운영'
      AND year = 2023
      AND semester = 1;

    INSERT INTO transaction (event_id, name, details)
    WITH transactions AS (SELECT eid, '이전 학기 인수인계비', ''
                          FROM dual
                          UNION ALL
                          SELECT eid, '동아리 기본지원금', ''
                          FROM dual)
    SELECT *
    FROM transactions;
END;


CREATE OR REPLACE FUNCTION get_transaction_id(
    event_id IN NUMBER, transaction_name IN VARCHAR2
)
    RETURN NUMBER
    IS
    result NUMBER;
BEGIN
    SELECT transaction_id
    INTO result
    FROM transaction t
    WHERE t.event_id = event_id
      AND t.name = transaction_name
      AND t.details IS NULL;
    RETURN result;
END;


CREATE OR REPLACE FUNCTION get_transaction_id(
    event_id IN NUMBER, transaction_name IN VARCHAR2, transaction_details IN VARCHAR2
)
    RETURN NUMBER
    IS
    result NUMBER;
BEGIN
    SELECT transaction_id
    INTO result
    FROM transaction t
    WHERE t.event_id = event_id
      AND t.name = transaction_name
      AND t.details = transaction_details;
    RETURN result;
END;


-- 동아리 인수인계비
DECLARE
    eid NUMBER;
BEGIN
    SELECT event_id
    INTO eid
    FROM event
    WHERE name = '동아리 운영'
      AND year = 2023
      AND semester = 1;

    INSERT INTO account (transaction_id, amount)
    WITH transactions AS (SELECT get_transaction_id(eid, '이전 학기 인수인계비'), 10000000
                          FROM dual
                          UNION ALL
                          SELECT get_transaction_id(eid, '동아리 기본지원금'), 350000
                          FROM dual)
    SELECT *
    FROM transactions;
END;


-- 악기 대여 보증금 입출 내역 insert
DECLARE
    eid NUMBER;
BEGIN
    SELECT event_id
    INTO eid
    FROM event
    WHERE name = '악기 대여'
      AND year = 2023
      AND semester = 1;

    INSERT INTO account_vw (event_id, transaction_name, amount, transaction_details)
    WITH transactions AS (SELECT eid, '이태권', 50000, '첼로'
                          FROM dual
                          UNION ALL
                          SELECT eid, '이정현', 50000, '바이올린'
                          FROM dual
                          UNION ALL
                          SELECT eid, '박은우', 50000, '비올라'
                          FROM dual
        -- 보증금의 경우 자동으로 학기말 보증금 환급이 되어야 함
    )
    SELECT *
    FROM transactions;
END;


-- 악기 공구 내역 insert
DECLARE
    eid NUMBER;
BEGIN
    SELECT event_id
    INTO eid
    FROM event
    WHERE name = '악기 공구'
      AND year = 2023
      AND semester = 1;

    INSERT INTO account_vw (event_id, transaction_name, amount, transaction_details)
    WITH transactions AS (SELECT eid, '박서영', 260000, '바이올린'
                          FROM dual
                          UNION ALL
                          SELECT eid, '박채원', 260000, '바이올린'
                          FROM dual
                          UNION ALL
                          SELECT eid, '김준수', 260000, '바이올린'
                          FROM dual
                          UNION ALL
                          SELECT eid, '이수민', 260000, '바이올린'
                          FROM dual
                          UNION ALL
                          SELECT eid, '이경서', 670000, '첼로'
                          FROM dual
                          UNION ALL
                          SELECT eid, '진성웅', 260000, '바이올린'
                          FROM dual
                          UNION ALL
                          SELECT eid, '양찬수 악기점', -1970000, '바이올린 5 + 첼로 1'
                          FROM dual
                          UNION ALL
                          SELECT eid, '성민지', 260000, '바이올린'
                          FROM dual
                          UNION ALL
                          SELECT eid, '양찬수 악기점', -260000, '바이올린 1'
                          FROM dual)
    SELECT *
    FROM transactions;
END;


-- 동아리 비품 구매 내역
DECLARE
    eid NUMBER;
BEGIN
    SELECT event_id
    INTO eid
    FROM event
    WHERE name = '동아리 비품'
      AND year = 2023
      AND semester = 1;

    INSERT INTO account_vw (event_id, transaction_name, amount, transaction_details, transaction_date)
    WITH transactions AS (SELECT eid, '회색 플라스틱 의자 5개', -15500, '쿠팡', TO_DATE('2023-04-16', 'YYYY-MM-DD')
                          FROM dual)
    SELECT *
    FROM transactions;
END;


-- 연주회 예산
DECLARE
    eid NUMBER;
BEGIN
    SELECT event_id
    INTO eid
    FROM event
    WHERE name = '40회 정기연주회'
      AND year = 2023
      AND semester = 1;

    INSERT INTO budget_vw (event_id, transaction_name, amount, transaction_details)
    WITH transactions AS (SELECT eid, '객원', -150000, '오보에 I'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -150000, '오보에 II'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -250000, '바순 I'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -200000, '바순 II'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -300000, '콘트라바순'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -250000, '트럼펫 I'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -150000, '트럼펫 II'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -250000, '트럼본 I'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -200000, '트럼본 II'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -300000, '호른 I'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -200000, '호른 II'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -200000, '호른 III'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -150000, '호른 IV'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -200000, '베이스 드럼'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -200000, '트라이앵글'
                          FROM dual
                          UNION ALL
                          SELECT eid, '객원', -200000, '심벌즈'
                          FROM dual
                          UNION ALL
                          SELECT eid, '콘서트홀 대관', -1200000, '미정'
                          FROM dual
                          UNION ALL
                          SELECT eid, '합창단 협연', -1000000, '벨라필콘서트필하모닉 합창단'
                          FROM dual)
    SELECT *
    FROM transactions;
END;

