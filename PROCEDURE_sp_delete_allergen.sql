/**********************************************************************/
/**
/** Procedure: sp_delete_allergen
/** Developer: Elisabeth Glatz
/** In: n_allergenID - ID of allergen that should be deleted
/** Description: Deletes an allergen
/**
/**********************************************************************/


CREATE OR REPLACE PROCEDURE sp_delete_allergen(n_allergenID NUMBER)
AS
BEGIN
	SAVEPOINT delete_allergen_savepoint;
	DELETE FROM allergen WHERE allergenID = n_allergenID;
EXCEPTION
	WHEN OTHERS THEN
		raise_application_error(-20402,'Fehler.');
		ROLLBACK TO delete_allergen_savepoint;
END;
/