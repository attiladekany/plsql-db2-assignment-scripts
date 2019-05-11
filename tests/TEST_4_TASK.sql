DECLARE RESULT NUMBER;
BEGIN
    UPDATE petrol_stations ps
    SET ps.ps_name = 'AS24 NONSTOP'
    WHERE ps.petrol_station_id = '11';
END;
/

