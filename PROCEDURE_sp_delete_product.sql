/**********************************************************************/
/**
/** Procedure: sp_delete_product
/** Developer: Elisabeth Glatz
/** In: n_produktID - ID of product that should be deleted
/** Description: Deletes a product
/**
/**********************************************************************/


CREATE OR REPLACE PROCEDURE sp_delete_product(n_produktID NUMBER)
AS
BEGIN
	SAVEPOINT delete_product_savepoint;
	DELETE FROM produkt WHERE produktID = n_produktID;
EXCEPTION
	WHEN OTHERS THEN
		raise_application_error(-20405,'Fehler.');
		ROLLBACK TO delete_product_savepoint;
END;
/