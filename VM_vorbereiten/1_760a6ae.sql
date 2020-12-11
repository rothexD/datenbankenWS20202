-- Originale (unveränderte) Flughafenbase-VM verwenden und alles als SYSTEM-User durchlaufen lassen!



/**********************************************************************/
/**
/** Table: Ort
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
/** Description: Personen, die sich bei Chipotle registriert haben
/**
/**********************************************************************/

CREATE TABLE kunde
(
	fk_personID NUMBER NOT NULL CONSTRAINT kunde_pk PRIMARY KEY,
	kreditkartennummer NUMBER NOT NULL,
	kundennummer NUMBER NOT NULL UNIQUE,
	punkte NUMBER DEFAULT 0,
	FOREIGN KEY(fk_personID) REFERENCES person(personID) ON DELETE CASCADE
);

/**********************************************************************/
/**
/** Table: Bahnhof
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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
/** Developer: Elisabeth Glatz, Lukas Schweinberger
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








------ SEQUENCES ------

CREATE SEQUENCE person_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

CREATE SEQUENCE bahnhof_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

CREATE SEQUENCE bahnsteig_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

CREATE SEQUENCE mitarbeiter_rolle_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

CREATE SEQUENCE gehaltsstufe_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

CREATE SEQUENCE servicedesk_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

CREATE SEQUENCE zug_id_seq
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 0
    NOCYCLE
    NOCACHE
;

CREATE SEQUENCE wagon_id_seq
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 0
    NOCYCLE
    NOCACHE
;

CREATE SEQUENCE wagon_art_id_seq
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 0
    NOCYCLE
    NOCACHE
;

CREATE SEQUENCE lokomotive_id_seq
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 0
    NOCYCLE
    NOCACHE
;

CREATE SEQUENCE allergen_id_seq
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 0
    NOCYCLE
    NOCACHE
;

CREATE SEQUENCE produkt_id_seq
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 0
    NOCYCLE
    NOCACHE
;


CREATE SEQUENCE wartung_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

CREATE SEQUENCE verbindung_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

CREATE SEQUENCE ticket_art_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

CREATE SEQUENCE ticket_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

CREATE SEQUENCE artikel_id_seq
	INCREMENT BY 1
	START WITH 1
	NOMAXVALUE
	MINVALUE 0
	NOCYCLE
	NOCACHE
;

------ INSERT DATA ------

-- ort
INSERT INTO ort VALUES (1010, 'Wien');
INSERT INTO ort VALUES (1020, 'Wien');
INSERT INTO ort VALUES (1030, 'Wien');
INSERT INTO ort VALUES (1040, 'Wien');
INSERT INTO ort VALUES (1050, 'Wien');
INSERT INTO ort VALUES (1060, 'Wien');
INSERT INTO ort VALUES (1070, 'Wien');
INSERT INTO ort VALUES (1080, 'Wien');
INSERT INTO ort VALUES (1090, 'Wien');
INSERT INTO ort VALUES (1100, 'Wien');
INSERT INTO ort VALUES (1110, 'Wien');
INSERT INTO ort VALUES (1120, 'Wien');
INSERT INTO ort VALUES (1130, 'Wien');
INSERT INTO ort VALUES (1140, 'Wien');
INSERT INTO ort VALUES (1150, 'Wien');
INSERT INTO ort VALUES (1160, 'Wien');
INSERT INTO ort VALUES (1170, 'Wien');
INSERT INTO ort VALUES (1180, 'Wien');
INSERT INTO ort VALUES (1190, 'Wien');
INSERT INTO ort VALUES (1200, 'Wien');
INSERT INTO ort VALUES (1210, 'Wien');
INSERT INTO ort VALUES (1220, 'Wien');
INSERT INTO ort VALUES (1230, 'Wien');
INSERT INTO ort VALUES (4020, 'Linz');
INSERT INTO ort VALUES (8010, 'Graz');
INSERT INTO ort VALUES (6900, 'Bregenz');
INSERT INTO ort VALUES (2130, 'Mistelbach');
INSERT INTO ort VALUES (5020, 'Salzburg');





-- personen (kunden und mitarbeiter)
-- kunden
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Herbert Hinterholz', TO_DATE('03.04.1993','DD.MM.YYYY'), 'Holzweg 5', 1010, 'holz@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Susi Sorglos', TO_DATE('03.04.1993','DD.MM.YYYY'), 'Wollzeile 12', 1010, 'sorglos@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Josef Brot', TO_DATE('13.05.1994','DD.MM.YYYY'), 'Burgring 2', 1020, 'brot@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Philipp Philipovic', TO_DATE('03.07.1992','DD.MM.YYYY'), 'Samgasse 1', 1020, 'philipovic@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Jakob Jagd', TO_DATE('03.07.1965','DD.MM.YYYY'), 'Jakobsweg 5', 1030, 'jagd@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Sieglinde Lindenbaum', TO_DATE('13.08.1990','DD.MM.YYYY'), 'Nikoloweg 1', 1040, 'lindenbaum@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Martina Hinterholz', TO_DATE('08.09.2000','DD.MM.YYYY'), 'Krampusgasse 525', 8010, 'holz1@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Eveline Hinterholz', TO_DATE('13.10.1993','DD.MM.YYYY'), 'Schottentor 25', 1010, 'holz2@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Johanna Ananas', TO_DATE('03.11.1993','DD.MM.YYYY'), 'Rennweg 15', 1090, 'ananas@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Barbara Lindefrau', TO_DATE('14.12.2000','DD.MM.YYYY'), 'Zwerggasse 15', 1010, 'lindefrau@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Tanja Müller', TO_DATE('24.01.1975','DD.MM.YYYY'), 'Dresdner Strasse 1', 1040, 'mueller@mail.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Lisa Ziegelstein', TO_DATE('13.03.1960','DD.MM.YYYY'), 'Am Berg 1', 8010, 'ziegelstein@mail.com', '-');

-- mitarbeiter
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Peter Bahnfreund', TO_DATE('11.03.1960','DD.MM.YYYY'), 'Heumarkt 13', 1010, 'bahnfreund@chipotle.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Zohan Zugfan', TO_DATE('13.03.1980','DD.MM.YYYY'), 'Nordpol 3', 1020, 'zugfan@chipotle.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Michael Gleisbauer', TO_DATE('13.03.1967','DD.MM.YYYY'), 'Teuergasse 1', 1190, 'gleisbauer@chipotle.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Johann Putz', TO_DATE('13.03.1990','DD.MM.YYYY'), 'Kebabweg 22', 1100, 'putz@chipotle.com', '-');
INSERT INTO person VALUES (person_id_seq.NEXTVAL, 'Raffael Arbeiter', TO_DATE('13.03.1920','DD.MM.YYYY'), 'Landberg 4', 1030, 'arbeiter@chipotle.com', 'N6y62HLflNkRU/EBs/IPHCasKJGnMi/DhadDA2vGcRQ=');





-- bahnhof
INSERT INTO bahnhof VALUES (bahnhof_id_seq.NEXTVAL, 'BF Graz', 'Bahnhofsplatz 1', 8010, 47.076668, 15.421371);
INSERT INTO bahnhof VALUES (bahnhof_id_seq.NEXTVAL, 'HBF Wien', 'Bahnhofsplatz 1', 1100, 48.210033, 16.363449);
INSERT INTO bahnhof VALUES (bahnhof_id_seq.NEXTVAL, 'BF Linz', 'Bahnhofsplatz 1', 4020, 47.861400, 15.029853);
INSERT INTO bahnhof VALUES (bahnhof_id_seq.NEXTVAL, 'BF Bregenz', 'Bahnhofsplatz 1', 6900, 47.503110, 9.747100);
INSERT INTO bahnhof VALUES (bahnhof_id_seq.NEXTVAL, 'BF Mistelbach', 'Bahnhofsplatz 1', 2130, 48.567430, 16.572200);
INSERT INTO bahnhof VALUES (bahnhof_id_seq.NEXTVAL, 'BF Salzburg', 'Bahnhofsplatz 1', 5020, 47.811195, 13.033229);





-- kunde
INSERT INTO kunde VALUES (1, 4030465715644984, 1000000,20);
INSERT INTO kunde VALUES (2, 4030465715644984, 1000001,10);
INSERT INTO kunde VALUES (3, 4030465715644984, 1000002,0);
INSERT INTO kunde VALUES (4, 4030465715644984, 1000003,0);
INSERT INTO kunde VALUES (5, 4030465715644984, 1000004,0);
INSERT INTO kunde VALUES (6, 4030465715644984, 1000005,0);
INSERT INTO kunde VALUES (7, 4030465715644984, 1000006,0);
INSERT INTO kunde VALUES (8, 4030465715644984, 1000007,0);
INSERT INTO kunde VALUES (9, 4030465715644984, 1000008,0);
INSERT INTO kunde VALUES (10, 4030465715644984, 1000009,0);
INSERT INTO kunde VALUES (11, 4030465715644984, 1000010,0);
INSERT INTO kunde VALUES (12, 4030465715644984, 1000011,0);





-- bahnsteige
-- jeder Bahnhof hat 3 Bahnsteige A, B, C
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 1, 'A');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 1, 'B');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 1, 'C');

INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 2, 'A');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 2, 'B');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 2, 'C');

INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 3, 'A');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 3, 'B');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 3, 'C');

INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 4, 'A');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 4, 'B');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 4, 'C');

INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 5, 'A');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 5, 'B');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 5, 'C');

INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 6, 'A');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 6, 'B');
INSERT INTO bahnsteig VALUES (bahnsteig_id_seq.NEXTVAL, 6, 'C');





-- mitarbeiterrollen
INSERT INTO mitarbeiter_rolle VALUES (mitarbeiter_rolle_id_seq.NEXTVAL, 'SchaffnerIn');
INSERT INTO mitarbeiter_rolle VALUES (mitarbeiter_rolle_id_seq.NEXTVAL, 'LokführerIn');
INSERT INTO mitarbeiter_rolle VALUES (mitarbeiter_rolle_id_seq.NEXTVAL, 'Reinigungskraft');
INSERT INTO mitarbeiter_rolle VALUES (mitarbeiter_rolle_id_seq.NEXTVAL, 'ServicedeskmitarbeiterIn');
INSERT INTO mitarbeiter_rolle VALUES (mitarbeiter_rolle_id_seq.NEXTVAL, 'Servicekraft');
INSERT INTO mitarbeiter_rolle VALUES (mitarbeiter_rolle_id_seq.NEXTVAL, 'VerkäuferIn');





-- gehaltsstufe
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 1500);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 1600);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 1700);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 1800);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 1900);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 2000);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 2100);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 2200);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 2300);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 2400);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 2500);
INSERT INTO gehaltsstufe VALUES (gehaltsstufe_id_seq.NEXTVAL, 2600);





-- mitarbeiter
INSERT INTO mitarbeiter VALUES (13, 5431030493, 1, 1);
INSERT INTO mitarbeiter VALUES (14, 5431030493, 2, 2);
INSERT INTO mitarbeiter VALUES (15, 5431030493, 3, 3);
INSERT INTO mitarbeiter VALUES (16, 5431030493, 4, 4);
INSERT INTO mitarbeiter VALUES (17, 5431030493, 5, 5);





-- servicedesk
INSERT INTO servicedesk VALUES (servicedesk_id_seq.NEXTVAL, '01500600', 1);
INSERT INTO servicedesk VALUES (servicedesk_id_seq.NEXTVAL, '02500600', 2);
INSERT INTO servicedesk VALUES (servicedesk_id_seq.NEXTVAL, '03500600', 3);
INSERT INTO servicedesk VALUES (servicedesk_id_seq.NEXTVAL, '04500600', 4);
INSERT INTO servicedesk VALUES (servicedesk_id_seq.NEXTVAL, '05500600', 5);
INSERT INTO servicedesk VALUES (servicedesk_id_seq.NEXTVAL, '06500600', 6);




-- wagon art
INSERT INTO wagon_art VALUES (wagon_art_id_seq.NEXTVAL,'Speisewagen',2,1);
INSERT INTO wagon_art VALUES (wagon_art_id_seq.NEXTVAL,'Personenwagen',40,2);
INSERT INTO wagon_art VALUES (wagon_art_id_seq.NEXTVAL,'Personenwagen',16,1);
INSERT INTO wagon_art VALUES (wagon_art_id_seq.NEXTVAL,'Güterwagen',10000,0);
INSERT INTO wagon_art VALUES (wagon_art_id_seq.NEXTVAL,'eventwagon',5,3);


-- zug
INSERT INTO zug VALUES (zug_id_seq.NEXTVAL,6153-6159-4860);
INSERT INTO zug VALUES (zug_id_seq.NEXTVAL,4532-5820-1442);
INSERT INTO zug VALUES (zug_id_seq.NEXTVAL,8752-4601-9346);
INSERT INTO zug VALUES (zug_id_seq.NEXTVAL,5420-1367-4536);
INSERT INTO zug VALUES (zug_id_seq.NEXTVAL,4186-3108-9615);
INSERT INTO zug VALUES (zug_id_seq.NEXTVAL,4568-1138-4138);

-- wagon
INSERT INTO wagon VALUES (wagon_id_seq.NEXTVAL,TO_DATE('2002-07-11', 'YYYY-MM-DD'),TO_DATE('2012-10-25', 'YYYY-MM-DD'),1,1);
INSERT INTO wagon VALUES (wagon_id_seq.NEXTVAL,TO_DATE('2014-02-12', 'YYYY-MM-DD'),TO_DATE('2015-09-04', 'YYYY-MM-DD'),2,1);
INSERT INTO wagon VALUES (wagon_id_seq.NEXTVAL,TO_DATE('2005-06-05', 'YYYY-MM-DD'),TO_DATE('2007-01-03', 'YYYY-MM-DD'),3,1);
INSERT INTO wagon VALUES (wagon_id_seq.NEXTVAL,TO_DATE('2012-12-30', 'YYYY-MM-DD'),TO_DATE('2013-07-24', 'YYYY-MM-DD'),4,2);
INSERT INTO wagon VALUES (wagon_id_seq.NEXTVAL,TO_DATE('2000-11-23', 'YYYY-MM-DD'),TO_DATE('2008-09-27', 'YYYY-MM-DD'),5,3);
INSERT INTO wagon VALUES (wagon_id_seq.NEXTVAL,TO_DATE('2001-11-20', 'YYYY-MM-DD'),TO_DATE('2009-01-12', 'YYYY-MM-DD'),4,4);
INSERT INTO wagon VALUES (wagon_id_seq.NEXTVAL,TO_DATE('2015-01-11', 'YYYY-MM-DD'),TO_DATE('2016-01-15', 'YYYY-MM-DD'),2,5);
INSERT INTO wagon VALUES (wagon_id_seq.NEXTVAL,TO_DATE('2013-12-04', 'YYYY-MM-DD'),TO_DATE('2018-08-01', 'YYYY-MM-DD'),1,6);


-- lokomotive
INSERT INTO lokomotive VALUES (lokomotive_id_seq.NEXTVAL,TO_DATE('2004-10-04', 'YYYY-MM-DD'),1000,TO_DATE('2006-10-04', 'YYYY-MM-DD'),1);
INSERT INTO lokomotive VALUES (lokomotive_id_seq.NEXTVAL,TO_DATE('2005-02-22', 'YYYY-MM-DD'),5431,TO_DATE('2007-02-22', 'YYYY-MM-DD'),1);
INSERT INTO lokomotive VALUES (lokomotive_id_seq.NEXTVAL,TO_DATE('2007-07-27', 'YYYY-MM-DD'),20000,TO_DATE('2017-07-27', 'YYYY-MM-DD'),2);
INSERT INTO lokomotive VALUES (lokomotive_id_seq.NEXTVAL,TO_DATE('2008-03-30', 'YYYY-MM-DD'),1100,TO_DATE('2018-03-30', 'YYYY-MM-DD'),3);
INSERT INTO lokomotive VALUES (lokomotive_id_seq.NEXTVAL,TO_DATE('2009-02-02', 'YYYY-MM-DD'),9784,TO_DATE('2010-02-02', 'YYYY-MM-DD'),4);
INSERT INTO lokomotive VALUES (lokomotive_id_seq.NEXTVAL,TO_DATE('2015-08-10', 'YYYY-MM-DD'),10000,TO_DATE('2016-08-10', 'YYYY-MM-DD'),5);
INSERT INTO lokomotive VALUES (lokomotive_id_seq.NEXTVAL,TO_DATE('2016-11-09', 'YYYY-MM-DD'),11000,TO_DATE('2020-11-09', 'YYYY-MM-DD'),6);



INSERT INTO allergen  VALUES (allergen_id_seq.NEXTVAL,'Gluten','A');
INSERT INTO allergen  VALUES (allergen_id_seq.NEXTVAL,'Krebstiere','B');
INSERT INTO allergen  VALUES (allergen_id_seq.NEXTVAL,'Eier','C');
INSERT INTO allergen  VALUES (allergen_id_seq.NEXTVAL,'Fisch','D');
INSERT INTO allergen  VALUES (allergen_id_seq.NEXTVAL,'Erdnüsse','E');

INSERT INTO produkt VALUES (produkt_id_seq.NEXTVAL,'Schnitzel',8.90);
INSERT INTO produkt VALUES (produkt_id_seq.NEXTVAL,'Erdnusssnack',4);
INSERT INTO produkt VALUES (produkt_id_seq.NEXTVAL,'Eiernockerl',6);
INSERT INTO produkt VALUES (produkt_id_seq.NEXTVAL,'Wasser',2);
INSERT INTO produkt VALUES (produkt_id_seq.NEXTVAL,'Cola',3);

INSERT INTO produkt_hat_allergen VALUES (5,2);
INSERT INTO produkt_hat_allergen VALUES (3,3);

INSERT INTO wagon_hat_produkt VALUES (1,1);
INSERT INTO wagon_hat_produkt VALUES (1,2);
INSERT INTO wagon_hat_produkt VALUES (1,3);
INSERT INTO wagon_hat_produkt VALUES (1,4);
INSERT INTO wagon_hat_produkt VALUES (1,5);

INSERT INTO wagon_hat_produkt VALUES (8,1);
INSERT INTO wagon_hat_produkt VALUES (8,2);
INSERT INTO wagon_hat_produkt VALUES (8,3);



-- wartung
INSERT INTO wartung VALUES (wartung_id_seq.NEXTVAL, (TO_TIMESTAMP('2020-11-03 06:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-03 08:00', 'YYYY-MM-DD HH24:MI')), 1);
INSERT INTO wartung VALUES (wartung_id_seq.NEXTVAL, (TO_TIMESTAMP('2020-11-15 10:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-15 11:00', 'YYYY-MM-DD HH24:MI')), 1);
INSERT INTO wartung VALUES (wartung_id_seq.NEXTVAL, (TO_TIMESTAMP('2020-11-05 06:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-05 08:00', 'YYYY-MM-DD HH24:MI')), 2);
INSERT INTO wartung VALUES (wartung_id_seq.NEXTVAL, (TO_TIMESTAMP('2020-11-06 06:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-06 08:00', 'YYYY-MM-DD HH24:MI')), 2);
INSERT INTO wartung VALUES (wartung_id_seq.NEXTVAL, (TO_TIMESTAMP('2020-11-07 07:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-07 09:00', 'YYYY-MM-DD HH24:MI')), 3);
INSERT INTO wartung VALUES (wartung_id_seq.NEXTVAL, (TO_TIMESTAMP('2020-11-12 10:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-12 11:00', 'YYYY-MM-DD HH24:MI')), 4);
INSERT INTO wartung VALUES (wartung_id_seq.NEXTVAL, (TO_TIMESTAMP('2020-11-15 10:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-15 11:00', 'YYYY-MM-DD HH24:MI')), 5);
INSERT INTO wartung VALUES (wartung_id_seq.NEXTVAL, (TO_TIMESTAMP('2020-11-25 10:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-25 11:00', 'YYYY-MM-DD HH24:MI')), 6);


-- verbindungen
-- Wien - Graz (von Wien Bahnsteig A nach Graz Bahnsteig C)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 6, 4, 1, (TO_TIMESTAMP('2020-11-26 10:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-26 12:30', 'YYYY-MM-DD HH24:MI')));
-- Graz - Wien (von Graz Bahnsteig C nach Wien Bahnsteig A)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 4, 6, 1, (TO_TIMESTAMP('2020-11-26 13:30', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-26 15:00', 'YYYY-MM-DD HH24:MI')));

-- Wien - Linz (von Wien Bahnsteig A nach Linz Bahnsteig B)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 4, 8, 2, (TO_TIMESTAMP('2020-11-26 08:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-26 09:30', 'YYYY-MM-DD HH24:MI')));
-- Linz - Wien (von Linz Bahnsteig B nach Wien Bahnsteig C)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 8, 4, 2, (TO_TIMESTAMP('2020-11-26 08:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-26 09:30', 'YYYY-MM-DD HH24:MI')));

-- Wien - Bregenz (von Wien Bahnsteig B nach Bregenz Bahnsteig A)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 10, 5, 3, (TO_TIMESTAMP('2020-11-26 09:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-26 18:00', 'YYYY-MM-DD HH24:MI')));
-- Bregenz - Wien (von Bregenz Bahnsteig A nach Wien Bahnsteig B)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 5, 10, 3, (TO_TIMESTAMP('2020-11-27 21:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-28 06:00', 'YYYY-MM-DD HH24:MI')));

-- Wien - Salzburg (von Wien Bahnsteig B nach Salzburg Bahnsteig A)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 16, 5, 4, (TO_TIMESTAMP('2020-11-28 09:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-28 12:00', 'YYYY-MM-DD HH24:MI')));
-- Salzburg - Wien (von Salzburg Bahnsteig A nach Wien Bahnsteig B)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 5, 16, 4, (TO_TIMESTAMP('2020-11-28 15:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-11-28 18:00', 'YYYY-MM-DD HH24:MI')));





-- ticketarten
INSERT INTO ticket_art VALUES (ticket_art_id_seq.NEXTVAL, 'Standardkarte',200);
INSERT INTO ticket_art VALUES (ticket_art_id_seq.NEXTVAL, 'Studentenkarte',150);
INSERT INTO ticket_art VALUES (ticket_art_id_seq.NEXTVAL, 'Seniorenkarte',50);
INSERT INTO ticket_art VALUES (ticket_art_id_seq.NEXTVAL, 'Kinderkarte',100);
INSERT INTO ticket_art VALUES (ticket_art_id_seq.NEXTVAL, 'Gruppenkarte',300);
INSERT INTO ticket_art VALUES (ticket_art_id_seq.NEXTVAL, 'Schuelerkarte',100);

-- tickets
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 1, 1, 10, TO_DATE('10.10.2020', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 1, 1, 5, TO_DATE('11.10.2020', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 2, 3, 5, TO_DATE('24.12.2020', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 5, 12, 7, TO_DATE('11.10.2020', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 5, 13, 7, TO_DATE('11.10.2020', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 5, 14, 7, TO_DATE('11.10.2020', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 3, 3, 17, TO_DATE('24.12.2020', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 3, 3, 150, TO_DATE('01.02.2021', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 4, 10, 200, TO_DATE('01.01.2021', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 4, 10, 10, TO_DATE('15.11.2020', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 6, 7, 3, TO_DATE('26.12.2020', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 6, 7, 5, TO_DATE('27.12.2020', 'DD.MM.YYYY'));
INSERT INTO ticket VALUES (ticket_id_seq.NEXTVAL, 2, 8, 5, TO_DATE('1.12.2020', 'DD.MM.YYYY'));


-- mehrfachticket
INSERT INTO mehrfachticket VALUES (1,timestamp '2020-10-10 0:0:0.0',timestamp '2020-11-10 0:0:0.0');
INSERT INTO mehrfachticket VALUES (3,timestamp '2020-12-24 0:0:0.0',timestamp '2021-01-24 0:0:0.0');
INSERT INTO mehrfachticket VALUES (4,timestamp '2020-10-11 0:0:0.0',timestamp '2020-10-12 0:0:0.0');
INSERT INTO mehrfachticket VALUES (5,timestamp '2020-10-11 0:0:0.0',timestamp '2020-10-12 0:0:0.0');
INSERT INTO mehrfachticket VALUES (6,timestamp '2020-10-11 0:0:0.0',timestamp '2020-10-12 0:0:0.0');
INSERT INTO mehrfachticket VALUES (8,timestamp '2021-02-01 0:0:0.0',timestamp '2022-02-01 0:0:0.0');
INSERT INTO mehrfachticket VALUES (9,timestamp '2021-01-01 0:0:0.0',timestamp '2022-01-01 0:0:0.0');


-- onetimeticket
INSERT INTO one_time_ticket VALUES (2,1,1);
INSERT INTO one_time_ticket VALUES (7,8,0);
INSERT INTO one_time_ticket VALUES (10,4,1);
INSERT INTO one_time_ticket VALUES (11,3,0);
INSERT INTO one_time_ticket VALUES (12,7,0);
INSERT INTO one_time_ticket VALUES (13,5,0);

--onlineArtikel
INSERT INTO online_artikel VALUES (artikel_id_seq.NEXTVAL,'dreirad',2000,120,timestamp '2019-02-01 0:0:0.0',timestamp '2022-02-01 0:0:0.0');
INSERT INTO online_artikel VALUES (artikel_id_seq.NEXTVAL,'keksdose',500,0,timestamp '2019-02-01 0:0:0.0',timestamp '2022-02-01 0:0:0.0');
INSERT INTO online_artikel VALUES (artikel_id_seq.NEXTVAL,'Naeset',200,20,timestamp '2019-02-01 0:0:0.0',timestamp '2022-02-01 0:0:0.0');
INSERT INTO online_artikel VALUES (artikel_id_seq.NEXTVAL,'FakeKaktus',800,5,timestamp '2019-02-01 0:0:0.0',timestamp '2022-02-01 0:0:0.0');
INSERT INTO online_artikel VALUES (artikel_id_seq.NEXTVAL,'Handtuch',150,15,timestamp '2025-02-01 0:0:0.0',timestamp '2027-02-01 0:0:0.0');
INSERT INTO online_artikel VALUES (artikel_id_seq.NEXTVAL,'Tragetasche',420,0,timestamp '2018-02-01 0:0:0.0',timestamp '2019-02-01 0:0:0.0');

--person_hat_online_artikel
INSERT INTO person_hat_online_artikel VALUES(1,3,timestamp '2020-01-01 0:0:0.0');
INSERT INTO person_hat_online_artikel VALUES(2,5,timestamp '2020-01-01 0:0:0.0');
INSERT INTO person_hat_online_artikel VALUES(3,5,timestamp '2020-01-01 0:0:0.0');

COMMIT;







--*********************************************************************
--**
--** View: Allergen_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Allergenen an,
--**              also ID, voller Name und Kürzel.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW allergen_info AS
    SELECT a.allergenid, a.allergen_bezeichnung, a.allergen_kuerzel
    FROM allergen a;
--*********************************************************************
--**
--** View: Bahnhof_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Bahnhöfen an,
--**              also ID, Name, Adresse und Position.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW bahnhof_info AS
    SELECT b.bahnhofid, b.bezeichnung, b.adresse, b.latitude, b.longitude
    FROM bahnhof b;
--*********************************************************************
--**
--** Table: Bahnhof_Timetable
--** Developer: Samuel Fiedorowicz
--** Description: View that show the timetable of every arrival and 
--**              departure of a train with the repsective trainstation 
--**              name and platform.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW bahnhof_timetable AS

SELECT bh.bahnhofID, bh.bezeichnung AS name, bs.bezeichnung AS bahnsteig, v.fk_zugID AS zugID, v.abfahrt_uhrzeit AS Uhrzeit, 'Ankunft' AS verbindungTyp
FROM bahnsteig bs
  JOIN bahnhof bh
    ON bs.fk_bahnhofID = bh.bahnhofID
  JOIN verbindung v
    ON v.fk_ankunft_bahnsteig = bs.bahnsteigID
    
UNION

SELECT bh.bahnhofID, bh.bezeichnung AS name, bs.bezeichnung AS bahnsteig, v.fk_zugID AS zugID, v.abfahrt_uhrzeit AS uhrzeit, 'Abfahrt' AS verbindungTyp
FROM bahnsteig bs
  JOIN bahnhof bh
    ON bs.fk_bahnhofID = bh.bahnhofID
  JOIN verbindung v
    ON v.fk_abfahrt_bahnsteig = bs.bahnsteigID
    
ORDER BY uhrzeit ASC;
--*********************************************************************
--**
--** View: Bahnsteig_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Bahnsteigen an,
--**              also ID, Bezeichnung und BahnhofId.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW bahnsteig_info AS
    SELECT bahnsteigid, bezeichnung, fk_bahnhofid AS bahnhofid
    FROM bahnsteig;
--*********************************************************************
--**
--** View: Gehaltsstufe_Info
--** Developer: Nicolas Klement
--** Description: Listet alle Gehaltsstufen auf, mit ID und Betrag.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW gehaltsstufe_info AS
    SELECT gehaltsstufeid, gehalt
    FROM gehaltsstufe;
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
        p.email, k.kreditkartennummer, k.kundennummer
    FROM kunde k
        JOIN person p
        ON k.fk_personid = p.personid
        JOIN ort o
        ON p.fk_plz = o.plz;
--*********************************************************************
--**
--** View: Lokomotive_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen bezüglich Lokomotiven an,
--**              inklusive Zug.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW lokomotive_info AS
    SELECT
        l.lokomotivid, l.baujahr, l.letzte_wartung,
        l.leistung, z.zugid, z.seriennummer
    FROM lokomotive l
        JOIN zug z
        ON l.fk_zugid = z.zugid;
--*********************************************************************
--**
--** View: Mehrfach_Ticket_Info
--** Developer: Samuel Fiedorowicz
--** Description: Zeigt für Mehrfachtickets den Gültigkeitsbereich,
--**              das Kaufdatum, den Preis und die Ticket ID an
--**
--*********************************************************************

CREATE OR REPLACE
VIEW mehrfach_ticket_info AS
SELECT
   p.personID, t.ticketID,
   ta.bezeichnung AS ticket_typ,
   t.preis, t.kaufdatum, mt.gueltig_ab, mt.gueltig_bis
FROM mehrfachticket mt
  JOIN ticket t
    ON mt.fk_ticketID = t.ticketID
  JOIN person p
    ON p.personID = t.fk_personID
  JOIN ticket_art ta
    ON ta.ticket_artID = t.fk_ticket_artID;
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
--*********************************************************************
--**
--** View: Mitarbeiterrollen_Info
--** Developer: Nicolas Klement
--** Description: Listet alle Mitarbeiterrollen auf,
--**              mit ID und Bezeichnung.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW mitarbeiterrolle_info AS
    SELECT rollenid, bezeichnung
    FROM mitarbeiter_rolle;
--*********************************************************************
--**
--** View: One_Time_Ticket_Info
--** Developer: Samuel Fiedorowicz
--** Description: Zeigt für Einmaltickets den Start- und Zielbahnhof
--**              sowie die dazugehörigen Bahnsteige, Preis,
--**              Kaufdatum und Uhrzeit der Abfahrt und Ankunft an.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW one_time_ticket_info AS
SELECT
  p.personID, t.ticketid,
  ta.bezeichnung AS TicketTyp,
  t.preis, t.kaufdatum, ot.already_scanned,
  bh_abfahrt.bezeichnung AS bahnhof_abfahrt,
  bh_ankunft.bezeichnung AS bahnhof_ankunft,
  bs_abfahrt.bezeichnung AS bahnsteig_abfahrt,
  bs_ankunft.bezeichnung AS bahnsteig_ankunft,
  v.abfahrt_uhrzeit, v.ankunft_uhrzeit
    
FROM ticket t
  JOIN one_time_ticket ot
    ON ot.fk_ticketID = t.ticketID
  JOIN ticket_art ta
    ON ta.ticket_artID = t.fk_ticket_artID
  JOIN person p
    ON p.personID = t.fk_personID
  JOIN verbindung v
    ON ot.fk_verbindungID = v.verbindungID
  JOIN bahnsteig bs_ankunft
    ON v.fk_ankunft_bahnsteig = bs_ankunft.bahnsteigID
  JOIN bahnsteig bs_abfahrt
    ON v.fk_abfahrt_bahnsteig = bs_abfahrt.bahnsteigID
  JOIN bahnhof bh_ankunft
    ON bs_ankunft.fk_bahnhofID = bh_ankunft.bahnhofID
  JOIN bahnhof bh_abfahrt
    ON bs_abfahrt.fk_bahnhofID = bh_abfahrt.bahnhofID;
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
--*********************************************************************
--**
--** View: Ort_Info
--** Developer: Nicolas Klement
--** Description: Listet alle Orte auf, mit PLZ und Bezeichnung.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW ort_info AS
    SELECT plz, ort AS bezeichnung
    FROM ort;
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
--*********************************************************************
--**
--** View: ServiceDesk_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Servicedesks an,
--**              also ID, TelNr und BahnhofID.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW servicedesk_info AS
    SELECT servicedeskid, rufnummer, fk_bahnhofid AS bahnhofid
    FROM servicedesk;
--*********************************************************************
--**
--** View: TicketArt_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Ticketarten an,
--**              also ID, Bezeichnung und Punkte.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW ticketart_info AS
    SELECT t.ticket_artid, t.bezeichnung, t.punkte
    FROM ticket_art t;
--*********************************************************************
--**
--** Table: vor_24h_gekauft
--** Developer: Jakob List
--** Description: View that shows every ticket that has been bought in the last 24 hours.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW vor_24h_gekauft AS

SELECT kaufdatum, ticketID FROM ticket WHERE kaufdatum >= CURRENT_TIMESTAMP - NUMTODSINTERVAL(24, 'HOUR');
--*********************************************************************
--**
--** View: Verbindung_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Verbindungen an,
--**              inklusive Bahnsteig, Bahnhof und Zug.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW verbindung_info AS
    SELECT
        v.verbindungid, v.abfahrt_uhrzeit, v.ankunft_uhrzeit,
        z.zugid, z.seriennummer,
        abbh.bezeichnung AS ab_bahnhof, abbs.bezeichnung AS ab_bahnsteig,
        anbh.bezeichnung AS an_bahnhof, anbs.bezeichnung AS an_bahnsteig
    FROM verbindung v
        JOIN zug z
        ON v.fk_zugid = z.zugid
        JOIN bahnsteig abbs
        ON v.fk_abfahrt_bahnsteig = abbs.bahnsteigid
        JOIN bahnhof abbh
        ON abbs.fk_bahnhofid = abbh.bahnhofid
        JOIN bahnsteig anbs
        ON v.fk_ankunft_bahnsteig = anbs.bahnsteigid
        JOIN bahnhof anbh
        ON anbs.fk_bahnhofid = anbh.bahnhofid;
--*********************************************************************
--**
--** Table: verfuegbare_artikel
--** Developer: Jakob List
--** Description: View that shows the currently available items that can be purchased in the webshop.
--**
--*********************************************************************

CREATE OR REPLACE 
VIEW verfuegbare_artikel AS
SELECT * FROM online_artikel
WHERE verfuegbar_von < CURRENT_TIMESTAMP AND verfuegbar_bis > CURRENT_TIMESTAMP;
--*********************************************************************
--**
--** Table: Verpflegung
--** Developer: Samuel Fiedorowicz
--** Description: View that allows to list every product that the train has.
--**

--*********************************************************************

CREATE OR REPLACE
VIEW verpflegung AS
SELECT z.*, p.name AS produkt
FROM zug z
  JOIN wagon w
    ON w.fk_zugID = z.zugID
  JOIN wagon_hat_produkt wv
    ON wv.fk_wagonID = w.wagonID
  JOIN produkt p
    ON p.produktID = wv.fk_produktID
ORDER BY z.zugID;
--*********************************************************************
--**
--** Table: verwendbare_tickets
--** Developer: Jakob List
--** Description: View that allows to look up all tickets which are still able to be used.
--**
--********************************************************************

CREATE OR REPLACE 
VIEW verwendbare_tickets AS
SELECT t.ticketid, t.fk_ticket_artid AS ticket_artid, t.fk_personid AS personid, ot.fk_verbindungid AS Verbindung, mt.gueltig_ab, mt.gueltig_bis FROM ticket t
LEFT JOIN one_time_ticket ot
ON t.ticketid = ot.fk_ticketid
LEFT JOIN mehrfachticket mt
ON t.ticketid = mt.fk_ticketid
WHERE kaufdatum >= CURRENT_TIMESTAMP OR (gueltig_bis > CURRENT_TIMESTAMP AND gueltig_ab < CURRENT_TIMESTAMP)
ORDER BY t.ticketid ASC;
--*********************************************************************
--**
--** Table: verwendete_tickets
--** Developer: Jakob List
--** Description: View that allows to look up all tickets which have been used.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW verwendete_tickets AS
SELECT t.ticketid, t.fk_ticket_artid AS ticket_artid, t.fk_personid AS personid, ot.fk_verbindungid AS Verbindung, mt.gueltig_ab, mt.gueltig_bis FROM ticket t
LEFT JOIN one_time_ticket ot
ON t.ticketid = ot.fk_ticketid
LEFT JOIN mehrfachticket mt
ON t.ticketid = mt.fk_ticketid
WHERE kaufdatum <= CURRENT_TIMESTAMP OR (gueltig_bis < CURRENT_TIMESTAMP AND gueltig_ab > CURRENT_TIMESTAMP)
ORDER BY t.ticketid ASC;
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
--*********************************************************************
--**
--** View: Wagon_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen bezüglich Wagons an,
--**              inklusive Wagonart und Zug.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW wagon_info AS
    SELECT
        w.wagonid, w.baujahr, w.letzte_wartung,
        a.aufgabe, a.kapazitaet, a.klasse,
        z.zugid, z.seriennummer
    FROM wagon w
        JOIN wagon_art a
        ON w.fk_wagon_artid = a.wagon_artid
        JOIN zug z
        ON w.fk_zugid = z.zugid;
--*********************************************************************
--**
--** View: Wartung_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Verbindungen an,
--**              inklusive Bahnsteig, Bahnhof und Zug.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW wartung_info AS
    SELECT
        w.wartungsid, w.start_wartung, w.ende_wartung, z.seriennummer
    FROM wartung w
        JOIN zug z
        ON w.fk_zugid = z.zugid;
--*********************************************************************
--**
--** View: Zug_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Zügen an,
--**              also ID und Seriennummer.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW zug_info AS
    SELECT zugid, seriennummer
    FROM zug;








--********************************************************************
--**
--** Function: f_average_ticket_price
--** In:
--** Returns: average price of a ticket last month
--** Developer: Jakob List
--** Description: calculates the average price of a ticket last month
--*
--********************************************************************

CREATE OR REPLACE FUNCTION f_average_ticket_price RETURN NUMBER IS 

	n_avg_preis NUMBER;
	
BEGIN
SELECT AVG(preis)
INTO n_avg_preis
FROM ticket t
  LEFT JOIN one_time_ticket ot ON t.ticketid = ot.fk_ticketid
  LEFT JOIN mehrfachticket mt ON t.ticketid = mt.fk_ticketid
WHERE kaufdatum >= CURRENT_TIMESTAMP+INTERVAL '-1' MONTH
AND   kaufdatum <= CURRENT_TIMESTAMP
ORDER BY t.ticketid ASC;

RETURN n_avg_preis;

EXCEPTION WHEN no_data_found THEN dbms_output.put_line ('Kein Ticket wurde verkauft.');
RETURN -1;

WHEN OTHERS THEN dbms_output.put_line ('Fehler aufgetreten.');
RETURN -1;

END;
/


--********************************************************************
--**
--** Function: f_calculate_price
--** In: n_bahnhofID_abfahrt and n_bahnhofID_ankunft
--** Returns: price for one route
--** Developer: Elisabeth Glatz
--** Description: calculates the the (linear) distance between two train stations and calculates the price for the calculated route
--*
--********************************************************************


CREATE OR REPLACE FUNCTION f_calculate_price(n_bahnhofID_abfahrt IN NUMBER, n_bahnhofID_ankunft IN NUMBER)
	RETURN NUMBER
IS

	n_bhf_abfahrt_long NUMBER;
	n_bhf_abfahrt_lat NUMBER;
	n_bhf_ankunft_long NUMBER;
	n_bhf_ankunft_lat NUMBER;
	
	n_dist_x NUMBER;
	n_dist_y NUMBER;
	n_dist_direct NUMBER;
	n_price NUMBER;
	
BEGIN
	
	SELECT latitude, longitude 
		INTO n_bhf_abfahrt_long, n_bhf_abfahrt_lat
	FROM bahnhof 
		WHERE bahnhofID = n_bahnhofID_abfahrt;
	
	dbms_output.put_line('Longitude Abfahrtsbahnhof:' || n_bhf_abfahrt_long);
	dbms_output.put_line('Latitude Abfahrtsbahnhof:' || n_bhf_abfahrt_lat);
	
	SELECT latitude, longitude 
		INTO n_bhf_ankunft_long, n_bhf_ankunft_lat 
	FROM bahnhof 
		WHERE bahnhofID = n_bahnhofID_ankunft;
	
	dbms_output.put_line('Longitude Ankunftsbahnhof:' || n_bhf_ankunft_long);
	dbms_output.put_line('Latitude Ankunftsbahnhof:' || n_bhf_ankunft_lat);
	
	n_dist_x := n_bhf_abfahrt_long - n_bhf_ankunft_long;
	n_dist_y := n_bhf_abfahrt_lat - n_bhf_ankunft_lat;
	n_dist_direct := sqrt(power(n_dist_x, 2) + power(n_dist_y, 2));

	dbms_output.put_line('Distanz:' || n_dist_direct);
	
	n_price := n_dist_direct * 20;
	
	IF n_dist_direct > 1.4 THEN 
		n_price := 24.3 * ln(8.64 * (n_dist_direct - 1.05)) - 3.6 * sqrt(2.5 * n_dist_direct);	
	END IF;

	RETURN n_price;
	
EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('Kein Bahnhof mit dieser ID gefunden.');
	RETURN -1;
	
	WHEN OTHERS THEN
  	dbms_output.put_line('Fehler aufgetreten.');
	RETURN -1;
	
END;
/

--********************************************************************
--**
--** Function: f_get_next_arrival
--** In: n_bahnhofID - ID from train station that
--** Returns: verbindungsID (ID of next arrival)
--** Developer: Elisabeth Glatz
--** Description: selects next arrival from the given train station and returns ID of connection
--**
--********************************************************************

CREATE OR REPLACE FUNCTION f_get_next_arrival(n_bahnhofID IN NUMBER)
	RETURN NUMBER
IS
	n_next_ID NUMBER;
BEGIN
	SELECT verbindungID INTO n_next_ID FROM (
		SELECT * FROM bahnhof 
					JOIN bahnsteig ON bahnhof.bahnhofID = bahnsteig.fk_bahnhofID
					JOIN verbindung ON bahnsteig.bahnsteigID = verbindung.fk_ankunft_bahnsteig
					WHERE bahnhofID = n_bahnhofID
						AND ankunft_uhrzeit >= CURRENT_TIMESTAMP
					ORDER BY ankunft_uhrzeit ASC
	) WHERE ROWNUM = 1;
	
	RETURN n_next_ID;
	
EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('Keine Verbindung mit dieser BahnhofID gefunden.');
	RETURN -1;
	
	WHEN OTHERS THEN
  	dbms_output.put_line('Fehler aufgetreten.');
	RETURN -1;
	
END;
/


--********************************************************************
--**
--** Function: f_get_next_departures
--** In: n_bahnhofID - ID from train station that
--** Returns: verbindungsID (ID of next departure)
--** Developer: Elisabeth Glatz
--** Description: selects next departure from the given train station and returns ID of connection
--**
--********************************************************************

CREATE OR REPLACE FUNCTION f_get_next_departures(n_bahnhofID IN NUMBER)
	RETURN NUMBER
IS
	n_next_ID NUMBER;
BEGIN
	SELECT verbindungID INTO n_next_ID FROM (
		SELECT * FROM bahnhof 
					JOIN bahnsteig ON bahnhof.bahnhofID = bahnsteig.fk_bahnhofID
					JOIN verbindung ON bahnsteig.bahnsteigID = verbindung.fk_abfahrt_bahnsteig
					WHERE bahnhofID = n_bahnhofID
						AND abfahrt_uhrzeit >= CURRENT_TIMESTAMP
					ORDER BY abfahrt_uhrzeit ASC
	) WHERE ROWNUM = 1;
	
	RETURN n_next_ID;
	
EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('Keine Verbindung mit dieser BahnhofID gefunden.');
	RETURN -1;
	
	WHEN OTHERS THEN
  	dbms_output.put_line('Fehler aufgetreten.');
	RETURN -1;
	
END;
/


--********************************************************************
--**
--** Function: f_get_personID
--** In: v_email - Email address of the user
--** Returns: PersonID of the user or error number
--** Developer: Nicolas Klement
--** Description: Looks up a user's personID and returns it.
--**              If no data found -1, several found -2, others -3.
--**
--********************************************************************


CREATE OR REPLACE FUNCTION f_get_personid(v_email IN VARCHAR2)
    RETURN VARCHAR2
IS
    n_id number;
BEGIN
    SELECT p.personid INTO n_id
    FROM person p
    WHERE p.email = v_email;

    RETURN n_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN -1;
    WHEN TOO_MANY_ROWS THEN
        RETURN -2;
    WHEN OTHERS THEN
        RETURN -3;
END;
/

--********************************************************************
--**
--** Function: f_get_role
--** In: v_email - Email address of the user
--** Returns: Name of the user's role
--** Developer: Nicolas Klement
--** Description: Looks up a user's role, if the user is an employee then the
--**              Mitarbeiter_Rolle ist returned, if the user is a customer then
--**              'Kunde' is returned, 'missing' if the email address does not
--**              match anyone's or 'ambiguous' if it matches several.
--**
--********************************************************************

CREATE OR REPLACE FUNCTION f_get_role(v_email IN VARCHAR2)
    RETURN VARCHAR2
IS
    v_role VARCHAR2(50);
BEGIN
    SELECT r.bezeichnung INTO v_role
    FROM person p
    LEFT JOIN mitarbeiter m ON p.personID = m.fk_personID
    LEFT JOIN mitarbeiter_rolle r ON m.fk_rollenID = r.rollenID
    WHERE p.email = v_email;

    RETURN COALESCE(v_role, 'Kunde');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'missing';
    WHEN TOO_MANY_ROWS THEN
        RETURN 'ambiguous';
    WHEN OTHERS THEN
        RETURN 'Anderer Fehler: ' || SQLERRM;
END;
/

/**********************************************************************/
/**
/** Function: f_total_expenditure
/** In: n_personID - id of the person
/** Returns: total the person has spent on webshop and tickets
/** Developer: Samuel Fiedorowicz
/** Description: Calculates total expenditure on webshop and
/**              tickets for a given person-ID
/**
/**********************************************************************/

