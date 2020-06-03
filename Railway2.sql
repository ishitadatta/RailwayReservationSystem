USE RAILWAY ;

create table if not exists USER(user_id varchar(50) primary key,
first_name varchar(50) not null,
last_name varchar(50)not null,
aadhar_no varchar(20),
aadhar_no varchar(50) default null,
gender char not null,
age int not null,
mobile_no varchar(12) not null,
email varchar(50) not null,
city varchar(50) default 'Others',
state varchar(50) not null,
pincode varchar(20) not null,
_password varchar(50) not null,
security_ques varchar(50),
security_ans varchar(50));

select* from user;

alter table user
modify aadhar_no varchar(50) default null;

create table if not exists TRAIN(train_num varchar(50) primary key,
train_name varchar(50),
arrival_time time not null,
departure_time time not null,
availablity_of_seats char,
date date);

create table if not exists STATION(station_no varchar(50) not null,
name varchar(50) not null,
hault varchar(50),
arrival_time time,
train_no varchar(50) not null,
primary key(station_no, train_no), 
constraint foreign key(train_no) references TRAIN(train_num));

alter table station modify train_no int after arrival_time;
select* from station;

create table if not exists TRAIN_STATUS(train_no varchar(50) primary key,
b_seats1 int null,
b_seats2 int null,
a_seats1 int null,
a_seats2 int null,
w_seats1 int null,
w_seats2 int null,
fare1 float null,
fare2 float null);

create table if not exists TICKET(id varchar(50) primary key,
user_id varchar(50) not null,
status char not null,
no_of_passengers int not null,
train_no varchar(50) not null, 
constraint foreign key(user_id) references USER(user_id),
constraint foreign key(train_no) references TRAIN(train_num));

select* from passenger;

ALTER TABLE train_status
modify fare2 float null;

create table if not exists PASSENGER(passenger_id varchar(50) not null primary key,
pnr_no int not null,
age int null,
check(age>=5),
gender char not null,
user_id varchar(50) not null,
reservation_status char null,
seat_number varchar(5) not null,
name varchar(50) not null,
ticket_id varchar(50) not null,
constraint foreign key(user_id) references USER(user_id),
constraint foreign key(ticket_id) references TICKET(id));

alter table passenger
drop foreign key user_id;

create table if not exists STARTS(train_no varchar(50),
station_no varchar(50) not null,
primary key(station_no, train_no),
constraint foreign key(train_no) references TRAIN(train_num),
constraint foreign key(station_no) references STATION(station_no));

create table if not exists STOPS_AT(train_no varchar(50),
station_no varchar(50) not null,
constraint foreign key(train_no) references TRAIN(train_num),
constraint foreign key(station_no) references STATION(station_no));

create table if not exists CANCEL(user_id varchar(50),
id varchar(50) not null,
passenger_id varchar(50) not null,
constraint foreign key(id) references TICKET(id),
constraint foreign key(user_id) references USER(user_id));

create table if not exists REACHES(train_no varchar(50),
station_no varchar(50) not null,
time time,
constraint foreign key(train_no) references TRAIN(train_num),
constraint foreign key(station_no) references STATION(station_no));

create table if not exists BOOK(user_id varchar(50) not null,
id varchar(50) not null,
constraint foreign key(user_id) references USER(user_id),
constraint foreign key(id) references TICKET(id));


insert into USER values('1701', 'Vijay' ,'Sharma','309887340843','M',34,'9887786655','vijay1@gmail.com','Kolkata','West Bengal','700106','12345@#','favourite colour','red');
insert into USER values(1702,'Rohit','Kumar','456709871234','M',45,'9809666555','rohit1kumar@gmail.com','Kolkata','West Bengal','700004','12@#345','favourite bike','bmw');
insert into USER values(1703,'Manaswi','Sree','765843210987','F',20,'9995550666','manasvi27@gmail.com','Kolkata','West Bengal','700004','0987hii','favourite flower','rose');
insert into USER values(1704,'Sneha','Agarwal','349043930952','F',19,'9492584628','sneha2000@gmail.com','Bangalore','Karnataka','5600102','0123pwm','favourite food','pizza');
insert into USER values(1705,'Rohit','Jain','495843210861','M',26,'9836700666','rohitjain@gmail.com','Bangalore','Karnataka','5600023','pwis098','favourite place','disneyland');

