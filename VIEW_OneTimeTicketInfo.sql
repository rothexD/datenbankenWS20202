--*********************************************************************
--**
--** View: OneTimeTicketInfo
--** Developer: Samuel Fiedorowicz
--** Description: Zeigt für Einmaltickets den Start- und Zielbahnhof
--**              sowie die dazugehörigen Bahnsteige, Preis,
--**              Kaufdatum und Uhrzeit der Abfahrt und Ankunft an.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW OneTimeTicketInfo AS
SELECT 
  t.ticketid, t.preis, t.kaufdatum, ot.already_scanned,
  bhAbfahrt.bezeichnung AS bahnhof_abfahrt, 
  bhAnkunft.bezeichnung AS bahnhof_ankunft,
  bsAbfahrt.bezeichnung AS bahnsteig_abfahrt,
  bsAnkunft.bezeichnung AS bahnsteig_ankunft, 
  v.abfahrt_uhrzeit, v.ankunft_uhrzeit
  
  FROM ticket t
    JOIN one_time_ticket ot
      ON ot.fk_ticketID = t.ticketID
    JOIN verbindung v
      ON ot.fk_verbindungID = v.verbindungID
    JOIN bahnsteig bsAnkunft
      ON v.fk_ankunft_bahnsteig = bsAnkunft.bahnsteigID
    JOIN bahnsteig bsAbfahrt
      ON v.fk_abfahrt_bahnsteig = bsAbfahrt.bahnsteigID
    JOIN bahnhof bhAnkunft
      ON bsAnkunft.fk_bahnhofID = bhAnkunft.bahnhofID
    JOIN bahnhof bhAbfahrt
      ON bsAbfahrt.fk_bahnhofID = bhAbfahrt.bahnhofID;
