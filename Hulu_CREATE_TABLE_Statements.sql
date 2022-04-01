



CREATE DATABASE HULU;
GO
USE HULU;
GO

/*-- Disabling extra Foreign Keys
ALTER TABLE UserAccount
DROP CONSTRAINT FK_UserAccount_PaymentID,
CONSTRAINT FK_UserAccount_PlanID ;

ALTER TABLE ProgramPlan
DROP CONSTRAINT FK_ProgramPlan_PlanID;
-- Disabling all constraints
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

-- Dropping Tables
DROP TABLE IF EXISTS Episode;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS KeyContributor;
DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS Network;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS PlugIn;
DROP TABLE IF EXISTS Program;
DROP TABLE IF EXISTS ProgramKeyContributor;
DROP TABLE IF EXISTS ProgramPlan;
DROP TABLE IF EXISTS ProgramRole;
DROP TABLE IF EXISTS ProgramSubGenre;
DROP TABLE IF EXISTS SubGenre;
DROP TABLE IF EXISTS SubscriptionPlan;
DROP TABLE IF EXISTS UserAccount;
DROP TABLE IF EXISTS UserProfile;

-- Re-enabling constraints
EXEC sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all" */



CREATE TABLE Network
(	NetworkName		VARCHAR(30) NOT NULL, 
	NetworkType		VARCHAR(30) NOT NULL, 
	Vendor			VARCHAR(30) NOT NULL,
	CONSTRAINT PK_Network_NetworkName PRIMARY KEY (NetworkName)
	);

CREATE TABLE Program
(	ProgramID		SMALLINT IDENTITY (1,1) NOT NULL, 
	Title			VARCHAR(50) NOT NULL, 
	Runtime		SMALLINT NOT NULL, 
	UserRating		Decimal(4,2) NOT NULL, 
	Franchise		VARCHAR(30), 
	ProgDescription	VARCHAR(200) NOT NULL, 
	ReleaseYear		NUMERIC(4) NOT NULL, 
	Country		VARCHAR(3) NOT NULL, 
	NetworkName		VARCHAR(30),
	CONSTRAINT PK_Program_ProgramID PRIMARY KEY (ProgramID),
	CONSTRAINT FK_Progam_NetworkName FOREIGN KEY (NetworkName) REFERENCES Network (NetworkName)
	);


CREATE TABLE Genre 
(	GenreID		SMALLINT IDENTITY(1,1) NOT NULL, 
	GenreName		VARCHAR(30),
	CONSTRAINT PK_Genre_GenreID PRIMARY KEY (GenreID)
	);


CREATE TABLE SubGenre 
(	SubGenreID		SMALLINT IDENTITY(1,1) NOT NULL, 
	GenreID			SMALLINT NOT NULL, 
	SubGenreName	VARCHAR(30),
	CONSTRAINT PK_SubGenre_SubGenreID PRIMARY KEY (SubGenreID),
	CONSTRAINT FK_SubGenre_GenreID FOREIGN KEY (GenreID) REFERENCES Genre (GenreID)
	);


CREATE TABLE ProgramSubGenre 
(	ProgramID		SMALLINT NOT NULL, 
	SubGenreID		SMALLINT NOT NULL,
	CONSTRAINT PK_ProgramSubGenre_ProgramID_SubGenreID PRIMARY KEY (ProgramID, SubGenreID),
	CONSTRAINT FK_ProgramSubGenre_ProgramID FOREIGN KEY (ProgramID) REFERENCES Program (ProgramID),
	CONSTRAINT FK_ProgramSubGenre_SubGenreID FOREIGN KEY (SubGenreID) REFERENCES SubGenre (SubGenreID)
	);

	
CREATE TABLE KeyContributor 
(	ContributorID	SMALLINT IDENTITY(1,1) NOT NULL, 
	FirstName		VARCHAR(30) NOT NULL, 
	MiddleName		VARCHAR(30) DEFAULT NULL, 
	LastName		VARCHAR(30) NOT NULL, 
	Gender			VARCHAR(1) NOT NULL, 
	Race			VARCHAR(10) NOT NULL, 
	Ethnicity		VARCHAR(10) NOT NULL,
	CONSTRAINT PK_KeyContributor_ContributorID PRIMARY KEY (ContributorID)
	);

CREATE TABLE ProgramKeyContributor 
(	ProgramID		SMALLINT NOT NULL, 
	ContributorID	SMALLINT NOT NULL, 
	CONSTRAINT PK_ProgramKeyContributor_ProgramID_ContributorID PRIMARY KEY (ProgramID, ContributorID),
	CONSTRAINT FK_ProgramKeyContributor_ProgramID FOREIGN KEY (ProgramID) REFERENCES Program (ProgramID),
	CONSTRAINT FK_ProgramKeyContributor_ContributorID FOREIGN KEY (ContributorID) REFERENCES KeyContributor (ContributorID)
	);

CREATE TABLE Movie 
(	ProgramID			SMALLINT NOT NULL, 
	MovieMaturityRating	VARCHAR(5) NOT NULL,
	CONSTRAINT PK_Movie_ProgramID PRIMARY KEY (ProgramID),
	CONSTRAINT FK_Movie_ProgramID FOREIGN KEY (ProgramID) REFERENCES Program (ProgramID)
	);



