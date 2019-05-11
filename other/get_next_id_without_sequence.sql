DECLARE
id NUMBER;
BEGIN
    select count(*)
    INTO id
    from charger_stations;
    
    id := id + 1;
    
    dbms_output.put_line(id);

END;
/
