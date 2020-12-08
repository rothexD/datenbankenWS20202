set serveroutput on;
/ 

/**********************************************************************/
/**
/** Procedure: sp_create_mitarbeiter_rolle
/** Developer: Lukas Schweinberger
/** Description: erschafft eine neue mitarbeiter rollenID
/** Variable:
/**		v_Bezeichnung VARCHAR2: bezeichnung für die neue rolle
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_mitarbeiter_rolle (v_Bezeichnung VARCHAR2)
AS
BEGIN
	SAVEPOINT CreateMitarbeiterRolleSave;
	INSERT INTO mitarbeiter_rolle VALUES (null,v_Bezeichnung);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20002,'Create MitarbeiterRolle was not unique');
  	ROLLBACK TO CreateMitarbeiterRolleSave;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20001,'Other Error in CreateMitarbeiterRolle');
  	ROLLBACK TO CreateMitarbeiterRolleSave;
END;
/


/**********************************************************************/
/**
/** Procedure: sp_delete_mitarbeiter_rolle
/** Developer: Lukas Schweinberger
/** Description: löscht eine mitarbeiter rolle
/** Variable:
/**		n_rollenID NUMBER: Id, primary key, zum löschen einer mitarbeiter rolle
/**********************************************************************/
CREATE OR REPLACE PROCEDURE sp_delete_mitarbeiter_rolle (n_rollenID NUMBER)
AS
BEGIN
	SAVEPOINT DeleteMitarbeiterRolleSave;
	DELETE FROM mitarbeiter_rolle WHERE rollenID = n_rollenID;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20003,'Other Error in CreateMitarbeiterRolle');
  	ROLLBACK TO DeleteMitarbeiterRolleSave;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_delete_mitarbeiter_rolle
