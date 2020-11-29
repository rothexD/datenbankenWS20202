/**********************************************************************/
/**
/** Table: Ort
/** Developer: if19b172, if19b205
/** Description: Name und PLZ aller Orte für die eine Adresse hinterlegt ist
/**
/**********************************************************************/

CREATE TABLE ort (
	plz NUMBER(4) CONSTRAINT ort_pk PRIMARY KEY,
	ort VARCHAR2(50)
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
	personID NUMBER CONSTRAINT person_pk PRIMARY KEY,
	name VARCHAR2(255),
	geburtsdatum TIMESTAMP,
	strasse_hausnummer VARCHAR2(250),
	fk_plz NUMBER,
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
	gehaltsstufeID NUMBER CONSTRAINT gehaltsstufe_pk PRIMARY KEY,
	gehalt NUMBER
);

/**********************************************************************/
/**
/** Table: Mitarbeiter_Rolle
/** Developer: if19b172, if19b205
/** Description: Funktionen, die ein Mitarbeiter, annehmen kann
/**
/**********************************************************************/

CREATE TABLE mitarbeiter_rolle (
	rollenID NUMBER CONSTRAINT mitarbeiter_rolle_pk PRIMARY KEY,
	bezeichnung VARCHAR2(50)
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
	fk_personID NUMBER CONSTRAINT mitarbeiter_pk PRIMARY KEY,
	sozialversicherungsnummer NUMBER(10),
	fk_gehaltsstufeID NUMBER,
	fk_rollenID NUMBER,
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
	fk_personID NUMBER CONSTRAINT kunde_pk PRIMARY KEY,
	email VARCHAR2(250),
	kreditkartennummer NUMBER,
	kundennummer NUMBER,
	punkte NUMBER,
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
	bahnhofID NUMBER CONSTRAINT bahnhof_pk PRIMARY KEY,
	bezeichnung varchar2(250),
	adresse VARCHAR2(250),
	fk_plz NUMBER,
	langitude NUMBER(8, 6),
	longitude NUMBER(9, 6),
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
	bahnsteigID NUMBER CONSTRAINT bahnsteig_pk PRIMARY KEY,
	fk_bahnhofID NUMBER,
	bezeichnung VARCHAR2(25),
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
	zugID NUMBER CONSTRAINT zug_pk PRIMARY KEY,
	seriennummer VARCHAR2(14)
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
	wagon_artID NUMBER CONSTRAINT wagon_art_pk PRIMARY KEY,
	aufgabe	VARCHAR2(50),
	kapazitaet NUMBER,
	klasse NUMBER
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
	wagonID NUMBER CONSTRAINT wagon_pk PRIMARY KEY,
	baujahr TIMESTAMP,
	letzte_wartung TIMESTAMP,
	fk_wagon_artID NUMBER,
	fk_zugID NUMBER,
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
	lokomotivID NUMBER CONSTRAINT lokomotive_pk PRIMARY KEY,
	baujahr TIMESTAMP,
	leistung NUMBER,
	letzte_wartung TIMESTAMP,
	fk_zugID NUMBER,
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

/**********************************************************************/
/**
/** Table: Wartung
/** Developer: if19b172, if19b205
/** Description: Wartungsarbeiten, die an einem Zug in einem Zeitfenster
/**              durchgeführt werden
/**
/**********************************************************************/

CREATE TABLE wartung (
	wartungsID NUMBER CONSTRAINT wartung_pk PRIMARY KEY,
	start_wartung TIMESTAMP,
	ende_wartung TIMESTAMP,
	fk_zugID NUMBER,
	FOREIGN KEY(fk_zugID) REFERENCES zug(zugID) ON DELETE CASCADE
);

/**********************************************************************/
/**
/** Table: ServiceDesk
/** Developer: if19b172, if19b205
/** Description: Schalter, die an einem Bahnhof existieren können
/**
/**********************************************************************/

CREATE TABLE servicedesk (
	servicedeskID NUMBER CONSTRAINT servicedesk_pk PRIMARY KEY,
	rufnummer VARCHAR2(50),
	fk_bahnhofID NUMBER,
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
	ticket_artID NUMBER CONSTRAINT ticket_art_pk PRIMARY KEY,
	bezeichnung VARCHAR2(50),
	punkte NUMBER
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
	ticketID NUMBER CONSTRAINT ticket_pk PRIMARY KEY,
	fk_ticket_artID NUMBER,
	fk_personID NUMBER,
	preis NUMBER,
	kaufdatum TIMESTAMP,
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
	fk_ticketID NUMBER CONSTRAINT one_time_ticket_pk PRIMARY KEY,
	fk_verbindungID NUMBER,
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
	fk_ticketID NUMBER CONSTRAINT mehrfachticket_pk PRIMARY KEY,
	gueltig_ab TIMESTAMP,
	gueltig_bis TIMESTAMP,
	FOREIGN KEY(fk_ticketID) REFERENCES ticket(ticketID) ON DELETE CASCADE
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
	allergenID NUMBER CONSTRAINT allergen_pk PRIMARY KEY,
	allergen_bezeichnung VARCHAR2(50),
	allergen_kuerzel VARCHAR2(5)
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
	produktID NUMBER CONSTRAINT produkt_pk PRIMARY KEY,
	name VARCHAR2(50),
	preis NUMBER
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
	fk_allergenID NUMBER,
	fk_produktID NUMBER,
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
	fk_wagonID NUMBER,
	fk_produktID NUMBER,
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
    artikelID NUMBER CONSTRAINT online_artikel_pk PRIMARY KEY,
    bezeichnung VARCHAR2(250),
    preis NUMBER,
    zusaetzliche_kosten NUMBER,
    verfuegbar_von TIMESTAMP,
    verfuegbar_bis TIMESTAMP,
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
    fk_artikelID NUMBER,
    fk_personID NUMBER,
    gekauft_an TIMESTAMP,
    FOREIGN KEY(fk_artikelID) REFERENCES online_artikel(artikelID) ON DELETE CASCADE,
    FOREIGN KEY(fk_personID) REFERENCES person(personID) ON DELETE CASCADE,
    CONSTRAINT person_hat_online_artikel_pk PRIMARY KEY(fk_artikelID, fk_personID)
);
