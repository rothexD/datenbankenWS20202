--*********************************************************************
--**
--** Table: verfuegbare_artikel
--** Developer: Jakob List
--** Description: View that shows the currently available items that can be purchased in the webshop.
--**
--*********************************************************************

CREATE OR REPLACE 
VIEW verfuegbare_artikel AS
SELECT * FROM online_artikel
WHERE verfuegbar_von < CURRENT_TIMESTAMP AND verfuegbar_bis > CURRENT_TIMESTAMP;
