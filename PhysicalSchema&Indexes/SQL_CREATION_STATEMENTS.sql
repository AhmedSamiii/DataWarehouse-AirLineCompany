ALTER SESSION SET CURRENT_SCHEMA = airlinecompany_dwh;



-- DONE
CREATE TABLE Date_DimensionT (
    Date_Key NUMBER ,
    Datee DATE,
    Day_of_Week VARCHAR2(20),
    Day_Number_in_Epoch NUMBER,
    Week_Number_in_Epoch NUMBER,
    Month_Number_in_Epoch NUMBER,
    Day_Number_in_Calendar_Month NUMBER,
    Day_Number_in_Calendar_Year NUMBER,
    Calendar_Month VARCHAR2(20),
    Calendar_Month_Number_in_Year NUMBER,
    Calendar_Year_Month VARCHAR2(20),
    Calendar_Quarter VARCHAR2(20),
    Calendar_Year_Quarter VARCHAR2(20),
    Calendar_Year NUMBER,
    Fiscal_Month VARCHAR2(20),
    Fiscal_Month_Number_in_Year NUMBER,
    Fiscal_Year_Month VARCHAR2(20),
    Fiscal_Quarter VARCHAR2(20),
    Fiscal_Year_Quarter VARCHAR2(20),
    Fiscal_Year NUMBER
);

-- Interaction Dimension
-- DONE
CREATE TABLE Interaction_DimensionT (
    Interaction_ID NUMBER ,
    Interaction_Type VARCHAR2(50), -- inquiries / complians / feedback
    Interaction_Channel VARCHAR2(50), -- phone / email / chat / in-person
    Sentiment VARCHAR2(20), -- positive / natural / negative
    Rating NUMBER, -- rate from 1 to 5
    Interaction_Phase VARCHAR2(20) -- before / after / within
);

-- Flight Ancillary Service Dimension
-- DONE
CREATE TABLE Ancillary_Service_DimensionT (
    Ancillary_Service_Key NUMBER ,
    Ancillary_Service_Number NUMBER,
    Service_Name VARCHAR2(100),
    Service_Class VARCHAR2(50),
    Service_Description CLOB -- Description: Detailed description of the service
);

-- DONE
CREATE TABLE Main_Service_DimensionT (
    Main_Service_Key NUMBER ,
    Main_Service_Number NUMBER,
    Main_Service_Name VARCHAR2(50)
    );


-- Booking Channel Dimension
-- DONE
CREATE TABLE Booking_Channel_DimensionT (
    Booking_Channel_Key VARCHAR2(50) ,
    Channel_ID VARCHAR2(50),
    Channel_Name VARCHAR2(100)
  
);

-- Aircraft Dimension
-- DONE
CREATE TABLE Aircraft_DimensionT (
    Aircraft_ID NUMBER ,
    Aircraft_Type VARCHAR2(50),
    Manufacturer VARCHAR2(100),
    Manufacturer_Date DATE,
    No_of_Seats_Economy NUMBER,
    No_of_Seats_Business NUMBER,
    No_of_Seats_First NUMBER,
    Max_Capacity NUMBER,
    Max_Range NUMBER(10, 2),
    Fuel_Capacity_in_Liter NUMBER(10, 2),
    Engine_Type VARCHAR2(100),
    Engine_Manufacturer VARCHAR2(100),
    Operating_Weight NUMBER(10, 2),
    Max_Takeoff_Weight NUMBER(10, 2),
    Max_Landing_Weight NUMBER(10, 2)
);

-- Airport Dimension
-- DONE
CREATE TABLE Airport_DimensionT (
    Airport_Code VARCHAR2(10) ,
    Airport_Name VARCHAR2(100),
    City VARCHAR2(100),
    Country VARCHAR2(100),
    Region VARCHAR2(100),
    Latitude NUMBER(10, 6),
    Longitude NUMBER(10, 6),
    Airport_Type VARCHAR2(50), 
    Airport_Code_ICAO VARCHAR2(10),
    Airport_Contact_Number VARCHAR2(20),
    Airport_Email VARCHAR2(100)
);