select* from user;
insert into TRAIN values(12711,'Shatabdi Exp','113000','114000','A',20200410);
insert into Train values(12315,'Commandel Exp','124500','125000','B',20200410);
insert into train values(12948,'Bangalore Exp','093000','101500','A',2020607);
insert into train values(12923,'Kengeri Exp','041000','083000','A',20200508);
insert into train values(12645,'Bengal Exp','093000','121500','A',20200912);

insert into station values(111,'Sealdah',10,'113000',12711);
insert into STATION values(222,'Tirupathi',5,'114500',12315);
insert into STATION values(333,'Malleshwaram',10,'121500',12923);
insert into STATION values(444,'Banasawadi',15,'093000',12948);
insert into STATION values(555,'Howrah',10,'093000',12645);

UPDATE train
SET date = 20200410
WHERE train_num = 12315;

SET SQL_SAFE_UPDATES = 0;

select* from STATION;
insert into TRAIN_STATUS values(12711,10,4,1,1,1,0,100,450);
insert into TRAIN_STATUS values(12315,10,5,0,0,2,1,300,600);
insert into TRAIN_STATUS values(12923,5,10,5,0,4,1,150,700);
insert into TRAIN_STATUS values(12948,10,15,2,1,3,0,200,800);
insert into TRAIN_STATUS values(12645,5,11,3,1,3,1,100,650);

UPDATE train_status
SET a_seats1 = 2
WHERE train_no = 12948;


insert into TICKET values(4001,1701,'C',1,12711);
insert into TICKET values(4002,1702,'W',1,12315);
insert into TICKET values(4003,1703,'C',2,12923);
insert into TICKET values(4004,1704,'C',1,12948);
insert into TICKET values(4005,1705,'C',1,12645);
select* from passenger;

insert into PASSENGER values(5001,78965,45,'M',1701,'C','B6-45','Ramesh',4001);
insert into PASSENGER values(5002,54523,54,'F',1701,'W','B3-21','Surekha',4002);
insert into PASSENGER values(5003,87654,42,'M',1702,'C','C6-11','Rohit',4003);
insert into PASSENGER values(5004,29873,19,'F',1704,'C','C6-11','Sneha',4004);
insert into PASSENGER values(5005,35827,26,'M',1705,'C','C6-11','Rohit',4005);

insert into STARTS values(12711,111);
insert into STARTS values(12315,222);
insert into STARTS values(12948,333);
insert into STARTS values(12923,444);
insert into STARTS values(12645,555);

insert into STOPS_AT values(12711,555);
insert into STOPS_AT values(12315,333);
insert into STOPS_AT values(12645,222);
insert into STOPS_AT values(12948,444);
insert into STOPS_AT values(12923,222);

insert into REACHES values(12711,222,040000);
insert into REACHES values(12315,444,053500);
insert into REACHES values(12645,111,093000);
insert into REACHES values(12948,222,093000);
insert into REACHES values(12923,333,041000);

insert into BOOK values(1701,4001);
insert into BOOK values(1702,4002);
insert into BOOK values(1703,4003);
insert into BOOK values(1704,4004);
insert into BOOK values(1705,4005);

insert into CANCEL values(1701,4001,5001);

select* from cancel;

/*Display the immediate train to Tirupathi having atleast 5 available in GENERAL class*/
SELECT DISTINCT T.*
FROM TRAIN T, STATION S, stops_at R
WHERE R.station_no = (SELECT station_no
					  FROM STATION
                      WHERE name = 'Tirupathi' )
	AND T.train_num=(SELECT train_no
				   FROM TRAIN_status
				   WHERE a_seats1 >= 5 )
