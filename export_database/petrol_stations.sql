--------------------------------------------------------
--  File created - Monday-April-22-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table PETROL_STATIONS
--------------------------------------------------------

  CREATE TABLE "DEKANY"."PETROL_STATIONS" 
   (	"PETROL_STATION_ID" NUMBER, 
	"PS_NAME" VARCHAR2(100 BYTE), 
	"PS_ADDRESS" VARCHAR2(100 BYTE), 
	"PS_ISNONSTOP" NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into DEKANY.PETROL_STATIONS
SET DEFINE OFF;
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (1,'MOL','Budapest, Prielle Kornélia u. 25, 1117',1);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (2,'Lukoil DESPAR','Budapest, Bartók Béla út 105, 1116',0);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (3,'MOL','Budapest, Nagyszõlõs u. 47, 1113',1);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (4,'Shell','Budapest, Tétényi út 2, 1115',1);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (5,'OMV','Budapest, Budafoki út 111-113, 1117',0);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (6,'Lukoil','Budapest, Hunyadi János út 18, 1117',1);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (7,'Auchan benzinkut','Kecskemét, Dunaföldvári u 2, 6000',0);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (8,'ENVI-METRO','Kecskemét, Halasi út 34, 6000',0);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (9,'Tiko Kft.','Kecskemét, 236, Úrrét, 6000',0);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (10,'Mobil Petrol benzinkút','Kecskemét, 6000',0);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (11,'AS24','Kecskemét, Canada Petrol, Fels?csalános tanya, 6000',1);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (12,'Petro-Canada','Kecskemét, 6000',1);
Insert into DEKANY.PETROL_STATIONS (PETROL_STATION_ID,PS_NAME,PS_ADDRESS,PS_ISNONSTOP) values (13,'Cng Tölt?állomás','Kecskemét, Szegedi út 88, 6000',0);
--------------------------------------------------------
--  DDL for Index PETROL_STATION_ID_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEKANY"."PETROL_STATION_ID_PK" ON "DEKANY"."PETROL_STATIONS" ("PETROL_STATION_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Trigger PETROL_STATIONS_BI
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DEKANY"."PETROL_STATIONS_BI" 
BEFORE INSERT ON PETROL_STATIONS
FOR EACH ROW
BEGIN
    SELECT PETROL_STATIONS_SEQUENCE.nextval INTO :new.PETROL_STATION_ID FROM dual;
END;

/
ALTER TRIGGER "DEKANY"."PETROL_STATIONS_BI" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRIGGER_PETROL_STATION_HISTORIES
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DEKANY"."TRIGGER_PETROL_STATION_HISTORIES" 
BEFORE INSERT OR DELETE OR UPDATE
    ON PETROL_STATIONS
FOR EACH ROW
DECLARE 
    PRAGMA AUTONOMOUS_TRANSACTION;
    userId          petrol_station_histories.active_user_id%TYPE;
    info            petrol_station_histories.information%TYPE;
    dmlType         VARCHAR2(10) := '';

    newPSName       petrol_stations.ps_name%TYPE        := :new.ps_name;
    newPSAddress    petrol_stations.ps_address%TYPE     := :new.ps_address;
    newPSIsNonStop  petrol_stations.ps_isnonstop%TYPE   := :new.ps_isnonstop;

    oldPSName       petrol_stations.ps_name%TYPE        := :new.ps_name;
    oldPSAddress    petrol_stations.ps_address%TYPE     := :new.ps_address;
    oldPSIsNonStop  petrol_stations.ps_isnonstop%TYPE   := :new.ps_isnonstop;
BEGIN

SELECT user INTO userId FROM dual;

info :=     'ACTIVE_USER: '         || userid || '|' ||
            'PETROL_STATION_ID: '   || :new.PETROL_STATION_ID || '|' ||
            'SYSTEM_DATE: '         || sysdate || '|';

    CASE
        WHEN INSERTING
            THEN dmlType := 'INSERT';
                    info := info || 'PS_NAME: '     || newPSName || '|' ||
                                    'PS_ADDRESS: '  || newPSAddress || '|' ||
                                    'PS_ISNONSTOP: '|| newPSIsNonStop;
        WHEN UPDATING
            THEN dmlType := 'UPDATE';
                    info := info || 'NEW PS_NAME: '     || newPSName || '|' ||
                                    'NEW PS_ADDRESS: '  || newPSAddress || '|' ||
                                    'NEW PS_ISNONSTOP: '|| newPSIsNonStop || '|';

                    info := info || 'OLD PS_NAME: '     || oldPSName || '|' ||
                                    'OLD PS_ADDRESS: '  || oldPSAddress || '|' ||
                                    'OLD PS_ISNONSTOP: '|| oldPSIsNonStop;

        ELSE --DELETING
                 dmlType := 'DELETE';
                    info := info || 'OLD PS_NAME: '     || oldPSName || '|' ||
                                    'OLD PS_ADDRESS: '  || oldPSAddress || '|' ||
                                    'OLD PS_ISNONSTOP: '|| oldPSIsNonStop;
    END CASE;

    info := info || '|' || 'DML_TYPE: ' || dmltype;

    INSERT INTO PETROL_STATION_HISTORIES 
        ("DML_TYPE",
        "ACTIVE_USER_ID",
        "PETROL_STATION_ID",
        "SYSTEM_DATE",
        "INFORMATION")
    VALUES (
        dmlType,
        userId,
        :new.PETROL_STATION_ID,
        sysdate,
        info);
    COMMIT;

END TRIGGER_PETROL_STATION_HISTORIES;

/
ALTER TRIGGER "DEKANY"."TRIGGER_PETROL_STATION_HISTORIES" ENABLE;
--------------------------------------------------------
--  Constraints for Table PETROL_STATIONS
--------------------------------------------------------

  ALTER TABLE "DEKANY"."PETROL_STATIONS" MODIFY ("PETROL_STATION_ID" NOT NULL ENABLE);
  ALTER TABLE "DEKANY"."PETROL_STATIONS" MODIFY ("PS_NAME" NOT NULL ENABLE);
  ALTER TABLE "DEKANY"."PETROL_STATIONS" MODIFY ("PS_ADDRESS" NOT NULL ENABLE);
  ALTER TABLE "DEKANY"."PETROL_STATIONS" MODIFY ("PS_ISNONSTOP" NOT NULL ENABLE);
  ALTER TABLE "DEKANY"."PETROL_STATIONS" ADD CONSTRAINT "PETROL_STATION_ID_PK" PRIMARY KEY ("PETROL_STATION_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
