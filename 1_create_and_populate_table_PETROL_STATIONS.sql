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
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('MOL', 'Budapest, Prielle Kornélia u. 25, 1117', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Lukoil DESPAR', 'Budapest, Bartók Béla út 105, 1116', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('MOL', 'Budapest, Nagyszõlõs u. 47, 1113', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Shell', 'Budapest, Tétényi út 2, 1115', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('OMV', 'Budapest, Budafoki út 111-113, 1117', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Lukoil', 'Budapest, Hunyadi János út 18, 1117', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Auchan benzinkut', 'Kecskemét, Dunaföldvári u 2, 6000', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('ENVI-METRO', 'Kecskemét, Halasi út 34, 6000', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Tiko Kft.', 'Kecskemét, 236, Úrrét, 6000', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Mobil Petrol benzinkút', 'Kecskemét, 6000', '0');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('AS24', 'Kecskemét, Canada Petrol, Fels?csalános tanya, 6000', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Petro-Canada', 'Kecskemét, 6000', '1');
INSERT INTO PETROL_STATIONS (PS_NAME, PS_ADDRESS, PS_ISNONSTOP) VALUES ('Cng Tölt?állomás', 'Kecskemét, Szegedi út 88, 6000', '0');