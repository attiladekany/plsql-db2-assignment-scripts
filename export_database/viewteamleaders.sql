--------------------------------------------------------
--  File created - Monday-April-22-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View VIEW_TEAMLEADERS
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "DEKANY"."VIEW_TEAMLEADERS" ("PS_NAME", "FULLNAME") AS 
  SELECT PS.PS_NAME, EMP.FULLNAME
        FROM PETROL_STATIONS PS
        INNER JOIN EMPLOYEES EMP ON PS.PETROL_STATION_ID = EMP.PETROL_STATION_ID
        WHERE IS_TEAMLEADER = 1
;
REM INSERTING into DEKANY.VIEW_TEAMLEADERS
SET DEFINE OFF;
Insert into DEKANY.VIEW_TEAMLEADERS (PS_NAME,FULLNAME) values ('MOL','Gulyás János');
Insert into DEKANY.VIEW_TEAMLEADERS (PS_NAME,FULLNAME) values ('Lukoil DESPAR','Jakab Gábor');
Insert into DEKANY.VIEW_TEAMLEADERS (PS_NAME,FULLNAME) values ('MOL','Boros Péter');
Insert into DEKANY.VIEW_TEAMLEADERS (PS_NAME,FULLNAME) values ('Shell','Váradi Tibor');
Insert into DEKANY.VIEW_TEAMLEADERS (PS_NAME,FULLNAME) values ('OMV','Orosz Imre');
Insert into DEKANY.VIEW_TEAMLEADERS (PS_NAME,FULLNAME) values ('Lukoil','Vincze Balázs');
--------------------------------------------------------
--  DDL for Trigger TRIGGER_INSTEAD_OF_INSERT_VIEW_TEAMLEADERS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DEKANY"."TRIGGER_INSTEAD_OF_INSERT_VIEW_TEAMLEADERS" 
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
ALTER TRIGGER "DEKANY"."TRIGGER_INSTEAD_OF_INSERT_VIEW_TEAMLEADERS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRIGGER_INSTEAD_OF_UPDATE_VIEW_TEAMLEADERS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DEKANY"."TRIGGER_INSTEAD_OF_UPDATE_VIEW_TEAMLEADERS" 
INSTEAD OF UPDATE
    ON VIEW_TEAMLEADERS
DECLARE
    p_petrolStationName           VIEW_TEAMLEADERS.PS_NAME%TYPE    := :new.PS_NAME;
    p_fullName                    VIEW_TEAMLEADERS.FULLNAME%TYPE   := :new.FULLNAME;

    oldPetrolStationName          VIEW_TEAMLEADERS.PS_NAME%TYPE    := :old.PS_NAME;
    oldFullName                   VIEW_TEAMLEADERS.FULLNAME%TYPE   := :old.FULLNAME;

    employeeId                    EMPLOYEES.EMPLOYEE_ID%TYPE;

    countUpdateIsPossible         NUMBER := 0;
    Update_Is_Impossible          EXCEPTION;

BEGIN
    SELECT COUNT(*)
    INTO countUpdateIsPossible
    FROM VIEW_TEAMLEADERS t
    WHERE t.PS_NAME = p_petrolStationName AND t.FULLNAME = p_fullName
    AND ROWNUM = 1;

    IF(countUpdateIsPossible > 0)
        THEN
            RAISE Update_Is_Impossible;
    END IF;

    SELECT emp.employee_id
    INTO employeeId
    FROM petrol_stations ps
    INNER JOIN employees emp ON ps.petrol_station_id = emp.petrol_station_id
    WHERE emp.is_teamleader = 1 AND 
          emp.fullname = oldfullname AND 
          ps.ps_name = oldpetrolstationname AND
          ROWNUM = 1;

    IF(oldFullName <> p_fullName)
        THEN
            UPDATE EMPLOYEES emp
              SET emp.FULLNAME = p_fullName
              WHERE emp.EMPLOYEE_ID = employeeId;
    END IF;

EXCEPTION
    WHEN Update_Is_Impossible
        THEN dbms_output.put_line('Ervenytelen adatok: ilyen adatokkal mar letezik teamleader.');

END TRIGGER_INSTEAD_OF_UPDATE_VIEW_TEAMLEADERS;

/
ALTER TRIGGER "DEKANY"."TRIGGER_INSTEAD_OF_UPDATE_VIEW_TEAMLEADERS" ENABLE;