-- Passenger Dimension
-- DONE
CREATE TABLE Passenger_DimensionT (
    Passenger_Key NUMBER ,
    Passport_Number VARCHAR2(20) ,
    First_Name VARCHAR2(100),
    Last_Name VARCHAR2(100),
    Gender CHAR(1),
    Nationality VARCHAR2(100),
    Email_Address VARCHAR2(100),
    Date_of_Birth DATE,
    Phone_Number VARCHAR2(20),
    Alive CHAR(1)
);

-- Passenger Profile Dimension
-- DONE
CREATE TABLE Passenger_Profile_DimT (
    Passenger_Profile_Key NUMBER ,
    Frequent_Flyer_Tier VARCHAR2(50),
    Home_Airport VARCHAR2(10) ,
    Club_Membership_Status VARCHAR2(50),
    Lifetime_Mileage_Tier VARCHAR2(50)
);

-- DONE
CREATE TABLE Fare_Basis_DimensionT (
  Fare_Basis_Key  VARCHAR2(50) ,
  Fare_Basis_Code VARCHAR2(50) ,
  Fare_Class VARCHAR2(50),
  Fare_Type VARCHAR2(50),
  Minimum_Stays NUMBER(10)
);

-- DONE
CREATE TABLE Class_Of_Service_Flown_DimT (
    Class_of_Service_Key NUMBER  ,
    Class_Purchased VARCHAR2(100),
    Class_Flown VARCHAR2(100),
    Purchased_Flown_Group VARCHAR2(100),
    Class_Change_Indicator VARCHAR2(100)
);

-- Payment Method Dimension
-- DONE
CREATE TABLE Payment_Method_DimT (
    Payment_Method_Key NUMBER  ,
    Payment_Method_Name VARCHAR2(100)
);

-- Partner Service Dimension
-- DONE
CREATE TABLE Partner_Service_DimensionT (
    Partner_Service_Key NUMBER  ,
    Partner_Service_ID NUMBER  ,
    Service_Name VARCHAR2(100),
    Partner_Name VARCHAR2(100),
    Partner_Type VARCHAR2(50)
);


-- Date Dimension
ALTER TABLE Date_DimensionT ADD CONSTRAINT PK_Date_DimensionT PRIMARY KEY (Date_Key);
 
-- Interaction Dimension
ALTER TABLE Interaction_DimensionT ADD CONSTRAINT PK_Interaction_DimensionT PRIMARY KEY (Interaction_ID);
 
-- Ancillary Service Dimension
ALTER TABLE Ancillary_Service_DimensionT ADD CONSTRAINT PK_AncService_DimensionT PRIMARY KEY (Ancillary_Service_Key);
 
-- Main Service Dimension
ALTER TABLE Main_Service_DimensionT ADD CONSTRAINT PK_Main_Service_DimensionT PRIMARY KEY (Main_Service_Key);
 
-- Transaction Type Dimension
ALTER TABLE Transaction_Type_DimensionT ADD CONSTRAINT PK_Transaction_Type_DimensionT PRIMARY KEY (Transaction_Type_Key);
 
-- Booking Channel Dimension
ALTER TABLE Booking_Channel_DimensionT ADD CONSTRAINT PK_Booking_Channel_DimensionT PRIMARY KEY (Booking_Channel_Key);
 
-- Aircraft Dimension
ALTER TABLE Aircraft_DimensionT ADD CONSTRAINT PK_Aircraft_DimensionT PRIMARY KEY (Aircraft_ID);
 
-- Airport Dimension
ALTER TABLE Airport_DimensionT ADD CONSTRAINT PK_Airport_DimensionT PRIMARY KEY (Airport_Code);
 
-- Passenger Dimension
ALTER TABLE Passenger_DimensionT ADD CONSTRAINT PK_Passenger_DimensionT PRIMARY KEY (Passenger_Key);
 
-- Passenger Profile Dimension
ALTER TABLE Passenger_Profile_DimT ADD CONSTRAINT PK_Passenger_Profile_DimT PRIMARY KEY (Passenger_Profile_Key);
 
