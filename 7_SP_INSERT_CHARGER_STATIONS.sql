--------------------------------------------------------
--  CREATE PROCEDURE FOR INSERT CHARGER_STATION (1. FELADAT)
--------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_INSERT_CHARGER_STATION(
    P_PETROL_STATION_ID petrol_stations.petrol_station_id%TYPE,
    P_CS_NUMBER charger_stations.cs_number%TYPE,
    P_CS_IS_USABLE charger_stations.cs_is_usable%TYPE,
    NUMBER_OF_CHARGERS out number
) AS

rowCountWithSameData    NUMBER;
nOfPetrolStation        NUMBER;

Invalid_Data            EXCEPTION;
Invalid_Foreign_Key     EXCEPTION;

BEGIN
    SELECT COUNT(*)
    INTO rowCountWithSameData
    FROM CHARGER_STATIONS CS
    WHERE CS.PETROL_STATION_ID = P_PETROL_STATION_ID AND CS.CS_NUMBER = P_CS_NUMBER;
    
    IF (rowCountWithSameData > 0)
    THEN
        RAISE Invalid_Data;
    END IF;
    -------------------------------------------------------
    SELECT COUNT(*)
    INTO nOfPetrolStation
    FROM petrol_stations PS
    WHERE ps.petrol_station_id = P_PETROL_STATION_ID;
    
    IF (nOfPetrolStation = 0)
    THEN
        RAISE Invalid_Foreign_Key;
    END IF;
    
    --VALID DATA EXEC INSERT INTO
    INSERT INTO CHARGER_STATIONS (PETROL_STATION_ID, CS_NUMBER, CS_IS_USABLE) 
    VALUES (P_PETROL_STATION_ID, P_CS_NUMBER, P_CS_IS_USABLE);
    COMMIT;

    SELECT COUNT(*) INTO NUMBER_OF_CHARGERS
    FROM charger_stations CS
    WHERE cs.petrol_station_id = p_petrol_station_id;
 
EXCEPTION
WHEN Invalid_Data
    THEN dbms_output.put_line('�rv�nytelen adatok: ilyen rekord m�r l�tezik.');
WHEN Invalid_Foreign_Key
    THEN dbms_output.put_line('�rvenytelen idegen kulcs!');
END SP_INSERT_CHARGER_STATION;
/
