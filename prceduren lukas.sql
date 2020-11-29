set serveroutput on;
/ 

CREATE OR REPLACE PROCEDURE CreateMitarbeiterRolle (Bezeichnung VARCHAR2)
AS
BEGIN
	SAVEPOINT CreateMitarbeiterRolleSave;
	INSERT INTO mitarbeiter_rolle VALUES (null,Bezeichnung);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20002,'Create MitarbeiterRolle was not unique');
  	ROLLBACK TO CreateMitarbeiterRolleSave;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20001,'Other Error in CreateMitarbeiterRolle');
  	ROLLBACK TO CreateMitarbeiterRolleSave;
END;
/
CREATE OR REPLACE PROCEDURE sp_DeleteMitarbeiterRolle (v_rollenID Number)
AS
BEGIN
	SAVEPOINT DeleteMitarbeiterRolleSave;
	DELETE FROM mitarbeiter_rolle WHERE rollenID = v_rollenID;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20003,'Other Error in CreateMitarbeiterRolle');
  	ROLLBACK TO DeleteMitarbeiterRolleSave;
END;
/

CREATE OR REPLACE PROCEDURE sp_CreateGehaltsStufe (gehalt Number)
AS
BEGIN
SAVEPOINT CreateCreateGehaltsStufe;
	INSERT INTO Gehaltsstufe VALUES (null,gehalt);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20004,'CreateGehaltsstufe was not unique');
  	ROLLBACK TO CreateCreateGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20005,'Other Error in CreateGehaltsStufe');
  	ROLLBACK TO CreateCreateGehaltsStufe;
END;
/

CREATE OR REPLACE PROCEDURE sp_DeleteGehaltsStufe (v_gehaltID Number)
AS
BEGIN
SAVEPOINT DeleteGehaltsStufe;
	DELETE FROM gehaltsstufe WHERE gehaltsstufeID = v_gehaltID;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20006,'Other Error in DeleteGehaltsStufe');
  	ROLLBACK TO DeleteGehaltsStufe;
END;
/

CREATE OR REPLACE PROCEDURE sp_CreateOnlineArtikel (Bezeichnung VARCHAR2,Punktekosten NUMBER,Zusaetzlichekosten NUMBER,VerfügbarVon TIMESTAMP,VerfügbarBis TIMESTAMP)
AS
BEGIN
	SAVEPOINT CreateOnlineArtikel;
	INSERT INTO online_artikel values(null,Bezeichnung,Punktekosten,Zusaetzlichekosten,VerfügbarVon,VerfügbarBis);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20007,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO DeleteGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20008,'Other Error in CreateOnlineArtikel');
  	ROLLBACK TO DeleteGehaltsStufe;
END;
/

CREATE OR REPLACE PROCEDURE sp_UpdateOnArtikePrice (v_ArtikelID Number,v_Preis Number,v_Punkte Number)
AS
	sqlbuilder varchar2(500);
BEGIN
	if v_Preis is null and v_Punkte is null then
		return;
	end if;
	SAVEPOINT UpdateOnArtikePrice;
	sqlbuilder := 'update online_artikel set ';	
	if v_Preis = null then
		sqlbuilder := sqlbuilder || ' preis = ' || v_Preis;
	end if;
	if v_Punkte = null then
		sqlbuilder := sqlbuilder || ' punktekosten = '||v_Punkte;
	end if;
	sqlbuilder := sqlbuilder || ' where aritkelID = '||v_ArtikelID;
	execute immediate sqlbuilder;
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20007,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO DeleteGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20008,'Other Error in CreateOnlineArtikel');
  	ROLLBACK TO DeleteGehaltsStufe;
END;
/

CREATE OR REPLACE PROCEDURE sp_DeleteOnlineArtikel (v_OnlineArtikelID Number)
AS
BEGIN
	SAVEPOINT DeleteOnlineArtikel;
	DELETE FROM online_artikel  WHERE artikelID = v_OnlineArtikelID;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20009,'Other Error in DeleteOnlineArtikel');
  	ROLLBACK TO DeleteOnlineArtikel;
END;
/

CREATE OR REPLACE PROCEDURE sp_CreateOrt (PLZ Number,Bezeichnung Varchar2)
AS
BEGIN
	SAVEPOINT CreateOrt;
	INSERT INTO ORT VALUES(PLZ,Bezeichnung);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20010,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO CreateOrt;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20011,'Other Error in CreateGehaltsStufe');
  	ROLLBACK TO CreateOrt;
