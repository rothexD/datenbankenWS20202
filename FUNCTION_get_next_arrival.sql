--********************************************************************
--**
--** Function: f_get_next_arrival
--** In: n_bahnhofID - ID from train station that
--** Returns: verbindungsID (ID of next arrival)
--** Developer: Elisabeth Glatz
--** Description: selects next arrival from the given train station and returns ID of connection
--**
--********************************************************************

CREATE OR REPLACE FUNCTION f_get_next_arrival(n_bahnhofID IN NUMBER)
	RETURN NUMBER
IS
	n_next_ID NUMBER;
BEGIN
	SELECT verbindungID INTO n_next_ID FROM (
		SELECT * FROM bahnhof 
					JOIN bahnsteig ON bahnhof.bahnhofID = bahnsteig.fk_bahnhofID
					JOIN verbindung ON bahnsteig.bahnsteigID = verbindung.fk_ankunft_bahnsteig
					WHERE bahnhofID = n_bahnhofID
						AND ankunft_uhrzeit >= CURRENT_TIMESTAMP
					ORDER BY ankunft_uhrzeit ASC
	) WHERE ROWNUM = 1;
	
	RETURN n_next_ID;
	
EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('Keine Verbindung mit dieser BahnhofID gefunden.');
	RETURN -1;
	
	WHEN OTHERS THEN
  	dbms_output.put_line('Fehler aufgetreten.');
	RETURN -1;
	
END;
/



SELECT f_get_next_arrival (2) FROM dual;