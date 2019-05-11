1. task - SP
	- SP_INSERT_CHARGER_STATIONS
	- check / exception handling
		- data exist with same values
		- invalid foreign key (not exist)
	return: number of row with the same foreign key
	
=========================================================

2. task - SP
	-sp: SP_GET_EMPLOYEES_BY_PETROL_STATION_NAME
		- input: ps_name (petrol_station table)
	- check / exception handling
		- if exist any row with the given parameter value ->> if not: custom em, then break
		- 1: get pk of this record where ps_name is equal with the parameter
			2: check if exists any row with this foreign key in the connected table ->> if not: c. em. then break
	return: all employee with this foreign key, formatted display , + one aggregated column | (count emp)

=========================================================

3. task - STORED FUNCTION
	- return with numbers if specified condition met
=========================================================

4. task - TRIGGER
	- test petrol_station_histories
	- add trigger to petrol_stations --> insert record if any crud action is executed
	
=========================================================
5. task - VIEW + 2 TRIGGER
=========================================================

		alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
