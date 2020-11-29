/**********************************************************************/
/**
/** Procedure: sp_delete_wagon
/** Developer: Samuel Fiedorowicz
/** Description: Löscht einen Wagon
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_delete_wagon(ID wagon.wagonID%TYPE)
AS

BEGIN
  SAVEPOINT before_delete_wagon;
  DELETE
    FROM wagon
    WHERE wagonID = ID;

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20202, 'Fehler beim Löschen des Wagons.');
    ROLLBACK TO before_delete_wagon;
END;
/
