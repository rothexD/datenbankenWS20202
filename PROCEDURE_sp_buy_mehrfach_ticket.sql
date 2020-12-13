/**********************************************************************/
/**
/** Procedure: sp_buy_mehrfach_ticket
/** Developer: Lukas Schweinberger
/** Description: erstellt einen mehrfach-ticket kauf
/** Variable:
/**		n_PersonID NUMBER: zu welcher perosn das ticket gehoert
/**		n_ticketArtId NUMBER: art des tickets
/**		gueltigVon TIMESTAMP: Von wann das ticket gueltig ist
/**		gueltigBis TIMESTAMP: Bis wann das ticket gueltig ist
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_buy_mehrfach_ticket(n_PersonID NUMBER,n_ticketArtId NUMBER,gueltigVon TIMESTAMP,gueltigBis TIMESTAMP,preis NUMBER)
AS
n_newTicket_id NUMBER;
BEGIN
  SAVEPOINT buy_mehrfach_tickt;
  select ticket_id_seq.NEXTVAL INTO n_newTicket_id FROM dual;
	INSERT INTO ticket VALUES(n_newTicket_id,n_ticketArtId,n_PersonID,preis,SYSDATE);
	INSERT INTO mehrfachticket VALUES(n_newTicket_id,gueltigVon,gueltigBis);
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