CREATE OR REPLACE
FUNCTION f_total_expenditure(n_personID IN person.personID%TYPE)
RETURN NUMBER

AS
  n_ticket_total NUMBER DEFAULT 0;
  n_webshop_total NUMBER DEFAULT 0;
  
BEGIN
  -- calculate expenditure on tickets
  SELECT SUM(preis) INTO n_ticket_total
  FROM ticket
  WHERE fk_personID = n_personID;
  
  -- calculate expenditure webshop
  SELECT SUM(zusaetzliche_kosten) INTO n_webshop_total
  FROM person_hat_online_artikel p
    JOIN online_artikel
      ON fk_artikelID = artikelID
  WHERE fk_personID = n_personID;

  -- return sum
  RETURN COALESCE(n_ticket_total + n_webshop_total, 0);
  
END;
/

--********************************************************************
--*
--* Function: f_try_login
--* Return: 0 for false, 1 for true
--* Parameter:
--* 	v_email: Start of timespann 1
--* 	v_passwort: END of timespann 1
--* Developer: Lukas Schweinberger
--* Description: tries to login by email and passwort, only returns 1 if unique
--********************************************************************


CREATE OR REPLACE FUNCTION f_try_login(v_email VARCHAR2,v_passwort VARCHAR2)
	RETURN NUMBER
