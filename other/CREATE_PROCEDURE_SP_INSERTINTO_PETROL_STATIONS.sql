--------------------------------------------------------
--  CREATE SEQUENCE FOR AUTO INCREMENT
--------------------------------------------------------

CREATE SEQUENCE PETROL_STATIONS_SEQUENCE
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
--------------------------------------------------------
--  CREATE TRIGGER FOR PETROL_STATIONS
--------------------------------------------------------
CREATE TRIGGER PETROL_STATIONS_BI
BEFORE INSERT ON PETROL_STATIONS
FOR EACH ROW
BEGIN
    SELECT PETROL_STATIONS_SEQUENCE.nextval INTO :new.PETROL_STATION_ID FROM dual;
END;
/

--------------------------------------------------------
--  CREATE STORED PROCEDURE FOR INSERT NEW PETROL STATON
--------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_INSERTINTO_PETROL_STATIONS(
	p_PS_NAME VARCHAR2,
	p_PS_ADDRESS VARCHAR2,
	p_PS_ISNONSTOP NUMBER
) AS

BEGIN
    INSERT INTO PETROL_STATIONS (
        PS_NAME,
        PS_ADDRESS,
        PS_ISNONSTOP) 
    VALUES (
        --'1',
        p_PS_NAME,
        p_PS_ADDRESS,
        p_PS_ISNONSTOP
        );

END SP_INSERTINTO_PETROL_STATIONS;
/