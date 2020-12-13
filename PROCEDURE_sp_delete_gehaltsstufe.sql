/**********************************************************************/
/**
/** Procedure: sp_delete_gehaltsstufe
/** Developer: Lukas Schweinberger
/** Description: löscht eine gehaltsstufe
/** Variable:
/**		n_gehaltID NUMBER: id,primary key, loescht gehaltstufe mit dieser id
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_gehaltsstufe (n_gehaltID NUMBER)
AS
BEGIN
SAVEPOINT DeleteGehaltsStufe;
	DELETE FROM gehaltsstufe WHERE gehaltsstufeID = n_gehaltID;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20006,'Other Error in DeleteGehaltsStufe');
  	ROLLBACK TO DeleteGehaltsStufe;
END;
/