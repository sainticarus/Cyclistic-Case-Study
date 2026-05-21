-- length check(16 unique characters)
SELECT length(ride_id)
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`;

-- Row Check (656274 unique rows)
SELECT count(*)
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`;

-- Distinct check (656274 returns TRUE) no duplicates
SELECT count(distinct (ride_id))
FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`;

-- checks number of nulls per row
SELECT 
  COUNT(*) - COUNT(ride_id) AS ride_id_count,
  COUNT(*) - COUNT(rideable_type) AS rideable_type_count,
  COUNT(*) - COUNT(started_at) AS started_at_count,
  COUNT(*) - COUNT(ended_at) AS ended_at_count,
  COUNT(*) - COUNT(start_lat) AS start_lat_count,
  COUNT(*) - COUNT(start_lng) AS start_lng_count,
  COUNT(*) - COUNT(end_lat) AS end_lat_count, -- 608 null values
  COUNT(*) - COUNT(start_station_name) AS start_station_name_count, --114396 null values
  COUNT(*) - COUNT(start_station_id) AS start_station_id_count, --  114396 null values
  COUNT(*) - COUNT(end_station_name) AS end_station_name_count, -- 125215 null values
  COUNT(*) - COUNT(end_station_id) AS end_station_id_count, -- 15215 null values
  COUNT(*) - COUNT(member_casual) AS member_casual_count,
  COUNT(*) - COUNT(end_lng) AS end_lng_count -- 608 null values

FROM `project-b498b95d-28d9-4cd7-978.trip_data.Q1_trips`;
