--*********************************************************************
--**
--** View: ServiceDesk_Info
--** Developer: Nicolas Klement
--** Description: Zeigt alle Informationen zu Servicedesks an,
--**              also ID, TelNr und BahnhofID.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW servicedesk_info AS
    SELECT servicedeskid, rufnummer, fk_bahnhofid AS bahnhofid
    FROM servicedesk;
