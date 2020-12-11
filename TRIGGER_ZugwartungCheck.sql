--********************************************************************
--*
--* Trigger: tr_br_i_zug_wartung_check
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger aims to verify that no train is on a connection while he should be in repair.
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_br_i_zug_wartung_check 
BEFORE INSERT ON verbindung
FOR EACH ROW
DECLARE
	n_trainHasWartungShedule NUMBER DEFAULT 0;
	t_beginWartungDate TIMESTAMP;
	t_endWartungDate TIMESTAMP;
	e_wartungviolation EXCEPTION;
	CURSOR hasWartungSheduled_cur IS SELECT start_wartung,ende_wartung FROM wartung WHERE fk_zugID = :new.fk_zugID;
	n_bool NUMBER;
BEGIN
	SELECT Count(*) INTO n_trainHasWartungShedule FROM wartung WHERE fk_zugID = :new.fk_zugID;
	IF n_trainHasWartungShedule > 0 THEN
		FOR v_result in	hasWartungSheduled_cur
		LOOP
			n_bool := f_validate_no_time_overlap(v_result.start_wartung,v_result.ende_wartung,:new.abfahrt_uhrzeit,:new.ankunft_uhrzeit);
			IF n_bool =0 THEN
		  	RAISE e_wartungviolation;
			END IF;
		END LOOP;
		RETURN;
	END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER tr_br_i_zug_wartung_check';
END;
/

