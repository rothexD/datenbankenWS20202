--*********************************************************************
--**
--** View: Wagon_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen bezüglich Wagons an,
--**              inklusive Wagonart und Zug.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW wagon_info AS
    SELECT
        w.wagonid, w.baujahr, w.letzte_wartung,
        a.aufgabe, a.kapazitaet, a.klasse,
        z.zugid, z.seriennummer
    FROM wagon w
        JOIN wagon_art a
        ON w.fk_wagon_artid = a.wagon_artid
        JOIN zug z
        ON w.fk_zugid = z.zugid;
