--*********************************************************************
--**
--** View: Bahnhof_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Bahnhöfen an,
--**              also ID, Name, Adresse und Position.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW bahnhof_info AS
    SELECT b.bahnhofid, b.bezeichnung, b.adresse, b.latitude, b.longitude
    FROM bahnhof b;
