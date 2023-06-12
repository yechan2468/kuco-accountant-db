CREATE VIEW budget_vw AS
SELECT e.event_id         AS event_id,
       e.name             AS event_name,
       t.transaction_id   AS transaction_id,
       t.name             AS transaction_name,
       b.amount           AS amount,
       t.details          AS transaction_details,
       b.transaction_date AS transaction_date
FROM transaction t
         JOIN budget b ON t.transaction_id = b.transaction_id
         JOIN event e ON t.event_id = e.event_id;


CREATE VIEW account_vw AS
SELECT e.event_id         AS event_id,
       e.name             AS event_name,
       t.transaction_id   AS transction_id,
       t.name             AS transaction_name,
       a.amount           AS amount,
       t.details          AS transaction_details,
       a.transaction_date AS transaction_date
FROM transaction t
         JOIN account a ON t.transaction_id = a.transaction_id
         JOIN event e ON t.event_id = e.event_id;


CREATE VIEW budget_account_comparison_vw AS
SELECT e.name                              AS event_name,
       t.name                              AS transaction_name,
       b.amount                            AS budget_amount,
       a.amount                            AS account_amount,
       t.details                           AS transaction_details,
       b.transaction_date                  AS budget_transaction_date,
       a.transaction_date                  AS account_transaction_date,
       NVL(a.amount, 0) - NVL(b.amount, 0) AS gap
FROM transaction t
         LEFT OUTER JOIN budget b ON t.transaction_id = b.transaction_id
         LEFT OUTER JOIN account a ON t.transaction_id = a.transaction_id
         JOIN event e ON t.event_id = e.event_id;


CREATE VIEW current_account_vw AS
SELECT e.name             AS event_name,
       t.name             AS transaction_name,
       a.amount           AS amount,
       t.details          AS transaction_details,
       a.transaction_date AS transaction_date
FROM transaction t
         JOIN account a ON t.transaction_id = a.transaction_id
         JOIN event e ON e.event_id = t.event_id
WHERE transaction_date <= SYSDATE;


CREATE VIEW expected_account_vw AS
SELECT e.name                                      AS event_name,
       t.name                                      AS transaction_name,
       NVL(a.amount, b.amount)                     AS amount,
       t.details                                   AS transaction_details,
       NVL(a.transaction_date, b.transaction_date) AS transaction_date
FROM transaction t
         LEFT OUTER JOIN account a ON t.transaction_id = a.transaction_id
         LEFT OUTER JOIN budget b ON t.transaction_id = b.transaction_id
         JOIN event e ON t.event_id = e.event_id;


CREATE VIEW member_vw AS
SELECT name,
       department,
       gisu
FROM member;


CREATE VIEW guest_vw AS
SELECT type,
       name
       -- , instrument
FROM guest;
