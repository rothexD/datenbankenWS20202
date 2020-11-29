--*********************************************************************
-- Table: Person
-- Name: ind_person_name
-- Attribut: name
--*********************************************************************
CREATE INDEX ind_person_name ON person(name);

--*********************************************************************
-- Table: Person
-- Name: ind_person_plz
-- Attribut: fk:plz
--*********************************************************************
CREATE INDEX ind_person_plz ON person(fk_plz);

--*********************************************************************
-- Table: Mitarbeiter
-- Name: ind_mitarbeiter_gehaltsstufe
-- Attribut: fk_gehaltsstufeid
--*********************************************************************
CREATE INDEX ind_mitarbeiter_gehaltsstufe ON mitarbeiter(fk_gehaltsstufeid);

--*********************************************************************
-- Table: Mitarbeiter
-- Name: ind_mitarbeiter_rollen
-- Attribut: fk_rollenid
--*********************************************************************
CREATE INDEX ind_mitarbeiter_rollen ON mitarbeiter(fk_rollenid);

--*********************************************************************
-- Table: Bahnhof
-- Name: ind_bahnhof_plz
-- Attribut: fk_plz
--*********************************************************************
CREATE INDEX ind_bahnhof_plz ON bahnhof(fk_plz);

--*********************************************************************
-- Table: Bahnsteig
-- Name: ind_bahnsteig_bahnhof
-- Attribut: fk_bahnhofid
--*********************************************************************
CREATE INDEX ind_bahnsteig_bahnhof ON bahnsteig(fk_bahnhofid);

--*********************************************************************
-- Table: Wagon
-- Name: ind_wagon_art
-- Attribut: fk_wagon_artid
--*********************************************************************
CREATE INDEX ind_wagon_art ON wagon(fk_wagon_artid);

--*********************************************************************
-- Table: Wagon
-- Name: ind_wagon_zug
-- Attribut: fk_zugid
--*********************************************************************
CREATE INDEX ind_wagon_zug ON wagon(fk_zugid);

--*********************************************************************
-- Table: Lokomotive
-- Name: ind_lokomotive_zug
-- Attribut: fk_zugid
--*********************************************************************
CREATE INDEX ind_lokomotive_zug ON lokomotive(fk_zugid);

--*********************************************************************
-- Table: Verbindung
-- Name: ind_verbindung_ankunft
-- Attribut: fk_ankunft_bahnsteig
--*********************************************************************
CREATE INDEX ind_verbindung_ankunft ON verbindung(fk_ankunft_bahnsteig);

--*********************************************************************
-- Table: Verbindung
-- Name: ind_verbindung_abfahrt
-- Attribut: fk_abfahrt_bahnsteig
--*********************************************************************
CREATE INDEX ind_verbindung_abfahrt ON verbindung(fk_abfahrt_bahnsteig);

--*********************************************************************
-- Table: Verbindung
-- Name: ind_verbindung_zug
-- Attribut: fk_zugid
--*********************************************************************
CREATE INDEX ind_verbindung_zug ON verbindung(fk_zugid);

--*********************************************************************
-- Table: Wartung
-- Name: ind_wartung_zug
-- Attribut: fk_zugid
--*********************************************************************
CREATE INDEX ind_wartung_zug ON wartung(fk_zugid);

--*********************************************************************
-- Table: Servicedesk
-- Name: ind_servicedesk_bahnhof
-- Attribut: fk_bahnhofid
--*********************************************************************
CREATE INDEX ind_servicedesk_bahnhof ON servicedesk(fk_bahnhofid);

--*********************************************************************
-- Table: Ticket
-- Name: ind_ticket_art
-- Attribut: fk_ticket_artid
--*********************************************************************
CREATE INDEX ind_ticket_art ON ticket(fk_ticket_artid);

--*********************************************************************
-- Table: Ticket
-- Name: ind_ticket_person
-- Attribut: fk_personid
--*********************************************************************
CREATE INDEX ind_ticket_person ON ticket(fk_personid);

--*********************************************************************
-- Table: one_time_ticket
-- Name: ind_ott_verbindung
-- Attribut: fk_verbindungid
--*********************************************************************
CREATE INDEX ind_ott_verbindung ON one_time_ticket(fk_verbindungid);

--*********************************************************************
-- Table: produkt_hat_allergen
-- Name: ind_produkt_allergen
-- Attribut: fk_produktid
--*********************************************************************
CREATE INDEX ind_produkt_allergen ON produkt_hat_allergen(fk_produktid);

--*********************************************************************
-- Table: Wagon
-- Name: ind_wagon_produkt
-- Attribut: fk_produktid
--*********************************************************************
CREATE INDEX ind_wagon_produkt ON wagon_hat_produkt(fk_produktid);

--*********************************************************************
-- Table: person_hat_online_artikel
-- Name: ind_artikel_person
-- Attribut: fk_personid
--*********************************************************************
CREATE INDEX ind_artikel_person ON person_hat_online_artikel(fk_personid);

--Drop indizes--

DROP INDEX ind_person_name;
DROP INDEX ind_person_plz;
DROP INDEX ind_mitarbeiter_gehaltsstufe;
DROP INDEX ind_mitarbeiter_rollen;
DROP INDEX ind_bahnhof_plz;
DROP INDEX ind_bahnsteig_bahnhof;
DROP INDEX ind_wagon_art;
DROP INDEX ind_wagon_zug;
DROP INDEX ind_lokomotive_zug;
DROP INDEX ind_verbindung_ankunft;
DROP INDEX ind_verbindung_abfahrt;
DROP INDEX ind_verbindung_zug;
DROP INDEX ind_wartung_zug;
DROP INDEX ind_servicedesk_bahnhof;
DROP INDEX ind_ticket_art;
DROP INDEX ind_ticket_person;
DROP INDEX ind_ott_verbindung;
DROP INDEX ind_produkt_allergen;
DROP INDEX ind_wagon_produkt;
DROP INDEX ind_artikel_person;