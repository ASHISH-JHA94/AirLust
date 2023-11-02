create database airline_db;
use airline_db;

create table airline(
    airline_id int primary key,
    airline_name varchar(32),
    iata_code varchar(4),
    icao_code varchar(4)
);

create table flights(
    flight_id int primary key,
    airline_id int,
    departure_icao varchar(4),
    arrival_icao varchar(4),
    departure_dt timestamp,
    arrival_dt timestamp,
    flight_name varchar(16),
    flight_status varchar(16),
    foreign key (airline_id) references airline(airline_id)
);

create table passengers(
    passenger_id int primary key,
    first_name varchar(16),
    last_name varchar(16),
    email varchar(64),
    phone varchar(10),
    dob date
);

create table bookings(
    booking_id int primary key,
    flight_id int,
    passenger_id int,
    booking_dt timestamp,
    booking_status varchar(16),
    foreign key (flight_id) references flights(flight_id),
    foreign key (passenger_id) references passengers(passenger_id)
);

create table transactions(
    transaction_id int primary key,
    booking_id int,
    amount float,
    payment_method varchar(16),
    transaction_dt timestamp,
    transaction_status varchar(16),
    foreign key (booking_id) references bookings(booking_id)
);

create table airports(
    airport_id int primary key,
    iata_code varchar(4),
    airport_name varchar(128),
    icao_code varchar(4)
);

create table seats(
    seat_id int primary key,
    flight_id int,
    seat_number int,
    seat_status int,
    seat_class varchar(16),
    foreign key (flight_id) references flights(flight_id)
);

