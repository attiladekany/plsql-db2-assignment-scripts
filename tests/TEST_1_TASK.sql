
DECLARE NUMBER_OF_CHARGERS number;
BEGIN

    SP_INSERT_CHARGER_STATION( 2,4,1,NUMBER_OF_CHARGERS);
    
    dbms_output.put_line('NUMBER_OF_CHARGERS:' || NUMBER_OF_CHARGERS);
END;
/

