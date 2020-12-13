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