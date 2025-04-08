-- EDA on Transport Data
-- Let us check if we have any NULL values in the data
SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	trip_date IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	trip_id IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	vehicle_number IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	vehicle_type IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	driver_name IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	loading_pt IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	unloading_pt IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	route_name IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	pod_id IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	pod_date IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	delivery_status IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	fuel_qty IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	freight IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	unloading_qty IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	material IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	rate IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	loading_qty IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	diesel_exp IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	driver_exp IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	bonus IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	billing_status IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	toll_exp IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	misc_exp IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	distance_km IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	delay_flag IS NULL;

SELECT
	COUNT(*)
FROM
	trip_data
WHERE
	planned_delivery_date IS NULL;

-- More efficient way
SELECT
  COUNT(*) AS total_rows,
  COUNT(trip_date) AS trip_date_not_null,
  COUNT(trip_id) AS trip_id_not_null,
  COUNT(vehicle_number) AS vehicle_number_not_null,
  COUNT(vehicle_type) AS vehicle_type_not_null,
  COUNT(driver_name) AS driver_name_not_null,
  COUNT(loading_pt) AS loading_pt_not_null,
  COUNT(unloading_pt) AS unloading_pt_not_null,
  COUNT(route_name) AS route_name_not_null,
  COUNT(pod_id) AS pod_id_not_null,
  COUNT(pod_date) AS pod_date_not_null,
  COUNT(delivery_status) AS delivery_status_not_null,
  COUNT(fuel_qty) AS fuel_qty_not_null,
  COUNT(freight) AS freight_not_null,
  COUNT(unloading_qty) AS unloading_qty_not_null,
  COUNT(material) AS material_not_null,
  COUNT(rate) AS rate_not_null,
  COUNT(loading_qty) AS loading_qty_not_null,
  COUNT(diesel_exp) AS diesel_exp_not_null,
  COUNT(driver_exp) AS driver_exp_not_null,
  COUNT(bonus) AS bonus_not_null,
  COUNT(billing_status) AS billing_status_not_null,
  COUNT(toll_exp) AS toll_exp_not_null,
  COUNT(misc_exp) AS misc_exp_not_null,
  COUNT(distance_km) AS distance_km_not_null,
  COUNT(delay_flag) AS delay_flag_not_null,
  COUNT(planned_delivery_date) AS planned_delivery_date_not_null
FROM
	trip_data;

-- Check if the data types are correct
SELECT
	column_name,
	data_type 
FROM
	information_schema.columns  
WHERE
	table_name = 'trip_data';


-- Convert trip_date from VARCHAR to DATE
ALTER TABLE trip_data 
ALTER COLUMN trip_date TYPE DATE
	USING TO_DATE(trip_date, 'YYYY-MM-DD');

-- Convert pod_date from VARCHAR to DATE
ALTER TABLE trip_data 
ALTER COLUMN pod_date TYPE DATE
	USING TO_DATE(pod_date, 'YYYY-MM-DD');

-- Convert planned_delivery_date from VARCHAR to DATE
ALTER TABLE trip_data 
ALTER COLUMN planned_delivery_date TYPE DATE
	USING TO_DATE(planned_delivery_date, 'YYYY-MM-DD');

-- Are there any duplicate trip_id?
SELECT
	trip_id,
	COUNT(1) 
FROM
	trip_data
GROUP BY
	trip_id
HAVING
	COUNT(1) > 1;

-- Are the dates within the expected range (Jan–Mar 2025)?
-- option 1
SELECT
	*
FROM
	trip_data
WHERE
	trip_date < '2025-01-01'
	OR trip_date > '2025-03-31';

-- option 2
SELECT 
    MIN(trip_date) AS earliest_date,
    MAX(trip_date) AS latest_date
FROM 
    trip_data;

-- Is the loading quantity ≥ unloading quantity for each trip?
SELECT
	*
FROM
	trip_data
WHERE
	loading_qty < unloading_qty;

