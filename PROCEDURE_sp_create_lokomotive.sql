/**********************************************************************/
/**
/** Procedure: sp_create_lokomotive
/** In: n_zugID - id of the train to add a lokomotive to
/** In: d_baujahr - year the lokomotive was built
/** In: n_leistung - power of the lokomotive
/** In: d_letzte_wartung - last date of maintenance
/** Developer: Samuel Fiedorowicz
/** Description: Create a lokomotive
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_create_lokomotive(n_zugID          IN lokomotive.fk_zugID%TYPE,
                               d_baujahr        IN lokomotive.baujahr%TYPE,
                               n_leistung       IN lokomotive.leistung%TYPE,
                               d_letzte_wartung IN lokomotive.letzte_wartung%TYPE)
AS
  e_integrity EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_create_lokomotive;
  INSERT INTO lokomotive VALUES (
    lokomotive_id_seq.NEXTVAL,
    d_baujahr, n_leistung,
    d_letzte_wartung,
    n_zugID
  );

EXCEPTION
  WHEN e_integrity THEN
    Raise_Application_Error(-20203, 'Fehler beim Erstellen der Lokomotive: Es gibt keinen Zug mit dieser ID.');
    ROLLBACK TO before_create_lokomotive;
  WHEN OTHERS THEN
    Raise_Application_Error(-20204, 'Fehler beim Erstellen der Lokomotive.');
    ROLLBACK TO before_create_lokomotive;
END;
/
