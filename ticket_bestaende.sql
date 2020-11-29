--Alle noch verwendebaren Tickets
CREATE OR REPLACE 
VIEW verwendbare_tickets AS
SELECT t.ticketid, t.fk_ticket_artid AS ticket_artid, t.fk_personid AS personid, ot.fk_verbindungid AS Verbindung, mt.gültigab, mt.gültigbis FROM ticket t
LEFT JOIN onetimeticket ot
ON t.ticketid = ot.fk_ticketid
LEFT JOIN mehrfachticket mt
ON t.ticketid = mt.fk_ticketid
WHERE kaufdatum >= CURRENT_TIMESTAMP OR (gültigbis > CURRENT_TIMESTAMP AND gültigab < CURRENT_TIMESTAMP)
ORDER BY t.ticketid asc;

--Alle schon verwendeten Tickets
CREATE OR REPLACE
VIEW verwendete_tickets AS
SELECT t.ticketid, t.fk_ticket_artid AS ticket_artid, t.fk_personid AS personid, ot.fk_verbindungid AS Verbindung, mt.gültigab, mt.gültigbis FROM ticket t
LEFT JOIN onetimeticket ot
ON t.ticketid = ot.fk_ticketid
LEFT JOIN mehrfachticket mt
ON t.ticketid = mt.fk_ticketid
WHERE kaufdatum <= CURRENT_TIMESTAMP OR (gültigbis < CURRENT_TIMESTAMP AND gültigab > CURRENT_TIMESTAMP)
ORDER BY t.ticketid asc;
