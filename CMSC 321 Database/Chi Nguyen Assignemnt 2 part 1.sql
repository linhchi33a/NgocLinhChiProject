CREATE TABLE SEAT_RESERVATION(
	 Flight_number VARCHAR(20) NOT NULL,
     Leg_number VARCHAR(20) NOT NULL,
     Date_res DATE NOT NULL,	
     Seat_number INT(4) NOT NULL,
     Customer_name VARCHAR(255),
     Customer_phone INT(10),
     PRIMARY KEY(Flight_number,Leg_number,Date_res,Seat_number)
);

CREATE TABLE FARE(
	 Flight_number VARCHAR(20) NOT NULL,
     Fare_code VARCHAR(20) NOT NULL,
     Amount INT(10),
     Restrictions VARCHAR(255),
     PRIMARY KEY(Flight_number,Fare_code)
);

CREATE TABLE AIRPORT(
	Airport_code VARCHAR(20) NOT NULL,
    name_airport VARCHAR(255),
    City VARCHAR(255),
    State VARCHAR(255),
    PRIMARY KEY(Airport_code)
);

CREATE TABLE AIRPLANE_TYPE(
	Airplane_type_name VARCHAR(255) NOT NULL,
    Max_seats INT(4),
    Company VARCHAR(255),
    PRIMARY KEY(Airplane_type_name)
);

CREATE TABLE CAN_LAND(
	Airplane_type_name VARCHAR(255) NOT NULL,
    Airport_code VARCHAR(20) NOT NULL,
	PRIMARY KEY(Airplane_type_name,Airport_code),
    FOREIGN KEY (Airport_code) REFERENCES AIRPORT(Airport_code)
    ON UPDATE CASCADE
	ON DELETE CASCADE,
    FOREIGN KEY (Airplane_type_name) REFERENCES AIRPLANE_TYPE(Airplane_type_name)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE FLIGHT_LEG(
	 Flight_number VARCHAR(20) NOT NULL,
     Leg_number VARCHAR(20) NOT NULL,
     Departure_airport_code VARCHAR(20),
     Scheduled_departure_time DATETIME,
     Arrival_airport_code VARCHAR(20),
     Scheduled_arrival_time DATETIME,
     PRIMARY KEY(Flight_number,Leg_number),
     FOREIGN KEY (Departure_airport_code) REFERENCES AIRPORT(Airport_code)
	 ON UPDATE CASCADE
	 ON DELETE CASCADE,
     FOREIGN KEY (Arrival_airport_code) REFERENCES AIRPORT(Airport_code)
	 ON UPDATE CASCADE
	 ON DELETE CASCADE
);

CREATE TABLE AIRPLANE(
	Airplane_id VARCHAR(20) NOT NULL,
	Total_number_of_seats INT(4),
	Airplane_type VARCHAR(255),
    PRIMARY KEY(Airplane_id),
    FOREIGN KEY (Airplane_type) REFERENCES AIRPLANE_TYPE(Airplane_type_name)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (Airplane_type) REFERENCES CAN_LAND(Airplane_type_name)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE LEG_INSTANCE(
	 Flight_number VARCHAR(20) NOT NULL,
     Leg_number VARCHAR(20) NOT NULL,
     Date_leg DATE,
     Number_of_available_seats INT(4),
     Airplane_id VARCHAR(20),
     Departure_airport_code VARCHAR(20),
     Departure_time DATETIME,
     Arrival_airport_code VARCHAR(20),
     Arrival_time DATETIME,
     PRIMARY KEY(Flight_number,Leg_number),
     FOREIGN KEY (Departure_airport_code,Arrival_airport_code) REFERENCES AIRPORT(Airport_code)
	 ON UPDATE CASCADE
	 ON DELETE CASCADE,
     FOREIGN KEY (Leg_number) REFERENCES FLIGHT_LEG(Leg_number)
	 ON UPDATE CASCADE
	 ON DELETE CASCADE,
	 FOREIGN KEY (Airplane_id) REFERENCES AIRPLANE(Airplane_id)
	 ON UPDATE CASCADE
	 ON DELETE CASCADE
);
CREATE TABLE FLIGHT(
	Flight_number VARCHAR(20) NOT NULL,
    Airline VARCHAR(255),
    Weekdays DATE,
    PRIMARY KEY(Flight_number),
	FOREIGN KEY (Airline) REFERENCES AIRPLANE_TYPE(Airplane_type_name)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (Weekdays) REFERENCES SEAT_RESERVATION(Date_res)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (Weekdays) REFERENCES LEG_INSTANCE(Date_leg)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);