# RailwayReservationSystem
A database management system using MySQL

 The Railway Reservation System facilitates the passengers to enquire about the trains available on the basis of source and destination, booking and cancellation of tickets, enquire about the status of the booked ticket, etc. The aim of the project is to design and develop a database maintaining the records of different trains, train status and passengers.     
This project contains an entity relationship model diagram based on a railway reservation system. There is also design of the database schema between different entities and their relationships. Notations used for the relationship constraints are using cardinality ratio and participation constraints. The triggers used in this project are created for: 
• Inserting (before and after) number of seats constraint in a Train Coach
• Updating (before and after) the train number constraint of the Ticket entity
• Deleting (before and after) the ticket number constraint as a separate audit trail      
Some of the queries made in this project involve finding out the minimum, maximum and average cost of the train fares of different train classes, some nested queries between the booking and cancellation of tickets and their correlation with the User and Passenger entities and join operation performed on the Ticket, Train and Passenger entities.This database for a Railway Reservation System provides us with all the details and different dependencies between the various entities in a Railway system with regard to trains, tickets, passengers, train stations, train date and timings, ticket fares, booking and cancellations.

Choice Of Keys

USER 
In the USER relation there is only one primary key that is the user_id. The address is a composite key. There are no composite primary keys nor does any of the entities have more than one key so there are no candidate keys. The entire relation is by default a superkey. 

PASSENGER
In the PASSENGER entity only one primary key is considered that is the passenger_id. A check constraint is applied to the PASSENGER’s age attribute for children who are below the age of 5 who do not have to pay train fare according to the Railway System rules.

TRAIN
In the TRAIN relation there is only 1 primary key that is the train_num.

TRAIN_STATUS
The TRAIN_STATUS entity is a weak entity type and the train_no here is the partial key. The relationship BOOKS is its identifying relation type. The train_status is identified by the train number and the specific train whose status details will be available in the TRAIN_STATUS entity.

STATION
In the STATION entity, the station_no and the train_no are candidate keys but since train_no is a referential integrity constraint station_no is chosen to be the primary key.

TICKET
In the TICKET entity only one primary key is considered that is the id. 

CANCEL
In the CANCEL relation all the keys are foreign keys. It is a 1:N binary relationship between Ticket and User where the participation of both is partial.

BOOK
In the BOOK relation both the attributes are foreign keys. Book is a ternary relationship between user, train_status, passenger and ticket where the participation of train_status is total and user, passenger and ticket is partial. it acts as an identifying relationship for the weak entity train_status.

STARTS
In the STARTS relation both the attributes are foreign keys and considered as candidate keys for the STARTS relation. It is a 1:N binary relation between Train and Station where the participation of train is total and station is partial. 

STOPS_AT
In the STOPS_AT relation both the attributes are foreign keys. It is a M:N binary relationship between Train and Station both having partial participation.

REACHES
In the REACHES relation there are two foreign keys – train_no and station_no. It is a 1:N binary relationship between Train and Station where the participation of Train is total and Station is partial.


FD and Normalization

In the following relations there is a single functional dependency of the keys in the relation having single primary key. Only for the relation Train there is more than one such functional dependency which is discussed as follows:

USER 
The USER relation is in 1NF since all columns have atomic and unique values. The relation is in 2NF since every nonprime attribute in USER is fully functionally dependent on the primary key user_id. None of the nonprime attribute of USER is transitively dependent on the primary key. So, it is in 3NF. It is in BCNF since no prime attribute is derived from a nonprime attribute. None of the database table instances contain two or more, independent and multivalued attributes describing the relevant entity, so it is in 4th Normal Form. The relation is in 5th Normal Form as it cannot be decomposed into any number of smaller tables without loss of data. Using Armstrong’s Strong and Complete set of inference rules we can derive another dependency of the address attribute which if considered as a composite attribute can have the Reflexive rule exercised on it. However, we have not considered address as an attribute for this particular relation.

PASSENGER


The PASSENGER entity is in 1NF since all columns have atomic and unique values. The relation schema is in 2NF since every nonprime attribute in PASSENGER is fully functionally dependent on the primary key passenger_id. None of the nonprime attributes of PASSENGER is transitively dependent on the primary key, so it is in 3NF. It is in BCNF since no prime attribute is derived from a nonprime attribute.  None of the database table instances contain more than one independent and multivalued attributes describing the relevant entity, so it is in 4th Normal Form. The relation is in 5th Normal Form as it cannot be decomposed into any number of smaller tables without loss of data.

TRAIN

The original TRAIN entity used for this project before normalisation is as shown above. The TRAIN relation is in 1NF since all columns have atomic and unique values. The relation is in 2NF since every nonprime attribute in USER is fully functionally dependent on the primary key user_id. The nonprime attributes a_seat1, a_seat2, w_seat1, w_seat2, b_seat1, b_seat2 and the fares fare1, fare2 are transitively dependent on the availability_of_seats. The dependency train_no→w_seats1 is transitive through availability_of_seats in TRAIN because both the dependencies train_no→availability_of_seats and availability_of_seats → w_seats1 hold and availability_of_seats is neither a key itself nor a subset of the key of the TRAIN relation. 

We normalize the Train entity (R) by performing binary decomposition that gives us the Train entity (R1) along with another entity Train_Status (R2) that contains the non-prime attributes in Train that were transitively dependent on the availability_of_seats attribute. This dependency is as shown below:
TRAIN

train_no	train_name	arrival_time	departure_time	availablility_of_seats	fare1	fare2	date	w_seats1	w_seats2	a_seats1	a_seats2	b_seats1	b_seats2




TRAIN
train_no	train_name	arrival_time	departure_time	availablility_of_seats	date

