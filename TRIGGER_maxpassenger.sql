--********************************************************************
--*
--* Trigger: trigger_MaxPassengers
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: CHeck if max onetimetickets is smaller than traincapacity -25%
--*
--********************************************************************

CREATE OR REPLACE TRIGGER trigger_MaxPassengers
BEFORE INSERT ON one_time_ticket 
FOR EACH ROW
DECLARE
	MaxTicketCounterReached EXCEPTION;
	CurrentTicketAmmount Number;
	MaxCapacityOfTrain Number;
	AdjustedMaxValue Number;
BEGIN
	SELECT sum(kapazitaet) INTO MaxCapacityOfTrain 
	FROM verbindung
		JOIN zug_hat_wagons ON zug_hat_wagons.fk_zugID = verbindung.fk_zugID 
		JOIN wagon ON zug_hat_wagons.fk_wagonID = wagon.wagonID
		JOIN wagon_art ON wagon_art.wagon_artID = wagon.wagonID;
	
	SELECT COUNT(*) INTO CurrentTicketAmmount FROM one_time_ticket WHERE fk_verbindungID = :new.fk_verbindungID;
	AdjustedMaxValue := MaxCapacityOfTrain * 0.8;
	IF CurrentTicketAmmount >= AdjustedMaxValue THEN
		RAISE MaxTicketCounterReached;
	END IF;	 
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER trigger_MaxPassengers';
END;
/
