--********************************************************************
--**
--** Function: f_get_role
--** In: v_email - Email address of the user
--** Returns: Name of the user's role
--** Developer: Nicolas Klement
--** Description: Looks up a user's role, if the user is an employee then the
--**              Mitarbeiter_Rolle ist returned, if the user is a customer then
--**              'Kunde' is returned, 'missing' if the email address does not
--**              match anyone's or 'ambiguous' if it matches several.
--**
--********************************************************************

CREATE OR REPLACE FUNCTION f_get_role(v_email IN VARCHAR2)
    RETURN VARCHAR2
IS
    v_role VARCHAR2(50);
BEGIN
    SELECT r.bezeichnung INTO v_role
    FROM person p
    LEFT JOIN mitarbeiter m ON p.personID = m.fk_personID
    LEFT JOIN mitarbeiter_rolle r ON m.fk_rollenID = r.rollenID
    WHERE p.email = v_email;

    RETURN COALESCE(v_role, 'Kunde');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'missing';
    WHEN TOO_MANY_ROWS THEN
        RETURN 'ambiguous';
    WHEN OTHERS THEN
        RETURN 'Anderer Fehler: ' || SQLERRM;
END;
/