-- Fare Basis Dimension
ALTER TABLE Fare_Basis_DimensionT ADD CONSTRAINT PK_Fare_Basis_DimensionT PRIMARY KEY (Fare_Basis_Key);
 
-- Class Of Service Flown Dimension
ALTER TABLE Class_Of_Service_Flown_DimT ADD CONSTRAINT PK_Class_Of_Service_Flown_DimT PRIMARY KEY (Class_of_Service_Key);
 
-- Payment Method Dimension
ALTER TABLE Payment_Method_DimT ADD CONSTRAINT PK_Payment_Method_DimT PRIMARY KEY (Payment_Method_Key);
 
-- Partner Service Dimension
ALTER TABLE Partner_Service_DimensionT ADD CONSTRAINT PK_Partner_Service_DimensionT PRIMARY KEY (Partner_Service_Key);


-- DONE
CREATE TABLE Flight_Activity_FactT (
    Scheduled_Departure_Date_Key NUMBER REFERENCES Date_DimensionT(Date_Key),
    Scheduled_Departure_Time_Key TIMESTAMP,
    Actual_Departure_Date_Key NUMBER REFERENCES Date_DimensionT(Date_Key),
    Actual_GMT_Departure_Time_Key TIMESTAMP,
    Scheduled_Arrival_Date_Key NUMBER REFERENCES Date_DimensionT(Date_Key),
    Scheduled_GMT_Arrival_Time_Key TIMESTAMP,
    Actual_Arrival_Date_Key NUMBER REFERENCES Date_DimensionT(Date_Key),
    Actual_Arrival_GMT_Time_Key TIMESTAMP,
    Passenger_Key NUMBER REFERENCES Passenger_DimensionT(Passenger_Key),
    Passenger_profile_Key NUMBER REFERENCES Passenger_Profile_DimT(Passenger_Profile_Key),
    Start_Airport_Key VARCHAR2(10) REFERENCES Airport_DimensionT(Airport_Code),
    End_Airport_Key VARCHAR2(10) REFERENCES Airport_DimensionT(Airport_Code),
    Airplane_Key NUMBER REFERENCES Aircraft_DimensionT(Aircraft_ID),
    Service_Class_Key NUMBER REFERENCES Class_Of_Service_Flown_DimT(Class_of_Service_Key),
    Fare_Basis_Key VARCHAR2(50) REFERENCES Fare_Basis_DimensionT(Fare_Basis_Key),
    Booking_Channel_Key VARCHAR2(50) REFERENCES Booking_Channel_DimensionT(Booking_Channel_Key),
    Confirmation_Number VARCHAR2(50),
    Ticket_Number VARCHAR2(50),
    Flight_Number VARCHAR2(50),
    Segment_Sequence_Number NUMBER,
    Departure_Time_Delay NUMBER,
    Arrival_Time_Delay NUMBER,
    Base_Fare_Revenue NUMBER(10, 2),
    Passenger_Facility_Charges NUMBER(10, 2),
    Airport_Tax NUMBER(10, 2),
    Government_Tax NUMBER(10, 2),
    Baggage_Charges NUMBER(10, 2),
    Upgrade_Fees NUMBER(10, 2),
    Transaction_Fees NUMBER(10, 2),
    Segment_Miles_Flown NUMBER(10, 2),
    Segment_Miles_Earned NUMBER(10, 2)
);

CREATE TABLE Reservation_FactT (
    Flight_ID VARCHAR2(20), -- Degenerate Dimension
    Snapshot_Date_Key NUMBER REFERENCES Date_DimensionT(Date_Key),
    Departure_Date_Key NUMBER REFERENCES Date_DimensionT(Date_Key),
    Arrival_Date_Key NUMBER REFERENCES Date_DimensionT(Date_Key),
    Remaining_Seat_E NUMBER,
    Remaining_Seat_PRIM_E NUMBER,
    Remaining_Seat_B NUMBER,
    Remaining_Seat_F NUMBER,
    Uneraned_Revenue NUMBER
);


