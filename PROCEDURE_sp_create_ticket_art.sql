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
	INSERT INTO ticket_art VALUES(NULL,v_bezeichnung,n_Punkte);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20024,'CreateTicketArt was not unique');
  	ROLLBACK TO CreateTicketArt;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20025,'Other Error in CreateTicketArt');
  	ROLLBACK TO CreateTicketArt;
END;
/