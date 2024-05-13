-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                        -- ONE INDEX FOR ALL FKs -- 


CREATE INDEX idx_flight_activity_fact_fk_all ON Flight_Activity_FactT(
    Scheduled_Departure_Date_Key,
    Actual_Departure_Date_Key,
    Scheduled_Arrival_Date_Key,
    Actual_Arrival_Date_Key,
    Passenger_Key,
    Passenger_profile_Key,
    Start_Airport_Key,
    End_Airport_Key,
    Airplane_Key,
    Service_Class_Key,
    Fare_Basis_Key,
    Booking_Channel_Key
);


CREATE INDEX idx_reservation_fact_fk_all ON Reservation_FactT(
    Snapshot_Date_Key,
    Departure_Date_Key,
    Arrival_Date_Key
);


CREATE INDEX idx_customer_care_fact_fk_all ON Customer_Care_FactT(
    Leg_Start_Airport_Key,
    Leg_End_Airport_Key,
    Aircraft_Key,
    Interaction_Date_Key,
    Passenger_profile_Key,
    Passenger_Key,
    Interaction_ID,
    Ancillary_Service_ID,
    Main_Service_Key
);


CREATE INDEX idx_flight_ancillary_points_fact_fk_all ON Flight_Ancillary_Points_FactT(
    Passenger_Key,
    Passenger_profile_Key,
    Ancillary_Service_Key,
    Transaction_Date_Key,
    Payment_Method_Key
);


CREATE INDEX idx_partner_points_fact_fk_all ON Partner_Points_FactT(
    Passenger_Key,
    Passenger_profile_Key,
    Partner_Service_Key,
    Transaction_Date_Key,
    Payment_Method_Key
);
