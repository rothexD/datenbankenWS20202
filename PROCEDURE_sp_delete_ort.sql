/**********************************************************************/
/**
/** Procedure: sp_delete_ort
/** Developer: Lukas Schweinberger
/** Description: loescht einen ort
/** Variable:
/**		n_PLZ NUMBER: Löscht eine bestimmte ort
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_ort (n_PLZ NUMBER)
AS
BEGIN
	SAVEPOINT DeleteOrt;
	DELETE FROM ORT WHERE plz = n_PLZ;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20012,'Other Error in DeleteOrt');
  	ROLLBACK TO DeleteOrt;
END;
/