IS
	n_count NUMBER;
BEGIN
	SELECT COUNT(*) INTO n_count FROM person WHERE email = v_email AND passwort = v_passwort;
	IF n_count = 1 THEN
		RETURN 1;
	END IF;
	RETURN 0;	
END;
/

--********************************************************************
--*
--* Function: f_validate_no_time_overlap
--* Return: 0 for false, 1 for true
--* Parameter:
--* 	t_timeA1: Start of timespan 1
--* 	t_timeA2: END of timespan 1
--*		t_timeB1: Start of timespan 2
--*		t_timeB2: END of timespan 2
--* Developer: Lukas Schweinberger
--* Description: validate that 2 timespanns dont overlap.
--********************************************************************


CREATE OR REPLACE FUNCTION f_validate_no_time_overlap(t_timeA1 TIMESTAMP, t_timeA2 TIMESTAMP,t_timeB1 TIMESTAMP, t_timeB2 TIMESTAMP)
	RETURN NUMBER
IS
BEGIN
		--abfahrtA..abfahrtB..ankunftB..ankunftA
		IF t_timeA1 < t_timeB1  AND t_timeB2 < t_timeA2 THEN
			RETURN 0;
		END IF;
		--abfahrtA..abfahrtB..ankunftA..ankunftB
		IF t_timeA1 < t_timeB1 AND t_timeA2 < t_timeB2 THEN
			RETURN 0;
		END IF;
		--abfahrtB..abfahrtA..ankunftB..ankunftA
		IF  t_timeB1 < t_timeA1 AND t_timeB2 < t_timeA2 THEN
			RETURN 0;
		END IF;
		--abfahrtB..abfahrtA..ankunftA..ankunftB
		IF t_timeB1 < t_timeA1 AND t_timeA2 < t_timeB2 THEN
			RETURN 0;
		END IF;
		RETURN 1;
