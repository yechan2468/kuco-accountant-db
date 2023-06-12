CREATE TABLE member
(
    member_id    NUMBER
        GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT member_id_pk
        PRIMARY KEY (member_id),
    name         VARCHAR2(3 CHAR)
        CONSTRAINT member_name_nn NOT NULL,
    department   VARCHAR2(10 CHAR),
    gisu         NUMBER(3)
        CONSTRAINT member_gisu_nn NOT NULL,
    CONSTRAINT member_gisu_integer
        CHECK ( TRUNC(gisu) = gisu ),
    CONSTRAINT member_gisu_over_zero
        CHECK ( gisu > 0 ),
    student_id   NUMBER(10),
    phone_number VARCHAR2(11 CHAR)
        CONSTRAINT member_phone_number_numeric
            CHECK ( REGEXP_LIKE(phone_number, '^[[:digit:]]+$') ),
    graduated    CHAR(1)
        DEFAULT '0'
        CONSTRAINT member_graduated_nn NOT NULL
);

CREATE TABLE guest
(
    guest_id     NUMBER
        GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT guest_id_pk
        PRIMARY KEY (guest_id),
    type         VARCHAR2(9 CHAR)
        CONSTRAINT guest_type_nn NOT NULL,
    CONSTRAINT guest_type_enum
        CHECK ( type IN ('conductor', 'amateur', 'pro') ),
    name         VARCHAR2(3 CHAR)
        CONSTRAINT guest_name_nn NOT NULL,
    phone_number VARCHAR2(11 CHAR)
        CONSTRAINT guest_phone_number_numeric
            CHECK ( REGEXP_LIKE(phone_number, '^[[:digit:]]+$') ),
    account      VARCHAR2(20)
);

CREATE TABLE event
(
    event_id NUMBER
        GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT event_id_pk
        PRIMARY KEY (event_id),
    name     VARCHAR2(10 CHAR)
        CONSTRAINT event_name_nn NOT NULL,
    year     NUMBER(4)
        CONSTRAINT event_year_nn NOT NULL,
    CONSTRAINT event_year_range
        CHECK ( year BETWEEN 2018 AND 2100 ),
    CONSTRAINT event_year_integer
        CHECK ( TRUNC(year) = year ),
    semester NUMBER(1)
        CONSTRAINT event_semester_nn NOT NULL,
    CONSTRAINT event_semester_range
        CHECK ( semester IN (1, 2) )
);

CREATE TABLE transaction
(
    transaction_id NUMBER
        GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT transaction_id_pk
        PRIMARY KEY (transaction_id),
    event_id       NUMBER
        CONSTRAINT transaction_event_id NOT NULL,
    CONSTRAINT transaction_event_id_fk
        FOREIGN KEY (event_id)
            REFERENCES event (event_id)
                ON DELETE CASCADE,
    name           VARCHAR2(20 CHAR)
        CONSTRAINT transaction_name_nn NOT NULL,
    details        VARCHAR2(50 CHAR)
        DEFAULT ''
);

CREATE TABLE budget
(
    transaction_id   NUMBER
        CONSTRAINT budget_transaction_id_nn NOT NULL,
    CONSTRAINT budget_transaction_id_fk
        FOREIGN KEY (transaction_id)
            REFERENCES transaction (transaction_id)
                ON DELETE CASCADE,
    amount           NUMBER
        CONSTRAINT budget_amount_nn NOT NULL,
    CONSTRAINT budget_amount_integer
        CHECK ( TRUNC(amount) = amount ),
    transaction_date DATE
        CONSTRAINT budget_transaction_date_year_range
            CHECK ( EXTRACT(YEAR FROM transaction_date) BETWEEN 2018 AND 2100)
);

CREATE TABLE account
(
    transaction_id   NUMBER
        CONSTRAINT account_transaction_id_nn NOT NULL,
    CONSTRAINT account_transaction_id_fk
        FOREIGN KEY (transaction_id)
            REFERENCES transaction (transaction_id)
                ON DELETE CASCADE,
    amount           NUMBER
        CONSTRAINT account_amount_nn NOT NULL,
    CONSTRAINT account_amount_integer
        CHECK ( TRUNC(amount) = amount ),
    transaction_date DATE
        CONSTRAINT account_transaction_date_year_range
            CHECK ( EXTRACT(YEAR FROM transaction_date) BETWEEN 2018 AND 2100)
);

CREATE TABLE fee
(
    member_id      NUMBER,
    CONSTRAINT fee_member_id_fk
        FOREIGN KEY (member_id)
            REFERENCES member (member_id)
                ON DELETE SET NULL,
    transaction_id NUMBER,
    CONSTRAINT fee_transaction_id_fk
        FOREIGN KEY (transaction_id)
            REFERENCES transaction (transaction_id)
                ON DELETE CASCADE
);

CREATE TABLE guest_pay
(
    guest_id       NUMBER,
    CONSTRAINT guest_pay_guest_id_fk
        FOREIGN KEY (guest_id)
            REFERENCES guest (guest_id)
                ON DELETE SET NULL,
    transaction_id NUMBER,
    CONSTRAINT guest_pay_transaction_id_fk
        FOREIGN KEY (transaction_id)
            REFERENCES transaction (transaction_id)
                ON DELETE CASCADE
);

CREATE TABLE participation_list
(
    member_id NUMBER,
    CONSTRAINT participation_list_member_id_fk
        FOREIGN KEY (member_id)
            REFERENCES member (member_id)
                ON DELETE SET NULL,
    event_id  NUMBER,
    CONSTRAINT participation_list_event_id_fk
        FOREIGN KEY (event_id)
            REFERENCES event (event_id)
                ON DELETE CASCADE
);
