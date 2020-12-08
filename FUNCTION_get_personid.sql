--********************************************************************
--**
--** Function: f_get_personID
--** In: v_email - Email address of the user
--** Returns: PersonID of the user or error number
--** Developer: Nicolas Klement
--** Description: Looks up a user's personID and returns it.
--**              If no data found -1, several found -2, others -3.
--**
--********************************************************************


CREATE OR REPLACE FUNCTION f_get_personid(v_email IN VARCHAR2)
    RETURN VARCHAR2
IS
    n_id number;
BEGIN
    SELECT p.personid INTO n_id
    FROM person p
    WHERE p.email = v_email;

    RETURN n_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN -1;
    WHEN TOO_MANY_ROWS THEN
        RETURN -2;
    WHEN OTHERS THEN
        RETURN -3;
END;
/