END;
/









/**********************************************************************/
/**
/** Procedure: sp_create_mitarbeiter_rolle
/** Developer: Lukas Schweinberger
/** Description: erschafft eine neue mitarbeiter rollenID
/** Variable:
/**		v_Bezeichnung VARCHAR2: bezeichnung für die neue rolle
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_mitarbeiter_rolle (v_Bezeichnung VARCHAR2)
AS
BEGIN
	SAVEPOINT CreateMitarbeiterRolleSave;
	INSERT INTO mitarbeiter_rolle VALUES (null,v_Bezeichnung);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20002,'Create MitarbeiterRolle was not unique');
  	ROLLBACK TO CreateMitarbeiterRolleSave;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20001,'Other Error in CreateMitarbeiterRolle');
  	ROLLBACK TO CreateMitarbeiterRolleSave;
END;
/


/**********************************************************************/
/**
/** Procedure: sp_delete_mitarbeiter_rolle
/** Developer: Lukas Schweinberger
/** Description: löscht eine mitarbeiter rolle
/** Variable:
/**		n_rollenID NUMBER: Id, primary key, zum löschen einer mitarbeiter rolle
/**********************************************************************/
CREATE OR REPLACE PROCEDURE sp_delete_mitarbeiter_rolle (n_rollenID NUMBER)
AS
BEGIN
	SAVEPOINT DeleteMitarbeiterRolleSave;
	DELETE FROM mitarbeiter_rolle WHERE rollenID = n_rollenID;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20003,'Other Error in CreateMitarbeiterRolle');
  	ROLLBACK TO DeleteMitarbeiterRolleSave;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_delete_mitarbeiter_rolle
