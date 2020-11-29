--********************************************************************
--*
--* Trigger: trigger_onlyOneConnectionAtTime
--* Type: BeFORe row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger ensures that no train can be on the same connection at the same time.
--*
--********************************************************************

CREATE OR REPLACE TRIGGER trigger_singleConAtTime
BEFORE INSERT ON verbindung
FOR EACH ROW
DECLARE
	TrainOnMultipleConnAtSameTime EXCEPTION;
	CURSOR cur_TrainHasConnections IS SELECT * FROM verbindung WHERE fk_zugID = :NEW.fk_zugID ;
	v_bool NUMBER;
BEGIN
	FOR v_result IN cur_TrainHasConnections
	LOOP
		v_bool := validate_no_time_overlap(v_result.abfahrt_uhrzeit,v_result.ankunft_uhrzeit,:NEW.abfahrt_uhrzeit,:NEW.ankunft_uhrzeit);
		if v_bool =0 then
		  raise TrainOnMultipleConnAtSameTime;
		end if;
	END LOOP;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER trigger_singleConAtTime';
END;
/
