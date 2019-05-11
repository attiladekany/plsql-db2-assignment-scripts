--------------------------------------------------------
--  CREATE TRIGGER FOR INSTEAD OF INSERT INTO VIEW_TEAMLEADERS 5. FELADAT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER TRIGGER_INSTEAD_OF_INSERT_VIEW_TEAMLEADERS
INSTEAD OF INSERT
    ON VIEW_TEAMLEADERS
DECLARE
    p_petrolStationName           VIEW_TEAMLEADERS.PS_NAME%TYPE    := :new.PS_NAME;    --PETROL_STATIONS
    p_fullName                    VIEW_TEAMLEADERS.FULLNAME%TYPE   := :new.FULLNAME;   --EMPLOYEES
    
    countPetrolStation            NUMBER := 0;
    countTeamLeaderWithSameName   NUMBER := 0;
    petrolStationId               PETROL_STATIONS.PETROL_STATION_ID%TYPE;
    
    Petrol_Station_Does_Not_Exist       EXCEPTION;
    Employee_With_Same_FullName_Exist   EXCEPTION;
BEGIN

    SELECT COUNT(*)
    INTO countPetrolStation
    FROM petrol_stations ps
    WHERE ps.ps_name = p_petrolStationName;
    
    IF (countPetrolStation = 0)
        THEN
            RAISE Petrol_Station_Does_Not_Exist;
    END IF;
    
    --GET PETROL STATION ID
    SELECT ps.petrol_station_id
    INTO petrolStationId
    FROM petrol_stations ps
    WHERE ps.ps_name = p_petrolStationName AND
    ROWNUM = 1;
    
    SELECT COUNT(*)
    INTO countTeamLeaderWithSameName
    FROM PETROL_STATIONS ps
    INNER JOIN EMPLOYEES EMP USING(PETROL_STATION_ID)
    WHERE ps.ps_name = p_petrolStationName AND emp.fullname = p_fullName AND emp.is_teamleader = 1;
    
    IF (countPetrolStation > 0 AND countTeamLeaderWithSameName > 0)
        THEN
            RAISE Employee_With_Same_FullName_Exist;
    END IF;
    
    IF (countPetrolStation > 0 AND countTeamLeaderWithSameName = 0)
        THEN
            -- EXECUTE INSERT
            INSERT INTO EMPLOYEES (PETROL_STATION_ID, FULLNAME, AGE, JOB_TITLE, IS_TEAMLEADER)
            VALUES (petrolStationId, p_fullName, NULL, NULL, 1);
    END IF;
    
    EXCEPTION
        WHEN Employee_With_Same_FullName_Exist
            THEN dbms_output.put_line('Ervenytelen adatok: ilyen nevu csoportvezeto mar letezik ehhez a toltoallomashoz.');
        
        WHEN Petrol_Station_Does_Not_Exist
            THEN dbms_output.put_line('Ervenytelen adatok: ilyen toltoallomas nem letezik.');
            
END TRIGGER_INSTEAD_OF_INSERT_VIEW_TEAMLEADERS;
/