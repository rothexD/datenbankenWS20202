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
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_br_i_buy_date_one_t_ticket';
END;
/
