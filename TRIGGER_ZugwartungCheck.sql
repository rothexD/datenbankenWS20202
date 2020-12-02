--********************************************************************
--*
--* Trigger: tr_br_zug_wartung_check
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger aims to verify that no train is on a connection while he should be in repair.
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_zug_wartung_check 
BEFORE INSERT ON verbindung
FOR EACH ROW
DECLARE
	n_TrainHasWartungShedule Number DEFAULT 0;
	BeginWartungDate timestamp;
	EndWartungDate timestamp;
	e_wartungviolation EXCEPTION;
	CURSOR cur_HasWartungSheduled IS SELECT start_wartung,ende_wartung FROM wartung WHERE fk_zugID = :new.fk_zugID;
	n_bool Number;
BEGIN
	SELECT Count(*) INTO n_TrainHasWartungShedule FROM wartung WHERE fk_zugID = :new.fk_zugID;
	IF n_TrainHasWartungShedule > 0 THEN
		FOR v_result in	cur_HasWartungSheduled
		LOOP
			n_bool := validate_no_time_overlap(v_result.start_wartung,v_result.ende_wartung,:NEW.abfahrt_uhrzeit,:NEW.ankunft_uhrzeit);
			IF n_bool =0 THEN
		  	raise e_wartungviolation;
			END IF;
		END LOOP;
		RETURN;
	END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_br_zug_wartung_check';
END;
/

