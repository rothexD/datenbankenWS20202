--*********************************************************************
--**
--** View: Online_Artikel_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Online-Artikeln an,
--**              also ID, Name, Preis in Punkten, Zusatzkosten
--**              und Verfügbarkeitszeitraum.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW online_artikel_info AS
    SELECT artikelid, bezeichnung, preis, zusaetzliche_kosten,
        verfuegbar_von, verfuegbar_bis
    FROM online_artikel;
