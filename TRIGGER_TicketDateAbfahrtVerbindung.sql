--********************************************************************
--*
--* Trigger: tr_br_buy_date_one_t_ticket
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger aims to verify that no ticket can be bought for a train-connection 
--* that has already left the trainstation (grace period 2 minutes incase they last minute jumped on)
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_buy_date_one_t_ticket
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	n_TrainHasWartungShedule NUMBER DEFAULT 0;
	n_ABfahrtsUhrzeit TIMESTAMP;
	n_kaufdatum TIMESTAMP;
	e_TicketDateException EXCEPTION;
BEGIN
	SELECT abfahrt_uhrzeit INTO n_ABfahrtsUhrzeit FROM verbindung WHERE verbindungID = :NEW.fk_verbindungID;
	SELECT kaufdatum INTO n_kaufdatum FROM ticket WHERE ticketID = :NEW.fk_ticketID;
	IF n_kaufdatum > n_ABfahrtsUhrzeit - interval '2' MINUTE THEN
	RAISE e_TicketDateException;
	END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_br_buy_date_one_t_ticket';
END;
/