order by date;

/* Aggregate queries */

/*Display the average,minimum, maximum fare of all trains of GENERAL and AC class 
that have available seats*/

SELECT avg(S.fare1) as Average_fare_General,
       avg(S.fare2) as Average_fare_AC,
	   min(S.fare1) as Minimum_General,
       min(S.fare2) as Minimum_AC,
	   max(S.fare1) as Maximum_General,
	   max(S.fare2) as Maximum_AC 
FROM railway.Train as T,
     railway.train_status as S
where T.train_num = S.train_no and T.availablity_of_seats  = 'A'
order by 2 desc;

/*Display the first name, last name, username, age, gender and the train they have booked in the
General class if their fare is higher than the average fare*/
SELECT U.first_name as First_Name, 
       U.last_name as Last_Name, 
	   U.user_id as Username, 
       U.age as Age, 
	   U.gender as Gender,
	   R.train_name as Train,
       S.fare1 as General
FROM railway.User as U,
     railway.TICKET as T,
     railway.TRAIN as R,
     railway.Train_Status as S,
	 (SELECT avg(S2.fare1) as Avg_fare
      FROM railway.train_status as S2) as P
WHERE U.user_id = T.user_id and 
      T.train_no = R.train_num and
      R.train_num = S.train_no and
      S.fare1 > P.Avg_fare
ORDER BY U.age desc;
      
/* Retrieve the name, age, gender of each user who is also a passenger*/
   
SELECT P.name, P.age, P.gender, P.reservation_status
FROM   railway.passenger AS P
WHERE P.user_id IN ( SELECT U.user_id   
                 FROM railway.User AS U   
				 WHERE P.name = U.first_name ); 

SELECT U.first_name,U.last_name, U.age, U.gender
FROM   railway.user AS U
WHERE Exists ( SELECT * 
                 FROM railway.Passenger AS P 
				 WHERE P.user_id = U.user_id and P.name = U.first_name ); 

/*List the name, passenger id, user id of a passenger having a cancelled ticket*/

SELECT name, passenger_id, user_id, ticket_id
FROM Passenger a
WHERE EXISTS( SELECT passenger_id
			 FROM Cancel b
			 WHERE b.passenger_id = a.passenger_id);

/*List the details of a user having a cancelled ticket*/

SELECT DISTINCT*
FROM User A, Cancel B
WHERE EXISTS ( SELECT passenger_id FROM Cancel B
               WHERE A.user_id = B.user_id )  
               AND Exists ( SELECT DISTINCT passenger_id
							FROM Passenger C
							WHERE B.passenger_id = C.passenger_id);
                            
/* Select each USER such that there does not exist a ticket having a ticket id of 4006
 that the USER does not book.*/                 
/*SELECT first_name, last_name
FROM USER
WHERE NOT EXISTS ( SELECT * FROM BOOK B     
					WHERE( B.id IN (SELECT id
									   FROM Ticket     
                                       WHERE id = 4001 )     
							AND   
                            NOT EXISTS( SELECT *       
										  FROM BOOK C  
										  WHERE C.user_id = user_id
										  AND C.id = B.id ))); */
/*6.	Display the train name, train number, and the time of arrival and departure of the
 trains whose final destination is at station 222 */
                                          
SELECT train_name, train_num, arrival_time, departure_time
FROM TRAIN
WHERE EXISTS ( SELECT * FROM Reaches B     
					WHERE( B.station_no IN (SELECT station_no
									   FROM STATION   
                                       WHERE station_no = 222 )     
							AND   
                            EXISTS( SELECT *       
										  FROM REACHES C  
										  WHERE C.train_no = train_num
										  AND C.station_no = B.station_no ))); 
                                          
                                          
