--********************************************************************
--*
--* Trigger: trigger_buy_date_one_time_ticket
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger aims to verify that no ticket can be bought for a train-connection 
--* that has already left the trainstation (grace period 2 minutes incase they last minute jumped on)
--*
--********************************************************************

CREATE OR REPLACE TRIGGER trigger_buy_date_one_t_ticket
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	TrainHasWartungShedule Number DEFAULT 0;
	v_ABfahrtsUhrzeit timestamp;
	v_kaufdatum timestamp;
	TicketDateException EXCEPTION;
BEGIN
	SELECT abfahrt_uhrzeit INTO v_AbfahrtsUhrzeit FROM verbindung WHERE verbindungID = :new.fk_verbindungID;
	SELECT kaufdatum INTO v_kaufdatum FROM ticket WHERE ticketID = :new.fk_ticketID;
	IF v_kaufdatum > v_AbfahrtsUhrzeit - interval '2' MINUTE THEN
	RAISE TicketDateException;
	END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER trigger_buy_date_one_t_ticket';
END;
/
