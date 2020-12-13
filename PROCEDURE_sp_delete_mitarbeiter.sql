/**********************************************************************/
/**
/** Procedure: sp_delete_mitarbeiter
/** Developer: Lukas Schweinberger
/** Description: löscht einen Mitarbeiter
/** Variable:
/**		n_personID Number: id,primary key zur identifikation der person
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_mitarbeiter(n_personID NUMBER)
AS
BEGIN
	SAVEPOINT DeleteMitarbeiter;
	DELETE FROM Mitarbeiter WHERE fk_personID = n_personID;
	DELETE FROM Person WHERE personID = n_personID;
EXCEPTION
	WHEN OTHERS THEN
		IF SQLCODE = -2292 THEN
			Raise_Application_Error(-20017,'Child key exception (internal)');
			ROLLBACK TO DeleteMitarbeiter;		
			RETURN;	
		END IF;
  	Raise_Application_Error(-20018,'Other Error in DeleteMitarbeiter');
  	ROLLBACK TO DeleteMitarbeiter;
END;
/