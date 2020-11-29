--*********************************************************************
--**
--** Table: vor_24h_gekauft
--** Developer: Jakob List
--** Description: View that shows every ticket that has been bought in the last 24 hours.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW vor_24h_gekauft AS

SELECT kaufdatum, ticketID FROM ticket WHERE kaufdatum >= CURRENT_TIMESTAMP - NUMTODSINTERVAL(24, 'HOUR');
