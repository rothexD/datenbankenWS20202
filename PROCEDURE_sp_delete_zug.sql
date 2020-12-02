/**********************************************************************/
/**
/** Procedure: sp_delete_zug
/** Developer: Samuel Fiedorowicz
/** Description: Löscht einen Zug
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_delete_zug(ID zug.zugID%TYPE)
AS
e_integrity EXCEPTION;
PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_delete_zug;
  DELETE
    FROM zug
    WHERE zugID = ID;

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20207, 'Fehler beim Löschen des Zugs.');
    ROLLBACK TO before_delete_zug;
END;
/
