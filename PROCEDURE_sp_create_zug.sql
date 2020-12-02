/**********************************************************************/
/**
/** Procedure: sp_create_zug
/** In: v_seriennummer - serial number of the new train
/** Developer: Samuel Fiedorowicz
/** Description: Create a train
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_create_zug(v_seriennummer IN zug.seriennummer%TYPE)
AS
BEGIN
  SAVEPOINT before_create_zug;
  INSERT INTO zug VALUES (zug_id_seq.NEXTVAL, v_seriennummer);

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20206, 'Fehler beim Erstellen der Zugs.');
    ROLLBACK TO before_create_zug;

END;
/
