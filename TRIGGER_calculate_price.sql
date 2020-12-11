
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

BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_br_i_trigger_calc_price';
END;
/
