--*********************************************************************
--**
--** Table: Verpflegung
--** Developer: Samuel Fiedorowicz
--** Description: View that allows to list every product that the train has.
--**
--*********************************************************************

CREATE OR REPLACE
VIEW Verpflegung AS
SELECT z.*, p.name AS produkt
  FROM zug z
  JOIN zug_hat_wagons zw
    ON zw.fk_zugID = z.zugID
  JOIN wagon w
    ON zw.fk_wagonID = w.wagonID
  JOIN wagon_hat_produkt wv
    ON wv.fk_wagonID = w.wagonID
  JOIN produkt p
    ON wv.fk_produktID = p.produktID;
