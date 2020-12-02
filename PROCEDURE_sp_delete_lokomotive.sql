/**********************************************************************/
/**
/** Procedure: sp_delete_lokomotive
/** In: n_lokomotiveID - id of the lokomotive to delete
/** Developer: Samuel Fiedorowicz
/** Description: Delete a lokomotive
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_delete_lokomotive(n_lokomotiveID lokomotive.lokomotivID%TYPE)
AS
  e_integrity EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_delete_lokomotive;
  DELETE
    FROM lokomotive
    WHERE lokomotivID = n_lokomotiveID;

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20205, 'Fehler beim Löschen des Lokomotive.');
    ROLLBACK TO before_delete_lokomotive;
END;
/
