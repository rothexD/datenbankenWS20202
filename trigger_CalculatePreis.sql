
--********************************************************************
--*
--* Trigger: tr_br_trigger_calculate_price
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: Calculates the price for a ticket and enters it
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_trigger_calculate_price
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	n_fk_ankunft_bahnsteig NUMBER;
	n_fk_abfahrt_bahnsteig NUMBER;
	n_AbfahrtBahnhofID NUMBER;
	n_AnkunftbahnhofID NUMBER;
	n_preis NUMBER;
BEGIN
	n_preis := -2;
	SELECT fk_ankunft_bahnsteig,fk_abfahrt_bahnsteig INTO  n_fk_ankunft_bahnsteig,n_fk_abfahrt_bahnsteig from verbindung where verbindungID = :new.fk_verbindungID;
	SELECT fk_bahnhofID into n_AbfahrtBahnhofID from bahnsteig where bahnsteig.bahnsteigID = n_fk_abfahrt_bahnsteig;
	SELECT fk_bahnhofID into n_AnkunftbahnhofID from bahnsteig where bahnsteig.bahnsteigID = n_fk_ankunft_bahnsteig;
	
	n_preis := calculate_price(n_AbfahrtBahnhofID,n_AnkunftbahnhofID);
	if n_preis = -1 then
	update ticket set preis = 10000 where ticketID = :new.fk_ticketID;
	return;
	end if;
	update ticket set preis = n_preis where ticketID = :new.fk_ticketID;
	return;
END;
/

BEGIN
execute immediate 'DROP TRIGGER tr_br_trigger_calculate_price';
END;
/
