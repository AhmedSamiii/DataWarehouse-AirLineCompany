-- Query 1: Retrieve passenger information along with their booking channel details and the total revenue generated from their bookings
SELECT p.First_Name, p.Last_Name, p.Email_Address, p.Phone_Number, bc.Channel_Name,
       COALESCE(SUM(ff.Base_Fare_Revenue + ff.Passenger_Facility_Charges + ff.Airport_Tax + ff.Government_Tax), 0) AS Total_Revenue
FROM Passenger_DimensionT p
LEFT JOIN Flight_Activity_FactT ff ON p.Passenger_Key = ff.Passenger_Key
LEFT JOIN Booking_Channel_DimensionT bc ON ff.Booking_Channel_Key = bc.Booking_Channel_Key
GROUP BY p.First_Name, p.Last_Name, p.Email_Address, p.Phone_Number, bc.Channel_Name;

-- Query 2: Get details of flights including their departure and arrival airports along with scheduled departure and arrival dates, and the average delay in departure and arrival times
SELECT ff.Flight_Number, dd1.Datee AS Scheduled_Departure_Date, dd2.Datee AS Scheduled_Arrival_Date, 
       da.Airport_Name AS Departure_Airport, aa.Airport_Name AS Arrival_Airport,
       AVG(ff.Departure_Time_Delay) AS Avg_Departure_Delay,
       AVG(ff.Arrival_Time_Delay) AS Avg_Arrival_Delay
FROM Flight_Activity_FactT ff
LEFT JOIN Date_DimensionT dd1 ON ff.Scheduled_Departure_Date_Key = dd1.Date_Key
LEFT JOIN Date_DimensionT dd2 ON ff.Scheduled_Arrival_Date_Key = dd2.Date_Key
LEFT JOIN Airport_DimensionT da ON ff.Start_Airport_Key = da.Airport_Code
LEFT JOIN Airport_DimensionT aa ON ff.End_Airport_Key = aa.Airport_Code
GROUP BY ff.Flight_Number, dd1.Datee, dd2.Datee, da.Airport_Name, aa.Airport_Name;

-- Query 3: Retrieve passenger interactions along with their sentiment and ratings, and the total number of interactions per passenger
SELECT p.First_Name, p.Last_Name, i.Interaction_Type, i.Sentiment, i.Rating,
       COUNT(*) AS Total_Interactions
FROM Passenger_DimensionT p
LEFT JOIN Customer_Care_FactT cc ON p.Passenger_Key = cc.Passenger_Key
LEFT JOIN Interaction_DimensionT i ON cc.Interaction_ID = i.Interaction_ID
GROUP BY p.First_Name, p.Last_Name, i.Interaction_Type, i.Sentiment, i.Rating;

-- Query 4: Get details of flights along with the passenger's frequent flyer tier and club membership status, and the total miles flown by each passenger
SELECT ff.Flight_Number, pp.Frequent_Flyer_Tier, pp.Club_Membership_Status,
       SUM(ff.Segment_Miles_Flown) AS Total_Miles_Flown
FROM Flight_Activity_FactT ff
LEFT JOIN Passenger_Profile_DimT pp ON ff.Passenger_profile_Key = pp.Passenger_Profile_Key
GROUP BY ff.Flight_Number, pp.Frequent_Flyer_Tier, pp.Club_Membership_Status;

-- Query 5: Retrieve flight activity details along with the aircraft type, manufacturer, and the total number of seats available
SELECT ff.Flight_Number, ad.Aircraft_Type, ad.Manufacturer,
       SUM(ad.No_of_Seats_Economy + ad.No_of_Seats_Business + ad.No_of_Seats_First) AS Total_Seats
FROM Flight_Activity_FactT ff
LEFT JOIN Aircraft_DimensionT ad ON ff.Airplane_Key = ad.Aircraft_ID
GROUP BY ff.Flight_Number, ad.Aircraft_Type, ad.Manufacturer;



-- Query 8: Retrieve the top 5 airports with the highest number of departures
SELECT Airport_Name, City, Country, Region, Departure_Count
FROM (
    SELECT ad.Airport_Name, ad.City, ad.Country, ad.Region, COUNT(*) AS Departure_Count,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS Rank_Departures
    FROM Flight_Activity_FactT ff
    LEFT JOIN Airport_DimensionT ad ON ff.Start_Airport_Key = ad.Airport_Code
    GROUP BY ad.Airport_Name, ad.City, ad.Country, ad.Region
)
WHERE Rank_Departures <= 5;

-- Query 9: Get the total number of interactions for each sentiment type and rating range
SELECT Sentiment, Rating, Total_Interactions
FROM (
    SELECT i.Sentiment, i.Rating,
           COUNT(*) AS Total_Interactions,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS Rank_Interactions
    FROM Interaction_DimensionT i
    LEFT JOIN Customer_Care_FactT cc ON i.Interaction_ID = cc.Interaction_ID
    GROUP BY i.Sentiment, i.Rating
)
WHERE Rank_Interactions <= 5;