/**********************************************************************/
/**
/** Procedure: sp_create_zug
/** Developer: Samuel Fiedorowicz
/** Description: Erstelle einen Zug
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_create_zug(seriennummer zug.seriennummer%TYPE)
AS
BEGIN
  SAVEPOINT before_create_zug;
  INSERT INTO zug VALUES (zug_id_seq.NEXTVAL, seriennummer);
  
EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20206, 'Fehler beim Erstellen der Zugs.');
    ROLLBACK TO before_create_zug;
    
END;
/