/** Developer: Lukas Schweinberger
/** Description: löscht eine mitarbeiter rolle
/** Variable:
/**		n_gehalt NUMBER: gehalt as float für die neue stufe
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_CreateGehaltsStufe (n_gehalt NUMBER)
AS
BEGIN
SAVEPOINT CreateCreateGehaltsStufe;
	INSERT INTO Gehaltsstufe VALUES (null,n_gehalt);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20004,'CreateGehaltsstufe was not unique');
  	ROLLBACK TO CreateCreateGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20005,'Other Error in CreateGehaltsStufe');
  	ROLLBACK TO CreateCreateGehaltsStufe;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_delete_gehalts_stufe
/** Developer: Lukas Schweinberger
/** Description: löscht eine mitarbeiter rolle
/** Variable:
/**		n_gehaltID NUMBER: id,primary key, loescht gehaltstufe mit dieser id
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_gehalts_stufe (n_gehaltID NUMBER)
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

/**********************************************************************/
/**
/** Procedure: sp_create_online_artikel
/** Developer: Lukas Schweinberger
/** Description: erschafft einen neuen artikel fuer den webshop
/** Variable:
/**		v_Bezeichnung VARCHAR2: Bezeichnung fuer den neuen artikel
/**		n_Punktekosten NUMBER: Wieviel Punkte ein neuer artikel kostet
/**		n_Zusaetzlichekosten NUMBER: Wieviel der Kunde zusaetzlich zahlen muss fuer den erwerb des artikels
/**		VerfügbarVon TIMESTAMP: Ab wann es verfuegbar ist.
/**		VerfügbarBis TIMESTAMP: Bis wann es verfuegbar ist.
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_online_artikel(v_Bezeichnung VARCHAR2,n_Punktekosten NUMBER,n_Zusaetzlichekosten NUMBER,VerfügbarVon TIMESTAMP,VerfügbarBis TIMESTAMP)
AS
BEGIN
	SAVEPOINT CreateOnlineArtikel;
	INSERT INTO online_artikel values(null,v_Bezeichnung,n_Punktekosten,n_Zusaetzlichekosten,VerfügbarVon,VerfügbarBis);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20007,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO DeleteGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20008,'Other Error in CreateOnlineArtikel');
  	ROLLBACK TO DeleteGehaltsStufe;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_update_artikel_price
/** Developer: Lukas Schweinberger
/** Description: update fuer den price eines artikels (optional einer von v_Preis,v_Punkte null)
/** Variable:
/**		n_ArtikelID NUMBER: id,primary key welcher artikel geaendert werden soll.
/**		n_Preis NUMBER: Neuer preis des artikels, optional null
/**		n_Punkte NUMBER: Neue Punktekosten des artikels, optional null
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_update_artikel_price (n_ArtikelID NUMBER,n_Preis NUMBER,n_Punkte NUMBER)
AS
	v_sqlbuilder VARCHAR2(500);
BEGIN
	IF n_Preis is null and n_Punkte is null THEN
		RETURN;
	END IF;
	SAVEPOINT UpdateOnArtikePrice;
	v_sqlbuilder := 'update online_artikel set ';	
	IF n_Preis = null THEN
		v_sqlbuilder := v_sqlbuilder || ' preis = ' || n_Preis;
	END IF;
	IF n_Punkte = null THEN
		v_sqlbuilder := v_sqlbuilder || ' punktekosten = '||n_Punkte;
	END IF;
	v_sqlbuilder := v_sqlbuilder || ' where aritkelID = '||n_ArtikelID;
	execute immediate v_sqlbuilder;
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20007,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO DeleteGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20008,'Other Error in CreateOnlineArtikel');
  	ROLLBACK TO DeleteGehaltsStufe;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_delete_artikel
/** Developer: Lukas Schweinberger
/** Description: löscht einen artikel aus dem shop
/** Variable:
/**		n_OnlineArtikelID NUMBER: id,primary key welcher artikel geloescht werden soll.
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_artikel (n_OnlineArtikelID NUMBER)
AS
BEGIN
	SAVEPOINT DeleteOnlineArtikel;
	DELETE FROM online_artikel  WHERE artikelID = n_OnlineArtikelID;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20009,'Other Error in DeleteOnlineArtikel');
  	ROLLBACK TO DeleteOnlineArtikel;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_create_ort
/** Developer: Lukas Schweinberger
/** Description: erstellt einen neuen ort
/** Variable:
/**		n_PLZ NUMBER: welche plz neu angelegt werden soll.
/**		v_Bezeichnung VARCHAR2: bezeichnung fuer den ort
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_ort (n_PLZ NUMBER,v_Bezeichnung VARCHAR2)
AS
BEGIN
	SAVEPOINT CreateOrt;
	INSERT INTO ORT VALUES(n_PLZ,v_Bezeichnung);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20010,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO CreateOrt;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20011,'Other Error in CreateGehaltsStufe');
  	ROLLBACK TO CreateOrt;
END;
/


/**********************************************************************/
/**
/** Procedure: sp_delete_ort
/** Developer: Lukas Schweinberger
/** Description: loescht einen ort
/** Variable:
/**		n_PLZ NUMBER: Löscht eine bestimmte ort
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_ort (n_PLZ NUMBER)
AS
BEGIN
	SAVEPOINT DeleteOrt;
	DELETE FROM ORT WHERE plz = n_PLZ;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20012,'Other Error in DeleteOrt');
  	ROLLBACK TO DeleteOrt;
END;
/

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
	DELETE FROM Mitarbeiter where fk_personID = n_personID;
	DELETE FROM Person where personID = n_personID;
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

/**********************************************************************/
/**
/** Procedure: sp_create_kunde
/** Developer: Lukas Schweinberger
/** Description: legt einen kunden
/** Variable:
/**		n_personID NUMBER: id,primary key mit dem die person geloescht wird
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_kunde(n_personID NUMBER)
AS
BEGIN
	SAVEPOINT DeleteKunde;
	DELETE FROM Kunde where fk_personID = n_personID;
	DELETE FROM Person where personID = n_personID;
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

/**********************************************************************/
/**
/** Procedure: sp_create_ticket_art
/** Developer: Lukas Schweinberger
/** Description: erstellt eine neue ticket art
/** Variable:
/**		v_bezeichnung VARCHAR2: bezeichnung der neuen ticket art
/**		n_Punkte NUMBER: Anzahl der Punkte die diese art von ticket gibt
/**********************************************************************/