/** Developer: Lukas Schweinberger
/** Description: löscht eine mitarbeiter rolle
/** Variable:
/**		n_gehalt NUMBER: gehalt as float für die neue stufe
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_CreateGehaltsStufe (n_gehalt NUMBER)
AS
BEGIN
SAVEPOINT CreateCreateGehaltsStufe;
	INSERT INTO Gehaltsstufe VALUES (null,n_gehalt);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20004,'CreateGehaltsstufe was not unique');
  	ROLLBACK TO CreateCreateGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20005,'Other Error in CreateGehaltsStufe');
  	ROLLBACK TO CreateCreateGehaltsStufe;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_delete_gehalts_stufe
/** Developer: Lukas Schweinberger
/** Description: löscht eine mitarbeiter rolle
/** Variable:
/**		n_gehaltID NUMBER: id,primary key, loescht gehaltstufe mit dieser id
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_gehalts_stufe (n_gehaltID NUMBER)
AS
BEGIN
SAVEPOINT DeleteGehaltsStufe;
	DELETE FROM gehaltsstufe WHERE gehaltsstufeID = n_gehaltID;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20006,'Other Error in DeleteGehaltsStufe');
  	ROLLBACK TO DeleteGehaltsStufe;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_create_online_artikel
/** Developer: Lukas Schweinberger
/** Description: erschafft einen neuen artikel fuer den webshop
/** Variable:
/**		v_Bezeichnung VARCHAR2: Bezeichnung fuer den neuen artikel
/**		n_Punktekosten NUMBER: Wieviel Punkte ein neuer artikel kostet
/**		n_Zusaetzlichekosten NUMBER: Wieviel der Kunde zusaetzlich zahlen muss fuer den erwerb des artikels
/**		VerfügbarVon TIMESTAMP: Ab wann es verfuegbar ist.
/**		VerfügbarBis TIMESTAMP: Bis wann es verfuegbar ist.
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_online_artikel(v_Bezeichnung VARCHAR2,n_Punktekosten NUMBER,n_Zusaetzlichekosten NUMBER,VerfügbarVon TIMESTAMP,VerfügbarBis TIMESTAMP)
AS
BEGIN
	SAVEPOINT CreateOnlineArtikel;
	INSERT INTO online_artikel values(null,v_Bezeichnung,n_Punktekosten,n_Zusaetzlichekosten,VerfügbarVon,VerfügbarBis);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20007,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO DeleteGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20008,'Other Error in CreateOnlineArtikel');
  	ROLLBACK TO DeleteGehaltsStufe;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_update_artikel_price
/** Developer: Lukas Schweinberger
/** Description: update fuer den price eines artikels (optional einer von v_Preis,v_Punkte null)
/** Variable:
/**		n_ArtikelID NUMBER: id,primary key welcher artikel geaendert werden soll.
/**		n_Preis NUMBER: Neuer preis des artikels, optional null
/**		n_Punkte NUMBER: Neue Punktekosten des artikels, optional null
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_update_artikel_price (n_ArtikelID NUMBER,n_Preis NUMBER,n_Punkte NUMBER)
AS
	v_sqlbuilder VARCHAR2(500);
BEGIN
	IF n_Preis is null and n_Punkte is null THEN
		RETURN;
	END IF;
	SAVEPOINT UpdateOnArtikePrice;
	v_sqlbuilder := 'update online_artikel set ';	
	IF n_Preis = null THEN
		v_sqlbuilder := v_sqlbuilder || ' preis = ' || n_Preis;
	END IF;
	IF n_Punkte = null THEN
		v_sqlbuilder := v_sqlbuilder || ' punktekosten = '||n_Punkte;
	END IF;
	v_sqlbuilder := v_sqlbuilder || ' where aritkelID = '||n_ArtikelID;
	execute immediate v_sqlbuilder;
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20007,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO DeleteGehaltsStufe;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20008,'Other Error in CreateOnlineArtikel');
  	ROLLBACK TO DeleteGehaltsStufe;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_delete_artikel
/** Developer: Lukas Schweinberger
/** Description: löscht einen artikel aus dem shop
/** Variable:
/**		n_OnlineArtikelID NUMBER: id,primary key welcher artikel geloescht werden soll.
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_artikel (n_OnlineArtikelID NUMBER)
AS
BEGIN
	SAVEPOINT DeleteOnlineArtikel;
	DELETE FROM online_artikel  WHERE artikelID = n_OnlineArtikelID;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20009,'Other Error in DeleteOnlineArtikel');
  	ROLLBACK TO DeleteOnlineArtikel;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_create_ort
/** Developer: Lukas Schweinberger
/** Description: erstellt einen neuen ort
/** Variable:
/**		n_PLZ NUMBER: welche plz neu angelegt werden soll.
/**		v_Bezeichnung VARCHAR2: bezeichnung fuer den ort
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_ort (n_PLZ NUMBER,v_Bezeichnung VARCHAR2)
AS
BEGIN
	SAVEPOINT CreateOrt;
	INSERT INTO ORT VALUES(n_PLZ,v_Bezeichnung);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20010,'CreateOnlineArtikel was not unique');
  	ROLLBACK TO CreateOrt;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20011,'Other Error in CreateGehaltsStufe');
  	ROLLBACK TO CreateOrt;
END;
/


/**********************************************************************/
/**
/** Procedure: sp_delete_ort
/** Developer: Lukas Schweinberger
/** Description: loescht einen ort
/** Variable:
/**		n_PLZ NUMBER: Löscht eine bestimmte ort
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_ort (n_PLZ NUMBER)
AS
BEGIN
	SAVEPOINT DeleteOrt;
	DELETE FROM ORT WHERE plz = n_PLZ;
EXCEPTION
	WHEN OTHERS THEN
  	Raise_Application_Error(-20012,'Other Error in DeleteOrt');
  	ROLLBACK TO DeleteOrt;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_create_mitarbeiter
/** Developer: Lukas Schweinberger
/** Description: legt einen neues mitarbeiter an
/** Variable:
/**		v_Name VARCHAR2: Name der person
/**		Geburtsdatum TIMESTAMP: tag an dem die person geboren ist
/**		v_Adresse VARCHAR2: adresse des mitarbeiters
/**		n_Sozialversicherungsnummer NUMBER: sozialversicherungsnummer des mitarbeiters
/**		n_PLZ NUMBER: postleitzahl des mitarbeiters
/**		n_Gehaltsstufe NUMBER: gehaltstufe des mitarbeiters
/**		n_MitarbeiterRolle NUMBER: mitarbeiterrolle des mitarbeiters
/**		v_Email VARCHAR2: Email des kundes
/**		v_Password VARCHAR2: passwordhash of the user
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_mitarbeiter(v_Name VARCHAR2,Geburtsdatum TIMESTAMP,v_Adresse VARCHAR2,n_Sozialversicherungsnummer NUMBER,n_PLZ NUMBER,n_Gehaltsstufe NUMBER,n_MitarbeiterRolle NUMBER,v_Email VARCHAR2,v_Password VARCHAR2)
AS
	n_newPersonID NUMBER;
BEGIN
	SAVEPOINT CreateMitarbeiter;
	select person_id_seq.NEXTVAL INTO n_newPersonID FROM dual;
	INSERT INTO Person VALUES(n_newPersonID,v_Name,Geburtsdatum,v_Adresse,n_PLZ,v_Email,v_password);
	INSERT INTO Mitarbeiter VALUES(n_newPersonID,n_Sozialversicherungsnummer,n_Gehaltsstufe,n_MitarbeiterRolle);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20013,'CreateMitarbeiter was not unique');
  	ROLLBACK TO CreateMitarbeiter;
	WHEN OTHERS THEN
		IF SQLCODE = -2291 or SQLCODE = -2292 THEN
			Raise_Application_Error(-20014,'Foreign key does not exist');
			ROLLBACK TO CreateMitarbeiter;		
			RETURN;	
		END IF;
  	Raise_Application_Error(-20016,'Other Error in CreateMitarbeiter');
  	ROLLBACK TO CreateMitarbeiter;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_delete_mitarbeiter
/** Developer: Lukas Schweinberger
/** Description: löscht einen Mitarbeiter
/** Variable:
/**		n_personID Number: id,primary key zur identifikation der person
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_mitarbeiter(n_personID NUMBER)
AS
BEGIN
	SAVEPOINT DeleteMitarbeiter;
	DELETE FROM Mitarbeiter where fk_personID = n_personID;
	DELETE FROM Person where personID = n_personID;
EXCEPTION
	WHEN OTHERS THEN
		IF SQLCODE = -2292 THEN
			Raise_Application_Error(-20017,'Child key exception (internal)');
			ROLLBACK TO DeleteMitarbeiter;		
			RETURN;	
		END IF;
  	Raise_Application_Error(-20018,'Other Error in DeleteMitarbeiter');
  	ROLLBACK TO DeleteMitarbeiter;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_create_kunde
/** Developer: Lukas Schweinberger
/** Description: legt einen neues mitarbeiter an
/** Variable:
/**		v_Name VARCHAR2: Name der person
/**		Geburtsdatum TIMESTAMP: tag an dem die person geboren ist
/**		v_Adresse VARCHAR2: adresse des kundes
/**		n_PLZ NUMBER: postleitzahl des kundes
/**		v_Email VARCHAR2: Email des kundes
/**		n_Kreditkartenummer NUMBER: Kreditkartennummer des kundes
/**		v_Password VARCHAR2: passwordhash of the user
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_create_kunde(v_NameOf VARCHAR2,Geburtsdatum TIMESTAMP,v_Adresse VARCHAR2,n_PLZ NUMBER,v_Email VARCHAR2,v_Password VARCHAR2,n_Kreditkartenummer NUMBER)
AS
n_newPersonID NUMBER;
BEGIN
	SAVEPOINT CreateKunde;
	select person_id_seq.NEXTVAL INTO n_newPersonID FROM dual;
	INSERT INTO Person VALUES(n_newPersonID,v_NameOf,Geburtsdatum,v_Adresse,n_PLZ,v_Email,v_Password);
	INSERT INTO Kunde VALUES(n_newPersonID,n_Kreditkartenummer,n_newPersonID + 10000,0);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20019,'CreateKunde was not unique');
  	ROLLBACK TO CreateKunde;
	WHEN OTHERS THEN
		IF SQLCODE = -2291 THEN
			Raise_Application_Error(-20020,'Foreign key does not exist');
			ROLLBACK TO CreateKunde;		
			RETURN;	
		END IF;
  	Raise_Application_Error(-20021,'Other Error in CreateKunde');
  	ROLLBACK TO CreateKunde;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_create_kunde
/** Developer: Lukas Schweinberger
/** Description: legt einen kunden
/** Variable:
/**		n_personID NUMBER: id,primary key mit dem die person geloescht wird
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_delete_kunde(n_personID NUMBER)
AS
BEGIN
	SAVEPOINT DeleteKunde;
	DELETE FROM Kunde where fk_personID = n_personID;
	DELETE FROM Person where personID = n_personID;
EXCEPTION
	WHEN OTHERS THEN
		IF SQLCODE = -2292 THEN
			Raise_Application_Error(-20022,'Child key exception (internal)');
			ROLLBACK TO DeleteKunde;		
			RETURN;	
		END IF;
  	Raise_Application_Error(-20023,'Other Error in DeleteKunde');
  	ROLLBACK TO DeleteKunde;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_create_ticket_art
/** Developer: Lukas Schweinberger
/** Description: erstellt eine neue ticket art
/** Variable:
/**		v_bezeichnung VARCHAR2: bezeichnung der neuen ticket art
/**		n_Punkte NUMBER: Anzahl der Punkte die diese art von ticket gibt
/**********************************************************************/


