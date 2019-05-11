--------------------------------------------------------
--  CREATE TRIGGER FOR INSTEAD OF UPDATE VIEW_PS_EMP 5. FELADAT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER TRIGGER_INSTEAD_OF_UPDATE_VIEW_TEAMLEADERS
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