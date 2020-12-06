--*********************************************************************
--**
--** View: Bahnsteig_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Bahnsteigen an,
--**              also ID, Bezeichnung und BahnhofId.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW bahnsteig_info AS
    SELECT bahnsteigid, bezeichnung, fk_bahnhofid AS bahnhofid
    FROM bahnsteig;
