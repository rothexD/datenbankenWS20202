/**********************************************************************/
/**
/** Procedure: sp_create_product
/** Developer: Elisabeth Glatz
/** In: v_name - product name
/** In: n_preis - price of the product
/** Description: Creates a new product
/**
/**********************************************************************/


CREATE OR REPLACE PROCEDURE sp_create_product(v_name IN VARCHAR2, n_preis IN NUMBER)
AS
BEGIN
	SAVEPOINT create_product_savepoint;
	INSERT INTO produkt VALUES (produkt_id_seq.NEXTVAL, v_name, n_preis);
EXCEPTION	
	WHEN DUP_VAL_ON_INDEX THEN
		raise_application_error(-20403,'Produkt existiert bereits.');
		ROLLBACK TO create_product_savepoint;
	WHEN OTHERS THEN
		raise_application_error(-20404,'Fehler.');
		ROLLBACK TO create_product_savepoint;
END;
/
