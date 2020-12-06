--*********************************************************************
--**
--** View: Gehaltsstufe_Info
--** Developer: Nicolas Klement
--** Description: Listet alle Gehaltsstufen auf, mit ID und Betrag.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW gehaltsstufe_info AS
    SELECT gehaltsstufeid, gehalt
    FROM gehaltsstufe;
