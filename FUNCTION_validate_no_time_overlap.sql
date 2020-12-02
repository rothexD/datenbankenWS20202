--********************************************************************
--*
--* Function: f_validate_no_time_overlap
--* Return: 0 for false, 1 for true
--* Parameter:
--* 	timeA1: Start of timespann 1
--* 	timeA2: END of timespann 1
--*		timeB1: Start of timespann 2
--*		timeB2: END of timespann 2
--* Developer: Lukas Schweinberger
--* Description: validate that 2 timespanns dont overlap.
--********************************************************************


CREATE OR REPLACE FUNCTION f_validate_no_time_overlap(timeA1 TIMESTAMP, timeA2 TIMESTAMP,timeB1 TIMESTAMP, timeB2 TIMESTAMP)
	RETURN NUMBER
IS
BEGIN
		--abfahrtA..abfahrtB..ankunftB..ankunftA
		IF timeA1 < timeB1  AND timeB2 < timeA2 THEN
			return 0;
		END IF;
		--abfahrtA..abfahrtB..ankunftA..ankunftB
		IF timeA1 < timeB1 AND timeA2 < timeB2 THEN
			return 0;
		END IF;
		--abfahrtB..abfahrtA..ankunftB..ankunftA
		IF  timeB1 < timeA1 AND timeB2 < timeA2 THEN
			return 0;
		END IF;
		--abfahrtB..abfahrtA..ankunftA..ankunftB
		IF timeB1 < timeA1 AND timeA2 < timeB2 THEN
			return 0;
		END IF;
		return 1;
END;
/

begin
	execute immediate 'DROP FUNCTION f_validate_no_time_overlap';
end;
/