CREATE OR REPLACE PROCEDURE sp_create_ticket_art(v_bezeichnung VARCHAR2,n_Punkte NUMBER)
AS
BEGIN
  SAVEPOINT CreateTicketArt;
	INSERT INTO ticket_art values(null,v_bezeichnung,n_Punkte);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20024,'CreateTicketArt was not unique');
  	ROLLBACK TO CreateTicketArt;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20025,'Other Error in CreateTicketArt');
  	ROLLBACK TO CreateTicketArt;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_buy_one_time_ticket
/** Developer: Lukas Schweinberger
/** Description: erstellt eine neue ticket art
/** Variable:
/**		n_PersonID NUMBER: zu welcher perosn das ticket gehoert
/**		n_ticketArtId NUMBER: art des tickets
/**		n_verbindungID NUMBER: id zu welcher verbindung das ticket gehoert
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_buy_one_time_ticket(n_PersonID NUMBER,n_ticketArtId NUMBER,n_verbindungID NUMBER)
AS
n_newTicket_id NUMBER;
BEGIN
  SAVEPOINT BuyOneTimeTicket;
  select ticket_id_seq.NEXTVAL into n_newTicket_id from dual;
	INSERT INTO ticket values(n_newTicket_id,n_ticketArtId,n_PersonID,-1,sysdate);
	INSERT INTO one_time_ticket values(n_newTicket_id,n_verbindungID,0);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20024,'BuyOneTimeTicket was not unique');
  	ROLLBACK TO BuyOneTimeTicket;
	WHEN OTHERS THEN
	  IF SQLCODE = -2291 THEN
			Raise_Application_Error(-20020,'Foreign key does not exist');
			ROLLBACK TO CreateKunde;		
	    RETURN;
	  END IF;
  	Raise_Application_Error(-20025,'Other Error in BuyOneTimeTicket');
  	ROLLBACK TO BuyOneTimeTicket;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_buy_one_time_ticket
/** Developer: Lukas Schweinberger
/** Description: erstellt eine neue ticket art
/** Variable:
/**		n_PersonID NUMBER: zu welcher perosn das ticket gehoert
/**		n_ticketArtId NUMBER: art des tickets
/**		gueltigVon TIMESTAMP: Von wann das ticket gueltig ist
/**		gueltigBis TIMESTAMP: Bis wann das ticket gueltig ist
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_buy_mehrfach_tickt(n_PersonID NUMBER,n_ticketArtId NUMBER,gueltigVon TIMESTAMP,gueltigBis TIMESTAMP,preis NUMBER)
AS
n_newTicket_id NUMBER;
BEGIN
  SAVEPOINT buy_mehrfach_tickt;
  select ticket_id_seq.NEXTVAL into n_newTicket_id from dual;
	INSERT INTO ticket values(n_newTicket_id,n_ticketArtId,n_PersonID,preis,sysdate);
	INSERT INTO mehrfachticket values(n_newTicket_id,gueltigVon,gueltigBis);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20024,'BuyOneTimeTicket was not unique');
  	ROLLBACK TO buy_mehrfach_tickt;
	WHEN OTHERS THEN
	  IF SQLCODE = -2291 THEN
			Raise_Application_Error(-20020,'Foreign key does not exist');
			ROLLBACK TO buy_mehrfach_tickt;		
	    RETURN;
	  END IF;
  	Raise_Application_Error(-20025,'Other Error in BuyOneTimeTicket');
  	ROLLBACK TO buy_mehrfach_tickt;
END;
/













