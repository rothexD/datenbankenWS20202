/**********************************************************************/
/**
/** Procedure: sp_create_mitarbeiter_rolle
/** Developer: Lukas Schweinberger
/** Description: erschafft eine neue mitarbeiter rollenID
/** Variable:
/**		v_Bezeichnung VARCHAR2: bezeichnung für die neue rolle
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_mitarbeiter_rolle (v_Bezeichnung VARCHAR2)
AS
BEGIN
	SAVEPOINT CreateMitarbeiterRolleSave;
	INSERT INTO mitarbeiter_rolle VALUES (null,v_Bezeichnung);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20002,'Create MitarbeiterRolle was not unique');
  	ROLLBACK TO CreateMitarbeiterRolleSave;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20001,'Other Error in CreateMitarbeiterRolle');
  	ROLLBACK TO CreateMitarbeiterRolleSave;
END;
/