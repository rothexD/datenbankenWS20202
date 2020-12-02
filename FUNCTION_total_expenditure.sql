/**********************************************************************/
/**
/** Function: f_total_expenditure
/** In: n_personID - id of the person
/** Returns: total the person has spent on webshop and tickets
/** Developer: Samuel Fiedorowicz
/** Description: Calculates total expenditure on webshop and
/**              tickets for a given person-ID
/**
/**********************************************************************/

CREATE OR REPLACE
FUNCTION f_total_expenditure(n_personID IN person.personID%TYPE)
RETURN NUMBER

AS
  n_ticket_total NUMBER DEFAULT 0;
  n_webshop_total NUMBER DEFAULT 0;
  
BEGIN
  -- calculate expenditure on tickets
  SELECT SUM(preis) INTO n_ticket_total
  FROM ticket
  WHERE fk_personID = n_personID;
  
  -- calculate expenditure webshop
  SELECT SUM(zusaetzliche_kosten) INTO n_webshop_total
  FROM person_hat_online_artikel p
    JOIN online_artikel
      ON fk_artikelID = artikelID
  WHERE fk_personID = n_personID;

  -- return sum
  RETURN COALESCE(n_ticket_total + n_webshop_total, 0);
  
END;
/
