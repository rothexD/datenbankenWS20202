--*********************************************************************
--**
--** View: Allergen_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Allergenen an,
--**              also ID, voller Name und Kürzel.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW allergen_info AS
    SELECT a.allergenid, a.allergen_bezeichnung, a.allergen_kuerzel
    FROM allergen a;