-- Are numerical columns like fuel_qty, freight, costs, etc. non-negative?
SELECT
	*
FROM
	trip_data
WHERE
	fuel_qty < 0
	OR
    freight < 0
	OR
    unloading_qty < 0
	OR
    rate < 0
	OR
    loading_qty < 0
	OR
    diesel_exp < 0
	OR
    driver_exp < 0
	OR
    bonus < 0
	OR
    toll_exp < 0
	OR
    misc_exp < 0
	OR
    distance_km < 0;


-- How many total trips are there?
SELECT
	COUNT(DISTINCT trip_id) AS total_trips
FROM
	trip_data;


-- How many trips per vehicle per month? Any vehicle under-used?
SELECT
	vehicle_number,
	TO_CHAR(trip_date, 'Month') AS trip_month,
	COUNT(DISTINCT trip_id) AS total_trips
FROM
	trip_data 
GROUP BY
	vehicle_number,
	trip_month
ORDER BY
	vehicle_number,
	trip_month;

-- Any underutilised vehicle
SELECT
	vehicle_number,
	TO_CHAR(trip_date, 'Month') AS trip_month,
	COUNT(DISTINCT trip_id) AS total_trips
FROM
	trip_data 
GROUP BY
	vehicle_number,
	trip_month
HAVING
	COUNT(DISTINCT trip_id) < 5;

-- What’s the distribution of vehicle types?
SELECT
	vehicle_type,
	COUNT(DISTINCT vehicle_number) AS total_vehicles
FROM
	trip_data
GROUP BY
	vehicle_type
ORDER BY
	total_vehicles DESC;

-- What are the top 5 most common loading–unloading point combinations?
SELECT
	route_name,
	COUNT(trip_id) AS total_trips
FROM
	trip_data
GROUP BY
	route_name
ORDER BY
	total_trips DESC
LIMIT
	5;

-- Which routes have the longest distances?
SELECT
	route_name,
	distance_km AS total_trips
FROM
	trip_data
GROUP BY
	route_name,
	2;

-- What’s the average loading/unloading qty?
SELECT
	AVG(loading_qty) AS avg_loading_qty,
	AVG(unloading_qty) AS avg_unloading_qty
FROM
	trip_data;

-- Which materials are most frequently transported?
-- on the basis of trips
SELECT
    material,
    COUNT(trip_id) AS total_trips
FROM
    trip_data
GROUP BY
    material
ORDER BY
    total_trips DESC;

-- on the basis of loading_qty
SELECT
    material,
    SUM(loading_qty) AS total_qty
FROM
    trip_data
GROUP BY
    material
ORDER BY
    total_qty DESC;

-- Which materials have higher damaged_qty?
SELECT
    material,
    SUM(loading_qty - unloading_qty) AS damaged_qty
FROM
    trip_data
GROUP BY
    material
ORDER BY
    damaged_qty DESC;

-- What’s the fuel consumption trend per month?
SELECT
    TO_CHAR(trip_date, 'Month') AS month_name,
    SUM(fuel_qty) AS total_fuel_consumption
FROM
    trip_data
GROUP BY
    month_name;

-- What is the average fuel efficiency (distance per litre)?
SELECT
    ROUND(AVG(distance_km/fuel_qty)::NUMERIC, 2) AS avg_fuel_efficiency
FROM
    trip_data;

-- How much is the average total cost per trip?
SELECT
    ROUND(AVG(diesel_exp + driver_exp + bonus + toll_exp + misc_exp)::NUMERIC, 2) AS avg_total_cost_per_trip
FROM
    trip_data;

-- What is the average freight per trip?
SELECT
    ROUND(AVG(freight)::NUMERIC, 2) AS avg_freight_per_trip
FROM
    trip_data;

-- What is the freight-to-total-cost ratio?
SELECT
    SUM(freight)/SUM(diesel_exp + driver_exp + bonus + toll_exp + misc_exp) AS freight_to_total_cost_ratio
