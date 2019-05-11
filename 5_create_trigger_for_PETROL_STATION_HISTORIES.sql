--------------------------------------------------------
--  CREATE TRIGGER FOR PETROL_STATION TABLE DML QUERIES 4. FELADAT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER TRIGGER_PETROL_STATION_HISTORIES
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

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';