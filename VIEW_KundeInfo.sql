--*********************************************************************
--**
--** View: Kunde_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen bezüglich Kunden an,
--**              exklusive Schlüssel abgesehen von personID.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW kunde_info AS
    SELECT
        p.personid, p.name, o.plz, o.ort, p.geburtsdatum, p.strasse_hausnummer,
        k.email, k.kreditkartennummer, k.kundennummer
    FROM kunde k
        JOIN person p
        ON k.fk_personid = p.personid
        JOIN ort o
        ON p.fk_plz = o.plz;
