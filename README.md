#  Transport Operations SQL Analysis (Jan–Mar 2025)

##  Project Overview
This project aims to analyze transport trip data collected from January to March 2025. The objective was to uncover insights related to trip performance, cost efficiency, vehicle utilization, delay patterns, and operational KPIs. The analysis was performed entirely using SQL.

---

##  Tools Used
- **PostgreSQL / SQL**
- **Dbeaver** (for organizing and tracking queries)
- **Excel** (for cross-validation where required)
- **VS Code** (for managing the files)

---

##  Dataset Summary
The dataset includes trip-level information:
- `trip_id`, `vehicle_id`, `driver_id`, `material`, `vehicle_type`
- `loading_point`, `unloading_point`, `loading_qty`, `unloading_qty`, `damage_qty`
- `fuel_qty`, `freight`, `total_cost`, `distance`, `bonus`
- `planned_pod_date`, `actual_pod_date`, `delay_flag`

---

##  Questions Answered (with Results)

###  Data Cleaning & Validation

**1. Are there any missing values? Which columns have them?**  
![Missing Values](images/checking_nulls.png)

**2. Are all data types correct (e.g., dates, numbers, categories)?**  
![Data Types](images/data.png)

**3. Are there any duplicate trip IDs?**  
![Duplicate Trip IDs](images/duplicate_trips.png)

**4. Are the trip dates within Jan–Mar 2025?**  
![Date Range Check](images/date_range.png)

**5. Is loading quantity ≥ unloading quantity for each trip?**  
![Loading vs Unloading](images/loading_qty_less_than_unloading_qty.png)

**6. Are numerical fields (fuel_qty, freight, costs, etc.) non-negative?**  
![Non-Negative Check](images/numerical_values_less_than_zero.png)

---

###  Trip & Vehicle Insights

**7. How many total trips are there?**  
![Total Trips](images/total_trips.png)

**8. How many trips per vehicle per month? Any under-used vehicles?**  
![Trips per Vehicle](images/trips_per_vehicle_per_month.png) 

***underutilised vehicles*** 

![Trips per Vehicle](images/underutilised_vehicle.png)

**9. What’s the distribution of vehicle types?**  
![Vehicle Types](images/distribution_of_vehicle_type.png)

**10. What are the top 5 most common loading–unloading point combinations?**  
![Top Route Pairs](images/top_5_loading_unloading_pt_combination.png)

**11. Which routes have the longest distances?**  
![Longest Routes](images/routes_with_longest_distance.png)

---

###  Quantity & Material Insights

**12. What’s the average loading/unloading quantity?**  
![Average Quantity](images/average_loading_unloading_qty.png)

**13. Which materials are most frequently transported?**  

***based on Loading Quantity*** 
![Top Materials](images/frequently_transported_materials_based_on_loading_qty.png)


***based on Trips***

![Top Materials](images/frequently_transported_materials_based_on_trips.png)

**14. Which materials have higher damage_qty?**  
![Damaged Materials](images/materials_with_higher_damaged_quantity.png)

**15. What’s the damage % trend by material?** 
![Damage Trend](images/damage_trend_by_material.png)

**16. Are some materials more prone to damage?**  
![Material Damage Propensity](images/damage_trend_by_material.png)

---

###  Fuel & Financial Metrics

**17. What’s the monthly fuel consumption trend?**  
![Fuel Trend](images/monthly_fuel_consumption_trend.png)

**18. What is the average fuel efficiency (distance per litre)?**  
![Fuel Efficiency](images/avg_fuel_efficiency.png)

**19. What is the average total cost per trip?**  
![Trip Cost](images/avg_total_cost_per_trip.png)

**20. What is the average freight per trip?**  
![Freight](images/avg_freight_per_trip.png)

**21. What is the freight-to-total-cost ratio?**  
![Freight Ratio](images/freight_to_total_cost_ratio.png)

**22. Are there trips where freight < total cost? How rare are they?**  
![Loss Trips](images/freight_less_than_trip_cost.png)

***how rare are they*** 

![Loss Trips](images/rarity.png)

**23. Which trips have very low or high margin?**  
***below 10% margin*** 
![Margins](images/below_ten_percent_margin.png) 
***above 10% margin*** 
![Margins](images/above_ten_percent_margin.png)

**24. Which vehicle has the highest average trip margin?**  
![Vehicle Margin](images/highest_avg_trip_margin_by_vehicle.png)

**25. What’s the most profitable route?**  
![Profitable Routes](images/most_profitable_route.png)

**26. How does distance affect cost or freight?**  
![Distance-Cost Correlation](images/distance_affecting_cost_or_freight.png)

---

###  Delay & Bonus Analysis

**27. How many trips are marked as Delayed vs On-Time?**  
![Delay Flags](images/delayed_vs_on_time.png)

**28. What’s the average delay duration (planned vs actual pod_date)?**  
![Avg Delay](images/avg_delay_duration.png)

**29. Which routes or drivers are associated with higher delays?**  
***delay by route***  
![Delay by Route/Driver](images/delays_by_route.png)  


***delay by drivers***  
![Delay by Route/Driver](images/delays_by_drivers.png) 

**30. Is there a pattern in delay_flag over months?**  
![Delay Trend](images/delay_flag_pattern.png)

**31. Are delayed deliveries more costly?**  
![Costly Delays](images/delayed_trips_costly.png)

**32. How does bonus vary between delayed and on-time deliveries?**  
![Bonus Comparison](images/delay_on_time_bonus.png)

---

###  Driver Analysis

**33. Which drivers have the most trips?**  
![Top Drivers](images/most_trips.png)

**34. Any driver with consistently higher/lower trip costs?**  
![Driver Costs](images/drivers.png)

---

>  *This project involved writing **57+ SQL queries** across various categories to uncover trends, validate data, and generate business insights.*