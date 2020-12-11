--*********************************************************************
--**
--** View: Mitarbeiter_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen bezüglich Mitarbeitern an,
--**              exklusive Schlüssel abgesehen von personID.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW mitarbeiter_info AS
    SELECT
        p.personid, p.name, o.plz, o.ort, p.geburtsdatum, p.strasse_hausnummer,
        g.gehalt, r.bezeichnung AS rollebezeichnung, m.sozialversicherungsnummer
    FROM mitarbeiter m
        JOIN person p
        ON m.fk_personid = p.personid
        JOIN ort o
        ON p.fk_plz = o.plz
        JOIN mitarbeiter_rolle r
        ON m.fk_rollenid = r.rollenid
        JOIN gehaltsstufe g
        ON m.fk_gehaltsstufeid = g.gehaltsstufeid;
