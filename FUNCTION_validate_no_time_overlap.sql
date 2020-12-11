--********************************************************************
--*
--* Function: f_validate_no_time_overlap
--* Return: 0 for false, 1 for true
--* Parameter:
--* 	t_timeA1: Start of timespan 1
--* 	t_timeA2: END of timespan 1
--*		t_timeB1: Start of timespan 2
--*		t_timeB2: END of timespan 2
--* Developer: Lukas Schweinberger
--* Description: validate that 2 timespanns dont overlap.
--********************************************************************


CREATE OR REPLACE FUNCTION f_validate_no_time_overlap(t_timeA1 TIMESTAMP, t_timeA2 TIMESTAMP,t_timeB1 TIMESTAMP, t_timeB2 TIMESTAMP)
	RETURN NUMBER
IS
BEGIN
		--abfahrtA..abfahrtB..ankunftB..ankunftA
		IF t_timeA1 < t_timeB1  AND t_timeB2 < t_timeA2 THEN
			RETURN 0;
		END IF;
		--abfahrtA..abfahrtB..ankunftA..ankunftB
		IF t_timeA1 < t_timeB1 AND t_timeA2 < t_timeB2 THEN
			RETURN 0;
		END IF;
		--abfahrtB..abfahrtA..ankunftB..ankunftA
		IF  t_timeB1 < t_timeA1 AND t_timeB2 < t_timeA2 THEN
			RETURN 0;
		END IF;
		--abfahrtB..abfahrtA..ankunftA..ankunftB
		IF t_timeB1 < t_timeA1 AND t_timeA2 < t_timeB2 THEN
			RETURN 0;
		END IF;
		RETURN 1;
END;
/

BEGIN
	EXECUTE IMMEDIATE 'DROP FUNCTION f_validate_no_time_overlap';
END;
/
