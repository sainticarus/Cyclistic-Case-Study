/* 
Append/union the 3 monthly bike trip data tables into one table
for biketrips from Jan 1, 2026 to March 31, 2026. 
*/
Create Table trip_data.Q1_trips AS
   SELECT *
   FROM(
  SELECT * FROM `project-b498b95d-28d9-4cd7-978.trip_data.0126_data` 
  UNION ALL
  SELECT * FROM`project-b498b95d-28d9-4cd7-978.trip_data.0226_data` 
  UNION ALL
  SELECT * FROM `project-b498b95d-28d9-4cd7-978.trip_data.0326_data` 
   );


SELECT *
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`;
    
/* NOTES:
Above 'SELECT *' query returned originally 656,274 rows, and is now 656134. Further, without additional consultation from the client, I have concluded to remove data point from 12/31 for continuity of the new fiscal year. I performed pre-cleaning in Sheets so that I can manipulate the data easier here.

The sum of the 3 table rows are the same, and we know the table was created correctly.
3 separate tables to equal the appended table with  UNION ALL.
A UNION ALL keeps all the rows from the multiple tables specified in the UNION ALL OR appends them.
However, a UNION will remove all rows that have duplicate values in one of the table's you are unioning.

-Analyze left to right for cleaning-

#1.ride_id:
- check length combinations for ride_id  
- and all values are unique as ride_id is a primary key
*/

SELECT LENGTH(ride_id), count(*)
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`
GROUP BY LENGTH(ride_id);

SELECT COUNT (DISTINCT ride_id)
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`;

/* NOTES:
All ride_id strings are 16 characters long and they are all distinct. 
No cleaning neccesary on this column.
*/

--#2. check the allowable rideable_types

SELECT DISTINCT rideable_type
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`;

/* NOTES: 
As seen above, there are 2 types of 'rideable_type': 
electric_bike, classic_bike.
But in previous renditions of the data, docked_bike is a naming error, and should be changed to classic_bike,
*/

/* 
#3. Check started_at and ended_at columns.
We only want the rows where the time length of the ride was longer than one minute,
but shorter than one day.
*/

SELECT *
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`
WHERE TIMESTAMP_DIFF(ended_at, started_at, MINUTE) <= 1 OR
   TIMESTAMP_DIFF(ended_at, started_at, MINUTE) >= 1440;

/*
#4. Check the start/end station name/id columns for naming inconsistencies
*/

SELECT start_station_name, count(*)
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`
GROUP BY start_station_name
ORDER BY start_station_name;

SELECT end_station_name, count(*)
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`
GROUP BY end_station_name
ORDER BY end_station_name;

SELECT COUNT(DISTINCT(start_station_name)) AS df_startname,
   COUNT(DISTINCT(end_station_name)) AS df_endname,
   COUNT(DISTINCT(start_station_id)) AS df_startid,
   COUNT(DISTINCT(end_station_id)) AS df_endid
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`;

/*
Start and end station names need to be cleaned up:
 -Remove leading and traling spaces.
 -Remove substrings '(Temp)' as Cyclisitc uses these substrings when repairs
  are happening to a station. All station names should have the same naming conventions.
 -Found starting/end_names with "DIVVY CASSETTE REPAIR MOBILE STATION", "Lyft Driver Center Private Rack",
  "351", "Base - 2132 W Hubbard Warehouse", Hubbard Bike-checking (LBS-WH-TEST), "WEST CHI-WATSON".
   We will delete these as they are maintainence trips, and do not offer any use to the analysis. As well, may not be in this dataset as of 2026
 -Start/End station id columns has an underprecedented naming convention error, and different string lengths.
  Since they do not offer any use to the analysis, we will delete these as well.
*/

#5. Check NULLS in start and end station name columns

SELECT rideable_type, count(*) as num_of_rides
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`
WHERE start_station_name IS NULL AND start_station_id IS NULL OR
    end_station_name IS NULL AND end_station_id IS NULL 
GROUP BY rideable_type;

/* 
Classic_bikes/docked_bikes will always start, and end their trip locked in a docking station, based on previous datasets so far. In 2026 electric bikes are more than likely going to outshadow classic bikes. As of 2026 Docked Bikes are excluded from the analysis.
Since electric bikes have more versatility, and could be locked up using their bike lock
instead of a docking station. Therefore, trips do not have to start or end at a station.
Next:
Remove classic/docked bike trips that do not have a start or end station name and have no start/end station id to use to fill in the null. Given Permission
- change the null station names to 'On Bike Lock' for electric bikes
*/

--#6. Check rows were latitude and longitude are null

SELECT *
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`
WHERE start_lat IS NULL OR
 start_lng IS NULL OR
 end_lat IS NULL OR
 end_lng IS NULL;

-- NOTE: we may remove these rows as all rows should have location points

#7. Confirm that there are only 2 member types in the member_casual column:

SELECT DISTINCT member_casual
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`

--NOTE: Yes the only values in this field are 'member' or 'casual'

--Now we are ready to clean the data and then analyze it.
--go to Clean Dataset.sql
