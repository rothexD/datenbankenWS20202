/**********************************************************************/
/**
/** Procedure: sp_delete_lokomotive
/** Developer: Samuel Fiedorowicz
/** Description: Löscht eine Lokomotive
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_delete_lokomotive(ID lokomotive.lokomotivID%TYPE)
AS
e_integrity EXCEPTION;
PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_delete_lokomotive;
  DELETE
    FROM lokomotive
    WHERE lokomotivID = ID;

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20205, 'Fehler beim Löschen des Lokomotive.');
    ROLLBACK TO before_delete_lokomotive;
END;
/
