--********************************************************************
--*
--* Function: f_try_login
--* Return: 0 for false, 1 for true
--* Parameter:
--* 	v_email: Start of timespann 1
--* 	v_passwort: END of timespann 1
--* Developer: Lukas Schweinberger
--* Description: tries to login by email and passwort, only returns 1 if unique
--********************************************************************


CREATE OR REPLACE FUNCTION f_try_login(v_email VARCHAR2,v_passwort VARCHAR2)
	RETURN NUMBER
IS
	n_count NUMBER;
BEGIN
	SELECT COUNT(*) INTO n_count FROM person WHERE email = v_email AND passwort = v_passwort;
	IF n_count = 1 THEN
		RETURN 1;
	END IF;
	RETURN 0;	
END;
/

begin
	execute immediate 'DROP FUNCTION f_try_login';
end;
/
