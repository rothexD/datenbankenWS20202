CREATE TABLE ort (
	plz NUMBER(4) CONSTRAINT ort_pk PRIMARY KEY,
	ort VARCHAR2(50)
);

CREATE TABLE person
(
	personID NUMBER CONSTRAINT person_pk PRIMARY KEY,
	name VARCHAR2(255),
	geburtsdatum TIMESTAMP,
	strasse_hausnummer VARCHAR2(250),
	fk_plz NUMBER,
	FOREIGN KEY(fk_plz) REFERENCES ort(plz) ON DELETE SET NULL
);

CREATE TABLE gehaltsstufe (
	gehaltsstufeID NUMBER CONSTRAINT gehaltsstufe_pk PRIMARY KEY,
	gehalt NUMBER
);

CREATE TABLE mitarbeiter_rolle (
	rollenID NUMBER CONSTRAINT mitarbeiter_rolle_pk PRIMARY KEY,
	bezeichnung VARCHAR2(50)
);

CREATE TABLE mitarbeiter
(
	fk_personID NUMBER CONSTRAINT mitarbeiter_pk PRIMARY KEY,
	sozialversicherungsnummer NUMBER(10),
	fk_gehaltsstufeID NUMBER,
	fk_rollenID NUMBER,
	FOREIGN KEY(fk_personID) REFERENCES person(personID) ON DELETE CASCADE,
	FOREIGN KEY(fk_gehaltsstufeID) REFERENCES gehaltsstufe(gehaltsstufeID) ON DELETE SET NULL,
	FOREIGN KEY(fk_rollenID) REFERENCES mitarbeiter_rolle(rollenID) ON DELETE SET NULL
);

CREATE TABLE kunde
(
	fk_personID NUMBER CONSTRAINT kunde_pk PRIMARY KEY,
	email VARCHAR2(250),
	kreditkartennummer NUMBER,
	kundennummer NUMBER,
	FOREIGN KEY(fk_personID) REFERENCES person(personID) ON DELETE CASCADE
);

CREATE Table bahnhof
(
	bahnhofID NUMBER CONSTRAINT bahnhof_pk PRIMARY KEY,
	bezeichnung varchar2(250),
	adresse VARCHAR2(250),
	fk_plz NUMBER,
	FOREIGN KEY(fk_plz) REFERENCES ort(plz) ON DELETE SET NULL
);

CREATE TABLE bahnsteig
(	
	bahnsteigID NUMBER CONSTRAINT bahnsteig_pk PRIMARY KEY,
	fk_bahnhofID NUMBER,
	bezeichnung VARCHAR2(25),
	FOREIGN KEY(fk_bahnhofID) REFERENCES bahnhof(bahnhofID) ON DELETE CASCADE
);

CREATE TABLE zug
(
	zugID NUMBER CONSTRAINT zug_pk PRIMARY KEY,
	seriennummer VARCHAR2(250)
);

CREATE TABLE wagon_art
(
	wagon_artID NUMBER CONSTRAINT wagon_art_pk PRIMARY KEY,
	aufgabe	VARCHAR2(50),
	kapazitaet NUMBER,
	klasse NUMBER
);

CREATE TABLE wagon
(
	wagonID NUMBER CONSTRAINT wagon_pk PRIMARY KEY,
	baujahr TIMESTAMP,
	letzte_wartung TIMESTAMP,
	fk_wagon_artID NUMBER,
	FOREIGN KEY(fk_wagon_artID) REFERENCES wagon_art(wagon_artID) ON DELETE SET NULL,
	CHECK(letzte_wartung >= baujahr)
);

CREATE TABLE lokomotive
(
	lokomotivID NUMBER CONSTRAINT lokomotive_pk PRIMARY KEY,
	baujahr TIMESTAMP,
	leistung NUMBER,
	letzte_wartung TIMESTAMP,
	CHECK(letzte_wartung >= baujahr)
);

-- ein zug hat keinen bis meherere wagons
CREATE TABLE zug_hat_wagons
(
	fk_zugID NUMBER,
	fk_wagonID NUMBER,
	FOREIGN KEY(fk_zugID) REFERENCES zug(zugID) ON DELETE CASCADE,
	FOREIGN KEY(fk_wagonID) REFERENCES wagon(wagonID) ON DELETE CASCADE,
	CONSTRAINT zug_hat_wagons_pk PRIMARY KEY(fk_zugID, fk_wagonID)
);

-- ein zug hat einen bis viele wagons
CREATE TABLE zug_hat_lokomotiven
(
	fk_zugID NUMBER,
	fk_lokomotivID NUMBER,
	FOREIGN KEY(fk_zugID) REFERENCES zug(zugID) ON DELETE CASCADE,
	FOREIGN KEY(fk_lokomotivID) REFERENCES lokomotive(lokomotivID) ON DELETE CASCADE,
	CONSTRAINT zug_hat_lokomotiven_pk PRIMARY KEY(fk_zugID,fk_lokomotivID)
);

