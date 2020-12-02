/**********************************************************************/
/**
/** Table: Ort
/** Developer: if19b172, if19b205
/** Description: Name und PLZ aller Orte für die eine Adresse hinterlegt ist
/**
/**********************************************************************/

CREATE TABLE ort (
	plz NUMBER(4) NOT NULL CONSTRAINT ort_pk PRIMARY KEY,
	ort VARCHAR2(50) NOT NULL
);

/**********************************************************************/
/**
/** Table: Person
/** Developer: if19b172, if19b205
/** Description: Personen, die in Verbindung mit Chipotle stehen
/**
/**********************************************************************/

CREATE TABLE person
(
	personID NUMBER NOT NULL CONSTRAINT person_pk PRIMARY KEY,
	name VARCHAR2(255) NOT NULL,
	geburtsdatum TIMESTAMP NOT NULL,
	strasse_hausnummer VARCHAR2(250) NOT NULL,
	fk_plz NUMBER NOT NULL,
	email VARCHAR2(255) NOT NULL UNIQUE,
    	passwort VARCHAR(64) NOT NULL,
	FOREIGN KEY(fk_plz) REFERENCES ort(plz) ON DELETE SET NULL
);

/**********************************************************************/
/**
/** Table: Gehaltsstufe
/** Developer: if19b172, if19b205
/** Description: Gehaltsklassen in welche ein Mitarbeiter eingeordnet
/**              werden kann
/**
/**********************************************************************/

CREATE TABLE gehaltsstufe (
	gehaltsstufeID NUMBER NOT NULL CONSTRAINT gehaltsstufe_pk PRIMARY KEY,
	gehalt NUMBER NOT NULL
);

/**********************************************************************/
/**
/** Table: Mitarbeiter_Rolle
/** Developer: if19b172, if19b205
/** Description: Funktionen, die ein Mitarbeiter, annehmen kann
/**
/**********************************************************************/

CREATE TABLE mitarbeiter_rolle (
	rollenID NUMBER NOT NULL CONSTRAINT mitarbeiter_rolle_pk PRIMARY KEY,
	bezeichnung VARCHAR2(50) NOT NULL
);

/**********************************************************************/
/**
/** Table: Mitarbeiter
/** Developer: if19b172, if19b205
/** Description: Personen, die für Chipotle tätig sind
/**
/**********************************************************************/

CREATE TABLE mitarbeiter
(
	fk_personID NUMBER NOT NULL CONSTRAINT mitarbeiter_pk PRIMARY KEY,
	sozialversicherungsnummer NUMBER(10) NOT NULL,
	fk_gehaltsstufeID NUMBER NOT NULL,
	fk_rollenID NUMBER NOT NULL,
	FOREIGN KEY(fk_personID) REFERENCES person(personID) ON DELETE CASCADE,
	FOREIGN KEY(fk_gehaltsstufeID) REFERENCES gehaltsstufe(gehaltsstufeID) ON DELETE SET NULL,
	FOREIGN KEY(fk_rollenID) REFERENCES mitarbeiter_rolle(rollenID) ON DELETE SET NULL
);

/**********************************************************************/
/**
/** Table: Kunde
/** Developer: if19b172, if19b205
/** Description: Personen, die sich bei Chipotle registriert haben
/**
/**********************************************************************/

CREATE TABLE kunde
(
	fk_personID NUMBER NOT NULL CONSTRAINT kunde_pk PRIMARY KEY,
	kreditkartennummer NUMBER NOT NULL UNIQUE,
	kundennummer NUMBER NOT NULL UNIQUE,
	punkte NUMBER DEFAULT 0,
	FOREIGN KEY(fk_personID) REFERENCES person(personID) ON DELETE CASCADE
);

/**********************************************************************/
/**
/** Table: Bahnhof
/** Developer: if19b172, if19b205
/** Description: Bahnhofsstationen, Name, Location
/**
/**********************************************************************/

CREATE Table bahnhof
(
	bahnhofID NUMBER NOT NULL CONSTRAINT bahnhof_pk PRIMARY KEY,
	bezeichnung varchar2(250) NOT NULL,
	adresse VARCHAR2(250) NOT NULL,
	fk_plz NUMBER NOT NULL,
	latitude NUMBER(8, 6) NOT NULL,
	longitude NUMBER(9, 6) NOT NULL,
	FOREIGN KEY(fk_plz) REFERENCES ort(plz) ON DELETE SET NULL
);

