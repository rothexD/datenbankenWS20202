/**********************************************************************/
/**
/** Procedure: sp_delete_mitarbeiter_rolle
/** Developer: Lukas Schweinberger
/** Description: löscht eine mitarbeiter rolle
/** Variable:
/**		n_rollenID NUMBER: Id, primary key, zum löschen einer mitarbeiter rolle
/**********************************************************************/
CREATE OR REPLACE PROCEDURE sp_delete_mitarbeiter_rolle (n_rollenID NUMBER)
AS
BEGIN
	SAVEPOINT DeleteMitarbeiterRolleSave;
	DELETE FROM mitarbeiter_rolle WHERE rollenID = n_rollenID;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20003,'Other Error in CreateMitarbeiterRolle');
  	ROLLBACK TO DeleteMitarbeiterRolleSave;
END;
/