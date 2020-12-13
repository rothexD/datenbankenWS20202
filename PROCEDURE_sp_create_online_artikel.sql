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
	INSERT INTO online_artikel VALUES(NULL,v_Bezeichnung,n_Punktekosten,n_Zusaetzlichekosten,VerfügbarVon,VerfügbarBis);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20007,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO DeleteGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20008,'Other Error in CreateOnlineArtikel');
  	ROLLBACK TO DeleteGehaltsStufe;
END;
/