/**********************************************************************/
/**
/** Table: Bahnsteig
/** Developer: if19b172, if19b205
/** Description: Bahnsteige in einem Bahnhof
/**
/**********************************************************************/

CREATE TABLE bahnsteig
(
	bahnsteigID NUMBER NOT NULL CONSTRAINT bahnsteig_pk PRIMARY KEY,
	fk_bahnhofID NUMBER NOT NULL,
	bezeichnung VARCHAR2(25) NOT NULL,
	FOREIGN KEY(fk_bahnhofID) REFERENCES bahnhof(bahnhofID) ON DELETE CASCADE
);

/**********************************************************************/
/**
/** Table: Zug
/** Developer: if19b172, if19b205
/** Description: Züge, die sich zwischen Bahnhöfen bewegen
/**
/**********************************************************************/

CREATE TABLE zug
(
	zugID NUMBER NOT NULL CONSTRAINT zug_pk PRIMARY KEY,
	seriennummer VARCHAR2(14) UNIQUE
);

/**********************************************************************/
/**
/** Table: Wagon_Art
/** Developer: if19b172, if19b205
/** Description: Typen, die ein Wagon annehmen kann
/**              (Speisewagon, Businessclass-Wagon, etc.)
/**
/**********************************************************************/

CREATE TABLE wagon_art
(
	wagon_artID NUMBER NOT NULL CONSTRAINT wagon_art_pk PRIMARY KEY,
	aufgabe	VARCHAR2(50) NOT NULL,
	kapazitaet NUMBER NOT NULL,
	klasse NUMBER NOT NULL
);

/**********************************************************************/
/**
/** Table: Wagon
/** Developer: if19b172, if19b205
/** Description: Wagone, die an einem Zug hängen
/**
/**********************************************************************/

CREATE TABLE wagon
(
	wagonID NUMBER NOT NULL CONSTRAINT wagon_pk PRIMARY KEY,
	baujahr TIMESTAMP NOT NULL,
	letzte_wartung TIMESTAMP,
	fk_wagon_artID NUMBER NOT NULL,
	fk_zugID NUMBER NOT NULL,
	FOREIGN KEY(fk_wagon_artID) REFERENCES wagon_art(wagon_artID) ON DELETE SET NULL,
	FOREIGN KEY(fk_zugID) REFERENCES zug(zugID) ON DELETE SET NULL,
	CHECK(letzte_wartung >= baujahr)
);

/**********************************************************************/
/**
/** Table: Lokomotive
/** Developer: if19b172, if19b205
/** Description: Lokomotive, die einen Zug führt
/**
/**********************************************************************/

CREATE TABLE lokomotive
(
	lokomotivID NUMBER NOT NULL CONSTRAINT lokomotive_pk PRIMARY KEY,
	baujahr TIMESTAMP NOT NULL,
	leistung NUMBER,
	letzte_wartung TIMESTAMP,
	fk_zugID NUMBER NOT NULL,
	FOREIGN KEY(fk_zugID) REFERENCES zug(zugID) ON DELETE SET NULL,
	CHECK(letzte_wartung >= baujahr)
);

/**********************************************************************/
/**
/** Table: Verbindung
/** Developer: if19b172, if19b205
/** Description: Strecke, die ein Zug in einem Zeitfenster fährt
/**
/**********************************************************************/

CREATE TABLE verbindung
(
	verbindungID NUMBER NOT NULL CONSTRAINT verbindung_pk PRIMARY KEY,
	fk_ankunft_bahnsteig NUMBER NOT NULL,
	fk_abfahrt_bahnsteig NUMBER NOT NULL,
	fk_zugID NUMBER NOT NULL,
	abfahrt_uhrzeit TIMESTAMP NOT NULL,
	ankunft_uhrzeit TIMESTAMP NOT NULL,
	FOREIGN KEY(fk_ankunft_bahnsteig) REFERENCES bahnsteig(bahnsteigID) ON DELETE CASCADE,
	FOREIGN KEY(fk_abfahrt_bahnsteig) REFERENCES bahnsteig(bahnsteigID) ON DELETE CASCADE,
	FOREIGN KEY(fk_zugID) REFERENCES zug(zugID) ON DELETE SET NULL,
	CHECK(abfahrt_uhrzeit < ankunft_uhrzeit)
);

