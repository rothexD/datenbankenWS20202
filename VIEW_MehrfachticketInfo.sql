--*********************************************************************
--**
--** View: Mehrfach_Ticket_Info
--** Developer: Samuel Fiedorowicz
--** Description: Zeigt für Mehrfachtickets den Gültigkeitsbereich,
--**              das Kaufdatum, den Preis und die Ticket ID an
--**
--*********************************************************************

CREATE OR REPLACE
VIEW mehrfach_ticket_info AS
SELECT
   p.personID, t.ticketID,
   ta.bezeichnung AS ticket_typ,
   t.preis, t.kaufdatum, mt.gueltig_ab, mt.gueltig_bis
FROM mehrfachticket mt
  JOIN ticket t
    ON mt.fk_ticketID = t.ticketID
  JOIN person p
    ON p.personID = t.fk_personID
  JOIN ticket_art ta
    ON ta.ticket_artID = t.fk_ticket_artID;
