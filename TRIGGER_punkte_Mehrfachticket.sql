--********************************************************************
--*
--* Trigger: tr_br_punkte_mehrfach
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: give kunde points if he buys a ticket (mehrfachticket = points *5 and *8 on birthday)
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_punkte_mehrfach
BEFORE INSERT ON mehrfachticket
FOR EACH ROW
DECLARE
	e_MaxTicketCounterReached EXCEPTION;
	n_personID NUMBER;
	n_punkteByTicketArt NUMBER;
	n_fk_ticket_artID NUMBER;
	geburtsdatum TIMESTAMP;
BEGIN
	SELECT fk_personID,fk_ticket_artID INTO n_personID,n_fk_ticket_artID FROM ticket WHERE ticket.ticketID = :new.fk_ticketID;
	SELECT punkte INTO n_punkteByTicketArt FROM ticket_art WHERE ticket_artID = n_fk_ticket_artID;
	SELECT geburtsdatum INTO geburtsdatum FROM person WHERE personID = n_personID;
	
	IF EXTRACT(month FROM geburtsdatum) = EXTRACT(month FROM sysdate) and EXTRACT(day FROM geburtsdatum) = EXTRACT(month FROM sysdate) THEN
		UPDATE kunde SET punkte = punkte + (n_punkteByTicketArt * 8) WHERE fk_personID = n_personID;
		RETURN;
	END IF;
	UPDATE kunde SET punkte = punkte + (n_punkteByTicketArt * 5) WHERE fk_personID = n_personID;
	RETURN;
END;
/
begin
execute immediate 'DROP TRIGGER tr_br_punkte_mehrfach';
end;
/
