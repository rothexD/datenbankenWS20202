--********************************************************************
--*
--* Trigger: tr_br_i_single_con_at_time
--* Type: BeFORe row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger ensures that no train can be on the same connection at the same time.
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_single_con_at_time
BEFORE INSERT ON verbindung
FOR EACH ROW
DECLARE
	e_trainOnMultipleConnAtSameTime EXCEPTION;
	CURSOR trainHasConnections_cur IS SELECT * FROM verbindung WHERE fk_zugID = :new.fk_zugID ;
	n_bool NUMBER;
BEGIN
	FOR v_result IN trainHasConnections_cur
	LOOP
		n_bool := validate_no_time_overlap(v_result.abfahrt_uhrzeit,v_result.ankunft_uhrzeit,:new.abfahrt_uhrzeit,:new.ankunft_uhrzeit);
		IF n_bool =0 THEN
		  RAISE e_trainOnMultipleConnAtSameTime;
		END IF;
	END LOOP;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_br_i_single_con_at_time';
END;
/
