/**********************************************************************/
/**
/** Procedure: sp_create_wagon
/** In: n_zugID - id of the train to add a wagon to
/** In: n_wagon_artID - id of the wagon type
/** In: d_baujahr - year the wagon was built
/** In: d_letzte_wartung - last date of maintenance
/** Developer: Samuel Fiedorowicz
/** Description: Create a wagon
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_create_wagon(n_zugID          IN zug.zugID%TYPE,
                          n_wagon_artID    IN wagon.fk_wagon_artID%TYPE,
                          d_baujahr        IN wagon.baujahr%TYPE,
                          d_letzte_wartung IN wagon.letzte_wartung%TYPE)
AS
e_integrity EXCEPTION;
PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_create_wagon;
  INSERT INTO wagon VALUES (
    wagon_id_seq.NEXTVAL,
    d_baujahr,
    d_letzte_wartung,
    n_wagon_artID,
    n_zugID
  );

EXCEPTION
  WHEN e_integrity THEN
    Raise_Application_Error(-20200, 'Fehler beim Erstellen des Wagons: Es gibt keinen Zug mit dieser ID.');
    ROLLBACK TO before_create_wagon;
  WHEN OTHERS THEN
    Raise_Application_Error(-20201, 'Fehler beim Erstellen des Wagons.');
    ROLLBACK TO before_create_wagon;
END;
/
