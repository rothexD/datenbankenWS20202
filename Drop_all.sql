------ DROP DATA & SEQUENCES ------

DELETE FROM ort;
DELETE FROM person;
DELETE FROM bahnhof;
DELETE FROM kunde;
DELETE FROM bahnsteig;
DELETE FROM mitarbeiter_rolle;
DELETE FROM gehaltsstufe;
DELETE FROM mitarbeiter;
DELETE FROM servicedesk;

DELETE FROM wagon_art;
DELETE FROM wagon;
DELETE FROM lokomotive;
DELETE FROM zug;
DELETE FROM allergen;
DELETE FROM produkt;
DELETE FROM produkt_hat_allergen;
DELETE FROM wagon_hat_produkt;

DELETE FROM wartung;
DELETE FROM verbindung;
DELETE FROM ticket_art;
DELETE FROM ticket;
DELETE FROM mehrfachticket;
DELETE FROM one_time_ticket;

DELETE FROM online_artikel;
DELETE FROM person_hat_online_artikel;



DROP SEQUENCE person_id_seq;
DROP SEQUENCE bahnhof_id_seq;
DROP SEQUENCE bahnsteig_id_seq;
DROP SEQUENCE mitarbeiter_rolle_id_seq;
DROP SEQUENCE gehaltsstufe_id_seq;
DROP SEQUENCE servicedesk_id_seq;

DROP SEQUENCE zug_id_seq;
DROP SEQUENCE wagon_id_seq;
DROP SEQUENCE wagon_art_id_seq;
DROP SEQUENCE lokomotive_id_seq;
DROP SEQUENCE allergen_id_seq;
DROP SEQUENCE produkt_id_seq;

DROP SEQUENCE wartung_id_seq;
DROP SEQUENCE verbindung_id_seq;
DROP SEQUENCE ticket_art_id_seq;
DROP SEQUENCE ticket_id_seq;
DROP SEQUENCE artikel_id_seq;


-- Drop Indizes --

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

------ DROP TABLES ------

DROP TABLE person CASCADE CONSTRAINTS;
DROP TABLE mitarbeiter CASCADE CONSTRAINTS;
DROP TABLE bahnhof CASCADE CONSTRAINTS;
DROP TABLE kunde CASCADE CONSTRAINTS;
DROP TABLE verbindung CASCADE CONSTRAINTS;
DROP TABLE wagon CASCADE CONSTRAINTS;
DROP TABLE lokomotive CASCADE CONSTRAINTS;
DROP TABLE wagon_art CASCADE CONSTRAINTS;
DROP TABLE bahnsteig CASCADE CONSTRAINTS;
DROP TABLE zug CASCADE CONSTRAINTS;
DROP TABLE wartung CASCADE CONSTRAINTS;
DROP TABLE mitarbeiter_rolle CASCADE CONSTRAINTS;
DROP TABLE servicedesk CASCADE CONSTRAINTS;
DROP TABLE ort CASCADE CONSTRAINTS;
DROP TABLE ticket_art CASCADE CONSTRAINTS;
DROP TABLE one_time_ticket CASCADE CONSTRAINTS;
DROP TABLE gehaltsstufe CASCADE CONSTRAINTS;
DROP TABLE allergen CASCADE CONSTRAINTS;
DROP TABLE produkt CASCADE CONSTRAINTS;
DROP TABLE produkt_hat_allergen CASCADE CONSTRAINTS;
DROP TABLE wagon_hat_produkt CASCADE CONSTRAINTS;
DROP TABLE mehrfachticket CASCADE CONSTRAINTS;
DROP TABLE ticket CASCADE CONSTRAINTS;
DROP TABLE online_artikel CASCADE CONSTRAINTS;
DROP TABLE person_hat_online_artikel CASCADE CONSTRAINTS;
