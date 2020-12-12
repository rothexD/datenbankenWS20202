--********************************************************************
--*
--* Trigger: tr_autoincr_name_id_seq
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: Takes care of the continuation of IDs that are used as primary keys and increments it by 1
--*
--********************************************************************
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



BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_zug_id_seq ';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_wagon_art_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_wagon_id_seq ';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_lokomotive_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_allergen_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_produkt_id_seq';

EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_person_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_bahnhof_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_bahnsteig_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_mrolle_id_seq ';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_gstufe_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_servicedesk_id_seq';

EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_verbindung_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_wartung_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_ticket_art_id_seq';
EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_ticket_id_seq';

EXECUTE IMMEDIATE 'DROP TRIGGER tr_autoincr_artikel_id_seq';
END;
/
















