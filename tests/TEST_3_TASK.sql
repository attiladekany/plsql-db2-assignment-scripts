DECLARE RESULT NUMBER;
BEGIN
    RESULT := FN_GET_EMPLOYEES_STATUS_BY_PS_NAME('Shell');
    dbms_output.put_line('RESULT: ' || RESULT);
END;
/