-- DONE
CREATE TABLE Customer_Care_FactT (
    Leg_Start_Airport_Key VARCHAR2(10) REFERENCES Airport_DimensionT(Airport_Code),
    Leg_End_Airport_Key VARCHAR2(10) REFERENCES Airport_DimensionT(Airport_Code),
    Ticket_Number VARCHAR2(50),
    Aircraft_Key NUMBER REFERENCES Aircraft_DimensionT(Aircraft_ID),
    Flight_Number VARCHAR2(50),
    Interaction_Date_Key NUMBER, --REFERENCES Date_DimensionT(Date_Key),
    Passenger_profile_Key NUMBER REFERENCES Passenger_Profile_DimT(Passenger_Profile_Key),
    Passenger_Key NUMBER REFERENCES Passenger_DimensionT(Passenger_Key),
    Interaction_ID NUMBER REFERENCES Interaction_DimensionT(Interaction_ID),
    Ancillary_Service_ID NUMBER REFERENCES Ancillary_Service_DimensionT(Ancillary_Service_Key),
    Main_Service_Key NUMBER REFERENCES Main_Service_DimensionT(Main_Service_Key),
    Status VARCHAR2(50),
    Comments CLOB
);

-- Flight Ancillary Points Fact
-- DONE
CREATE TABLE Flight_Ancillary_Points_FactT (
    Passenger_Key NUMBER REFERENCES Passenger_DimensionT(Passenger_Key),
    Passenger_profile_Key NUMBER REFERENCES Passenger_Profile_DimT(Passenger_Profile_Key),
    Ancillary_Service_Key NUMBER REFERENCES Ancillary_Service_DimensionT(Ancillary_Service_Key),
    Transaction_Date_Key NUMBER, --REFERENCES Date_DimensionT(Date_Key),
    Payment_Method_Key NUMBER REFERENCES Payment_Method_DimT(Payment_Method_Key),
    Ticket_Number VARCHAR2(50),
    Transaction_Type VARCHAR2(50),
    No_of_Points NUMBER,
    Ancillary _Service_Cost NUMBER(10, 2)
);

-- Partner Points Fact
-- DONE
CREATE TABLE Partner_Points_FactT (
    Passenger_Key NUMBER REFERENCES Passenger_DimensionT(Passenger_Key),
    Passenger_profile_Key NUMBER REFERENCES Passenger_Profile_DimT(Passenger_Profile_Key),
    Partner_Service_Key NUMBER REFERENCES Partner_Service_DimensionT(Partner_Service_Key),
    Transaction_Date_Key NUMBER, --REFERENCES Date_DimensionT(Date_Key),
    Payment_Method_Key NUMBER REFERENCES Payment_Method_DimT(Payment_Method_Key),
    Transaction_ID VARCHAR2(50),
    Transaction_Type VARCHAR2(50),
    No_of_Points NUMBER,
    Partner_Service_Cost NUMBER(10, 2)
);



CREATE TABLE Issued_Ticket_FactT (
    Reservation_ID VARCHAR2(20), -- Degenerate Dimension
    Flight_ID VARCHAR2(20), -- Degenerate Dimension
    Ticket_No VARCHAR2(20), --Degenerate Dimiension
    Passenger_key Number REFERENCES PASSENGER_DIMENSIONT(Passenger_key),
    Ticket_Issue_Date_Key NUMBER REFERENCES Date_DimensionT(Date_Key),
    Departure_Date_Key NUMBER REFERENCES Date_DimensionT(Date_Key),
    Arrival_Date_Key NUMBER REFERENCES Date_DimensionT(Date_Key),
    Booking_Class_of_service_key NUMBER REFERENCES Class_Of_Service_Flown_DimT(Class_of_service_key),
    Fare_basis_key VARCHAR2(50) REFERENCES Fare_Basis_DimensionT(Fare_Basis_Key),
    Ticketing_channel_key  VARCHAR2(50) REFERENCES BOOKING_CHANNEL_DIMENSIONT(Booking_Channel_key),
    Payment_Method_Key NUMBER REFERENCES Payment_Method_DimT(Payment_Method_Key),
    Ticketing_Status VARCHAR2(20),
    Ticket_price Number,
    Seat_Number VARCHAR2(10)
);