--*********************************************************************
--**
--** Table: verwendbare_tickets
--** Developer: Jakob List
--** Description: View that allows to look up all tickets which are still able to be used.
--**
--********************************************************************

CREATE OR REPLACE 
VIEW verwendbare_tickets AS
SELECT t.ticketid, t.fk_ticket_artid AS ticket_artid, t.fk_personid AS personid, ot.fk_verbindungid AS Verbindung, mt.gueltig_ab, mt.gueltig_bis FROM ticket t
LEFT JOIN one_time_ticket ot
ON t.ticketid = ot.fk_ticketid
LEFT JOIN mehrfachticket mt
ON t.ticketid = mt.fk_ticketid
WHERE kaufdatum >= CURRENT_TIMESTAMP OR (gueltig_bis > CURRENT_TIMESTAMP AND gueltig_ab < CURRENT_TIMESTAMP)
ORDER BY t.ticketid ASC;
