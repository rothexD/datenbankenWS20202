--*********************************************************************
--**
--** View: Wartung_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Verbindungen an,
--**              inklusive Bahnsteig, Bahnhof und Zug.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW wartung_info AS
    SELECT
        w.wartungsid, w.start_wartung, w.ende_wartung, z.seriennummer
    FROM wartung w
        JOIN zug z
        ON w.fk_zugid = z.zugid;
