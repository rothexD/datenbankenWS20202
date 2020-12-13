/**********************************************************************/
/**
/** Procedure: sp_book_alternative_train
/** In: n_ticketID - id of the tick to rebook
/** Developer: Samuel Fiedorowicz
/** Description: Rebook the ticket to the next connection with the same
/**              origin and destination.
/**
/**********************************************************************/

CREATE OR REPLACE
PROCEDURE sp_book_alternative_train(n_ticketID IN NUMBER)
AS
    n_bahnhof_abfahrt NUMBER;
    n_bahnhof_ankunft NUMBER;
    d_abfahrt_uhrzeit DATE;
    verbindung_rec verbindung%ROWTYPE;

BEGIN
    SELECT v.abfahrt_uhrzeit, bh_abfahrt.bahnhofID, bh_ankunft.bahnhofID
    INTO d_abfahrt_uhrzeit, n_bahnhof_abfahrt, n_bahnhof_ankunft
    FROM One_Time_Ticket
        JOIN verbindung v
          ON v.verbindungID = fk_verbindungID
        JOIN bahnsteig bs_Ankunft
          ON bs_ankunft.bahnsteigID = v.fk_ankunft_bahnsteig
        JOIN bahnsteig bs_abfahrt
          ON bs_abfahrt.bahnsteigID = v.fk_abfahrt_bahnsteig
        JOIN bahnhof bh_ankunft
          ON bh_ankunft.bahnhofID = bs_ankunft.fk_bahnhofID
        JOIN bahnhof bh_abfahrt
          ON bh_abfahrt.bahnhofID = bs_abfahrt.fk_bahnhofID
    WHERE fk_ticketID = n_ticketID;

    SELECT v.* INTO verbindung_rec
    FROM verbindung v
        JOIN bahnsteig bs_ankunft 
          ON bs_ankunft.bahnsteigID = v.fk_ankunft_bahnsteig
        JOIN bahnsteig bs_abfahrt 
          ON bs_abfahrt.bahnsteigID = v.fk_abfahrt_bahnsteig
        JOIN bahnhof bh_ankunft 
          ON bs_ankunft.fk_bahnhofID = bh_ankunft.bahnhofID
        JOIN bahnhof bh_abfahrt 
          ON bs_abfahrt.fk_bahnhofID = bh_abfahrt.bahnhofID
    WHERE bh_abfahrt.bahnhofID = n_bahnhof_abfahrt
      AND bh_ankunft.bahnhofID = n_bahnhof_ankunft
      AND abfahrt_uhrzeit > d_abfahrt_uhrzeit
      AND ROWNUM = 1
    ORDER BY abfahrt_uhrzeit DESC;
    
    UPDATE One_Time_Ticket
    SET fk_verbindungID = verbindung_rec.verbindungID
    WHERE fk_ticketID = n_ticketID;
    
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20007, 'Es gibt keine neue Verbindung.');
    
END;
/
