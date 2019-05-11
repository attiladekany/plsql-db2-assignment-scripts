--------------------------------------------------------
--  CREATE FUNCTION FOR GET_EMPLOYEES STATUS BY PETROL_STATION NAME (3. FELADAT)
--------------------------------------------------------
CREATE OR REPLACE FUNCTION FN_GET_EMPLOYEES_STATUS_BY_PS_NAME(
    P_PS_NAME petrol_stations.ps_name%TYPE
)   RETURN NUMBER
AS
    petrolStationCount  NUMBER := 0;
    employeesCount      NUMBER := 0;
BEGIN
    SELECT COUNT (*)
    INTO petrolStationCount
    FROM PETROL_STATIONS PS
    WHERE PS.PS_NAME = P_PS_NAME;
    
    IF(petrolStationCount > 0) THEN
        SELECT COUNT(*)
        INTO employeesCount
        FROM EMPLOYEES E
        WHERE e.petrol_station_id = 
            (SELECT ps.petrol_station_id
            FROM PETROL_STATIONS PS
            WHERE PS.PS_NAME = P_PS_NAME);
    END IF;
    
    --dbms_output.put_line('petrolStationCount: ' || petrolStationCount);
    --dbms_output.put_line('employeesCount: ' || employeesCount);

  CASE
    WHEN petrolStationCount > 0 AND employeesCount > 0
        THEN RETURN -4;
        
    WHEN petrolStationCount > 0 AND employeesCount = 0
        THEN RETURN -3;
        
    WHEN petrolStationCount = 0 AND employeesCount = 0
        THEN RETURN -1;
        
    WHEN petrolStationCount > 1 
        THEN RETURN -2;
        
    ELSE
        RETURN employeesCount;
  END CASE;

END FN_GET_EMPLOYEES_STATUS_BY_PS_NAME;
/
