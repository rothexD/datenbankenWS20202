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
	IF n_Preis IS NULL AND n_Punkte IS NULL THEN
		RETURN;
	END IF;
	SAVEPOINT UpdateOnArtikePrice;
	v_sqlbuilder := 'update online_artikel set ';	
	IF n_Preis = NULL THEN
		v_sqlbuilder := v_sqlbuilder || ' preis = ' || n_Preis;
	END IF;
	IF n_Punkte = NULL THEN
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