--------------------------------------------------------
--  DDL for Table PETROL_STATIONS
--------------------------------------------------------
--DROP TABLE "PETROL_STATIONS";
CREATE TABLE "PETROL_STATIONS"
(
	"PETROL_STATION_ID" NUMBER NOT NULL,
	"PS_NAME" VARCHAR2(100) NOT NULL,
	"PS_ADDRESS" VARCHAR2(100) NOT NULL,
	"PS_ISNONSTOP" NUMBER(1,0) NOT NULL
);

--------------------------------------------------------
--  ADD CONSTRAINT TO PETROL_STATIONS
--------------------------------------------------------
ALTER TABLE "PETROL_STATIONS" ADD CONSTRAINT "PETROL_STATION_ID_PK" PRIMARY KEY ("PETROL_STATION_ID");

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
--  POPULATE PETROL_STATIONS
--------------------------------------------------------
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('MOL', 'Budapest, Prielle Korn�lia u. 25, 1117', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Lukoil DESPAR', 'Budapest, Bart�k B�la �t 105, 1116', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('MOL', 'Budapest, Nagysz�l�s u. 47, 1113', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Shell', 'Budapest, T�t�nyi �t 2, 1115', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('OMV', 'Budapest, Budafoki �t 111-113, 1117', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Lukoil', 'Budapest, Hunyadi J�nos �t 18, 1117', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Auchan benzinkut', 'Kecskem�t, Dunaf�ldv�ri u 2, 6000', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('ENVI-METRO', 'Kecskem�t, Halasi �t 34, 6000', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Tiko Kft.', 'Kecskem�t, 236, �rr�t, 6000', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Mobil Petrol benzink�t', 'Kecskem�t, 6000', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('AS24', 'Kecskem�t, Canada Petrol, Fels?csal�nos tanya, 6000', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Petro-Canada', 'Kecskem�t, 6000', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Cng T�lt?�llom�s', 'Kecskem�t, Szegedi �t 88, 6000', '0');