FROM
    trip_data;

-- Are there any trips where freight < total cost? How rare are they?
SELECT
    *
FROM
    trip_data
WHERE
	freight < (diesel_exp + driver_exp + bonus + toll_exp + misc_exp);

-- how rare are they?
SELECT
    COUNT(*) AS loss_making_trips,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM trip_data), 2) AS percentage_of_total
FROM
    trip_data
WHERE
    freight < (diesel_exp + driver_exp + bonus + toll_exp + misc_exp);

-- Which trips have very low or high margin?
-- trips with low margin
SELECT 
    trip_id,
    freight,
    (diesel_exp + driver_exp + bonus + toll_exp + misc_exp) AS total_cost,
    (freight - (diesel_exp + driver_exp + bonus + toll_exp + misc_exp)) AS margin,
    ROUND(((freight - (diesel_exp + driver_exp + bonus + toll_exp + misc_exp)) * 100.0 / NULLIF(freight, 0))::NUMERIC, 2) AS margin_percent
FROM 
    trip_data
WHERE 
    ((freight - (diesel_exp + driver_exp + bonus + toll_exp + misc_exp)) * 100.0 / NULLIF(freight, 0)) < 10
ORDER BY margin ASC;

-- trips with high margin
SELECT 
    trip_id,
    freight,
    (diesel_exp + driver_exp + bonus + toll_exp + misc_exp) AS total_cost,
    (freight - (diesel_exp + driver_exp + bonus + toll_exp + misc_exp)) AS margin,
    ROUND(((freight - (diesel_exp + driver_exp + bonus + toll_exp + misc_exp)) * 100.0 / NULLIF(freight, 0))::NUMERIC, 2) AS margin_percent
FROM 
    trip_data
WHERE 
    ((freight - (diesel_exp + driver_exp + bonus + toll_exp + misc_exp)) * 100.0 / NULLIF(freight, 0)) > 90
ORDER BY margin ASC;

--How many trips are marked as Delayed vs On-Time?
SELECT
	delay_flag,
	COUNT(*) AS total_trips
FROM
	trip_data
GROUP BY
	delay_flag;

-- What’s the average delay duration (planned vs actual pod_date)?
SELECT
    delay_flag,
    AVG(pod_date - planned_delivery_date) AS avg_delay_duration
FROM
    trip_data
WHERE
	delay_flag = 'Delayed'
GROUP BY
    delay_flag;

-- Which routes or drivers are associated with higher delays?
-- for routes
SELECT
	route_name,
	COUNT(*) FILTER (WHERE delay_flag = 'Delayed') AS delay_count
FROM
	trip_data
GROUP BY
	route_name
ORDER BY
	delay_count DESC;

-- for drivers
SELECT
	driver_name,
	COUNT(*) FILTER (WHERE delay_flag = 'Delayed') AS delay_count
FROM
	trip_data
GROUP BY
	driver_name
ORDER BY
	delay_count DESC;


--Is there a pattern in delay_flag over months?
SELECT
	EXTRACT (MONTH FROM planned_delivery_date) AS month_num,
    TO_CHAR(planned_delivery_date, 'Month') AS month_name,
    COUNT(*) FILTER (WHERE delay_flag = 'Delayed') AS delayed_trips,
    COUNT(*) FILTER (WHERE delay_flag = 'On-Time') AS on_time_trips
FROM
    trip_data
GROUP BY
    month_num,
    month_name
ORDER BY
    month_num,
	month_name;

-- Which drivers have the most trips?
SELECT
	driver_name,
	COUNT(trip_id) AS total_trips
FROM
	trip_data
GROUP BY
	driver_name
ORDER BY
	total_trips DESC;

-- Any driver with consistently higher/lower trip costs?
SELECT
    driver_name,
    COUNT(trip_id) AS total_trips,
    ROUND(AVG(diesel_exp + driver_exp + bonus + toll_exp + misc_exp)::NUMERIC, 2) AS avg_trip_cost
