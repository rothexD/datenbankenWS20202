/**********************************************************************/
/**
/** Procedure: sp_create_lokomotive
/** Developer: Samuel Fiedorowicz
/** Description: Erstellt eine Lokomotive
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_create_lokomotive(zugID          lokomotive.fk_zugID%TYPE,
                               baujahr        lokomotive.baujahr%TYPE,
                               leistung       lokomotive.leistung%TYPE,
                               letzte_wartung lokomotive.letzte_wartung%TYPE)
AS
e_integrity EXCEPTION;
PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_create_lokomotive;
  INSERT INTO lokomotive VALUES (lokomotive_id_seq.NEXTVAL, baujahr, leistung, letzte_wartung, zugID);

EXCEPTION
  WHEN e_integrity THEN
    Raise_Application_Error(-20203, 'Fehler beim Erstellen der Lokomotive: Es gibt keinen Zug mit dieser ID.');
    ROLLBACK TO before_create_lokomotive;
  WHEN OTHERS THEN
    Raise_Application_Error(-20204, 'Fehler beim Erstellen der Lokomotive.');
    ROLLBACK TO before_create_lokomotive;
END;
/
