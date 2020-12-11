--********************************************************************
--**
--** Function: f_average_ticket_price
--** In:
--** Returns: average price of a ticket last month
--** Developer: Jakob List
--** Description: calculates the average price of a ticket last month
--*
--********************************************************************

CREATE OR REPLACE FUNCTION f_average_ticket_price RETURN NUMBER IS 

	n_avg_preis NUMBER;
	
BEGIN
SELECT AVG(preis)
INTO n_avg_preis
FROM ticket t
  LEFT JOIN one_time_ticket ot ON t.ticketid = ot.fk_ticketid
  LEFT JOIN mehrfachticket mt ON t.ticketid = mt.fk_ticketid
WHERE kaufdatum >= CURRENT_TIMESTAMP+INTERVAL '-1' MONTH
AND   kaufdatum <= CURRENT_TIMESTAMP
ORDER BY t.ticketid ASC;

RETURN n_avg_preis;

EXCEPTION WHEN no_data_found THEN dbms_output.put_line ('Kein Ticket wurde verkauft.');
RETURN -1;

WHEN OTHERS THEN dbms_output.put_line ('Fehler aufgetreten.');
RETURN -1;

END;
/


BEGIN
  dbms_output.put_line(f_average_ticket_price);
END;
/