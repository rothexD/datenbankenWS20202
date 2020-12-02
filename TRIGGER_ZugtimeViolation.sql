--********************************************************************
--*
--* Trigger: tr_br_single_con_at_time
--* Type: BeFORe row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger ensures that no train can be on the same connection at the same time.
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_single_con_at_time
BEFORE INSERT ON verbindung
FOR EACH ROW
DECLARE
	e_TrainOnMultipleConnAtSameTime EXCEPTION;
	CURSOR cur_TrainHasConnections IS SELECT * FROM verbindung WHERE fk_zugID = :NEW.fk_zugID ;
	n_bool NUMBER;
BEGIN
	FOR v_result IN cur_TrainHasConnections
	LOOP
		n_bool := validate_no_time_overlap(v_result.abfahrt_uhrzeit,v_result.ankunft_uhrzeit,:NEW.abfahrt_uhrzeit,:NEW.ankunft_uhrzeit);
		if n_bool =0 then
		  raise e_TrainOnMultipleConnAtSameTime;
		end if;
	END LOOP;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_br_single_con_at_time';
END;
/
