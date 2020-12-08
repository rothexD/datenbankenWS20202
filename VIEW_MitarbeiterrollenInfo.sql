--*********************************************************************
--**
--** View: Mitarbeiterrollen_Info
--** Developer: Nicolas Klement
--** Description: Listet alle Mitarbeiterrollen auf,
--**              mit ID und Bezeichnung.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW mitarbeiterrolle_info AS
    SELECT rollenid, bezeichnung
    FROM mitarbeiter_rolle;