FROM
    trip_data
GROUP BY
    driver_name
ORDER BY
    avg_trip_cost DESC;

-- Which vehicle has the highest avg trip margin?
SELECT 
    vehicle_number,
    ROUND(AVG(freight - (diesel_exp + driver_exp + bonus + toll_exp + misc_exp))::NUMERIC, 2) AS margin
FROM 
    trip_data
GROUP BY
	vehicle_number
ORDER BY
	margin DESC
LIMIT 1;

-- What’s the most profitable route?
SELECT 
    route_name,
    ROUND(AVG(freight - (diesel_exp + driver_exp + bonus + toll_exp + misc_exp))::NUMERIC, 2) AS profit
FROM 
    trip_data
GROUP BY
	route_name
ORDER BY
	profit DESC
LIMIT 1;

-- What’s the damage % trend by material?
-- option 1
SELECT
    material,
    EXTRACT(MONTH FROM trip_date) AS month_num,
    TO_CHAR(trip_date, 'Month') AS month_name,
    SUM(loading_qty - unloading_qty) AS damaged_qty,
    ROUND((SUM(loading_qty - unloading_qty) * 100/SUM(loading_qty))::NUMERIC, 2) AS damaged_qty_percent
FROM
    trip_data
GROUP BY
    material,
    month_num,
    month_name;

-- option 2
WITH monthly_data AS (
    SELECT
        material,
        DATE_TRUNC('month', trip_date) AS month,
        SUM(loading_qty) AS total_loaded,
        SUM(loading_qty - unloading_qty) AS total_damaged
    FROM
        trip_data
    GROUP BY
        material,
        DATE_TRUNC('month', trip_date)
)

SELECT
    material,
    TO_CHAR(month, 'YYYY-MM') AS month,
    total_loaded,
    total_damaged,
    ROUND(((total_damaged * 100.0) / NULLIF(total_loaded, 0))::NUMERIC, 2) AS damage_percent
FROM
    monthly_data
ORDER BY
    material,
    month;

-- How does distance affect cost or freight?
SELECT
    distance_km,
    ROUND(AVG(freight)::NUMERIC, 2) AS avg_freight,
    ROUND(AVG(diesel_exp + driver_exp + bonus + toll_exp + misc_exp)::NUMERIC, 2) AS avg_total_cost,
    ROUND(AVG(freight - (diesel_exp + driver_exp + bonus + toll_exp + misc_exp))::NUMERIC, 2) AS avg_margin,
    ROUND((AVG(freight) / NULLIF(AVG(distance_km), 0))::NUMERIC, 2) AS freight_per_km,
    ROUND((AVG((diesel_exp + driver_exp + bonus + toll_exp + misc_exp)) / NULLIF(AVG(distance_km), 0))::NUMERIC, 2) AS cost_per_km
FROM
    trip_data
GROUP BY
    distance_km
ORDER BY
    distance_km;

-- Are delayed deliveries more costly?
SELECT
    delay_flag,
    ROUND(AVG(diesel_exp + driver_exp + bonus + toll_exp + misc_exp)::NUMERIC, 2) AS avg_total_cost
FROM
    trip_data
GROUP BY
    delay_flag;

-- Are some materials more prone to damage?
SELECT
    material,
    SUM(loading_qty - unloading_qty) AS total_damaged_qty,
    SUM(loading_qty) AS total_loaded_qty,
    ROUND((SUM(loading_qty - unloading_qty) * 100.0 / NULLIF(SUM(loading_qty), 0))::NUMERIC, 2) AS damage_percent
FROM
    trip_data
GROUP BY
    material
ORDER BY
    damage_percent DESC;

-- How does bonus varies between delayed and on time deliveries?
SELECT
    delay_flag,
    COUNT(*) AS total_trips,
    ROUND(AVG(bonus)::NUMERIC, 2) AS avg_bonus
FROM
    trip_data
GROUP BY
    delay_flag;

