/*OUTER JOIN*/
 /*SELECT U.TRAIN_NO AS Train_no,  
        S.fare1 AS Fare
FROM (TRAIN_STATUS AS U LEFT OUTER JOIN TRAIN_STATUS AS S 
      ON U.a_seats1 = S.w_seats1);*/

SELECT T.train_num, T.train_name, S.name as Station_name, S.station_no, S.hault as Hault_minutes
FROM  TRAIN AS T LEFT OUTER JOIN STATION AS S
		ON  T.train_num = S.train_no
ORDER BY S.station_no desc;

SELECT T.status, T.train_no, P.pnr_no, P.Seat_number, P.age,P.gender 
FROM  TICKET AS T 
RIGHT OUTER JOIN PASSENGER AS P
ON  T.id = P.ticket_id
ORDER BY P.age desc;
                       
SELECT id, train_name, name, age, seat_number, arrival_time, departure_time
FROM ( (TICKET JOIN TRAIN ON train_no = train_num)  
JOIN PASSENGER ON ticket_id = id) 
WHERE id = 4003;

SHOW TRIGGERS;

/*audit trail*/
CREATE TABLE train_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trainNumber INT DEFAULT NULL,
    passengers INT NOT NULL,
    action VARCHAR(50) DEFAULT NULL,
    passengrs INT DEFAULT NULL,
    beforestatus VARCHAR(50) DEFAULT NULL,
    afterstatus VARCHAR(50) DEFAULT NULL,
    changedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    coach_no VARCHAR(100) DEFAULT NULL,
    seats INT NOT NULL,
    name VARCHAR(100) DEFAULT NULL,
    email VARCHAR(255) DEFAULT NULL,
    birthDate DATE
);

ALTER TABLE train_audit RENAME COLUMN aftertrain_no TO afterstatus;

alter table train_AUDIT
modify afterstatus VARCHAR(100) DEFAULT NULL;

/*INSERT BEFORE*/
CREATE TABLE TrainCoachNums(
    totalSeats INT DEFAULT NULL
);

Delimiter $$
CREATE TRIGGER before_traincoaches_insert
BEFORE INSERT
ON Train_audit FOR EACH ROW
BEGIN
    DECLARE rowcount INT;
    
    SELECT COUNT(*) 
    INTO rowcount
    FROM TrainCoachNums;
    
    IF rowcount > 0 THEN
        UPDATE TrainCoachNums
        SET totalSeats = totalSeats + new.seats;
    ELSE
        INSERT INTO TrainCoachNums(totalSeats)
        VALUES(new.seats);
    END IF; 

END $$
DELIMITER ;

/*Testing insert before*/
INSERT INTO Train_audit(coach_no, seats)
VALUES('A1',40);
SELECT * FROM TrainCoachNums;

INSERT INTO Train_audit(coach_no, seats)
VALUES('B2',70);
SELECT * FROM TrainCoachNums;

INSERT INTO Train_audit(coach_no, seats)
VALUES('A1',40);
SELECT * FROM TrainCoachNums;


/*INSERT AFTER TRIGGER*/
CREATE TABLE  passen (
    id INT AUTO_INCREMENT,
    passengerId INT,
    address VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (id , passengerId)
);

drop table passengrs;
ALTER TABLE PASSENGRS
MODIFY ADDRESS VARCHAR(25) DEFAULT NULL;
DELIMITER $$

CREATE TRIGGER after_passengers_insert
AFTER INSERT
ON train_audit FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
        INSERT INTO passen(passengerId, address)
        VALUES(new.id,CONCAT('Hi ', NEW.email, ', please update your date of birth.'));
    END IF;
END$$

DELIMITER ;
/*TESTING INSERT AFTER*/
 
INSERT INTO train_audit(name, email, birthDate)
VALUES
    ( 'John Doe','john.doe@example.com', NULL),
    ('Jane Doe', 'jane.doe@example.com','2000-01-01');
