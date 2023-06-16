CREATE OR REPLACE FUNCTION get_category_id_by_name(name IN VARCHAR2)
    RETURN NUMBER IS
    result NUMBER := 0;
BEGIN
    SELECT category_id
    INTO result
    FROM category
    WHERE category_name = name;
    RETURN result;
END;
/


CREATE OR REPLACE FUNCTION get_event_id_by_name(name IN VARCHAR2)
    RETURN NUMBER IS
    result NUMBER := 0;
BEGIN
    SELECT event_type_id
    INTO result
    FROM event_type
    WHERE event_type_name = name;
    RETURN result;
END;
/


CREATE OR REPLACE FUNCTION get_guest_type_id_by_name(name IN VARCHAR2)
    RETURN NUMBER IS
    result NUMBER := 0;
BEGIN
    SELECT guest_type_id
    INTO result
    FROM guest_type
    WHERE guest_type_name = name;
    RETURN result;
END;
/
