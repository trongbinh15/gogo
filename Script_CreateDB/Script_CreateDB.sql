USE master;
GO
DROP DATABASE GoGo
GO
CREATE DATABASE GoGo
GO
USE GoGo3
GO

create table Roles
(
	Id int primary key identity(1,1),
	Role nvarchar(50),

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit
)

CREATE TABLE Subscription
(
	AgentID INT,
	Month INT,
	Year INT,
	Fee INT NOT NULL,

	PRIMARY KEY (Month, Year, AgentID)
)

create table Users
(
	Id int primary key identity(1,1),
	Username varchar(30),
	Password varchar(30),
	Fullname nvarchar(50),
	PhoneNumber char(10) ,
	Email varchar(50) ,
	DateOfBirth date,
	Address nvarchar(50),
	Point int,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit
)

create table UserRole
(
	UserId int,
	RoleId int,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit,

	primary key(UserId,RoleId),
	FOREIGN KEY(UserId) references Users(Id),
	FOREIGN KEY(RoleId) references Roles(Id)
)

create table Agent
(
	Id int primary key identity(1,1),
	AgentName nvarchar(30),
	Address nvarchar(50),
	PhoneNumber nvarchar(10) unique,
	Owner int,

	PathOfImage varchar(MAX),

	Rate int,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit


		FOREIGN KEY(Owner) references Users(Id)
)

create table VehicleType
(
	Id int primary key identity(1,1),
	VehicleName nvarchar(50),
	Seat int,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit
)

create table Vehicle
(
	Id int primary key identity(1,1),
	VehicleLicense nvarchar(30) unique,
	VehicleBrand nvarchar(50),
	VehicleTypeId int,
	AgentId int,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit

		FOREIGN KEY (VehicleTypeId) REFERENCES VehicleType(Id),
	FOREIGN KEY (AgentId) REFERENCES Agent(Id)
)

create table City
(
	Id int primary key identity(1,1),
	CityName nvarchar(30),

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit
)

create table District
(
	Id int primary key identity(1,1),

	DistrictName nvarchar(30),
	CityId int,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit

		FOREIGN KEY(CityId) REFERENCES City(Id),
)

create table Station
(
	Id int primary key identity(1,1),
	StationName nvarchar(30),
	Longitude float,
	Latitude float,

	DistrictId int,
	Address nvarchar(50),

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit

		FOREIGN KEY(DistrictId) REFERENCES District(Id),
)

create table Trip
(
	Id int primary key identity(1,1),

	VehicleId int,
	OriginCity int,
	DestinationCity int,

	EstStartTime time,
	EstEndTime time,

	Status bit,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit,

	FOREIGN KEY(VehicleId) REFERENCES VEHICLE(Id),
	FOREIGN KEY(OriginCity) REFERENCES City(Id),
	FOREIGN KEY(DestinationCity) REFERENCES City(Id)
)

create table TripStation
(
	TripId int,
	StationId int,
	Priority int,

	EstArrival time,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit

		PRIMARY KEY(TripId, StationId, Priority)

		FOREIGN KEY(TripId) REFERENCES Trip(Id),
	FOREIGN KEY(StationId) REFERENCES Station(Id)
)

create table Ticket
(
	Id int primary key identity(1,1),

	TripId int,
	SeatCode char(3),
	EstCost int,
	Status bit,
	Date date,
	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit

		FOREIGN KEY(TripId) REFERENCES Trip(Id)
)

create table PaymentMethod
(
	Id int primary key identity(1,1),

	MethodName nvarchar(30),

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit
)

create table Sales
(
	CustomerId int,
	TicketId int,

	Cost int,
	PaymentMethodId int,
	OriginStationId int,
	DestinationStationId int,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit

		PRIMARY KEY(CustomerId,TicketId),
	FOREIGN KEY(CustomerId) REFERENCES Users(Id),
	FOREIGN KEY(TicketId) REFERENCES Ticket(Id),
	FOREIGN KEY(PaymentMethodId) REFERENCES PaymentMethod(Id),
	FOREIGN KEY(OriginStationId) REFERENCES Station(Id),
	FOREIGN KEY(DestinationStationId) REFERENCES Station(Id)
)

CREATE TABLE PositionEvent
(
	Id int primary key identity(1,1),
	Latitude float,
	Longitude float,
	Date datetime
)

CREATE TABLE SEAT
(
	Id int primary key identity(1,1),
	VehicleTypeId int,
	Col int,
	Row int,
	Status bit,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit

		FOREIGN KEY(VehicleTypeId) REFERENCES VehicleType(Id),
)

ALTER TABLE Ticket
ADD SeatId int

ALTER TABLE SEAT
ADD SeatCode char(3)

ALTER TABLE Ticket
ADD FOREIGN KEY (SeatId) REFERENCES SEAT(Id)

ALTER TABLE Ticket
DROP COLUMN SeatCode

ALTER TABLE Ticket
ALTER COLUMN Status int

CREATE TABLE TransactionInfo
(
	PaymentMethod int,
	BankTranNo varchar(64),
	CardType varchar(64),
	BankCode varchar(64),
	PayDate varchar(64),
	ResponseCode varchar(64),
	TransactionNo varchar(64),
	OrderInfo nvarchar(256),
	Amount int,

	LastCreatedDate datetime,
	LastModifiedDate datetime,
	IsDeleted bit

		PRIMARY KEY (PaymentMethod,BankTranNo)
		FOREIGN KEY (PaymentMethod) REFERENCES PaymentMethod(Id)
)

ALTER TABLE Sales
ADD BankTranNo varchar(64)

ALTER TABLE Sales
ADD BarCode varchar(64)

CREATE TYPE TicketList
AS TABLE 
(
	TicketId int
)

CREATE TABLE BAOCAODOANHTHUNAM_DATA
(
	Year int,
	T1 INT,
	T2 INT,
	T3 INT,
	T4 INT,
	T5 INT,
	T6 INT,
	T7 INT,
	T8 INT,
	T9 INT,
	T10 INT,
	T11 INT,
	T12 INT,
)

CREATE TABLE BAOCAOLUULUONGNAM_DATA
(
	Year int,
	T1 INT,
	T2 INT,
	T3 INT,
	T4 INT,
	T5 INT,
	T6 INT,
	T7 INT,
	T8 INT,
	T9 INT,
	T10 INT,
	T11 INT,
	T12 INT,
)