SELECT * FROM train_audit;
SELECT * FROM passen;

/*update before*/
Delimiter $$
CREATE TRIGGER before_ticket_update 
BEFORE UPDATE ON TICKET
FOR EACH ROW 
BEGIN
	 INSERT INTO train_audit
	 SET action = 'update',
     trainNumber = OLD.train_no,
     passengers= OLD.no_of_passengers,
     changedat = NOW();
END $$
Delimiter;
     
/*Testing trigger before_ticket_update*/
UPDATE ticket
SET 
    no_of_passengers = 2
WHERE
    train_no = 12923;
    
SELECT * FROM train_audit;
SELECT* FROM TICKET;

/*UPDATE AFTER*/

Delimiter $$
CREATE TRIGGER after_ticket_update
AFTER UPDATE
ON TICKET FOR EACH ROW
BEGIN
	
    IF OLD.status <> new.status THEN
        INSERT INTO train_audit(passengers,beforestatus, afterstatus)
        VALUES(old.id, old.status, new.status);
    END IF;
END$$
DELIMITER ;
drop trigger after_ticket_update;
/*Testing trigger after_ticket_update*/
UPDATE Ticket
SET STATUS = 'W'
WHERE id = 4003;
SELECT * FROM train_audit;
SELECT* FROM Ticket;


/*DELETE BEFORE TRIGGER*/
CREATE TABLE TrainDel_audit (
    ticketNumber INT PRIMARY KEY,
    journeydate DATE DEFAULT NULL,
    fare DECIMAL(10,2) NOT NULL DEFAULT 0

);

INSERT INTO TrainDel_audit(ticketNumber,journeydate,fare)
VALUES
    (1002,'2020-06-01',50000),
    (1056,'2020-06-01',60000),
    (1076,'2020-06-01',70000);
    
CREATE TABLE FareArchives (
    id INT AUTO_INCREMENT,
    ticketNumber INT ,
    journeydate DATE NOT NULL,
    fare DECIMAL(12, 2 ) NOT NULL DEFAULT 0,
    deletedAt TIMESTAMP DEFAULT NOW(),
	PRIMARY KEY(id,ticketNumber)
);

DELIMITER $$
CREATE TRIGGER before_TrainDel_audit_delete
BEFORE DELETE
ON TrainDel_audit FOR EACH ROW
BEGIN
    INSERT INTO FareArchives(ticketNumber,journeydate,fare)
    VALUES(OLD.ticketNumber,OLD.journeydate,OLD.fare);
END$$ 
DELIMITER ;

/*TESTING DELETE BEFORE*/
DELETE FROM TrainDel_audit 
WHERE ticketNumber = 1002;
SELECT * FROM FareArchives;   
DELETE FROM TrainDel_audit;
SELECT * FROM FareArchives;


/*DELETE AFTER TRIGGER*/

CREATE TABLE  TrainDel_audit_after(
    ticketNumber INT PRIMARY KEY,
    fare DECIMAL(10,2) NOT NULL DEFAULT 0
);

INSERT INTO TrainDel_audit_after(ticketNumber,fare)
VALUES
    (1002,5000),
    (1056,7000),
    (1076,8000);
CREATE TABLE FareBudgets(
    total DECIMAL(15,2) NOT NULL
);
INSERT INTO FareBudgets(total)
SELECT SUM(fare) 
FROM TrainDel_audit_after;
SELECT * FROM FareBudgets;        

CREATE TRIGGER after_TrainDel_audit_delete
AFTER DELETE
ON TrainDel_audit_after FOR EACH ROW
UPDATE FareBudgets 
SET total = total - old.fare;

/*TESTING AFTER DELETE TRIGGER*/
DELETE FROM TrainDel_audit_after
WHERE ticketNumber = 1002;
SELECT * FROM FareBudgets;   
DELETE FROM TrainDel_audit_after;
SELECT * FROM FareBudgets;   
