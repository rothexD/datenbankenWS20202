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
BEGIN
	FOR v_result IN cur_TrainHasConnections
	LOOP
		--abfahrtA = old
		--abfahrtB = NEW
		
		--abfahrtA..abfahrtB..ankunftB..ankunftA
		IF v_result.abfahrt_uhrzeit < :NEW.abfahrt_uhrzeit  AND :NEW.ankunft_uhrzeit < v_result.ankunft_uhrzeit THEN
			RAISE TrainOnMultipleConnAtSameTime;
		END IF;
		--abfahrtA..abfahrtB..ankunftA..ankunftB
		IF v_result.abfahrt_uhrzeit < :NEW.abfahrt_uhrzeit AND v_result.ankunft_uhrzeit < :NEW.ankunft_uhrzeit THEN
			RAISE TrainOnMultipleConnAtSameTime;
		END IF;
		--abfahrtB..abfahrtA..ankunftB..ankunftA
		IF  :NEW.abfahrt_uhrzeit < v_result.abfahrt_uhrzeit AND :NEW.ankunft_uhrzeit < v_result.ankunft_uhrzeit THEN
			RAISE TrainOnMultipleConnAtSameTime;
		END IF;
		--abfahrtB..abfahrtA..ankunftA..ankunftB
		IF :NEW.abfahrt_uhrzeit < v_result.abfahrt_uhrzeit AND v_result.ankunft_uhrzeit < :NEW.ankunft_uhrzeit THEN
			RAISE TrainOnMultipleConnAtSameTime;
		END IF;
	END LOOP;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TRIGGER trigger_singleConAtTime';
END;
/