TRAIN_STATUS
train_no	a_seats1	a_seats2	b_seats1	b_seats2	w_seats1	w_seats2	fare1	fare2

Testing for lossless join and preservation of functional dependencies of the above decomposition:
We use property NJB to test for lossless join or no-additive join (Nonadditive Join Test for Binary Decompositions). Here, the decomposition D = {R1, R2} of R has the lossless (nonadditive) join property with respect to a set of functional dependencies F on R if and only if either 
•	The FD ((R1 ∩ R2) → (R1 − R2)) is in F+, or 
•	The FD ((R1 ∩ R2) → (R2 − R1)) is in F+

R = {train_no, train_name, arrival_time, departure_time, availablility_of_seats, fare1, fare2, date, w_seats1, w_seats2, a_seats1, a_seats2, b_seats1, b_seats2}
R1 = TRAIN = {train_no, train_name, arrival_time, departure_time, availablility_of_seats, date}
R2 = TRAIN_STATUS = { train_no, fare1, fare2, w_seats1, w_seats2, a_seats1, a_seats2, b_seats1, b_seats2}
F = { train_no → {train_name, arrival_time, departure_time, availablility_of_seats, date};
       train_no → { fare1, fare2, w_seats1, w_seats2, a_seats1, a_seats2, b_seats1, b_seats2}

R1 ∩ R2 gives us train_no  and R1- R2 = { arrival_time, departure_time, availablility_of_seats, date} so we get the FD train_no → {train_name, arrival_time, departure_time, availablility_of_seats, date} which is in F. Similarly the FD for ((R1 ∩ R2) → (R2 − R1)) is also in F. Therefore the decomposition of TRAIN into TRAIN and TRAIN_STATUS satisfies the lossless join test. (No spurious tuples will be generated as a result of a join condition)

STATION

The STATION entity is in 1NF since all columns have atomic and unique values. The relation schema is in 2NF since every nonprime attribute in STATION is fully functionally dependent on the primary key station_no. None of the nonprime attributes of STATION is transitively dependent on the primary key, so it is in 3NF. It is in BCNF since no prime attribute is derived from a nonprime attribute. None of the database table instance contains two or more, independent and multivalued attributes describing the relevant entity, so it is in 4th Normal Form. The relation is in 5th Normal Form as it cannot be decomposed into any number of smaller tables without loss of data.

TICKET

The TICKET entity is in 1NF since all columns have atomic and unique values. The relation schema is in 2NF since every nonprime attribute in TICKET is fully functionally dependent on the primary key id. None of the nonprime attribute of TICKET is transitively dependent on the primary key. So, it is in 3NF. It is in BCNF since no prime attribute is derived from a nonprime attribute. None of the database table instances contain two or more, independent and multivalued attributes describing the relevant entity, so it is in 4th Normal Form. Ticket is in 5th Normal Form as it cannot be decomposed into any number of smaller tables without loss of data.

CANCEL

The CANCEL relation is in 1NF since all columns have atomic and unique values. The relation is in 2NF since there are no nonprime attribute in CANCEL that need to be fully functionally dependent on their respective primary keys. There are no nonprime attributes in CANCEL that can be transitively dependent on the primary key, so it is in 3NF. It is in BCNF since no prime attribute is derived from a nonprime attribute. None of the database table instance contains two or more, independent and multivalued attributes describing the relevant entity, so it is in 4th Normal Form. The relation is in 5th Normal Form as it cannot be decomposed into any number of smaller tables without loss of data.

BOOK

The BOOK relation is in 1NF since all columns have atomic and unique values. The relation is in 2NF since there are no nonprime attributes in BOOK that need to be functionally dependent on their respective primary keys, user_id and id. There are no nonprime attributes in CANCEL that can be transitively dependent on the primary key, so it is in 3NF. It is in BCNF since no prime attribute is derived from a nonprime attribute.None of the database table instances contain two or more, independent and multivalued attributes describing the relevant entity, so it is in 4th Normal Form. The relation is in 5th Normal Form as it cannot be decomposed into any number of smaller tables without loss of data.

STARTS

The STARTS relation is in 1NF since all columns have atomic and unique values. The relation is in 2NF since there are no nonprime attribute in STARTS that need to be fully functionally dependent on the primary key. There are no nonprime attributes in CANCEL that can be transitively dependent on the primary key, so it is in 3NF. It is in BCNF since no prime attribute is derived from a nonprime attribute. None of the database table instance contains two or more, independent and multivalued attributes describing the relevant entity, so it is in 4th Normal Form. The relation is in 5th Normal Form as it cannot be decomposed into any number of smaller tables without loss of data.

STOPS_AT

The STOPS_AT is in 1NF since all columns have atomic and unique values. The relation is in 2NF since there are no nonprime attributes in STOPS_AT that need to be fully functionally dependent on the primary key. There are no nonprime attributes in CANCEL that can be transitively dependent on the primary key, so it is in 3NF. It is in BCNF since no prime attribute is derived from a nonprime attribute. None of database table instance contains two or more, independent and multivalued attributes describing the relevant entity, so it is in 4th Normal Form. The relation is in 5th Normal Form as it cannot be decomposed into any number of smaller tables without loss of data.

REACHES

The REACHES relation is in 1NF since all columns have atomic and unique values. The relation is in 2NF since the nonprime attribute time in REACHES is fully functionally dependent on the primary key train_no. The nonprime attributes in CANCEL are not transitively dependent on the primary key, so it is in 3NF. It is in BCNF since no prime attribute is derived from a nonprime attribute. None of the database table instance contains two or more, independent and multivalued attributes describing the relevant entity, so it is in 4th Normal Form. The relation is in 5th Normal Form as it cannot be decomposed into any number of smaller tables without loss of data.

