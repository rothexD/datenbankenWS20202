--*********************************************************************
--**
--** View: TicketArt_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Ticketarten an,
--**              also ID, Bezeichnung und Punkte.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW ticketart_info AS
    SELECT t.ticket_artid, t.bezeichnung, t.punkte
    FROM ticket_art t;
