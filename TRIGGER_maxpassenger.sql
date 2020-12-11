--********************************************************************
--*
--* Trigger: tr_br_i_max_passengers
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: CHeck if max onetimetickets is smaller than traincapacity -25%
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_max_passengers
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	e_maxTicketCounterReached EXCEPTION;
	n_currentTicketAmount Number;
	n_maxCapacityOfTrain Number;
	n_adjustedMaxValue Number;
BEGIN
	SELECT sum(kapazitaet) INTO n_maxCapacityOfTrain 
	FROM verbindung
		JOIN wagon ON wagon.fk_zugID = verbindung.fk_zugID 
		JOIN wagon_art ON wagon_art.wagon_artID = wagon.wagonID WHERE verbindung.verbindungID = :new.fk_verbindungID;
	
	SELECT COUNT(*) INTO n_currentTicketAmount FROM one_time_ticket WHERE fk_verbindungID = :new.fk_verbindungID;
	n_adjustedMaxValue := n_maxCapacityOfTrain * 0.8;
	IF n_currentTicketAmount >= n_adjustedMaxValue THEN
		RAISE e_maxTicketCounterReached;
	END IF;	 
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_br_i_max_passengers';
END;
/