CREATE OR REPLACE PROCEDURE sp_create_ticket_art(v_bezeichnung VARCHAR2,n_Punkte NUMBER)
AS
BEGIN
  SAVEPOINT CreateTicketArt;
	INSERT INTO ticket_art values(null,v_bezeichnung,n_Punkte);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20024,'CreateTicketArt was not unique');
  	ROLLBACK TO CreateTicketArt;
	WHEN OTHERS THEN
  	Raise_Application_Error(-20025,'Other Error in CreateTicketArt');
  	ROLLBACK TO CreateTicketArt;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_buy_one_time_ticket
/** Developer: Lukas Schweinberger
/** Description: erstellt eine neue ticket art
/** Variable:
/**		n_PersonID NUMBER: zu welcher perosn das ticket gehoert
/**		n_ticketArtId NUMBER: art des tickets
/**		n_verbindungID NUMBER: id zu welcher verbindung das ticket gehoert
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_buy_one_time_ticket(n_PersonID NUMBER,n_ticketArtId NUMBER,n_verbindungID NUMBER)
AS
n_newTicket_id NUMBER;
BEGIN
  SAVEPOINT BuyOneTimeTicket;
  select ticket_id_seq.NEXTVAL into n_newTicket_id from dual;
	INSERT INTO ticket values(n_newTicket_id,n_ticketArtId,n_PersonID,-1,sysdate);
	INSERT INTO one_time_ticket values(n_newTicket_id,n_verbindungID,0);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20024,'BuyOneTimeTicket was not unique');
  	ROLLBACK TO BuyOneTimeTicket;
	WHEN OTHERS THEN
	  IF SQLCODE = -2291 THEN
			Raise_Application_Error(-20020,'Foreign key does not exist');
			ROLLBACK TO CreateKunde;		
	    RETURN;
	  END IF;
  	Raise_Application_Error(-20025,'Other Error in BuyOneTimeTicket');
  	ROLLBACK TO BuyOneTimeTicket;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_buy_one_time_ticket
/** Developer: Lukas Schweinberger
/** Description: erstellt eine neue ticket art
/** Variable:
/**		n_PersonID NUMBER: zu welcher perosn das ticket gehoert
/**		n_ticketArtId NUMBER: art des tickets
/**		gueltigVon TIMESTAMP: Von wann das ticket gueltig ist
/**		gueltigBis TIMESTAMP: Bis wann das ticket gueltig ist
/**********************************************************************/

CREATE OR REPLACE PROCEDURE sp_buy_mehrfach_tickt(n_PersonID NUMBER,n_ticketArtId NUMBER,gueltigVon TIMESTAMP,gueltigBis TIMESTAMP,preis NUMBER)
AS
n_newTicket_id NUMBER;
BEGIN
  SAVEPOINT buy_mehrfach_tickt;
  select ticket_id_seq.NEXTVAL into n_newTicket_id from dual;
	INSERT INTO ticket values(n_newTicket_id,n_ticketArtId,n_PersonID,preis,sysdate);
	INSERT INTO mehrfachticket values(n_newTicket_id,gueltigVon,gueltigBis);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
  	Raise_Application_Error(-20024,'BuyOneTimeTicket was not unique');
  	ROLLBACK TO buy_mehrfach_tickt;
	WHEN OTHERS THEN
	  IF SQLCODE = -2291 THEN
			Raise_Application_Error(-20020,'Foreign key does not exist');
			ROLLBACK TO buy_mehrfach_tickt;		
	    RETURN;
	  END IF;
  	Raise_Application_Error(-20025,'Other Error in BuyOneTimeTicket');
  	ROLLBACK TO buy_mehrfach_tickt;
END;
/













/**********************************************************************/
/**
/** Procedure: sp_book_alternative_train
/** In: n_ticketID - id of the tick to rebook
/** Developer: Samuel Fiedorowicz
/** Description: Rebook the ticket to the next connection with the same
/**              origin and destination.
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_book_alternative_train(n_ticketID IN NUMBER)
AS
    n_bahnhof_abfahrt NUMBER;
    n_bahnhof_ankunft NUMBER;
    d_abfahrt_uhrzeit DATE;
    verbindung_rec verbindung%ROWTYPE;

BEGIN
    SELECT v.abfahrt_uhrzeit, bh_abfahrt.bahnhofID, bh_ankunft.bahnhofID
    INTO d_abfahrt_uhrzeit, n_bahnhof_abfahrt, n_bahnhof_ankunft
    FROM One_Time_Ticket
        JOIN verbindung v
          ON v.verbindungID = fk_verbindungID
        JOIN bahnsteig bs_Ankunft
          ON bs_ankunft.bahnsteigID = v.fk_ankunft_bahnsteig
        JOIN bahnsteig bs_abfahrt
          ON bs_abfahrt.bahnsteigID = v.fk_abfahrt_bahnsteig
        JOIN bahnhof bh_ankunft
          ON bh_ankunft.bahnhofID = bs_ankunft.fk_bahnhofID
        JOIN bahnhof bh_abfahrt
          ON bh_abfahrt.bahnhofID = bs_abfahrt.fk_bahnhofID
    WHERE fk_ticketID = n_ticketID;

    SELECT v.* INTO verbindung_rec
    FROM verbindung v
        JOIN bahnsteig bs_ankunft 
          ON bs_ankunft.bahnsteigID = v.fk_ankunft_bahnsteig
        JOIN bahnsteig bs_abfahrt 
          ON bs_abfahrt.bahnsteigID = v.fk_abfahrt_bahnsteig
        JOIN bahnhof bh_ankunft 
          ON bs_ankunft.fk_bahnhofID = bh_ankunft.bahnhofID
        JOIN bahnhof bh_abfahrt 
          ON bs_abfahrt.fk_bahnhofID = bh_abfahrt.bahnhofID
    WHERE bh_abfahrt.bahnhofID = n_bahnhof_abfahrt
      AND bh_ankunft.bahnhofID = n_bahnhof_ankunft
      AND abfahrt_uhrzeit > d_abfahrt_uhrzeit
      AND ROWNUM = 1
    ORDER BY abfahrt_uhrzeit DESC;
    
    UPDATE One_Time_Ticket
    SET fk_verbindungID = verbindung_rec.verbindungID
    WHERE fk_ticketID = n_ticketID;
    
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20007, 'Es gibt keine neue Verbindung.');
    
END;
/
/**********************************************************************/
/**
/** Procedure: sp_create_allergen
/** Developer: Elisabeth Glatz
/** In: v_bezeichnung - description of allergen
/** In: v_kuerzel - abbreviation of allergen
/** Description: Creates a new allergen
/**
/**********************************************************************/


CREATE OR REPLACE PROCEDURE sp_create_allergen(v_bezeichnung IN VARCHAR2, v_kuerzel IN VARCHAR2)
AS
BEGIN
	SAVEPOINT create_allergen_savepoint;
	INSERT INTO allergen VALUES (allergen_id_seq.NEXTVAL, v_bezeichnung, v_kuerzel);
EXCEPTION	
	WHEN DUP_VAL_ON_INDEX THEN
		raise_application_error(-20400,'Allergen existiert bereits.');
		ROLLBACK TO create_allergen_savepoint;
	WHEN OTHERS THEN
		raise_application_error(-20401,'Fehler.');
		ROLLBACK TO create_allergen_savepoint;
END;
/
/**********************************************************************/
/**
/** Procedure: sp_create_lokomotive
/** In: n_zugID - id of the train to add a lokomotive to
/** In: d_baujahr - year the lokomotive was built
/** In: n_leistung - power of the lokomotive
/** In: d_letzte_wartung - last date of maintenance
/** Developer: Samuel Fiedorowicz
/** Description: Create a lokomotive
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_create_lokomotive(n_zugID          IN lokomotive.fk_zugID%TYPE,
                               d_baujahr        IN lokomotive.baujahr%TYPE,
                               n_leistung       IN lokomotive.leistung%TYPE,
                               d_letzte_wartung IN lokomotive.letzte_wartung%TYPE)
AS
  e_integrity EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_create_lokomotive;
  INSERT INTO lokomotive VALUES (
    lokomotive_id_seq.NEXTVAL,
    d_baujahr, n_leistung,
    d_letzte_wartung,
    n_zugID
  );

EXCEPTION
  WHEN e_integrity THEN
    Raise_Application_Error(-20203, 'Fehler beim Erstellen der Lokomotive: Es gibt keinen Zug mit dieser ID.');
    ROLLBACK TO before_create_lokomotive;
  WHEN OTHERS THEN
    Raise_Application_Error(-20204, 'Fehler beim Erstellen der Lokomotive.');
    ROLLBACK TO before_create_lokomotive;
END;
/
/**********************************************************************/
/**
/** Procedure: sp_create_product
/** Developer: Elisabeth Glatz
/** In: v_name - product name
/** In: n_preis - price of the product
/** Description: Creates a new product
/**
/**********************************************************************/


