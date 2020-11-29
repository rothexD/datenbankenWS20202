/**********************************************************************/
/**
/** Procedure: sp_create_wagon
/** Developer: Samuel Fiedorowicz
/** Description: Erstellt einen Wagon
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_create_wagon(zugID          zug.zugID%TYPE,
                          wagon_artID    wagon.fk_wagon_artID%TYPE,
                          baujahr        wagon.baujahr%TYPE,
                          letzte_wartung wagon.letzte_wartung%TYPE)
AS
e_integrity EXCEPTION;
PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_create_wagon;
  INSERT INTO wagon VALUES (wagon_id_seq.NEXTVAL, baujahr, letzte_wartung, wagon_artID, zugID);

EXCEPTION
  WHEN e_integrity THEN
    Raise_Application_Error(-20200, 'Fehler beim Erstellen des Wagons: Es gibt keinen Zug mit dieser ID.');
    ROLLBACK TO before_create_wagon;
  WHEN OTHERS THEN
    Raise_Application_Error(-20201, 'Fehler beim Erstellen des Wagons.');
    ROLLBACK TO before_create_wagon;
END;
/
