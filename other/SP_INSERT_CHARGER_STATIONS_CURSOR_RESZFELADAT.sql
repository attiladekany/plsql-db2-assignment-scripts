DECLARE
    CURSOR EMPLOYEE_CURSOR IS
        SELECT e.employee_id,
               e.petrol_station_id,
               e.fullname,
               e.is_teamleader,
               e.age,
               e.job_title
        FROM EMPLOYEES E
        WHERE E.PETROL_STATION_ID = 5;
    employeeStruct EMPLOYEE_CURSOR%ROWTYPE;

        
BEGIN
    OPEN EMPLOYEE_CURSOR;
    FETCH EMPLOYEE_CURSOR INTO employeeStruct;
    WHILE EMPLOYEE_CURSOR%FOUND LOOP
        dbms_output.put_line('petrol_station_id: ' || RPAD(employeeStruct.employee_id, 10) ||
                             'fullname: ' || RPAD(employeestruct.fullname || ';', 20) ||
                             'is_teamleader: ' || RPAD(employeestruct.is_teamleader, 10) ||
                             'age: ' || RPAD(employeestruct.age, 10) ||
                             'job_title: ' || employeestruct.job_title);
    
    FETCH EMPLOYEE_CURSOR INTO employeeStruct;
    END LOOP;
    CLOSE EMPLOYEE_CURSOR;
END;
/