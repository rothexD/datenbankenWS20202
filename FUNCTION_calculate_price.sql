--********************************************************************
--**
--** Function: f_calculate_price
--** In: i_bahnhofID_abfahrt and i_bahnhofID_ankunft
--** Returns: price for one route
--** Developer: Elisabeth Glatz
--** Description: calculates the the (linear) distance between two train stations and calculates the price for the calculated route
--*
--********************************************************************


CREATE OR REPLACE FUNCTION f_calculate_price(i_bahnhofID_abfahrt IN NUMBER, i_bahnhofID_ankunft IN NUMBER)
	RETURN NUMBER
IS

	n_bhf_abfahrt_long NUMBER;
	n_bhf_abfahrt_lat NUMBER;
	n_bhf_ankunft_long NUMBER;
	n_bhf_ankunft_lat NUMBER;
	
	n_dist_x NUMBER;
	n_dist_y NUMBER;
	n_dist_direct NUMBER;
	n_price NUMBER;
	
BEGIN
	
	SELECT latitude, longitude 
		INTO n_bhf_abfahrt_long, n_bhf_abfahrt_lat
	FROM bahnhof 
		WHERE bahnhofID = i_bahnhofID_abfahrt;
	
	dbms_output.put_line('Longitude Abfahrtsbahnhof:' || n_bhf_abfahrt_long);
	dbms_output.put_line('Latitude Abfahrtsbahnhof:' || n_bhf_abfahrt_lat);
	
	SELECT latitude, longitude 
		INTO n_bhf_ankunft_long, n_bhf_ankunft_lat 
	FROM bahnhof 
		WHERE bahnhofID = i_bahnhofID_ankunft;
	
	dbms_output.put_line('Longitude Ankunftsbahnhof:' || n_bhf_ankunft_long);
	dbms_output.put_line('Latitude Ankunftsbahnhof:' || n_bhf_ankunft_lat);
	
	n_dist_x := n_bhf_abfahrt_long - n_bhf_ankunft_long;
	n_dist_y := n_bhf_abfahrt_lat - n_bhf_ankunft_lat;
	n_dist_direct := sqrt(power(n_dist_x, 2) + power(n_dist_y, 2));

	dbms_output.put_line('Distanz:' || n_dist_direct);
	
	n_price := n_dist_direct * 20;
	
	IF n_dist_direct > 1.4 THEN 
		n_price := 24.3 * ln(8.64 * (n_dist_direct - 1.05)) - 3.6 * sqrt(2.5 * n_dist_direct);	
	END IF;

	RETURN n_price;
	
EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('Kein Bahnhof mit dieser ID gefunden.');
	RETURN -1;
	
	WHEN OTHERS THEN
  	dbms_output.put_line('Fehler aufgetreten.');
	RETURN -1;
	
END;
/



 
select f_calculate_price(4, 6) from dual; -- salzburg bis bregenz: 67,50€ (vergleichswert)
select f_calculate_price(2, 5) from dual; -- wien bis mistelbach: 12€
select f_calculate_price(2, 6) from dual; -- wien bis salzburg: 56,80€
select f_calculate_price(2, 4) from dual; -- bregenz bis wien: 80€
select f_calculate_price(1, 2) from dual; -- graz bis wien: 40€
select f_calculate_price(3, 2) from dual; -- linz bis wien: 38,50€
	
