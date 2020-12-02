--*********************************************************************
--**
--** View: Lokomotive_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen bezüglich Lokomotiven an,
--**              inklusive Zug.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW lokomotive_info AS
    SELECT
        l.lokomotivid, l.baujahr, l.letzte_wartung,
        l.leistung, z.zugid, z.seriennummer
    FROM lokomotive l
        JOIN zug z
        ON l.fk_zugid = z.zugid;