/**********************************************************************/
/**
/** Table: Wartung
/** Developer: if19b172, if19b205
/** Description: Wartungsarbeiten, die an einem Zug in einem Zeitfenster
/**              durchgeführt werden
/**
/**********************************************************************/

CREATE TABLE wartung (
	wartungsID NUMBER NOT NULL CONSTRAINT wartung_pk PRIMARY KEY,
	start_wartung TIMESTAMP NOT NULL,
	ende_wartung TIMESTAMP NOT NULL,
	fk_zugID NUMBER NOT NULL,
	FOREIGN KEY(fk_zugID) REFERENCES zug(zugID) ON DELETE CASCADE,
	CHECK(start_wartung < ende_wartung)
);

/**********************************************************************/
/**
/** Table: ServiceDesk
/** Developer: if19b172, if19b205
/** Description: Schalter, die an einem Bahnhof existieren können
/**
/**********************************************************************/

CREATE TABLE servicedesk (
	servicedeskID NUMBER NOT NULL CONSTRAINT servicedesk_pk PRIMARY KEY,
	rufnummer VARCHAR2(50) NOT NULL UNIQUE,
	fk_bahnhofID NUMBER NOT NULL,
	FOREIGN KEY(fk_bahnhofID) REFERENCES bahnhof(bahnhofID) ON DELETE CASCADE
);

/**********************************************************************/
/**
/** Table: Ticket_Art
/** Developer: if19b172, if19b205
/** Description: Tickettypen wie Studentenkarten, Seniorenkarten, etc.
/**
/**********************************************************************/

CREATE TABLE ticket_art (
	ticket_artID NUMBER NOT NULL CONSTRAINT ticket_art_pk PRIMARY KEY,
	bezeichnung VARCHAR2(50) NOT NULL,
	punkte NUMBER DEFAULT 0 NOT NULL
);

/**********************************************************************/
/**
/** Table: Ticket
/** Developer: if19b172, if19b205
/** Description: Gekaufte Tickets, die einer Person und einer Verbindung
/**              zugeordnet sind
/**
/**********************************************************************/

CREATE TABLE ticket
(
	ticketID NUMBER NOT NULL CONSTRAINT ticket_pk PRIMARY KEY,
	fk_ticket_artID NUMBER NOT NULL,
	fk_personID NUMBER NOT NULL,
	preis NUMBER NOT NULL,
	kaufdatum TIMESTAMP NOT NULL,
	FOREIGN KEY(fk_personID) REFERENCES person(personID) ON DELETE CASCADE,
	FOREIGN KEY(fk_ticket_artID) REFERENCES ticket_art(ticket_artID) ON DELETE SET NULL
);

/**********************************************************************/
/**
/** Table: One_Time_Ticket
/** Developer: if19b172, if19b205
/** Description: Tickets, die einmalig für eine Fahrt verwendet werden
/**              können
/**
/**********************************************************************/

CREATE TABLE one_time_ticket (
	fk_ticketID NUMBER NOT NULL CONSTRAINT one_time_ticket_pk PRIMARY KEY,
	fk_verbindungID NUMBER NOT NULL,
	already_scanned NUMBER(1) DEFAULT 0,
	CHECK (already_scanned between 0 and 1),
	FOREIGN KEY(fk_verbindungID) REFERENCES verbindung(verbindungID) ON DELETE SET NULL,
	FOREIGN KEY(fk_ticketID) REFERENCES ticket(ticketID) ON DELETE CASCADE
);

/**********************************************************************/
/**
/** Table: Mehrfachticket
/** Developer: if19b172, if19b205
/** Description: Tickets, die über einen Zeitraum hinweg verwendet
/**              werden können
/**
/**********************************************************************/

CREATE TABLE mehrfachticket
(
	fk_ticketID NUMBER NOT NULL CONSTRAINT mehrfachticket_pk PRIMARY KEY,
	gueltig_ab TIMESTAMP NOT NULL,
	gueltig_bis TIMESTAMP NOT NULL,
	FOREIGN KEY(fk_ticketID) REFERENCES ticket(ticketID) ON DELETE CASCADE,
	CHECK(gueltig_ab < gueltig_bis)
);

