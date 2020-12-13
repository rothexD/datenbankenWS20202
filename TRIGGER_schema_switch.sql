--********************************************************************
--*
--* Trigger: Schema_Switch
--* Type: After Logon on Database
--* Developer: Nicolas Klement
--* Description: Automatically switch schema to SYSTEM after logon
--*
--********************************************************************

CREATE OR REPLACE TRIGGER tr_al_d_schema_switch
AFTER LOGON ON DATABASE
BEGIN
    IF user = 'DATENBANKPROJEKT' THEN
        EXECUTE IMMEDIATE 'ALTER SESSION SET CURRENT_SCHEMA=SYSTEM';
    END IF;
END;
/

--drop trigger tr_al_d_schema_switch;
