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
	select count(*) into n_count from person where email = v_email and passwort = v_passwort;
	if n_count = 1 then
		return 1;
	end if;
	return 0;	
END;
/

begin
	execute immediate 'DROP FUNCTION f_try_login';
end;
/
