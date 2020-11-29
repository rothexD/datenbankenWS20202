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
	v_personID Number;
	punkteByTicketArt Number;
	v_fk_ticket_artID Number;
BEGIN
	select fk_personID,fk_ticket_artID into v_personID,v_fk_ticket_artID from ticket where ticket.ticketID = :new.fk_ticketID;
	select punkte into punkteByTicketArt from ticket_art where ticket_artID = v_fk_ticket_artID;
	Update kunde set punkte = punkte + (punkteByTicketArt * 5) where fk_personID = v_personID;
END;
/
begin
execute immediate 'DROP TRIGGER trigger_Punkte_mehrfacht';
end;
/