-- insert into airports
INSERT INTO airports VALUES (1,'JFK','John F. Kennedy International Airport','KJFK');
INSERT INTO airports VALUES (2,'LAX','Los Angeles International Airport','KLAX');
INSERT INTO airports VALUES (3,'ORD','Chicago O Hare International Airport','KORD');
INSERT INTO airports VALUES (4,'ATL','Hartsfield-Jackson Atlanta International Airport','KATL');
INSERT INTO airports VALUES (5,'SFO','San Francisco International Airport','KSFO');
INSERT INTO airports VALUES (6,'LHR','London Heathrow Airport','EGLL');
INSERT INTO airports VALUES (7,'CDG','Charles de Gaulle Airport','LFPG');
INSERT INTO airports VALUES (8,'FRA','Frankfurt Airport','EDDF');
INSERT INTO airports VALUES (9,'AMS','Amsterdam Airport Schiphol','EHAM');
INSERT INTO airports VALUES (10,'BCN','Barcelona-El Prat Airport','LEBL');
INSERT INTO airports VALUES (11,'HND','Haneda Airport','RJTT');
INSERT INTO airports VALUES (12,'PEK','Beijing Capital International Airport','ZBAA');
INSERT INTO airports VALUES (13,'ICN','Incheon International Airport','RKSI');
INSERT INTO airports VALUES (14,'SIN','Singapore Changi Airport','WSSS');
INSERT INTO airports VALUES (15,'BKK','Suvarnabhumi Airport','VTBS');
INSERT INTO airports VALUES (16,'HKG','Hong Kong International Airport','VHHH');
INSERT INTO airports VALUES (17,'DXB','Dubai International Airport','OMDB');
INSERT INTO airports VALUES (18,'KUL','Kuala Lumpur International Airport','WMKK');
INSERT INTO airports VALUES (19,'IST','Istanbul Airport','LTFM');
INSERT INTO airports VALUES (20,'TPE','Taiwan Taoyuan International Airport','RCTP');
INSERT INTO airports VALUES (21,'DEL','Indira Gandhi International Airport','VIDP');
INSERT INTO airports VALUES (22,'BOM','Chhatrapati Shivaji Maharaj International Airport','VABB');
INSERT INTO airports VALUES (23,'MAA','Chennai International Airport','VOMM');
INSERT INTO airports VALUES (24,'HYD','Rajiv Gandhi International Airport','VOHS');
INSERT INTO airports VALUES (25,'BLR','Kempegowda International Airport','VOBL');
INSERT INTO airports VALUES (26,'CCU','Netaji Subhas Chandra Bose International Airport','VECC');
INSERT INTO airports VALUES (27,'COK','Cochin International Airport','VOCI');
INSERT INTO airports VALUES (28,'IXC','Shaheed Bhagat Singh International Airport','VICG');
INSERT INTO airports VALUES (29,'GOI','Dabolim Airport','VOGO');
INSERT INTO airports VALUES (30,'JAI','Jaipur International Airport','VIJP');
INSERT INTO airports VALUES (31,'ATQ','Sri Guru Ram Dass Jee International Airport','VIAR');
INSERT INTO airports VALUES (32,'AMD','Sardar Vallabhbhai Patel International Airport','VAAH');
INSERT INTO airports VALUES (33,'VNS','Lal Bahadur Shastri International Airport','VEBN');
INSERT INTO airports VALUES (34,'NAG','Dr. Babasaheb Ambedkar International Airport','VANP');
INSERT INTO airports VALUES (35,'IXR','Birsa Munda Airport','VERC');
INSERT INTO airports VALUES (36,'LKO','Chaudhary Charan Singh International Airport','VILK');
INSERT INTO airports VALUES (37,'BDQ','Vadodara Airport','VABO');
INSERT INTO airports VALUES (38,'RPR','Swami Vivekananda Airport','VARP');
INSERT INTO airports VALUES (39,'RJA','Rajahmundry Airport','VORY');
INSERT INTO airports VALUES (40,'IXM','Madurai Airport','VOMD');
INSERT INTO airports VALUES (41,'TRV','Trivandrum International Airport','VOTV');
INSERT INTO airports VALUES (42,'BBI','Biju Patnaik International Airport','VEBS');
INSERT INTO airports VALUES (43,'IXU','Aurangabad Airport','VAAU');
INSERT INTO airports VALUES (44,'STV','Surat International Airport','VASU');
INSERT INTO airports VALUES (45,'HSR','Rajkot International Airport','VAHS');
INSERT INTO airports VALUES (46,'TRZ','Tiruchirapalli International Airport','VOTR');
INSERT INTO airports VALUES (47,'CCJ','Calicut International Airport','VOCL');
INSERT INTO airports VALUES (48,'IXJ','Jammu Airport','VIJU');
INSERT INTO airports VALUES (49,'IXB','Bagdogra International Airport','VEBD');
INSERT INTO airports VALUES (50,'IXY','Kandla Airport','VAKE');
INSERT INTO airports VALUES (51,'GAU','Lokpriya Gopinath Bordoloi International Airport','VEGT');
INSERT INTO airports VALUES (52,'CJB','Coimbatore International Airport','VOCB');
INSERT INTO airports VALUES (53,'HBX','Hubli Airport','VOHB');
INSERT INTO airports VALUES (54,'IXP','Pathankot Airport','VIPK');
INSERT INTO airports VALUES (55,'IXG','Belgavi Airport','VOBM');
INSERT INTO airports VALUES (56,'PAT','Jay Prakash Narayan International Airport','VEPT');
INSERT INTO airports VALUES (57,'JLR','Jabalpur Airport','VAJB');
INSERT INTO airports VALUES (58,'GAY','Gaya Airport','VEGY');
INSERT INTO airports VALUES (59,'IXA','Maharaja Bir Bikram Airport','VEAT');
INSERT INTO airports VALUES (60,'ISK','Nashik Airport','VAOZ');
--^

--insert into airline
INSERT INTO airline VALUES (1,'IndiGo','6E','IGO');
INSERT INTO airline VALUES (2,'Air India','AI','AIC');
INSERT INTO airline VALUES (3,'SpiceJet','SG','SEJ');
INSERT INTO airline VALUES (4,'Go First','G8','GOW');
INSERT INTO airline VALUES (5,'Vistara','UK','VTI');
INSERT INTO airline VALUES (6,'Akasa Air','QP','AKJ');
INSERT INTO airline VALUES (7,'Emirates','EK','UAE');
INSERT INTO airline VALUES (8,'British Airways','BA','BAW');
INSERT INTO airline VALUES (9,'Lufthansa','LH','DLH');
INSERT INTO airline VALUES (10,'Singapore Airlines','SQ','SIA');
--^

