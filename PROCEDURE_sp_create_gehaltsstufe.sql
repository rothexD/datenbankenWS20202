/**********************************************************************/
/**
/** Procedure: sp_create_gehaltsstufe
/** Developer: Lukas Schweinberger
/** Description: erstellt eine mitarbeiter rolle
/** Variable:
/**		n_gehalt NUMBER: gehalt as float für die neue stufe
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_gehaltsstufe (n_gehalt NUMBER)
AS
BEGIN
SAVEPOINT CreateCreateGehaltsStufe;
	INSERT INTO Gehaltsstufe VALUES (null,n_gehalt);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20004,'CreateGehaltsstufe was not unique');
  	ROLLBACK TO CreateCreateGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20005,'Other Error in CreateGehaltsStufe');
  	ROLLBACK TO CreateCreateGehaltsStufe;
END;
/