--------------------------------------------------------
--  CREATE PROCEDURE FOR GET_EMPLOYEES BY PETROL_STATION NAME (2. FELADAT)
--------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_GET_EMPLOYEES_BY_PS_NAME(
    P_PS_NAME petrol_stations.ps_name%TYPE
) AS
    
    numberOfConnectedEmployee       NUMBER := 0;
    petolStationId                  NUMBER := 0;
    countPetrolstationWithGivenName NUMBER := 0;

    Invalid_Petrol_Station_Name     EXCEPTION;    
    No_Connected_Employee_To_This_Petrol_Station EXCEPTION;

BEGIN

--============================== start validations ===========================

    SELECT COUNT(*)
    INTO countPetrolstationWithGivenName
    FROM PETROL_STATIONS PS
    WHERE PS.PS_NAME = P_PS_NAME;

    IF(countPetrolstationWithGivenName = 0)
    THEN
        RAISE Invalid_Petrol_Station_Name;
    END IF;

    SELECT PS.PETROL_STATION_ID
    INTO petolStationId
    FROM PETROL_STATIONS PS
    WHERE PS.PS_NAME = P_PS_NAME and
    rownum = 1; --if there are multiple result then get the first

    SELECT COUNT(*)
    INTO numberOfConnectedEmployee
    FROM EMPLOYEES E
    WHERE E.PETROL_STATION_ID = petolStationId;
    
    IF (numberOfConnectedEmployee = 0)
    THEN
        RAISE No_Connected_Employee_To_This_Petrol_Station;
    END IF;
    --============================== end validations =============================
    
    --============================== DECLARE CURSOR ==============================
DECLARE
    CURSOR EMPLOYEE_CURSOR IS
        SELECT e.employee_id,
               e.petrol_station_id,
               e.fullname,
               e.is_teamleader,
               e.age,
               e.job_title
        FROM EMPLOYEES E
        WHERE E.PETROL_STATION_ID = petolStationId;
        employeeStruct EMPLOYEE_CURSOR%ROWTYPE;
   
BEGIN
    OPEN EMPLOYEE_CURSOR;
    FETCH EMPLOYEE_CURSOR INTO employeeStruct;
    WHILE EMPLOYEE_CURSOR%FOUND
        LOOP
            dbms_output.put_line('petrol_station_id: ' || RPAD(employeeStruct.employee_id, 5) ||
                                'fullname: ' || RPAD(employeestruct.fullname, 20) ||
                                'is_teamleader: ' || RPAD(employeestruct.is_teamleader, 5) ||
                                'age: ' || RPAD(employeestruct.age, 5) ||
                                'job_title: ' || RPAD(employeestruct.job_title, 30) ||
                                'number_of_employees: ' || numberOfConnectedEmployee);
        
            FETCH EMPLOYEE_CURSOR INTO employeeStruct;
        END LOOP;
    CLOSE EMPLOYEE_CURSOR;
END;
--============================== END CURSOR ==================================

EXCEPTION
WHEN Invalid_Petrol_Station_Name
    THEN dbms_output.put_line('�rv�nytelen param�ter: ezzel a petrol station name-el nem l�tezik t�lt?�llom�s.');
WHEN No_Connected_Employee_To_This_Petrol_Station
    THEN dbms_output.put_line('�rvenytelen kulcs: ehhez a t�lt?�llom�shoz nincsenek dolgoz�k rendelve.!');
WHEN NO_DATA_FOUND
    THEN RAISE Invalid_Petrol_Station_Name;
END SP_GET_EMPLOYEES_BY_PS_NAME;
/
