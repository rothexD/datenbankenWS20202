CREATE OR REPLACE FUNCTION validate_no_time_overlap(timeA1 timestamp, timeA2 timestamp,timeB1 timestamp, timeB2 timestamp)
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
	execute immediate 'DROP FUNCTION validate_no_time_overlap';
end;
/