/**********************************************************************/
/**
/** Table: Allergen
/** Developer: if19b172, if19b205
/** Description: Allergene, die in einem Produkt (Verpflegung)
/**              enthalten sind
/**
/**********************************************************************/

CREATE TABLE allergen (
	allergenID NUMBER NOT NULL CONSTRAINT allergen_pk PRIMARY KEY,
	allergen_bezeichnung VARCHAR2(50) NOT NULL UNIQUE,
	allergen_kuerzel VARCHAR2(5) NOT NULL UNIQUE
);

/**********************************************************************/
/**
/** Table: Produkt
/** Developer: if19b172, if19b205
/** Description: Verpflegung, die in einem Zug mit einem Speisewagon
/**              angeboten werden
/**
/**********************************************************************/

CREATE TABLE produkt (
	produktID NUMBER NOT NULL CONSTRAINT produkt_pk PRIMARY KEY,
	name VARCHAR2(50) NOT NULL UNIQUE,
	preis NUMBER NOT NULL
);

/**********************************************************************/
/**
/** Table: Produkt_hat_Allergen
/** Developer: if19b172, if19b205
/** Description: Zuordnung der Allergene zu einem Produkt
/**
/**********************************************************************/

CREATE TABLE produkt_hat_allergen
(
	fk_allergenID NUMBER NOT NULL,
	fk_produktID NUMBER NOT NULL,
	FOREIGN KEY(fk_produktID) REFERENCES produkt(produktID) ON DELETE CASCADE,
	FOREIGN KEY(fk_allergenID) REFERENCES allergen(allergenID) ON DELETE CASCADE,
	CONSTRAINT produkt_hat_allergen_pk PRIMARY KEY(fk_produktID,fk_allergenID)
);

/**********************************************************************/
/**
/** Table: Wagon_hat_Produkt
/** Developer: if19b172, if19b205
/** Description: Zuordnung der Produkte zu den (Speise-)Wagons, die
/**              dieses Produkt anbieten
/**
/**********************************************************************/

CREATE TABLE wagon_hat_produkt
(
	fk_wagonID NUMBER NOT NULL,
	fk_produktID NUMBER NOT NULL,
	FOREIGN KEY(fk_produktID) REFERENCES produkt(produktID) ON DELETE CASCADE,
	FOREIGN KEY(fk_wagonID) REFERENCES wagon(wagonID) ON DELETE CASCADE,
	CONSTRAINT wagon_hat_produkt_pk PRIMARY KEY(fk_produktID, fk_wagonID)
);

/**********************************************************************/
/**
/** Table: Online_Artikel
/** Developer: if19b169
/** Description: Artikel, die Kunden im Austausch gegen Kundenpunte
/**              im Chipotle-Webshop kaufen können
/**
/**********************************************************************/

CREATE TABLE online_artikel
(
    artikelID NUMBER NOT NULL CONSTRAINT online_artikel_pk PRIMARY KEY,
    bezeichnung VARCHAR2(250) NOT NULL,
    preis NUMBER NOT NULL,
    zusaetzliche_kosten NUMBER NOT NULL,
    verfuegbar_von TIMESTAMP NOT NULL,
    verfuegbar_bis TIMESTAMP NOT NULL,
    CHECK(verfuegbar_von < verfuegbar_bis)
);

/**********************************************************************/
/**
/** Table: Person_Hat_Online_Artikel
/** Developer: if19b169
/** Description: Zuordnung welche Kunden, welche Artikel gekauft haben
/**
/**********************************************************************/

CREATE TABLE person_hat_online_artikel
(
    fk_artikelID NUMBER NOT NULL,
    fk_personID NUMBER NOT NULL,
    gekauft_an TIMESTAMP NOT NULL,
    FOREIGN KEY(fk_artikelID) REFERENCES online_artikel(artikelID) ON DELETE CASCADE,
    FOREIGN KEY(fk_personID) REFERENCES person(personID) ON DELETE CASCADE,
    CONSTRAINT person_hat_online_artikel_pk PRIMARY KEY(fk_artikelID, fk_personID)
);

--Indizes--

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
