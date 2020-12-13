/**********************************************************************/
/**
/** Procedure: sp_create_mitarbeiter
/** Developer: Lukas Schweinberger
/** Description: legt einen neues mitarbeiter an
/** Variable:
/**		v_Name VARCHAR2: Name der person
/**		Geburtsdatum TIMESTAMP: tag an dem die person geboren ist
/**		v_Adresse VARCHAR2: adresse des mitarbeiters
/**		n_Sozialversicherungsnummer NUMBER: sozialversicherungsnummer des mitarbeiters
/**		n_PLZ NUMBER: postleitzahl des mitarbeiters
/**		n_Gehaltsstufe NUMBER: gehaltstufe des mitarbeiters
/**		n_MitarbeiterRolle NUMBER: mitarbeiterrolle des mitarbeiters
/**		v_Email VARCHAR2: Email des kundes
/**		v_Password VARCHAR2: passwordhash of the user
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_mitarbeiter(v_Name VARCHAR2,Geburtsdatum TIMESTAMP,v_Adresse VARCHAR2,n_Sozialversicherungsnummer NUMBER,n_PLZ NUMBER,n_Gehaltsstufe NUMBER,n_MitarbeiterRolle NUMBER,v_Email VARCHAR2,v_Password VARCHAR2)
AS
	n_newPersonID NUMBER;
BEGIN
	SAVEPOINT CreateMitarbeiter;
	select person_id_seq.NEXTVAL INTO n_newPersonID FROM dual;
	INSERT INTO Person VALUES(n_newPersonID,v_Name,Geburtsdatum,v_Adresse,n_PLZ,v_Email,v_password);
	INSERT INTO Mitarbeiter VALUES(n_newPersonID,n_Sozialversicherungsnummer,n_Gehaltsstufe,n_MitarbeiterRolle);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20013,'CreateMitarbeiter was not unique');
  	ROLLBACK TO CreateMitarbeiter;
	WHEN OTHERS THEN
		IF SQLCODE = -2291 or SQLCODE = -2292 THEN
			Raise_Application_Error(-20014,'Foreign key does not exist');
			ROLLBACK TO CreateMitarbeiter;		
			RETURN;	
		END IF;
  	Raise_Application_Error(-20016,'Other Error in CreateMitarbeiter');
  	ROLLBACK TO CreateMitarbeiter;
END;
/