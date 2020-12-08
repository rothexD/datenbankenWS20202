--*********************************************************************
--**
--** View: Zug_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Zügen an,
--**              also ID und Seriennummer.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW zug_info AS
    SELECT zugid, seriennummer
    FROM zug;
