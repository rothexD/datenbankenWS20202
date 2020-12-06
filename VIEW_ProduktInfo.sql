--*********************************************************************
--**
--** View: Produkt_Info
--** Developer: Nicolas Klement
--** Description: Zeigt grundlegende Informationen zu Produkten an,
--**              also ID, Name und Preis.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW produkt_info AS
    SELECT p.produktid, p.name, p.preis
    FROM produkt p;
