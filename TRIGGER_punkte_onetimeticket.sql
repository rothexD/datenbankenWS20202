--********************************************************************
--*
--* Trigger: trigger_Punkte_ott
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: give kunde points if he buys a ticket
--*
--********************************************************************

CREATE OR REPLACE TRIGGER trigger_Punkte_ott
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	MaxTicketCounterReached EXCEPTION;
	v_personID NUMBER;
	punkteByTicketArt NUMBER;
	v_fk_ticket_artID NUMBER;
	v_geburtsdatum TIMESTAMP;
BEGIN
	select fk_personID,fk_ticket_artID into v_personID,v_fk_ticket_artID from ticket where ticket.ticketID = :new.fk_ticketID;
	select punkte into punkteByTicketArt from ticket_art where ticket_artID = v_fk_ticket_artID;
	Update kunde set punkte = punkte + punkteByTicketArt where fk_personID = v_personID;	
	select geburtsdatum into v_geburtsdatum from person where personID = v_personID;
	
	IF EXTRACT(month FROM v_geburtsdatum) = EXTRACT(month FROM sysdate) AND EXTRACT(day FROM v_geburtsdatum) = EXTRACT(month FROM sysdate) THEN
		UPDATE kunde set punkte = punkte + punkteByTicketArt + 200 WHERE fk_personID = v_personID;
		RETURN;
	END IF;
	UPDATE kunde SET punkte = punkte + punkteByTicketArt WHERE fk_personID = v_personID;
	RETURN;
END;
/

BEGIN
execute immediate 'DROP TRIGGER trigger_Punkte_ott';
END;
/
