/**********************************************************************/
/**
/** Procedure: sp_create_allergen
/** Developer: Elisabeth Glatz
/** In: v_bezeichnung - description of allergen
/** In: v_kuerzel - abbreviation of allergen
/** Description: Creates a new allergen
/**
/**********************************************************************/


CREATE OR REPLACE PROCEDURE sp_create_allergen(v_bezeichnung IN VARCHAR2, v_kuerzel IN VARCHAR2)
AS
BEGIN
	SAVEPOINT create_allergen_savepoint;
	INSERT INTO allergen VALUES (allergen_id_seq.NEXTVAL, v_bezeichnung, v_kuerzel);
EXCEPTION	
	WHEN DUP_VAL_ON_INDEX THEN
		raise_application_error(-20400,'Allergen existiert bereits.');
		ROLLBACK TO create_allergen_savepoint;
	WHEN OTHERS THEN
		raise_application_error(-20401,'Fehler.');
		ROLLBACK TO create_allergen_savepoint;
END;
/
