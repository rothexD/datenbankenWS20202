--********************************************************************
--*
--* Trigger: tr_br_i_punkte_ott
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: give kunde points if he buys a ticket, additional 200 points if ticket bought on birthday
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_punkte_ott
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	e_maxTicketCounterReached EXCEPTION;
	n_personID NUMBER;
	n_punkteByTicketArt NUMBER;
	n_fk_ticket_artID NUMBER;
	t_geburtsdatum TIMESTAMP;
BEGIN
	SELECT fk_personID,fk_ticket_artID INTO n_personID,n_fk_ticket_artID FROM ticket WHERE ticket.ticketID = :new.fk_ticketID;
	SELECT punkte INTO n_punkteByTicketArt FROM ticket_art WHERE ticket_artID = n_fk_ticket_artID;
	Update kunde SET punkte = punkte + n_punkteByTicketArt WHERE fk_personID = n_personID;	
	SELECT geburtsdatum INTO t_geburtsdatum FROM person WHERE personID = n_personID;
	
	IF EXTRACT(month FROM t_geburtsdatum) = EXTRACT(month FROM sysdate) AND EXTRACT(day FROM t_geburtsdatum) = EXTRACT(month FROM sysdate) THEN
		UPDATE kunde SET punkte = punkte + n_punkteByTicketArt + 200 WHERE fk_personID = n_personID;
		RETURN;
	END IF;
	UPDATE kunde SET punkte = punkte + n_punkteByTicketArt WHERE fk_personID = n_personID;
	RETURN;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_br_i_punkte_ott';
END;
/