END;
/

CREATE OR REPLACE PROCEDURE sp_DeleteOrt (v_PLZ Number)
AS
BEGIN
	SAVEPOINT DeleteOrt;
	DELETE FROM ORT WHERE plz = v_PLZ;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20012,'Other Error in DeleteOrt');
  	ROLLBACK TO DeleteOrt;
END;
/

CREATE OR REPLACE PROCEDURE sp_CreateMitarbeiter(Name Varchar2,Geburtsdatum timestamp,Adresse Varchar2,Sozialversicherungsnummer Number,PLZ Number,Gehaltsstufe Number,MitarbeiterRolle Number)
AS
	v_newPersonID Number;
BEGIN
	SAVEPOINT CreateMitarbeiter;
	select person_id_seq.NEXTVAL into v_newPersonID from dual;
	INSERT INTO Person VALUES(v_newPersonID,Name,Geburtsdatum,Adresse,PLZ);
	INSERT INTO Mitarbeiter VALUES(v_newPersonID,Sozialversicherungsnummer,Gehaltsstufe,MitarbeiterRolle);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20013,'CreateMitarbeiter was not unique');
  	ROLLBACK TO CreateMitarbeiter;
	WHEN OTHERS THEN
		if sqlcode = -2291 or sqlcode = -2292 then
			Raise_Application_Error(-20014,'Foreign key does not exist');
			ROLLBACK TO CreateMitarbeiter;		
			return;	
		end if;
  	Raise_Application_Error(-20016,'Other Error in CreateMitarbeiter');
  	ROLLBACK TO CreateMitarbeiter;
END;
/

CREATE OR REPLACE PROCEDURE sp_DeleteMitarbeiter(v_personID Number)
AS
	v_newPersonID Number;
BEGIN
	SAVEPOINT DeleteMitarbeiter;
	DELETE FROM Mitarbeiter where fk_personID = v_personID;
	DELETE FROM Person where personID = v_personID;
EXCEPTION
	WHEN OTHERS THEN
		if sqlcode = -2292 then
			Raise_Application_Error(-20017,'Child key exception (internal)');
			ROLLBACK TO DeleteMitarbeiter;		
			return;	
		end if;
  	Raise_Application_Error(-20018,'Other Error in CreateMitarbeiter');
  	ROLLBACK TO DeleteMitarbeiter;
END;
/

CREATE OR REPLACE PROCEDURE sp_CreateKunde(NameOf Varchar2,Geburtsdatum timestamp,Adresse VARCHAR2,PLZ Number,Email VARCHAR2,Kreditkartenummer Number)
AS
	v_newPersonID Number;
BEGIN
	SAVEPOINT CreateKunde;
	select person_id_seq.NEXTVAL into v_newPersonID from dual;
	INSERT INTO Person VALUES(v_newPersonID,NameOf,Geburtsdatum,Adresse,PLZ);
	INSERT INTO Kunde VALUES(v_newPersonID,Email,Kreditkartenummer,v_newPersonID + 10000,0);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20019,'CreateMitarbeiter was not unique');
  	ROLLBACK TO CreateKunde;
	WHEN OTHERS THEN
		if sqlcode = -2291 then
			Raise_Application_Error(-20020,'Foreign key does not exist');
			ROLLBACK TO CreateKunde;		
			return;	
		end if;
  	Raise_Application_Error(-20021,'Other Error in CreateMitarbeiter');
  	ROLLBACK TO CreateKunde;
END;
/

CREATE OR REPLACE PROCEDURE sp_DeleteKunde(v_personID Number)
AS
	v_newPersonID Number;
BEGIN
	SAVEPOINT DeleteKunde;
	DELETE FROM Kunde where fk_personID = v_personID;
	DELETE FROM Person where personID = v_personID;
EXCEPTION
	WHEN OTHERS THEN
		if sqlcode = -2292 then
			Raise_Application_Error(-20022,'Child key exception (internal)');
			ROLLBACK TO DeleteKunde;		
			return;	
		end if;
  	Raise_Application_Error(-20023,'Other Error in CreateMitarbeiter');
  	ROLLBACK TO DeleteKunde;
END;
/




















