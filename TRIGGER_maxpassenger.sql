--********************************************************************
--*
--* Trigger: tr_br_max_passengers
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: CHeck if max onetimetickets is smaller than traincapacity -25%
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_max_passengers
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	e_MaxTicketCounterReached EXCEPTION;
	n_CurrentTicketAmmount Number;
	n_MaxCapacityOfTrain Number;
	n_AdjustedMaxValue Number;
BEGIN
	SELECT sum(kapazitaet) INTO n_MaxCapacityOfTrain 
	FROM verbindung
		JOIN wagon ON wagon.fk_zugID = verbindung.fk_zugID 
		JOIN wagon_art ON wagon_art.wagon_artID = wagon.wagonID where verbindung.verbindungID = :new.fk_verbindungID;
	
	SELECT COUNT(*) INTO n_CurrentTicketAmmount FROM one_time_ticket WHERE fk_verbindungID = :new.fk_verbindungID;
	n_AdjustedMaxValue := n_MaxCapacityOfTrain * 0.8;
	IF n_CurrentTicketAmmount >= n_AdjustedMaxValue THEN
		RAISE e_MaxTicketCounterReached;
	END IF;	 
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_br_max_passengers';
END;
/