CREATE OR REPLACE PROCEDURE sp_create_product(v_name IN VARCHAR2, n_preis IN NUMBER)
AS
BEGIN
	SAVEPOINT create_product_savepoint;
	INSERT INTO produkt VALUES (produkt_id_seq.NEXTVAL, v_name, n_preis);
EXCEPTION	
	WHEN DUP_VAL_ON_INDEX THEN
		raise_application_error(-20403,'Produkt existiert bereits.');
		ROLLBACK TO create_product_savepoint;
	WHEN OTHERS THEN
		raise_application_error(-20404,'Fehler.');
		ROLLBACK TO create_product_savepoint;
END;
/
/**********************************************************************/
/**
/** Procedure: sp_create_wagon
/** In: n_zugID - id of the train to add a wagon to
/** In: n_wagon_artID - id of the wagon type
/** In: d_baujahr - year the wagon was built
/** In: d_letzte_wartung - last date of maintenance
/** Developer: Samuel Fiedorowicz
/** Description: Create a wagon
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_create_wagon(n_zugID          IN zug.zugID%TYPE,
                          n_wagon_artID    IN wagon.fk_wagon_artID%TYPE,
                          d_baujahr        IN wagon.baujahr%TYPE,
                          d_letzte_wartung IN wagon.letzte_wartung%TYPE)
AS
  e_integrity EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_create_wagon;
  INSERT INTO wagon VALUES (
    wagon_id_seq.NEXTVAL,
    d_baujahr,
    d_letzte_wartung,
    n_wagon_artID,
    n_zugID
  );

EXCEPTION
  WHEN e_integrity THEN
    Raise_Application_Error(-20200, 'Fehler beim Erstellen des Wagons: Es gibt keinen Zug mit dieser ID.');
    ROLLBACK TO before_create_wagon;
  WHEN OTHERS THEN
    Raise_Application_Error(-20201, 'Fehler beim Erstellen des Wagons.');
    ROLLBACK TO before_create_wagon;
END;
/
/**********************************************************************/
/**
/** Procedure: sp_create_zug
/** In: v_seriennummer - serial number of the new train
/** Developer: Samuel Fiedorowicz
/** Description: Create a train
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_create_zug(v_seriennummer IN zug.seriennummer%TYPE)
AS
BEGIN
  SAVEPOINT before_create_zug;
  INSERT INTO zug VALUES (zug_id_seq.NEXTVAL, v_seriennummer);

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20206, 'Fehler beim Erstellen der Zugs.');
    ROLLBACK TO before_create_zug;

END;
/
/**********************************************************************/
/**
/** Procedure: sp_delete_allergen
/** Developer: Elisabeth Glatz
/** In: n_allergenID - ID of allergen that should be deleted
/** Description: Deletes an allergen
/**
/**********************************************************************/


CREATE OR REPLACE PROCEDURE sp_delete_allergen(n_allergenID NUMBER)
AS
BEGIN
	SAVEPOINT delete_allergen_savepoint;
	DELETE FROM allergen WHERE allergenID = n_allergenID;
EXCEPTION
	WHEN OTHERS THEN
		raise_application_error(-20402,'Fehler.');
		ROLLBACK TO delete_allergen_savepoint;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_delete_lokomotive
/** In: n_lokomotiveID - id of the lokomotive to delete
/** Developer: Samuel Fiedorowicz
/** Description: Delete a lokomotive
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_delete_lokomotive(n_lokomotiveID lokomotive.lokomotivID%TYPE)
AS
  e_integrity EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_delete_lokomotive;
  DELETE
    FROM lokomotive
    WHERE lokomotivID = n_lokomotiveID;

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20205, 'Fehler beim Löschen des Lokomotive.');
    ROLLBACK TO before_delete_lokomotive;
END;
/
/**********************************************************************/
/**
/** Procedure: sp_delete_product
/** Developer: Elisabeth Glatz
/** In: n_produktID - ID of product that should be deleted
/** Description: Deletes a product
/**
/**********************************************************************/


CREATE OR REPLACE PROCEDURE sp_delete_product(n_produktID NUMBER)
AS
BEGIN
	SAVEPOINT delete_product_savepoint;
	DELETE FROM produkt WHERE produktID = n_produktID;
EXCEPTION
	WHEN OTHERS THEN
		raise_application_error(-20405,'Fehler.');
		ROLLBACK TO delete_product_savepoint;
END;
/

