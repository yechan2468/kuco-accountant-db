CREATE OR REPLACE VIEW budget_vw AS
SELECT et.event_type_name   AS event,
       c.category_name      AS category,
       b.budget_description AS description,
       b.budget_amount      AS amount,
       b.budget_date        AS "date"
FROM budget b
         JOIN category c ON b.category_id = c.category_id
         JOIN event e ON c.event_id = e.event_id
         JOIN event_type et ON e.event_type_id = et.event_type_id;


CREATE OR REPLACE VIEW current_transaction_vw AS
SELECT et.event_type_name        AS event,
       c.category_name           AS category,
       t.transaction_description AS description,
       t.transaction_amount      AS amount,
       t.transaction_date        AS "date"
FROM transaction t
         JOIN category c ON t.category_id = c.category_id
         JOIN event e ON c.event_id = e.event_id
         JOIN event_type et ON e.event_type_id = et.event_type_id
WHERE t.transaction_date
          <= SYSDATE;


CREATE OR REPLACE VIEW expected_transaction_vw AS
SELECT et.event_type_name        AS event,
       c.category_name           AS category,
       t.transaction_description AS description,
       t.transaction_amount      AS amount,
       t.transaction_date        AS "date"
FROM transaction t
         JOIN category c ON t.category_id = c.category_id
         JOIN event e ON c.event_id = e.event_id
         JOIN event_type et ON e.event_type_id = et.event_type_id;


CREATE OR REPLACE VIEW balance_vw AS
SELECT DISTINCT (SELECT SUM(t.transaction_amount)
                 FROM transaction t
                 WHERE t.transaction_date <= SYSDATE) AS balance,
                (SELECT SUM(t.transaction_amount)
                 FROM transaction t)                  AS expected_balance
FROM transaction;


CREATE OR REPLACE VIEW budget_transaction_comparison_vw AS
SELECT event,
       category,
       SUM(budget_amount)                           AS budget_amount,
       SUM(transaction_amount)                      AS transaction_amount,
       SUM(transaction_amount) - SUM(budget_amount) AS gap
FROM (SELECT et.event_type_name   AS event,
             c.category_name      AS category,
             b.budget_amount      AS budget_amount,
             t.transaction_amount AS transaction_amount
      FROM category c
               JOIN transaction t ON c.category_id = t.category_id
               FULL OUTER JOIN budget b ON c.category_id = b.category_id
               FULL OUTER JOIN event e ON c.event_id = e.event_id
               JOIN event_type et ON et.event_type_id = e.event_type_id)
GROUP BY event, category;


CREATE OR REPLACE VIEW member_vw AS
SELECT member_name AS name,
       department  AS department,
       gisu        AS gisu
FROM member;


CREATE OR REPLACE VIEW guest_vw AS
SELECT guest_name         AS name,
       gt.guest_type_name AS type,
       phone_number       AS phone_number,
       account_number     AS account_number
FROM guest
         JOIN guest_type gt ON guest.guest_type_id = gt.guest_type_id;