CREATE TABLE verbindung
(
	verbindungID NUMBER CONSTRAINT verbindung_pk PRIMARY KEY,
	fk_ankunft_bahnsteig NUMBER,
	fk_abfahrt_bahnsteig NUMBER,
	fk_zugID NUMBER,
	abfahrt_uhrzeit TIMESTAMP,
	ankunft_uhrzeit TIMESTAMP,
	FOREIGN KEY(fk_ankunft_bahnsteig) REFERENCES bahnsteig(bahnsteigID) ON DELETE CASCADE,
	FOREIGN KEY(fk_abfahrt_bahnsteig) REFERENCES bahnsteig(bahnsteigID) ON DELETE CASCADE,
	FOREIGN KEY(fk_zugID) REFERENCES zug(zugID) ON DELETE SET NULL,
	CHECK(abfahrt_uhrzeit < ankunft_uhrzeit)
);

CREATE TABLE wartung (
	wartungsID NUMBER CONSTRAINT wartung_pk PRIMARY KEY,
	start_wartung TIMESTAMP,
	ende_wartung TIMESTAMP,
	fk_zugID NUMBER,
	FOREIGN KEY(fk_zugID) REFERENCES zug(zugID) ON DELETE CASCADE
);

CREATE TABLE servicedesk (
	servicedeskID NUMBER CONSTRAINT servicedesk_pk PRIMARY KEY,
	rufnummer VARCHAR2(50),
	fk_bahnhofID NUMBER,
	FOREIGN KEY(fk_bahnhofID) REFERENCES bahnhof(bahnhofID) ON DELETE CASCADE
);

CREATE TABLE ticket_art (
	ticket_artID NUMBER CONSTRAINT ticket_art_pk PRIMARY KEY,
	bezeichnung VARCHAR2(50)
);

CREATE TABLE ticket
(
	ticketID NUMBER CONSTRAINT ticket_pk PRIMARY KEY,
	fk_ticket_artID NUMBER,
	fk_personID NUMBER,
	preis NUMBER,
	kaufdatum TIMESTAMP,
	FOREIGN KEY(fk_personID) REFERENCES person(personID) ON DELETE CASCADE,
	FOREIGN KEY(fk_ticket_artID) REFERENCES ticket_art(ticket_artID) ON DELETE SET NULL
);

CREATE TABLE one_time_ticket (
	fk_ticketID NUMBER CONSTRAINT one_time_ticket_pk PRIMARY KEY,
	fk_verbindungID NUMBER,
	already_scanned NUMBER(1) DEFAULT 0,
	CHECK (already_scanned between 0 and 1),
	FOREIGN KEY(fk_verbindungID) REFERENCES verbindung(verbindungID) ON DELETE SET NULL,
	FOREIGN KEY(fk_ticketID) REFERENCES ticket(ticketID) ON DELETE CASCADE
);

CREATE TABLE mehrfachticket
(
	fk_ticketID NUMBER CONSTRAINT mehrfachticket_pk PRIMARY KEY,
	gueltig_ab TIMESTAMP,
	gueltig_bis TIMESTAMP,
	FOREIGN KEY(fk_ticketID) REFERENCES ticket(ticketID) ON DELETE CASCADE
);

CREATE TABLE allergen (
	allergenID NUMBER CONSTRAINT allergen_pk PRIMARY KEY,
	allergen_bezeichnung VARCHAR2(50),
	allergen_kuerzel VARCHAR2(5)
);

CREATE TABLE produkt (
	produktID NUMBER CONSTRAINT verpflegung_pk PRIMARY KEY,
	name VARCHAR2(50),
	preis NUMBER
);

CREATE TABLE produkt_hat_allergen
(
	fk_allergenID NUMBER,
	fk_produktID NUMBER,
	FOREIGN KEY(fk_produktID) REFERENCES produkt(produktID) ON DELETE CASCADE,
	FOREIGN KEY(fk_allergenID) REFERENCES allergen(allergenID) ON DELETE CASCADE,
	CONSTRAINT produkt_hat_allergen_pk PRIMARY KEY(fk_produktID,fk_allergenID)
);

CREATE TABLE wagon_hat_produkt
(
	fk_wagonID NUMBER,
	fk_produktID NUMBER,
	FOREIGN KEY(fk_produktID) REFERENCES produkt(produktID) ON DELETE CASCADE,
	FOREIGN KEY(fk_wagonID) REFERENCES wagon(wagonID) ON DELETE CASCADE,
	CONSTRAINT wagon_hat_produkt_pk PRIMARY KEY(fk_produktID, fk_wagonID)
);