/**********************************************************************/
/**
/** Procedure: sp_delete_wagon
/** In: n_wagonID - id of the wagon to delete
/** Developer: Samuel Fiedorowicz
/** Description: Delete a wagon
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_delete_wagon(n_wagonID wagon.wagonID%TYPE)
AS

BEGIN
  SAVEPOINT before_delete_wagon;
  DELETE
    FROM wagon
    WHERE wagonID = n_wagonID;

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20202, 'Fehler beim Löschen des Wagons.');
    ROLLBACK TO before_delete_wagon;
END;
/
/**********************************************************************/
/**
/** Procedure: sp_delete_zug
/** In: n_zugID - id of the zug to delete
/** Developer: Samuel Fiedorowicz
/** Description: Delete a train
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_delete_zug(n_zugID zug.zugID%TYPE)
AS
  e_integrity EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_integrity, -2291);

BEGIN
  SAVEPOINT before_delete_zug;
  DELETE
    FROM zug
    WHERE zugID = n_zugID;

EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20207, 'Fehler beim Löschen des Zugs.');
    ROLLBACK TO before_delete_zug;
END;
/







CREATE OR REPLACE TRIGGER tr_autoincr_zug_id_seq 
BEFORE INSERT ON zug
FOR EACH ROW
BEGIN
  IF :NEW.zugID IS NULL THEN
	SELECT zug_id_seq.NEXTVAL
	INTO   :new.zugID
	FROM   dual;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_autoincr_wagon_art_id_seq 
BEFORE INSERT ON wagon_art
FOR EACH ROW
BEGIN
  IF :NEW.wagon_artID IS NULL THEN
	SELECT wagon_art_id_seq.NEXTVAL
	INTO   :new.wagon_artID
	FROM   dual;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_autoincr_wagon_id_seq 
BEFORE INSERT ON wagon 
FOR EACH ROW
BEGIN
	IF :new.wagonID IS NULL THEN
	  SELECT wagon_id_seq.NEXTVAL
	  INTO   :new.wagonID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_lokomotive_id_seq
BEFORE INSERT ON lokomotive
FOR EACH ROW
BEGIN
	IF :new.lokomotivID IS NULL THEN
	  SELECT lokomotive_id_seq.NEXTVAL
	  INTO   :new.lokomotivID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_allergen_id_seq
BEFORE INSERT ON allergen 
FOR EACH ROW
BEGIN
	IF :new.allergenID IS NULL THEN
	  SELECT allergen_id_seq.NEXTVAL
	  INTO   :new.allergenID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_produkt_id_seq 
BEFORE INSERT ON produkt 
FOR EACH ROW
BEGIN
	IF :new.produktID IS NULL THEN
	  SELECT produkt_id_seq.NEXTVAL
	  INTO   :new.produktID
	  FROM   dual;
	END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_autoincr_person_id_seq 
BEFORE INSERT ON person 
FOR EACH ROW
BEGIN
	IF :new.personID IS NULL THEN	
	  SELECT person_id_seq.NEXTVAL
	  INTO   :new.personID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_bahnhof_id_seq 
BEFORE INSERT ON bahnhof
FOR EACH ROW
BEGIN
	IF :new.bahnhofID IS NULL THEN	
	  SELECT bahnhof_id_seq.NEXTVAL
	  INTO   :new.bahnhofID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_bahnsteig_id_seq
BEFORE INSERT ON bahnsteig
FOR EACH ROW
BEGIN
	IF :new.bahnsteigID IS NULL THEN	
	  SELECT bahnsteig_id_seq.NEXTVAL
	  INTO   :new.bahnsteigID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_mrolle_id_seq 
BEFORE INSERT ON mitarbeiter_rolle 
FOR EACH ROW
BEGIN
	IF :new.rollenID IS NULL THEN	
	  SELECT mitarbeiter_rolle_id_seq.NEXTVAL
	  INTO   :new.rollenID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_gstufe_id_seq 
BEFORE INSERT ON gehaltsstufe 
FOR EACH ROW
BEGIN
	IF :new.gehaltsstufeID IS NULL THEN	
	  SELECT gehaltsstufe_id_seq.NEXTVAL
	  INTO   :new.gehaltsstufeID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_servicedesk_id_seq
BEFORE INSERT ON servicedesk 
FOR EACH ROW
BEGIN
	IF :new.servicedeskID IS NULL THEN	
	  SELECT servicedesk_id_seq.NEXTVAL
	  INTO   :new.servicedeskID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_verbindung_id_seq
BEFORE INSERT ON verbindung 
FOR EACH ROW
BEGIN
	IF :new.verbindungID IS NULL THEN	
	  SELECT verbindung_id_seq.NEXTVAL
	  INTO   :new.verbindungID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_wartung_id_seq
BEFORE INSERT ON wartung 
FOR EACH ROW
BEGIN
	IF :new.wartungsID IS NULL THEN	
	  SELECT wartung_id_seq.NEXTVAL
	  INTO   :new.wartungsID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_ticket_art_id_seq
BEFORE INSERT ON ticket_art 
FOR EACH ROW
BEGIN
	IF :new.ticket_artID IS NULL THEN	
	  SELECT ticket_art_id_seq.NEXTVAL
	  INTO   :new.ticket_artID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_ticket_id_seq
BEFORE INSERT ON ticket 
FOR EACH ROW
BEGIN
	IF :new.ticketID IS NULL THEN	
	  SELECT ticket_id_seq.NEXTVAL
	  INTO   :new.ticketID
	  FROM   dual;
	END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_autoincr_artikel_id_seq
BEFORE INSERT ON online_artikel
FOR EACH ROW
BEGIN
	IF :new.artikelID IS NULL THEN	
	  SELECT artikel_id_seq.NEXTVAL
	  INTO   :new.artikelID
	  FROM   dual;
	END IF;
END;
/




--********************************************************************
--*
--* Trigger: tr_br_i_trigger_calc_price
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: Calculates the price for a ticket and enters it
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_trigger_calc_price
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	n_fk_ankunft_bahnsteig NUMBER;
	n_fk_abfahrt_bahnsteig NUMBER;
	n_abfahrt_bahnhofID NUMBER;
	n_ankunft_bahnhofID NUMBER;
	n_preis NUMBER;
BEGIN
	n_preis := -2;
	SELECT fk_ankunft_bahnsteig,fk_abfahrt_bahnsteig INTO  n_fk_ankunft_bahnsteig,n_fk_abfahrt_bahnsteig FROM verbindung WHERE verbindungID = :new.fk_verbindungID;
	SELECT fk_bahnhofID INTO n_abfahrt_bahnhofID FROM bahnsteig WHERE bahnsteig.bahnsteigID = n_fk_abfahrt_bahnsteig;
	SELECT fk_bahnhofID INTO n_ankunft_bahnhofID FROM bahnsteig WHERE bahnsteig.bahnsteigID = n_fk_ankunft_bahnsteig;
	
	n_preis := f_calculate_price(n_abfahrt_bahnhofID,n_ankunft_bahnhofID);
	IF n_preis = -1 THEN
	UPDATE ticket SET preis = 10000 WHERE ticketID = :new.fk_ticketID;
	RETURN;
	END IF;
	UPDATE ticket SET preis = n_preis WHERE ticketID = :new.fk_ticketID;
	RETURN;
END;
/

--********************************************************************
--*
--* Trigger: tr_br_i_max_passengers
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: CHeck if max onetimetickets is smaller than traincapacity -25%
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_max_passengers
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	e_maxTicketCounterReached EXCEPTION;
	n_currentTicketAmount Number;
	n_maxCapacityOfTrain Number;
	n_adjustedMaxValue Number;
BEGIN
	SELECT sum(kapazitaet) INTO n_maxCapacityOfTrain 
	FROM verbindung
		JOIN wagon ON wagon.fk_zugID = verbindung.fk_zugID 
		JOIN wagon_art ON wagon_art.wagon_artID = wagon.wagonID WHERE verbindung.verbindungID = :new.fk_verbindungID;
	
	SELECT COUNT(*) INTO n_currentTicketAmount FROM one_time_ticket WHERE fk_verbindungID = :new.fk_verbindungID;
	n_adjustedMaxValue := n_maxCapacityOfTrain * 0.8;
	IF n_currentTicketAmount >= n_adjustedMaxValue THEN
		RAISE e_maxTicketCounterReached;
	END IF;	 
END;
/

--********************************************************************
--*
--* Trigger: tr_br_i_punkte_mehrfach
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: give kunde points if he buys a ticket (mehrfachticket = points *5 and *8 on birthday)
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_punkte_mehrfach
BEFORE INSERT ON mehrfachticket
FOR EACH ROW
DECLARE
	e_maxTicketCounterReached EXCEPTION;
	n_personID NUMBER;
	n_punkteByTicketArt NUMBER;
	n_fk_ticket_artID NUMBER;
	t_geburtsdatum TIMESTAMP;
BEGIN
	SELECT fk_personID,fk_ticket_artID INTO n_personID,n_fk_ticket_artID FROM ticket WHERE ticket.ticketID = :new.fk_ticketID;
	SELECT punkte INTO n_punkteByTicketArt FROM ticket_art WHERE ticket_artID = n_fk_ticket_artID;
	SELECT geburtsdatum INTO t_geburtsdatum FROM person WHERE personID = n_personID;
	
	IF EXTRACT(month FROM t_geburtsdatum) = EXTRACT(MONTH FROM SYSDATE) and EXTRACT(day FROM t_geburtsdatum) = EXTRACT(MONTH FROM SYSDATE) THEN
		UPDATE kunde SET punkte = punkte + (n_punkteByTicketArt * 8) WHERE fk_personID = n_personID;
		RETURN;
	END IF;
	UPDATE kunde SET punkte = punkte + (n_punkteByTicketArt * 5) WHERE fk_personID = n_personID;
	RETURN;
END;
/

--********************************************************************
--*
--* Trigger: tr_br_i_punkte_ott
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: give kunde points if he buys a ticket, additional 200 points if ticket bought on birthday
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_punkte_ott
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	e_maxTicketCounterReached EXCEPTION;
	n_personID NUMBER;
	n_punkteByTicketArt NUMBER;
	n_fk_ticket_artID NUMBER;
	t_geburtsdatum TIMESTAMP;
BEGIN
	SELECT fk_personID,fk_ticket_artID INTO n_personID,n_fk_ticket_artID FROM ticket WHERE ticket.ticketID = :new.fk_ticketID;
	SELECT punkte INTO n_punkteByTicketArt FROM ticket_art WHERE ticket_artID = n_fk_ticket_artID;
	Update kunde SET punkte = punkte + n_punkteByTicketArt WHERE fk_personID = n_personID;	
	SELECT geburtsdatum INTO t_geburtsdatum FROM person WHERE personID = n_personID;
	
	IF EXTRACT(month FROM t_geburtsdatum) = EXTRACT(month FROM sysdate) AND EXTRACT(day FROM t_geburtsdatum) = EXTRACT(month FROM sysdate) THEN
		UPDATE kunde SET punkte = punkte + n_punkteByTicketArt + 200 WHERE fk_personID = n_personID;
		RETURN;
	END IF;
	UPDATE kunde SET punkte = punkte + n_punkteByTicketArt WHERE fk_personID = n_personID;
	RETURN;
END;
/


--********************************************************************
--*
--* Trigger: Schema_Switch
--* Type: After Logon on Database
--* Developer: Nicolas Klement
--* Description: Automatically switch schema to SYSTEM after logon
--*
--********************************************************************

CREATE OR REPLACE TRIGGER schema_switch
AFTER LOGON ON DATABASE
BEGIN
    IF user = 'DATENBANKPROJEKT' THEN
        EXECUTE IMMEDIATE 'ALTER SESSION SET CURRENT_SCHEMA=SYSTEM';
    END IF;
END;
/

--********************************************************************
--*
--* Trigger: tr_br_i_buy_date_one_t_ticket
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger aims to verify that no ticket can be bought for a train-connection 
--* that has already left the trainstation (grace period 2 minutes incase they last minute jumped on)
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_buy_date_one_t_ticket
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	n_trainHasWartungShedule NUMBER DEFAULT 0;
	t_abfahrts_uhrzeit TIMESTAMP;
	t_kaufdatum TIMESTAMP;
	e_ticketDateException EXCEPTION;
BEGIN
	SELECT abfahrt_uhrzeit INTO t_abfahrts_uhrzeit FROM verbindung WHERE verbindungID = :new.fk_verbindungID;
	SELECT kaufdatum INTO t_kaufdatum FROM ticket WHERE ticketID = :new.fk_ticketID;
	IF t_kaufdatum > t_abfahrts_uhrzeit - interval '2' MINUTE THEN
	RAISE e_ticketDateException;
	END IF;
END;
/

--********************************************************************
--*
--* Trigger: tr_br_i_single_con_at_time
--* Type: BeFORe row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger ensures that no train can be on the same connection at the same time.
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_single_con_at_time
BEFORE INSERT ON verbindung
FOR EACH ROW
DECLARE
	e_trainOnMultipleConnSameTime EXCEPTION;
	CURSOR trainHasConnections_cur IS SELECT * FROM verbindung WHERE fk_zugID = :new.fk_zugID ;
	n_bool NUMBER;
BEGIN
	FOR v_result IN trainHasConnections_cur
	LOOP
		n_bool := f_validate_no_time_overlap(v_result.abfahrt_uhrzeit,v_result.ankunft_uhrzeit,:new.abfahrt_uhrzeit,:new.ankunft_uhrzeit);
		IF n_bool =0 THEN
		  RAISE e_trainOnMultipleConnSameTime;
		END IF;
	END LOOP;
END;
/

--********************************************************************
--*
--* Trigger: tr_br_i_zug_wartung_check
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger aims to verify that no train is on a connection while he should be in repair.
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_zug_wartung_check 
BEFORE INSERT ON verbindung
FOR EACH ROW
DECLARE
	n_trainHasWartungShedule NUMBER DEFAULT 0;
	t_beginWartungDate TIMESTAMP;
	t_endWartungDate TIMESTAMP;
	e_wartungviolation EXCEPTION;
	CURSOR hasWartungSheduled_cur IS SELECT start_wartung,ende_wartung FROM wartung WHERE fk_zugID = :new.fk_zugID;
	n_bool NUMBER;
BEGIN
	SELECT Count(*) INTO n_trainHasWartungShedule FROM wartung WHERE fk_zugID = :new.fk_zugID;
	IF n_trainHasWartungShedule > 0 THEN
		FOR v_result in	hasWartungSheduled_cur
		LOOP
			n_bool := f_validate_no_time_overlap(v_result.start_wartung,v_result.ende_wartung,:new.abfahrt_uhrzeit,:new.ankunft_uhrzeit);
			IF n_bool =0 THEN
		  	RAISE e_wartungviolation;
			END IF;
		END LOOP;
		RETURN;
	END IF;
END;
/





CREATE USER datenbankprojekt IDENTIFIED BY password;
GRANT CONNECT TO datenbankprojekt;

GRANT SELECT ON system.allergen_info TO datenbankprojekt;
GRANT SELECT ON system.bahnhof_info TO datenbankprojekt;
GRANT SELECT ON system.bahnhof_timetable TO datenbankprojekt;
GRANT SELECT ON system.bahnsteig_info TO datenbankprojekt;
GRANT SELECT ON system.gehaltsstufe_info TO datenbankprojekt;
GRANT SELECT ON system.kunde_info TO datenbankprojekt;
GRANT SELECT ON system.lokomotive_info TO datenbankprojekt;
GRANT SELECT ON system.mehrfach_ticket_info TO datenbankprojekt;
GRANT SELECT ON system.mitarbeiter_info TO datenbankprojekt;
GRANT SELECT ON system.mitarbeiterrolle_info TO datenbankprojekt;
GRANT SELECT ON system.one_time_ticket_info TO datenbankprojekt;
GRANT SELECT ON system.online_artikel_info TO datenbankprojekt;
GRANT SELECT ON system.ort_info TO datenbankprojekt;
GRANT SELECT ON system.produkt_allergen_info TO datenbankprojekt;
GRANT SELECT ON system.produkt_info TO datenbankprojekt;
GRANT SELECT ON system.servicedesk_info TO datenbankprojekt;
GRANT SELECT ON system.ticketart_info TO datenbankprojekt;
GRANT SELECT ON system.vor_24h_gekauft TO datenbankprojekt;
GRANT SELECT ON system.verbindung_info TO datenbankprojekt;
GRANT SELECT ON system.verfuegbare_artikel TO datenbankprojekt;
GRANT SELECT ON system.verpflegung TO datenbankprojekt;
GRANT SELECT ON system.verwendbare_tickets TO datenbankprojekt;
GRANT SELECT ON system.verwendete_tickets TO datenbankprojekt;
GRANT SELECT ON system.wagonart_info TO datenbankprojekt;
GRANT SELECT ON system.wagon_info TO datenbankprojekt;
GRANT SELECT ON system.wartung_info TO datenbankprojekt;
GRANT SELECT ON system.zug_info TO datenbankprojekt;

GRANT EXECUTE ON system.f_average_ticket_price TO datenbankprojekt;
GRANT EXECUTE ON system.f_calculate_price TO datenbankprojekt;
GRANT EXECUTE ON system.f_get_next_arrival TO datenbankprojekt;
GRANT EXECUTE ON system.f_get_next_departures TO datenbankprojekt;
GRANT EXECUTE ON system.f_get_personid TO datenbankprojekt;
GRANT EXECUTE ON system.f_get_role TO datenbankprojekt;
GRANT EXECUTE ON system.f_total_expenditure TO datenbankprojekt;
GRANT EXECUTE ON system.f_try_login TO datenbankprojekt;
GRANT EXECUTE ON system.f_validate_no_time_overlap TO datenbankprojekt;

GRANT EXECUTE ON system.sp_create_mitarbeiter_rolle TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_mitarbeiter_rolle TO datenbankprojekt;
GRANT EXECUTE ON system.sp_CreateGehaltsStufe TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_gehalts_stufe TO datenbankprojekt;
GRANT EXECUTE ON system.sp_create_online_artikel TO datenbankprojekt;
GRANT EXECUTE ON system.sp_update_artikel_price TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_artikel TO datenbankprojekt;
GRANT EXECUTE ON system.sp_create_ort TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_ort TO datenbankprojekt;
GRANT EXECUTE ON system.sp_create_mitarbeiter TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_mitarbeiter TO datenbankprojekt;
GRANT EXECUTE ON system.sp_create_kunde TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_kunde TO datenbankprojekt;
GRANT EXECUTE ON system.sp_create_ticket_art TO datenbankprojekt;
GRANT EXECUTE ON system.sp_buy_one_time_ticket TO datenbankprojekt;
GRANT EXECUTE ON system.sp_buy_mehrfach_tickt TO datenbankprojekt;
GRANT EXECUTE ON system.sp_book_alternative_train TO datenbankprojekt;
GRANT EXECUTE ON system.sp_create_allergen TO datenbankprojekt;
GRANT EXECUTE ON system.sp_create_lokomotive TO datenbankprojekt;
GRANT EXECUTE ON system.sp_create_product TO datenbankprojekt;
GRANT EXECUTE ON system.sp_create_wagon TO datenbankprojekt;
GRANT EXECUTE ON system.sp_create_zug TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_allergen TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_lokomotive TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_product TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_wagon TO datenbankprojekt;
GRANT EXECUTE ON system.sp_delete_zug TO datenbankprojekt;

COMMIT;
