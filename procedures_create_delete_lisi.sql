set serveroutput on;
/ 


CREATE OR REPLACE PROCEDURE sp_create_allergen(v_bezeichnung in VARCHAR2, v_kuerzel in VARCHAR2)

IS
BEGIN
	SAVEPOINT ps_create_allergen_savepoint;
	INSERT INTO allergen VALUES (allergen_id_seq.NEXTVAL, v_bezeichnung, v_kuerzel);
EXCEPTION	
	WHEN DUP_VAL_ON_INDEX THEN
		raise_application_error(-20400,'Allergen existiert bereits.');
		ROLLBACK TO ps_create_allergen_savepoint;
	WHEN OTHERS THEN
		raise_application_error(-20401,'Fehler.');
		ROLLBACK TO ps_create_allergen_savepoint;
END;
/



CREATE OR REPLACE PROCEDURE sp_delete_allergen(i_allergenID NUMBER)
AS
BEGIN
	SAVEPOINT sp_delete_allergen_savepoint;
	DELETE FROM allergen WHERE allergenID = i_allergenID;
EXCEPTION
	WHEN OTHERS THEN
		raise_application_error(-20402,'Fehler.');
		ROLLBACK TO sp_delete_allergen_savepoint;
END;
/



CREATE OR REPLACE PROCEDURE sp_create_product(v_name in VARCHAR2, i_preis in NUMBER)

IS
BEGIN
	SAVEPOINT create_product_savepoint;
	INSERT INTO produkt VALUES (produkt_id_seq.NEXTVAL, v_name, i_preis);
EXCEPTION	
	WHEN DUP_VAL_ON_INDEX THEN
		raise_application_error(-20403,'Produkt existiert bereits.');
		ROLLBACK TO create_product_savepoint;
	WHEN OTHERS THEN
		raise_application_error(-20404,'Fehler.');
		ROLLBACK TO create_product_savepoint;
END;
/


CREATE OR REPLACE PROCEDURE sp_delete_product(i_produktID NUMBER)
AS
BEGIN
	SAVEPOINT delete_product_savepoint;
	DELETE FROM produkt WHERE produktID = i_produktID;
EXCEPTION
	WHEN OTHERS THEN
		raise_application_error(-20405,'Fehler.');
		ROLLBACK TO delete_product_savepoint;
END;
/





BEGIN
	sp_create_allergen('Gluten','A');
	exec sp_delete_allergen(1);
	
	sp_create_product('Schnitzel', 8.90);
	exec sp_delete_product(1);
END;
/


DROP TABLE allergen CASCADE CONSTRAINTS;
DROP TABLE produkt CASCADE CONSTRAINTS;

DELETE FROM allergen;
DELETE FROM produkt;
DROP SEQUENCE allergen_id_seq;
DROP SEQUENCE produkt_id_seq;
