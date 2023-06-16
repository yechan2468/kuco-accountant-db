CREATE TABLE member
(
    member_id    NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT member_id_pk PRIMARY KEY (member_id),
    member_name  VARCHAR2(5 CHAR)
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

create table guest_type
(
    guest_type_id   NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT guest_type_id_pk
        PRIMARY KEY (guest_type_id),
    guest_type_name VARCHAR2(4 CHAR)
        CONSTRAINT guest_type_name_nn NOT NULL,
        CONSTRAINT guest_type_enum
        CHECK ( guest_type_name IN ('지휘자', '프로', '아마추어') )
);

CREATE TABLE guest
(
    guest_id       NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT guest_id_pk
        PRIMARY KEY (guest_id),
    guest_type_id number,
    CONSTRAINT guest_guest_type_id_fk
        FOREIGN KEY (guest_type_id)
            REFERENCES guest_type (guest_type_id)
                ON DELETE CASCADE,
    guest_name     VARCHAR2(5 CHAR)
        CONSTRAINT guest_name_nn NOT NULL,
    phone_number   VARCHAR2(11 CHAR)
        CONSTRAINT guest_phone_number_numeric
            CHECK ( REGEXP_LIKE(phone_number, '^[[:digit:]]+$') ),
    account_number VARCHAR2(20)
);

CREATE TABLE event_type
(
    event_type_id   NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT event_type_id_pk
        PRIMARY KEY (event_type_id),
    event_type_name VARCHAR2(10 CHAR)
        CONSTRAINT event_name_nn NOT NULL
);

CREATE TABLE event
(
    event_id      NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT event_id_pk
        PRIMARY KEY (event_id),
    event_type_id NUMBER,
    CONSTRAINT event_event_type_id_fk
        FOREIGN KEY (event_type_id)
            REFERENCES event_type (event_type_id)
                ON DELETE CASCADE,
    year          NUMBER(4)
        CONSTRAINT event_year_nn NOT NULL,
    CONSTRAINT event_year_range
        CHECK ( year BETWEEN 2018 AND 2100 ),
    CONSTRAINT event_year_integer
        CHECK ( TRUNC(year) = year ),
    semester      NUMBER(1)
        CONSTRAINT event_semester_nn NOT NULL,
    CONSTRAINT event_semester_range
        CHECK ( semester IN (1, 2) )
);

CREATE TABLE category
(
    category_id   NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT category_id_pk
        PRIMARY KEY (category_id),
    event_id      NUMBER
        CONSTRAINT event_id_nn NOT NULL,
    CONSTRAINT category_event_id_fk
        FOREIGN KEY (event_id)
            REFERENCES event (event_id)
                ON DELETE CASCADE,
    category_name VARCHAR2(20 CHAR)
        CONSTRAINT category_name_nn NOT NULL
);

CREATE TABLE budget
(
    budget_id          NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT budget_id_pk
        PRIMARY KEY (budget_id),
    category_id        NUMBER
        CONSTRAINT budget_category_id_nn NOT NULL,
    CONSTRAINT budget_transaction_id_fk
        FOREIGN KEY (category_id)
            REFERENCES category (category_id)
                ON DELETE CASCADE,
    budget_description VARCHAR2(50 CHAR),
    budget_amount      NUMBER
        CONSTRAINT budget_amount_nn NOT NULL,
    CONSTRAINT budget_amount_integer
        CHECK ( TRUNC(budget_amount) = budget_amount ),
    budget_date        DATE
        CONSTRAINT budget_transaction_date_year_range
            CHECK ( EXTRACT(YEAR FROM budget_date) BETWEEN 2018 AND 2100)
);

CREATE TABLE transaction
(
    transaction_id          NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    CONSTRAINT transaction_id_pk
        PRIMARY KEY (transaction_id),
    category_id             NUMBER
        CONSTRAINT transaction_category_id_nn NOT NULL,
    CONSTRAINT transaction_category_id_pk
        FOREIGN KEY (category_id)
            REFERENCES category (category_id)
                ON DELETE CASCADE,
    transaction_description VARCHAR2(50 CHAR),
    transaction_amount      NUMBER
        CONSTRAINT account_amount_nn NOT NULL,
    CONSTRAINT account_amount_integer
        CHECK ( TRUNC(transaction_amount) = transaction_amount ),
    transaction_date        DATE
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
