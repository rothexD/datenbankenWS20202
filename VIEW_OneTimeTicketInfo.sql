--*********************************************************************
--**
--** View: One_Time_Ticket_Info
--** Developer: Samuel Fiedorowicz
--** Description: Zeigt für Einmaltickets den Start- und Zielbahnhof
--**              sowie die dazugehörigen Bahnsteige, Preis,
--**              Kaufdatum und Uhrzeit der Abfahrt und Ankunft an.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW one_time_ticket_info AS
SELECT
  p.personID, t.ticketid,
  ta.bezeichnung AS ticket_typ,
  t.preis, t.kaufdatum, ot.already_scanned,
  bh_abfahrt.bezeichnung AS bahnhof_abfahrt,
  bh_ankunft.bezeichnung AS bahnhof_ankunft,
  bs_abfahrt.bezeichnung AS bahnsteig_abfahrt,
  bs_ankunft.bezeichnung AS bahnsteig_ankunft,
  v.abfahrt_uhrzeit, v.ankunft_uhrzeit

  FROM ticket t
    JOIN one_time_ticket ot
      ON ot.fk_ticketID = t.ticketID
    JOIN ticket_art ta
      ON ta.ticket_artID = t.fk_ticket_artID
    JOIN person p
      ON p.personID = t.fk_personID
    JOIN verbindung v
      ON ot.fk_verbindungID = v.verbindungID
    JOIN bahnsteig bs_ankunft
      ON v.fk_ankunft_bahnsteig = bs_ankunft.bahnsteigID
    JOIN bahnsteig bs_abfahrt
      ON v.fk_abfahrt_bahnsteig = bs_abfahrt.bahnsteigID
    JOIN bahnhof bh_ankunft
      ON bs_ankunft.fk_bahnhofID = bh_ankunft.bahnhofID
    JOIN bahnhof bh_abfahrt
      ON bs_abfahrt.fk_bahnhofID = bh_abfahrt.bahnhofID;
