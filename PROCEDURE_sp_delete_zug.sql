/**********************************************************************/
/**
/** Procedure: sp_delete_zug
/** In: n_zugID - id of the zug to delete
/** Developer: Samuel Fiedorowicz
/** Description: Delete a train
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_delete_zug(n_zugID zug.zugID%TYPE)
AS
    e_integrity EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_delete_zug;
  DELETE
    FROM zug
    WHERE zugID = n_zugID;

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20207, 'Fehler beim Löschen des Zugs.');
    ROLLBACK TO before_delete_zug;
END;
/
