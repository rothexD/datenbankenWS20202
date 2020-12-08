--*********************************************************************
--**
--** View: Produkt_Allergen_Info
--** Developer: Nicolas Klement
--** Description: Listet alle Informationen zu Allergenen jeder
--**              ProduktID auf.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW produkt_allergen_info AS
    SELECT fk_produktid AS produktid, fk_allergenid AS allergenid,
        a.allergen_bezeichnung, a.allergen_kuerzel
    FROM produkt_hat_allergen pa
        JOIN allergen a
        ON pa.fk_allergenid = a.allergenid;
