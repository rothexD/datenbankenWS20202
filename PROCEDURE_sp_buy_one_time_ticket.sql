/**********************************************************************/
/**
/** Procedure: sp_buy_one_time_ticket
/** Developer: Lukas Schweinberger
/** Description: erstellt einen one-time-ticket kauf
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
  select ticket_id_seq.NEXTVAL INTO n_newTicket_id FROM dual;
	INSERT INTO ticket VALUES(n_newTicket_id,n_ticketArtId,n_PersonID,-1,SYSDATE);
	INSERT INTO one_time_ticket VALUES(n_newTicket_id,n_verbindungID,0);
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