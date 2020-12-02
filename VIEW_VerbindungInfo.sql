--*********************************************************************
--**
--** View: Verbindung_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Verbindungen an,
--**              inklusive Bahnsteig, Bahnhof und Zug.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW verbindung_info AS
    SELECT
        v.verbindungid, v.abfahrt_uhrzeit, v.ankunft_uhrzeit,
        z.zugid, z.seriennummer,
        abbh.bezeichnung AS ab_bahnhof, abbs.bezeichnung AS ab_bahnsteig,
        anbh.bezeichnung AS an_bahnhof, anbs.bezeichnung AS an_bahnsteig
    FROM verbindung v
        JOIN zug z
        ON v.fk_zugid = z.zugid
        JOIN bahnsteig abbs
        ON v.fk_abfahrt_bahnsteig = abbs.bahnsteigid
        JOIN bahnhof abbh
        ON abbs.fk_bahnhofid = abbh.bahnhofid
        JOIN bahnsteig anbs
        ON v.fk_ankunft_bahnsteig = anbs.bahnsteigid
        JOIN bahnhof anbh
        ON anbs.fk_bahnhofid = anbh.bahnhofid;
