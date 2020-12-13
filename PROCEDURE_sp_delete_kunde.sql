/**********************************************************************/
/**
/** Procedure: sp_delete_kunde
/** Developer: Lukas Schweinberger
/** Description: legt einen kunden
/** Variable:
/**		n_personID NUMBER: id,primary key mit dem die person geloescht wird
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_kunde(n_personID NUMBER)
AS
BEGIN
	SAVEPOINT DeleteKunde;
	DELETE FROM Kunde WHERE fk_personID = n_personID;
	DELETE FROM Person WHERE personID = n_personID;
EXCEPTION
	WHEN OTHERS THEN
		IF SQLCODE = -2292 THEN
			Raise_Application_Error(-20022,'Child key exception (internal)');
			ROLLBACK TO DeleteKunde;		
			RETURN;	
		END IF;
  	Raise_Application_Error(-20023,'Other Error in DeleteKunde');
  	ROLLBACK TO DeleteKunde;
END;
/