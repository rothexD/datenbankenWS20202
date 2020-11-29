--********************************************************************
--*
--* Trigger: trigger_Punkte_ott
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: give kunde points if he buys a ticket
--*
--********************************************************************

CREATE OR REPLACE TRIGGER trigger_CalculatePrice
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	v_fk_ankunft_bahnsteig NUMBER;
	v_fk_abfahrt_bahnsteig NUMBER;
	v_AbfahrtBahnhofID NUMBER;
	v_AnkunftbahnhofID NUMBER;
	v_preis NUMBER;
BEGIN
	v_preis := -2;
	SELECT fk_ankunft_bahnsteig,fk_abfahrt_bahnsteig INTO  v_fk_ankunft_bahnsteig,V_fk_abfahrt_bahnsteig from verbindung where verbindungID = :new.fk_verbindungID;
	SELECT fk_bahnhofID into v_AbfahrtBahnhofID from bahnsteig where bahnsteig.bahnsteigID = v_fk_abfahrt_bahnsteig;
	SELECT fk_bahnhofID into v_AnkunftbahnhofID from bahnsteig where bahnsteig.bahnsteigID = v_fk_ankunft_bahnsteig;
	
	v_preis := calculate_price(v_AbfahrtBahnhofID,v_AnkunftbahnhofID);
	if v_preis = -1 then
	update ticket set preis = 10000 where ticketID = :new.fk_ticketID;
	return;
	end if;
	update ticket set preis = v_preis where ticketID = :new.fk_ticketID;
	return;
END;
/

BEGIN
execute immediate 'DROP TRIGGER trigger_CalculatePrice';
END;
/
