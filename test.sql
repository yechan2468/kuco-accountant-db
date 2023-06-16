/*===================
    DATA INSERTION
====================*/
-- EVENT TYPE
INSERT INTO event_type (event_type_name)
VALUES ('동아리 운영');
INSERT INTO event_type (event_type_name)
VALUES ('정기연주회');
INSERT INTO event_type (event_type_name)
VALUES ('뮤직캠프');
INSERT INTO event_type (event_type_name)
VALUES ('작은 연주회');
INSERT INTO event_type (event_type_name)
VALUES ('쿠코인의 밤');
INSERT INTO event_type (event_type_name)
VALUES ('멘토링');
INSERT INTO event_type (event_type_name)
VALUES ('기타');

-- EVENT
BEGIN
    FOR etid IN 1..12
        LOOP
            INSERT INTO event(event_type_id, year, semester)
            VALUES (etid, 2023, 1);
        END LOOP;
END;

-- CATEGORY
INSERT INTO category (event_id, category_name)
VALUES (1, '동아리 정기회비');
INSERT INTO category (event_id, category_name)
VALUES (1, '이전 학기 인수인계비');
INSERT INTO category (event_id, category_name)
VALUES (1, '동아리 인수인계비');
INSERT INTO category (event_id, category_name)
VALUES (1, '악기 대여');
INSERT INTO category (event_id, category_name)
VALUES (1, '악기 공구');
INSERT INTO category (event_id, category_name)
VALUES (1, '동아리 박람회');
INSERT INTO category (event_id, category_name)
VALUES (2, '회비');
INSERT INTO category (event_id, category_name)
VALUES (2, '콘서트홀 대관');
INSERT INTO category (event_id, category_name)
VALUES (2, '연습실 대관');
INSERT INTO category (event_id, category_name)
VALUES (2, '객원');
INSERT INTO category (event_id, category_name)
VALUES (2, '타악기 대여');
INSERT INTO category (event_id, category_name)
VALUES (2, '악보');
INSERT INTO category (event_id, category_name)
VALUES (2, '홍보');
INSERT INTO category (event_id, category_name)
VALUES (2, '당일 지출');
INSERT INTO category (event_id, category_name)
VALUES (3, '숙소 대여');
INSERT INTO category (event_id, category_name)
VALUES (3, '버스 대절');
INSERT INTO category (event_id, category_name)
VALUES (3, '식비');
INSERT INTO category (event_id, category_name)
VALUES (4, '뒷풀이');
INSERT INTO category (event_id, category_name)
VALUES (5, '뒷풀이');

CREATE OR REPLACE FUNCTION getcategoryidbyname(name IN VARCHAR2)
    RETURN NUMBER IS
    result NUMBER := 0;
BEGIN
    SELECT category_id
    INTO result
    FROM category
    where category_name = name;
    RETURN result;
END;

-- GUEST TYPE
INSERT INTO guest_type (guest_type_name)
VALUES ('지휘자');
INSERT INTO guest_type (guest_type_name)
VALUES ('프로');
INSERT INTO guest_type (guest_type_name)
VALUES ('아마추어');


-- MEMBER
INSERT INTO member (member_name, department, gisu, student_id, phone_number)
WITH members AS (SELECT '이예찬', '소프트웨어융합학과', 20, 2019102117, 01023115288
                 FROM dual
                 UNION ALL
                 SELECT '고도규', '소프트웨어융합학과', 20, 2019100200, 01044232222
                 FROM dual
                 UNION ALL
                 SELECT '이태권', '학과1', 21, 2020100000, 01006830577
                 FROM dual
                 UNION ALL
                 SELECT '이정현', '학과2', 21, 2020100037, 01041690869
                 FROM dual
                 UNION ALL
                 SELECT '박은우', '학과2', 21, 2020100013, 01077428089
                 FROM dual
                 UNION ALL
                 SELECT '박서영', '학과3', 22, 2021101108, 01056458479
                 FROM dual
                 UNION ALL
                 SELECT '박채원', '학과4', 22, 2021101129, 01020387446
                 FROM dual
                 UNION ALL
                 SELECT '김준수', '학과5', 22, 2018101109, 01072169759
                 FROM dual
                 UNION ALL
                 SELECT '이수민', '학과5', 22, 2021103806, 01089450046
                 FROM dual
                 UNION ALL
                 SELECT '이경서', '학과5', 23, 2022104657, 01004068844
                 FROM dual
                 UNION ALL
                 SELECT '진성웅', '학과6', 23, 2022104644, 01088578591
                 FROM dual
                 UNION ALL
                 SELECT '성민지', '학과7', 23, 2022104671, 01068336446
                 FROM dual)
SELECT *
FROM members;

-- GUEST
INSERT INTO guest (guest_type_id, guest_name, phone_number, account_number)
WITH guests AS (SELECT 0, '배재혁', 01012341234, '하나12312312312345'
                FROM dual
                UNION ALL
                SELECT 1, '프로객원1', 01012341234, '하나12312312312345'
                FROM dual
                UNION ALL
                SELECT 1, '프로객원2', 01023452345, '국민12345612123456'
                FROM dual
                UNION ALL
                SELECT 2, '아마객원1', 01034563456, '농협12345678912345'
                FROM dual
                UNION ALL
                SELECT 2, '아마객원2', 01045674567, '신한98765432101234'
                FROM dual)
SELECT *
FROM guests;

-- TRANSACTION
INSERT INTO transaction (category_id, transaction_description, transaction_amount)
WITH transactions AS (SELECT getcategoryidbyname('악기 대여'), '이태권 첼로', 50000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 대여'), '이정현 바이올린', 50000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 대여'), '박은우 비올라', 50000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 공구'), '박서영 바이올린', 260000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 공구'), '박채원 바이올린', 260000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 공구'), '김준수 바이올린', 260000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 공구'), '이수민 바이올린', 260000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 공구'), '이경서 첼로', 670000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 공구'), '진성웅 바이올린', 260000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 공구'), '양찬수 악기점: 바이올린 5 + 첼로 1', -1970000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 공구'), '성민지 바이올린', 260000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('악기 공구'), '양찬수 악기점: 바이올린 1', -260000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('동아리 비품'), '회색 플라스틱 의자 5개', '쿠팡'
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('이전 학기 인수인계비'), '', 3000000
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('동아리 기본지원금'), '', 350000
                      FROM dual)
SELECT *
FROM transactions;


-- BUDGET
INSERT INTO budget (category_id, budget_description, budget_amount, budget_date)
WITH transactions AS (SELECT getcategoryidbyname('객원'), '오보에 I', -150000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '오보에 II', -150000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '바순 I', -2500000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '바순 II', -200000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '콘트라바순', -300000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '트럼펫 I', -250000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '트럼펫 II', -150000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '트럼본 I', -250000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '트럼본 II', -200000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '호른 I', -300000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '호른 II', -200000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '호른 III', -200000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '호른 IV', -150000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '베이스 드럼', -200000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '트라이앵글', -200000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '심벌즈', -200000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('콘서트홀 대관'), '', -1200000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual
                      UNION ALL
                      SELECT getcategoryidbyname('객원'), '벨라필하모닉합창단', -1400000, TO_DATE('20230909', 'YYYYMMDD')
                      FROM dual)
SELECT *
FROM transactions;

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