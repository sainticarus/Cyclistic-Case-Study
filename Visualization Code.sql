---- DATA CLEANED, next is analyzation, and visualization
 Create Table trip_data.type_of_ride AS (
    SELECT ride_type, member_type, COUNT(*) AS amount_of_rides
    FROM trip_data.clean_combo_tripdata
    GROUP BY ride_type, member_type
    ORDER BY member_type, amount_of_rides DESC
  );
---- amount of rides per month:
 Create Table trip_data.rides_per_month AS (
    SELECT member_type, month, COUNT(*) AS num_of_rides
    FROM trip_data.clean_combo_tripdata
    GROUP BY member_type, month
  );

---- amount of rides per day:
 Create Table trip_data.rides_per_day AS (
    SELECT member_type, day_of_week, COUNT(*) AS num_of_rides
    FROM trip_data.clean_combo_tripdata
    GROUP BY member_type, day_of_week
  );

---- amount of rides per hour:
 Create Table trip_data.rides_per_hour AS (
    SELECT
      member_type,
      EXTRACT(HOUR FROM started_at) AS time_of_day,
      COUNT(*) AS num_of_rides
    FROM trip_data.clean_combo_tripdata
    GROUP BY member_type, time_of_day
  );

---- average length of ride per day:
 Create Table trip_data.avg_trip_length AS (
    SELECT
      member_type,
      day_of_week,
      ROUND(AVG(ride_time_m), 0) AS avg_ride_time_minutes,
      AVG(AVG(ride_time_m))
        OVER(PARTITION BY member_type) AS combined_avg_ride_time
    FROM trip_data.clean_combo_tripdata
    GROUP BY member_type, day_of_week
  );

---- starting docking station location for casuals:
 Create Table trip_data.start_station_casual AS (
    SELECT
      starting_station_name,
      ROUND(AVG(start_lat), 4) AS start_lat,
      ROUND(AVG(start_lng), 4) AS start_lng,
      COUNT(*) AS num_of_rides
    FROM `project-b498b95d-28d9-4cd7-978.trip_data.clean_combo_tripdata`
    WHERE member_type = 'casual' AND starting_station_name <> 'On Bike Lock'
    GROUP BY starting_station_name
  );

---- starting docking station location for members:
 Create Table trip_data.start_station_member AS (
    SELECT
      starting_station_name,
      ROUND(AVG(start_lat), 4) AS start_lat,
      ROUND(AVG(start_lng), 4) AS start_lng,
      COUNT(*) AS num_of_rides
    FROM `project-b498b95d-28d9-4cd7-978.trip_data.clean_combo_tripdata`
    WHERE member_type = 'member' AND starting_station_name <> 'On Bike Lock'
    GROUP BY starting_station_name
  );

---- ending docking station name for casuals:
 Create Table trip_data.end_station_casual AS (
    SELECT
      ending_station_name,
      ROUND(AVG(start_lat), 4) AS end_lat,
      ROUND(AVG(start_lng), 4) AS end_lng,
      COUNT(*) AS num_of_rides
    FROM `project-b498b95d-28d9-4cd7-978.trip_data.clean_combo_tripdata`
    WHERE member_type = 'casual' AND ending_station_name <> 'On Bike Lock'
    GROUP BY ending_station_name
  );

---- ending bike station for members:
Create Table trip_data.end_station_member AS (
    SELECT
      ending_station_name,
      ROUND(AVG(start_lat), 4) AS end_lat,
      ROUND(AVG(start_lng), 4) AS end_lng,
      COUNT(*) AS num_of_rides
    FROM `project-b498b95d-28d9-4cd7-978.trip_data.clean_combo_tripdata`
    WHERE member_type = 'member' AND ending_station_name <> 'On Bike Lock'
    GROUP BY ending_station_name
  );

---- ending bike lock location for casuals:
 Create Table trip_data.lock_location_casual AS (
    SELECT end_lat, end_lng, COUNT(*) AS num_of_rides
    FROM trip_data.clean_combo_tripdata
    WHERE ending_station_name = 'On Bike Lock' AND member_type = 'casual'
    GROUP BY end_lat, end_lng
  );

---- ending bike lock location for members:
Create Table trip_data.lock_location_member AS (
 SELECT end_lat, end_lng, COUNT(*) AS num_of_rides
FROM trip_data.clean_combo_tripdata
WHERE ending_station_name = 'On Bike Lock' AND member_type = 'member'
GROUP BY end_lat, end_lng
  );
