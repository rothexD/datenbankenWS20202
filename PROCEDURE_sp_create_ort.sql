/**********************************************************************/
/**
/** Procedure: sp_create_ort
/** Developer: Lukas Schweinberger
/** Description: erstellt einen neuen ort
/** Variable:
/**		n_PLZ NUMBER: welche plz neu angelegt werden soll.
/**		v_Bezeichnung VARCHAR2: bezeichnung fuer den ort
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_ort (n_PLZ NUMBER,v_Bezeichnung VARCHAR2)
AS
BEGIN
	SAVEPOINT CreateOrt;
	INSERT INTO ORT VALUES(n_PLZ,v_Bezeichnung);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20010,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO CreateOrt;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20011,'Other Error in CreateGehaltsStufe');
  	ROLLBACK TO CreateOrt;
END;
/