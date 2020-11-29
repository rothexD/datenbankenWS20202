CREATE OR REPLACE
VIEW bahnhof_timetable AS

SELECT bh.bahnhofID AS ID, bh.bezeichnung AS Name, bs.bezeichnung AS bahnsteig, v.fk_zugID AS zugID, v.abfahrt_uhrzeit AS Uhrzeit, 'Ankunft' AS VerbindungTyp
  FROM bahnsteig bs
  JOIN bahnhof bh
    ON bs.fk_bahnhofID = bh.bahnhofID
  JOIN verbindung v
    ON v.fk_ankunft_bahnsteig = bs.bahnsteigID
    
UNION

SELECT bh.bahnhofID AS ID, bh.bezeichnung AS Name, bs.bezeichnung AS bahnsteig, v.fk_zugID AS zugID, v.abfahrt_uhrzeit AS Uhrzeit, 'Abfahrt' AS VerbindungTyp
  FROM bahnsteig bs
  JOIN bahnhof bh
    ON bs.fk_bahnhofID = bh.bahnhofID
  JOIN verbindung v
    ON v.fk_abfahrt_bahnsteig = bs.bahnsteigID;
