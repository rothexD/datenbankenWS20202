--*********************************************************************
--**
--** View: MehrfachticketInfo
--** Developer: Samuel Fiedorowicz
--** Description: Zeigt für Mehrfachtickets den Gültigkeitsbereich,
--**              das Kaufdatum, den Preis und die Ticket ID an
--**
--*********************************************************************

CREATE OR REPLACE
VIEW MehrfachticketInfo AS
SELECT t.ticketID, t.preis, t.kaufdatum, mt.gueltig_ab, mt.gueltig_bis
  FROM Mehrfachticket mt
  JOIN Ticket t
    ON mt.fk_ticketID = t.ticketID;