CREATE TABLE Episode 
(	ProgramID				SMALLINT NOT NULL, 		
	EpisodeMaturityRating	VARCHAR(5) NOT NULL, 
	Season					NUMERIC(3) NOT NULL, 
	Show					VARCHAR(100) NOT NULL, 

	CONSTRAINT PK_Episode_ProgramID PRIMARY KEY ( ProgramID ) ,
	CONSTRAINT FK_Episode_ProgramID FOREIGN KEY ( ProgramID ) REFERENCES Program ( ProgramID ) 
);


CREATE TABLE ProgramRole 
(	RoleID			SMALLINT IDENTITY(1,1) NOT NULL, 
	ProgramID		SMALLINT NOT NULL,
	ContributorID	SMALLINT NOT NULL, 
	RoleName		VARCHAR(30) NOT NULL

	CONSTRAINT PK_ProgramRole_RoleID PRIMARY KEY ( RoleID ), 
	CONSTRAINT FK_ProgramRole_ProgramID FOREIGN KEY ( ProgramID ) REFERENCES Program ( ProgramID ), 
	CONSTRAINT FK_ProgramRole_ContributoreID FOREIGN KEY ( ContributorID ) REFERENCES KeyContributor ( ContributorID ) 
);


CREATE TABLE ProgramPlan
(	ProgramID		SMALLINT NOT NULL, 
	PlanID			SMALLINT NOT NULL 

	CONSTRAINT PK_ProgramPlan_ProgramID_PlanID PRIMARY KEY ( ProgramID, PlanID ), 
	CONSTRAINT FK_ProgramPlan_ProgramID FOREIGN KEY ( ProgramID ) REFERENCES Program ( ProgramID )

);




CREATE TABLE UserAccount
(	EmailAddress		VARCHAR(80) NOT NULL,
	FirstName		VARCHAR(30) NOT NULL, 
	MiddleName		VARCHAR(30) NULL,
	LastName		VARCHAR(30) NOT NULL, 
	UserPassword		VARCHAR(30) NOT NULL,
	PlanID			SMALLINT NOT NULL, 
	PaymentID		SMALLINT NOT NULL

	CONSTRAINT PK_UserAccount_EmailAddress PRIMARY KEY ( EmailAddress )

);

CREATE TABLE Payment 
(	PaymentID		SMALLINT NOT NULL,
	EmailAddress	VARCHAR(80) NOT NULL, 
	CardNum			NCHAR(16) NOT NULL,
	Cardholder		VARCHAR(60) NOT NULL,
	ExpMonth		NUMERIC(2) NOT NULL, 
	ExpYear			NUMERIC(2) NULL, 
	SecurityCode	NUMERIC(4) NOT NULL, 
	Nickname		VARCHAR(30) NOT NULL

	CONSTRAINT PK_Payment_PaymentID PRIMARY KEY ( PaymentID ), 
	CONSTRAINT FK_Payment_EmailAddress FOREIGN KEY ( EmailAddress ) REFERENCES UserAccount ( EmailAddress ) 

);


CREATE TABLE SubscriptionPlan 
(	PlanID			SMALLINT NOT NULL,  
	Price			DECIMAL(4,2) NOT NULL, 
	PlanName		VARCHAR(30) NOT NULL, 

	CONSTRAINT PK_SubscriptionPlan_PlanID PRIMARY KEY ( PlanID )

);


ALTER TABLE UserAccount
ADD CONSTRAINT FK_UserAccount_PaymentID FOREIGN KEY ( PaymentID ) REFERENCES Payment ( PaymentID ),
CONSTRAINT FK_UserAccount_PlanID FOREIGN KEY ( PlanID ) REFERENCES SubscriptionPlan ( PlanID ) ;

ALTER TABLE ProgramPlan
ADD CONSTRAINT FK_ProgramPlan_PlanID FOREIGN KEY (PlanID) REFERENCES SubscriptionPlan (PlanID);

CREATE TABLE PlugIn
(	PlugInID		SMALLINT  NOT NULL,
	PlanID			SMALLINT NOT NULL,
	PlugInName		VARCHAR(30) NOT NULL,
	PlugInPrice		DECIMAL(4,2) NOT NULL,
	AnnualDiscountPrice	DECIMAL(4,2) NOT NULL

	CONSTRAINT PK_PlugIn_PlugInID_PlanID PRIMARY KEY (PlugInID, PlanID),
	CONSTRAINT FK_PlugIn_PlanID FOREIGN KEY ( PlanID ) REFERENCES SubscriptionPlan ( PlanID ) 

);

CREATE TABLE UserProfile
(	ProfileID		VARCHAR(50) NOT NULL,
	EmailAddress		VARCHAR(80) NOT NULL, 
	ProfileName		VARCHAR(50) NOT NULL, 
	PIN			NUMERIC(4) NOT NULL, 
	Gender		CHAR(1),
	Birthdate		DATE NOT NULL,
	ProfilePicture		NCHAR(1) NULL, --This will be null for data as it would increase our complexity beyond the scope of the project. It references which of the selected images they choose for their profile. 

	CONSTRAINT PK_UserProfile_ProfileID PRIMARY KEY (ProfileID),
	CONSTRAINT FK_UserProfile_EmailAddress FOREIGN KEY ( EmailAddress ) REFERENCES UserAccount ( EmailAddress ) 

);
