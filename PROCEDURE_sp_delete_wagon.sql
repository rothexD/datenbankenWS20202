/**********************************************************************/
/**
/** Procedure: sp_delete_wagon
/** In: n_wagonID - id of the wagon to delete
/** Developer: Samuel Fiedorowicz
/** Description: Delete a wagon
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_delete_wagon(n_wagonID wagon.wagonID%TYPE)
AS

BEGIN
  SAVEPOINT before_delete_wagon;
  DELETE
    FROM wagon
    WHERE wagonID = n_wagonID;

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20202, 'Fehler beim Löschen des Wagons.');
    ROLLBACK TO before_delete_wagon;
END;
/
