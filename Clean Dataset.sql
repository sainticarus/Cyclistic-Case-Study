-- Appends stored data for Q1 Trips as an alias
WITH trip_data.combo_data AS
(
    SELECT *
    FROM (
      SELECT * FROM `project-b498b95d-28d9-4cd7-978.trip_data.0126_data`
    UNION ALL
      SELECT * FROM `project-b498b95d-28d9-4cd7-978.trip_data.0226_data`
    UNION ALL
      SELECT * FROM `project-b498b95d-28d9-4cd7-978.trip_data.0326_data`
        )
); 

---- DATA CLEAN PROCESS
---- Find classic/docked trips that does NOT null location
---- Therefore, "no ride ID" is a temporary variable created for nonconclusive data points

 Create Table trip_data.null_station_names AS
(
    SELECT ride_id AS no_ride_id
    FROM
      (
        SELECT
          ride_id,
          start_station_name,
          start_station_id,
          end_station_name,
          end_station_id
        FROM trip_data.combo_data
        WHERE rideable_type = 'classic_bike' OR rideable_type = 'electric_bike'
      )
    WHERE
      start_station_name IS NOT NULL AND start_station_id IS NOT NULL
      OR end_station_name IS NOT NULL AND end_station_id IS NOT NULL
);

-- Remove rows to have correlation of classic/docked and start/end
 Create Table trip_data.null_station_names_clean AS
(
   SELECT *
    FROM trip_data.combo_data AS cd
    LEFT JOIN trip_data.null_station_names AS nsn
    ON cd.ride_id = nsn.no_ride_id
    WHERE
      nsn.no_ride_id IS NULL
      AND cd.start_lat IS NOT NULL
      AND cd.start_lng IS NOT NULL
      AND cd.end_lat IS NOT NULL
      AND cd.end_lng IS NOT NULL
);

  ---- Replace docked_bike with classic. Cleans data to remove any confusion
  ---- Fills nulls with 'Bike locked' insuating completed travel destination
  ---- create new columns for time relevant variables
  
 Create Table trip_data.agg_tripdata AS 
(
    SELECT
      ride_id,
      REPLACE(rideable_type, 'docked_bike', 'classic_bike') AS ride_type,
      started_at,
      ended_at,
      IFNULL(TRIM(REPLACE(start_station_name, '(Temp)', '')), 'On Bike Lock')
        AS starting_station_name,
      IFNULL(TRIM(REPLACE(end_station_name, '(Temp)', '')), 'On Bike Lock')
        AS ending_station_name,
      CASE
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 1 THEN 'Sun'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 2 THEN 'Mon'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 3 THEN 'Tues'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 4 THEN 'Wed'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 5 THEN 'Thur'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 6 THEN 'Fri'
        ELSE 'Sat'
        END AS day_of_week,
      CASE
        WHEN EXTRACT(MONTH FROM started_at) = 1 THEN 'Jan'
        WHEN EXTRACT(MONTH FROM started_at) = 2 THEN 'Feb'
        ELSE 'Mar'
        END AS month,
      EXTRACT(DAY FROM started_at) AS day,
      EXTRACT(YEAR FROM started_at) AS year,
      TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_time_m,
      start_lat,
      start_lng,
      end_lat,
      end_lng,
      member_casual AS member_type
    FROM trip_data.null_station_names_clean
);
--Remove rows that contains maintainence and testing data, based on earlier data reports
 Create Table trip_data.clean_combo_tripdata AS (
    SELECT *
    FROM trip_data.agg_tripdata
    WHERE
      ride_time_m > 1
      AND ride_time_m < 1440
      AND starting_station_name <> 'DIVVY CASSETTE REPAIR MOBILE STATION'
      AND starting_station_name <> 'Lyft Driver Center Private Rack'
      AND starting_station_name <> '351'
      AND starting_station_name <> 'Base - 2132 W Hubbard Warehouse'
      AND starting_station_name <> 'Hubbard Bike-checking (LBS-WH-TEST)'
      AND starting_station_name <> 'WEST CHI-WATSON'
      AND ending_station_name <> 'DIVVY CASSETTE REPAIR MOBILE STATION'
      AND ending_station_name <> 'Lyft Driver Center Private Rack'
      AND ending_station_name <> '351'
      AND ending_station_name <> 'Base - 2132 W Hubbard Warehouse'
      AND ending_station_name <> 'Hubbard Bike-checking (LBS-WH-TEST)'
      AND ending_station_name <> 'WEST CHI-WATSON'
);
