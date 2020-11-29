--********************************************************************
--*
--* Trigger: trigger_Punkte_mehrfacht
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: give kunde points if he buys a ticket
--*
--********************************************************************

CREATE OR REPLACE TRIGGER trigger_Punkte_mehrfacht
BEFORE INSERT ON mehrfachticket
FOR EACH ROW
DECLARE
	MaxTicketCounterReached EXCEPTION;
	v_personID NUMBER;
	punkteByTicketArt NUMBER;
	v_fk_ticket_artID NUMBER;
	v_geburtsdatum TIMESTAMP;
BEGIN
	SELECT fk_personID,fk_ticket_artID INTO v_personID,v_fk_ticket_artID FROM ticket WHERE ticket.ticketID = :new.fk_ticketID;
	SELECT punkte INTO punkteByTicketArt FROM ticket_art WHERE ticket_artID = v_fk_ticket_artID;
	SELECT geburtsdatum INTO v_geburtsdatum FROM person WHERE personID = v_personID;
	
	IF EXTRACT(month FROM v_geburtsdatum) = EXTRACT(month FROM sysdate) and EXTRACT(day FROM v_geburtsdatum) = EXTRACT(month FROM sysdate) THEN
		UPDATE kunde SET punkte = punkte + (punkteByTicketArt * 8) WHERE fk_personID = v_personID;
		RETURN;
	END IF;
	UPDATE kunde SET punkte = punkte + (punkteByTicketArt * 5) WHERE fk_personID = v_personID;
	RETURN;
END;
/
begin
execute immediate 'DROP TRIGGER trigger_Punkte_mehrfacht';
end;
/
