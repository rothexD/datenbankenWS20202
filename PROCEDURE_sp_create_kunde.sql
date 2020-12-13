/**********************************************************************/
/**
/** Procedure: sp_create_kunde
/** Developer: Lukas Schweinberger
/** Description: legt einen neues mitarbeiter an
/** Variable:
/**		v_Name VARCHAR2: Name der person
/**		Geburtsdatum TIMESTAMP: tag an dem die person geboren ist
/**		v_Adresse VARCHAR2: adresse des kundes
/**		n_PLZ NUMBER: postleitzahl des kundes
/**		v_Email VARCHAR2: Email des kundes
/**		n_Kreditkartenummer NUMBER: Kreditkartennummer des kundes
/**		v_Password VARCHAR2: passwordhash of the user
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_kunde(v_NameOf VARCHAR2,Geburtsdatum TIMESTAMP,v_Adresse VARCHAR2,n_PLZ NUMBER,v_Email VARCHAR2,v_Password VARCHAR2,n_Kreditkartenummer NUMBER)
AS
n_newPersonID NUMBER;
BEGIN
	SAVEPOINT CreateKunde;
	select person_id_seq.NEXTVAL INTO n_newPersonID FROM dual;
	INSERT INTO Person VALUES(n_newPersonID,v_NameOf,Geburtsdatum,v_Adresse,n_PLZ,v_Email,v_Password);
	INSERT INTO Kunde VALUES(n_newPersonID,n_Kreditkartenummer,n_newPersonID + 10000,0);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20019,'CreateKunde was not unique');
  	ROLLBACK TO CreateKunde;
	WHEN OTHERS THEN
		IF SQLCODE = -2291 THEN
			Raise_Application_Error(-20020,'Foreign key does not exist');
			ROLLBACK TO CreateKunde;		
			RETURN;	
		END IF;
  	Raise_Application_Error(-20021,'Other Error in CreateKunde');
  	ROLLBACK TO CreateKunde;
END;
/