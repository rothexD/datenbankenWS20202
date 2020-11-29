CREATE OR REPLACE TRIGGER autoincr_zug_id_seq 
BEFORE INSERT ON zug
FOR EACH ROW
BEGIN
  SELECT zug_id_seq.NEXTVAL
  INTO   :new.zugID
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER autoincr_wagon_art_id_seq 
BEFORE INSERT ON wagon_art
FOR EACH ROW
BEGIN
  SELECT wagon_art_id_seq.NEXTVAL
  INTO   :new.wagon_artID
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER autoincr_wagon_id_seq 
BEFORE INSERT ON wagon 
FOR EACH ROW
BEGIN
  SELECT wagon_id_seq.NEXTVAL
  INTO   :new.wagonID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_lokomotive_id_seq
BEFORE INSERT ON lokomotive
FOR EACH ROW
BEGIN
  SELECT lokomotive_id_seq.NEXTVAL
  INTO   :new.lokomotivID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_allergen_id_seq
BEFORE INSERT ON allergen 
FOR EACH ROW
BEGIN
  SELECT allergen_id_seq.NEXTVAL
  INTO   :new.allergenID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_produkt_id_seq 
BEFORE INSERT ON produkt 
FOR EACH ROW
BEGIN
  SELECT produkt_id_seq.NEXTVAL
  INTO   :new.produktID
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER autoincr_person_id_seq 
BEFORE INSERT ON person 
FOR EACH ROW
BEGIN
  SELECT person_id_seq.NEXTVAL
  INTO   :new.personID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_bahnhof_id_seq 
BEFORE INSERT ON bahnhof
FOR EACH ROW
BEGIN
  SELECT bahnhof_id_seq.NEXTVAL
  INTO   :new.bahnhofID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_bahnsteig_id_seq
BEFORE INSERT ON bahnsteig
FOR EACH ROW
BEGIN
  SELECT bahnsteig_id_seq.NEXTVAL
  INTO   :new.bahnsteigID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_mrolle_id_seq 
BEFORE INSERT ON mitarbeiter_rolle 
FOR EACH ROW
BEGIN
  SELECT mitarbeiter_rolle_id_seq.NEXTVAL
  INTO   :new.rollenID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_gehaltsstufe_id_seq 
BEFORE INSERT ON gehaltsstufe 
FOR EACH ROW
BEGIN
  SELECT gehaltsstufe_id_seq.NEXTVAL
  INTO   :new.gehaltsstufeID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_servicedesk_id_seq
BEFORE INSERT ON servicedesk 
FOR EACH ROW
BEGIN
  SELECT servicedesk_id_seq.NEXTVAL
  INTO   :new.servicedeskID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_verbindung_id_seq
BEFORE INSERT ON verbindung 
FOR EACH ROW
BEGIN
  SELECT verbindung_id_seq.NEXTVAL
  INTO   :new.verbindungID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_wartung_id_seq
BEFORE INSERT ON wartung 
FOR EACH ROW
BEGIN
  SELECT wartung_id_seq.NEXTVAL
  INTO   :new.wartungsID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_ticket_art_id_seq
BEFORE INSERT ON ticket_art 
FOR EACH ROW
BEGIN
  SELECT ticket_art_id_seq.NEXTVAL
  INTO   :new.ticket_artID
  FROM   dual;
END;
/
CREATE OR REPLACE TRIGGER autoincr_ticket_id_seq
BEFORE INSERT ON ticket 
FOR EACH ROW
BEGIN
  SELECT ticket_id_seq.NEXTVAL
  INTO   :new.ticketID
  FROM   dual;
END;
/



BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_zug_id_seq ';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_wagon_art_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_wagon_id_seq ';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_lokomotive_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_allergen_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_produkt_id_seq';

EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_person_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_bahnhof_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_bahnsteig_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_mrolle_id_seq ';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_gehaltsstufe_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_servicedesk_id_seq';

EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_verbindung_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_wartung_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_ticket_art_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER autoincr_ticket_id_seq';
END;
/
















