--*********************************************************************
--**
--** View: Ort_Info
--** Developer: Nicolas Klement
--** Description: Listet alle Orte auf, mit PLZ und Bezeichnung.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW ort_info AS
    SELECT plz, ort AS bezeichnung
    FROM ort;
