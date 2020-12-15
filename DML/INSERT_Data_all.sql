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
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 6, 4, 1, (TO_TIMESTAMP('2020-12-14 10:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-12-14 12:30', 'YYYY-MM-DD HH24:MI')));
-- Graz - Wien (von Graz Bahnsteig C nach Wien Bahnsteig A)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 4, 6, 1, (TO_TIMESTAMP('2020-12-14 13:30', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-12-14 15:00', 'YYYY-MM-DD HH24:MI')));

-- Wien - Linz (von Wien Bahnsteig A nach Linz Bahnsteig B)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 4, 8, 2, (TO_TIMESTAMP('2020-12-14 08:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-12-14 09:30', 'YYYY-MM-DD HH24:MI')));
-- Linz - Wien (von Linz Bahnsteig B nach Wien Bahnsteig C)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 8, 4, 2, (TO_TIMESTAMP('2020-12-14 08:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-12-14 09:30', 'YYYY-MM-DD HH24:MI')));

-- Wien - Bregenz (von Wien Bahnsteig B nach Bregenz Bahnsteig A)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 10, 5, 3, (TO_TIMESTAMP('2020-12-14 09:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-12-14 18:00', 'YYYY-MM-DD HH24:MI')));
-- Bregenz - Wien (von Bregenz Bahnsteig A nach Wien Bahnsteig B)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 5, 10, 3, (TO_TIMESTAMP('2020-12-15 21:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-12-16 06:00', 'YYYY-MM-DD HH24:MI')));

-- Wien - Salzburg (von Wien Bahnsteig B nach Salzburg Bahnsteig A)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 16, 5, 4, (TO_TIMESTAMP('2020-12-16 09:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-12-16 12:00', 'YYYY-MM-DD HH24:MI')));
-- Salzburg - Wien (von Salzburg Bahnsteig A nach Wien Bahnsteig B)
INSERT INTO verbindung VALUES (verbindung_id_seq.NEXTVAL, 5, 16, 4, (TO_TIMESTAMP('2020-12-16 15:00', 'YYYY-MM-DD HH24:MI')), (TO_TIMESTAMP('2020-12-16 18:00', 'YYYY-MM-DD HH24:MI')));





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


------ SELECT DATA -----
SELECT * FROM ort;
SELECT * FROM person;
SELECT * FROM bahnhof;
SELECT * FROM kunde;
SELECT * FROM bahnsteig;
SELECT * FROM mitarbeiter_rolle;
SELECT * FROM gehaltsstufe;
SELECT * FROM mitarbeiter;
SELECT * FROM servicedesk;

SELECT * FROM wagon_art;
SELECT * FROM wagon;
SELECT * FROM lokomotive;
SELECT * FROM zug;
SELECT * FROM allergen;
SELECT * FROM produkt;
SELECT * FROM produkt_hat_allergen;
SELECT * FROM wagon_hat_produkt;

SELECT * FROM wartung;
SELECT * FROM verbindung;
SELECT * FROM ticket_art;
SELECT * FROM ticket;
SELECT * FROM mehrfachticket;
SELECT * FROM one_time_ticket;

COMMIT;