--insert into flights
INSERT INTO flights VALUES (1,1,'VIDP','LTFM','2023-10-30 08:00:00','2023-10-30 12:00:00','6E 11','SCHEDULED');
INSERT INTO flights VALUES (2,1,'VIDP','OMDB','2023-10-30 09:30:00','2023-10-30 12:30:00','6E 25','SCHEDULED');
INSERT INTO flights VALUES (3,1,'VABB','LTFM','2023-10-30 10:45:00','2023-10-30 13:45:00','6E 15','DELAYED');
INSERT INTO flights VALUES (4,1,'VABB','OMDB','2023-10-30 08:00:00','2023-10-30 12:00:00','6E 65','SCHEDULED');
INSERT INTO flights VALUES (5,1,'VOMM','WSSS','2023-10-30 10:45:00','2023-10-30 13:45:00','6E 57','SCHEDULED');
INSERT INTO flights VALUES (6,1,'VECC','VTBS','2023-10-30 08:00:00','2023-10-30 12:00:00','6E 77','SCHEDULED');
INSERT INTO flights VALUES (7,2,'VIDP','KJFK','2023-10-30 08:00:00','2023-10-30 12:00:00','AI 101','DELAYED');
INSERT INTO flights VALUES (8,2,'VIDP','KORD','2023-10-30 09:30:00','2023-10-30 12:30:00','AI 127','SCHEDULED');
INSERT INTO flights VALUES (9,2,'VIDP','EGLL','2023-10-30 10:45:00','2023-10-30 13:45:00','AI 161','SCHEDULED');
INSERT INTO flights VALUES (10,2,'VIDP','KSFO','2023-10-30 08:00:00','2023-10-30 12:00:00','AI 173','SCHEDULED');
INSERT INTO flights VALUES (11,2,'VIDP','VTBS','2023-10-30 10:45:00','2023-10-30 13:45:00','AI 333','SCHEDULED');
INSERT INTO flights VALUES (12,2,'VOBL','KSFO','2023-10-30 08:00:00','2023-10-30 12:00:00','AI 175','SCHEDULED');
INSERT INTO flights VALUES (13,2,'VABB','KJFK','2023-10-30 08:00:00','2023-10-30 12:00:00','AI 191','DELAYED');
INSERT INTO flights VALUES (14,3,'VIDP','OMDB','2023-10-30 09:30:00','2023-10-30 12:30:00','SG 17','SCHEDULED');
INSERT INTO flights VALUES (15,3,'VABB','OMDB','2023-10-30 10:45:00','2023-10-30 13:45:00','SG 19','SCHEDULED');
INSERT INTO flights VALUES (16,7,'VIDP','OMDB','2023-10-30 08:00:00','2023-10-30 12:00:00','EK 516','CANCELLED');
INSERT INTO flights VALUES (17,8,'VABB','EGLL','2023-10-30 10:45:00','2023-10-30 13:45:00','BA 142','SCHEDULED');
INSERT INTO flights VALUES (18,9,'VIDP','EDDF','2023-10-30 08:00:00','2023-10-30 12:00:00','LH 763','CANCELLED');
INSERT INTO flights VALUES (19,10,'VABB','WSSS','2023-10-30 10:45:00','2023-10-30 13:45:00','SQ 403','SCHEDULED');
INSERT INTO flights VALUES (20,10,'VIDP','WSSS','2023-10-30 08:00:00','2023-10-30 12:00:00','SQ 423','SCHEDULED');
INSERT INTO flights VALUES (21,1,'VIDP','VABB','2023-10-29 06:30:00','2023-10-29 08:45:00','6E 23','DELAYED');
INSERT INTO flights VALUES (22,1,'VOMM','VOHS','2023-10-29 09:15:00','2023-10-29 10:55:00','6E 41','SCHEDULED');
INSERT INTO flights VALUES (23,1,'VOHS','VOBL','2023-10-29 11:45:00','2023-10-29 13:05:00','6E 65','SCHEDULED');
INSERT INTO flights VALUES (24,1,'VECC','VOCI','2023-10-29 14:15:00','2023-10-29 16:55:00','6E 87','SCHEDULED');
INSERT INTO flights VALUES (25,1,'VICG','VIJP','2023-10-29 17:30:00','2023-10-29 18:50:00','6E 101','SCHEDULED');
INSERT INTO flights VALUES (26,2,'VAAH','VEBN','2023-10-30 07:00:00','2023-10-30 08:40:00','AI 11','SCHEDULED');
INSERT INTO flights VALUES (27,2,'VEBN','VILK','2023-10-30 09:20:00','2023-10-30 11:00:00','AI 23','DELAYED');
INSERT INTO flights VALUES (28,2,'VABB','VECC','2023-10-30 06:00:00','2023-10-30 08:40:00','AI 675','SCHEDULED');
INSERT INTO flights VALUES (29,2,'VIDP','VABB','2023-10-30 07:00:00','2023-10-30 09:15:00','AI 887','SCHEDULED');
INSERT INTO flights VALUES (30,2,'VABO','VAJB','2023-10-30 18:15:00','2023-10-30 19:55:00','AI 59','SCHEDULED');
INSERT INTO flights VALUES (31,3,'VOCI','VECC','2023-10-29 07:00:00','2023-10-29 09:30:00','SG 11','SCHEDULED');
INSERT INTO flights VALUES (32,3,'VECC','VOMM','2023-10-29 10:15:00','2023-10-29 12:45:00','SG 23','CANCELLED');
INSERT INTO flights VALUES (33,3,'VOMM','VOHS','2023-10-29 13:30:00','2023-10-29 15:00:00','SG 35','SCHEDULED');
INSERT INTO flights VALUES (34,3,'VOHS','VOBL','2023-10-29 16:00:00','2023-10-29 17:30:00','SG 47','DELAYED');
INSERT INTO flights VALUES (35,3,'VOBL','VOTR','2023-10-29 18:15:00','2023-10-29 19:45:00','SG 59','SCHEDULED');
INSERT INTO flights VALUES (36,4,'VAAU','VABO','2023-10-30 06:45:00','2023-10-30 08:15:00','G8 11','SCHEDULED');
INSERT INTO flights VALUES (37,4,'VABO','VAJB','2023-10-30 09:00:00','2023-10-30 10:30:00','G8 23','SCHEDULED');
INSERT INTO flights VALUES (38,4,'VAJB','VERC','2023-10-30 11:15:00','2023-10-30 12:45:00','G8 35','DELAYED');
INSERT INTO flights VALUES (39,4,'VERC','VEGY','2023-10-30 13:30:00','2023-10-30 15:00:00','G8 47','SCHEDULED');
INSERT INTO flights VALUES (40,4,'VEGY','VEAT','2023-10-30 16:15:00','2023-10-30 17:45:00','G8 59','SCHEDULED');
INSERT INTO flights VALUES (41,5,'VIJP','VOTV','2023-10-29 08:00:00','2023-10-29 10:30:00','UK 11','DELAYED');
INSERT INTO flights VALUES (42,5,'VOTV','VOCB','2023-10-29 11:15:00','2023-10-29 13:15:00','UK 23','SCHEDULED');
INSERT INTO flights VALUES (43,5,'VOCB','VEGT','2023-10-29 14:00:00','2023-10-29 16:00:00','UK 35','SCHEDULED');
INSERT INTO flights VALUES (44,5,'VEGT','VEBS','2023-10-29 16:45:00','2023-10-29 18:45:00','UK 47','CANCELLED');
INSERT INTO flights VALUES (45,5,'VEBS','VIAR','2023-10-29 19:30:00','2023-10-29 21:30:00','UK 59','SCHEDULED');
INSERT INTO flights VALUES (46,6,'VIAR','VICG','2023-10-30 07:30:00','2023-10-30 09:30:00','QP 11','SCHEDULED');
INSERT INTO flights VALUES (47,6,'VICG','VORY','2023-10-30 10:15:00','2023-10-30 12:15:00','QP 23','SCHEDULED');
INSERT INTO flights VALUES (48,6,'VORY','VOGO','2023-10-30 13:00:00','2023-10-30 15:00:00','QP 35','DELAYED');
INSERT INTO flights VALUES (49,6,'VOGO','VOHB','2023-10-30 15:45:00','2023-10-30 17:45:00','QP 47','SCHEDULED');
INSERT INTO flights VALUES (50,6,'VOHB','VAOZ','2023-10-30 18:30:00','2023-10-30 20:30:00','QP 59','SCHEDULED');
--^

-- insert into seats table
DELIMITER//
CREATE PROCEDURE insert_seat_record()
BEGIN
    DECLARE seat_number_val INT;
    DECLARE max_seat_number INT;
    DECLARE seat_id_val INT;
    DECLARE seat_class_val VARCHAR(16);
    
    SET seat_number_val = 1;
    SET seat_id_val = 1;
    SET max_seat_number = 150;

    WHILE seat_id_val <= 7500 DO 
		IF seat_number_val <= 50 THEN
			SET seat_class_val = 'BUSINESS';
		ELSE 
			SET seat_class_val = 'ECONOMY';
		END IF;
        
        INSERT INTO seats (flight_id, seat_number, seat_status, seat_class)
        VALUES (1, seat_number_val, 'AVAILABLE', seat_class_val);

        
        SET seat_number_val = seat_number_val + 1;
        IF seat_number_val > max_seat_number THEN
            SET seat_number_val = 1;
        END IF;
        SET seat_id_val=seat_id_val+1;
    END WHILE;
END;
//
DELIMITER;
UPDATE seats SET flight_id = CEIL(seat_id / 150);
-- ^ necessary

-- leave the rest empty since they depend on the user's actions
