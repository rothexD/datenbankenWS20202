--********************************************************************
--*
--* Trigger: trigger_zug_wartung_check
--* Type: Before row
--* Type Extension: insert
--* Developer: Lukas Schweinberger
--* Description: This trigger aims to verify that no train is on a connection while he should be in repair.
--*
--********************************************************************

CREATE OR REPLACE TRIGGER trigger_zug_wartung_check 
BEFORE INSERT ON verbindung
FOR EACH ROW
DECLARE
	TrainHasWartungShedule Number DEFAULT 0;
	BeginWartungDate timestamp;
	EndWartungDate timestamp;
	wartungviolation_exception EXCEPTION;
	CURSOR cur_HasWartungSheduled IS SELECT start_wartung,ende_wartung FROM wartung WHERE fk_zugID = :new.fk_zugID;
BEGIN
	SELECT Count(*) INTO TrainHasWartungShedule FROM wartung WHERE fk_zugID = :new.fk_zugID;
	IF TrainHasWartungShedule > 0 THEN
		FOR v_result in	cur_HasWartungSheduled
		LOOP
		  --abfahrt timestamp '2020-10-10 0:0:0.0', ankunfttimestamp '2020-11-10 0:0:0.0'
		  --    abfahrt..wartungsBEGIN..wartungsende..ankunft
			IF :new.abfahrt_uhrzeit < v_result.start_wartung AND v_result.ende_wartung < :new.ankunft_uhrzeit  THEN
				RAISE wartungviolation_exception; 
			END IF;
			--	  abfahrt..wartungsBEGIN..ankunft..wartungsende
			IF :new.abfahrt_uhrzeit < v_result.start_wartung AND :new.ankunft_uhrzeit < v_result.ende_wartung THEN
				RAISE wartungviolation_exception;
			END IF;
			--	  wartungsBEGIN..abfahrt..ankunft..wartungsende
			IF v_result.start_wartung < :new.abfahrt_uhrzeit AND :new.ankunft_uhrzeit < v_result.ende_wartung  THEN
				RAISE wartungviolation_exception;
			END IF;				
			--	  wartungsBEGIN..abfahrt..wartungsende..ankunft
			IF v_result.start_wartung < :new.abfahrt_uhrzeit AND v_result.ende_wartung < :new.ankunft_uhrzeit THEN
				RAISE wartungviolation_exception;
			END IF;
		END LOOP;
		RETURN;
	END IF;

END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER trigger_zug_wartung_check'  
END;
/

