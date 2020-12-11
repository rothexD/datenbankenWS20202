CREATE USER datenbankprojekt IDENTIFIED BY password;
GRANT CONNECT TO datenbankprojekt;

----- now grant execute on all stored procedures here in form of  "GRANT EXECUTE ON b.procedure_name TO a"  while b is the user that has the procedure stored.
 