--*********************************************************************
--**
--** View: WagonArt_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Wagonarten an,
--**              also ID, Aufgabe, Kapazität und Klasse.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW wagonart_info AS
    SELECT wagon_artid, aufgabe, kapazitaet, klasse
    FROM wagon_art;
