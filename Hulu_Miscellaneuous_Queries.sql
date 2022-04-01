USE HULU;

-- Update a Payment Option
UPDATE Payment
SET CardNum= 1234568910111214,
	Cardholder= 'Joe Schmo',
	ExpMonth=12, 
	ExpYear=25, 
	SecurityCode=2041, 
	Nickname= 'Main'
WHERE EmailAddress='asdf@gmail.com';

--Creating a stored procedure to add all of a new customer's information at once.
DROP PROCEDURE IF EXISTS NewCustomer;
CREATE PROCEDURE NewCustomer
	@EmailAddress	VARCHAR(80),
	@FirstName		VARCHAR(30), 
	@MiddleName		VARCHAR(30),
	@LastName		VARCHAR(30), 
	@UserPassword	VARCHAR(30),
	@PlanID			SMALLINT, 
	@PaymentID		SMALLINT,
	@ProfileID		VARCHAR(50),
	@ProfileName	VARCHAR(50), 
	@PIN			NUMERIC(4), 
	@Gender			CHAR(1),
	@Birthdate		DATE, 
	@CardNum		NCHAR(16),
	@Cardholder		VARCHAR(60),
	@ExpMonth		NUMERIC(2), 
	@ExpYear		NUMERIC(2), 
	@SecurityCode	NUMERIC(4), 
	@Nickname		VARCHAR(30)
AS
BEGIN

	BEGIN TRANSACTION NewCustomer;
		ALTER TABLE UserAccount 
		DROP CONSTRAINT FK_UserAccount_PaymentID;
		ALTER TABLE Payment
		DROP CONSTRAINT FK_Payment_EmailAddress;
		ALTER TABLE UserProfile
		DROP CONSTRAINT FK_UserProfile_EmailAddress;

		INSERT INTO UserAccount (EmailAddress, FirstName, MiddleName, LastName, UserPassword, PlanID, PaymentID)
		VALUES	(@EmailAddress, @FirstName, @MiddleName, @LastName, @UserPassword, @PlanID, @PaymentID);

		INSERT INTO  Payment (PaymentID, EmailAddress, CardNum, Cardholder, ExpMonth, ExpYear, SecurityCode, Nickname)
		VALUES (@PaymentID, @EmailAddress, @CardNum, @Cardholder, @ExpMonth, @ExpYear, @SecurityCode, @Nickname)

		INSERT INTO UserProfile ( ProfileID, EmailAddress, ProfileName, PIN, Gender, Birthdate, ProfilePicture)
		VALUES (@ProfileID, @EmailAddress, @ProfileName, @PIN, @Gender, @Birthdate, NULL)

		ALTER TABLE UserAccount
		ADD CONSTRAINT FK_UserAccount_PaymentID FOREIGN KEY ( PaymentID ) REFERENCES Payment ( PaymentID );
		ALTER TABLE Payment
		ADD CONSTRAINT FK_Payment_EmailAddress FOREIGN KEY ( EmailAddress ) REFERENCES UserAccount ( EmailAddress ) ;
		ALTER TABLE UserProfile
		ADD CONSTRAINT FK_UserProfile_EmailAddress FOREIGN KEY ( EmailAddress ) REFERENCES UserAccount ( EmailAddress ) ;
		
	COMMIT TRANSACTION NewCustomer;

END;

--Executing Said Procedure
EXECUTE NewCustomer
	@EmailAddress = 'johnnysnow@gmail.com',
	@FirstName='John', 
	@MiddleName='Darius',
	@LastName='Snow', 
	@UserPassword='DragonsForever',
	@PlanID= 1, 
	@PaymentID= 12,
	@ProfileID= 11,
	@ProfileName='Johnny', 
	@PIN= 1712, 
	@Gender='M',
	@Birthdate='1111-02-22', 
	@CardNum='13121110987654321',
	@Cardholder='Johnathan D Snow',
	@ExpMonth= 11, 
	@ExpYear= 26, 
	@SecurityCode= 734, 
	@Nickname='moms';


--Creating a query that will pull all customers accounts who can watch 'Grown Ups' based on their subscription
SELECT EmailAddress, CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS CustomerName
FROM UserAccount AS UA
INNER JOIN ProgramPlan AS PgPl
ON UA.PlanID= PgPl.PlanID
WHERE PgPl.ProgramID IN
(	SELECT ProgramID
	FROM Program
	WHERE Title='Grown Ups');


--Creating a view that will allow us to view all of the Movies in a subscription plan.
DROP VIEW IF EXISTS [ProgramSubscription];

CREATE VIEW [ProgramSubscription] AS
SELECT Title 
FROM Program AS P
INNER JOIN Movie AS M
ON P.ProgramID= M.ProgramID
INNER JOIN ProgramPlan AS PgPl
ON P.ProgramID=PgPl.ProgramID
WHERE PgPl.PlanID=2;

--Displaying the View
SELECT *
FROM [ProgramSubscription];

-- Creating a query that will determine how much income is coming in monthly & yearly from subscription fees for each plan
SELECT	sp.PlanName,
		sp.Price*COUNT(ua.PlanID) AS TotalMonthlyIncome,
		sp.Price*COUNT(ua.PlanID)*12 AS TotalAnnualIncome
FROM SubscriptionPlan AS sp
INNER JOIN UserAccount AS ua
ON ua.PlanID=sp.PlanID
GROUP BY sp.PlanName, sp.Price;


-- UDF created to see PlanName based on ProfileID
USE group1_project_HULU

IF EXISTS (SELECT * FROM sys.objects WHERE name=N'CustomerSubscriptionPlan')	DROP FUNCTION CustomerSubscriptionPlan ; 	CREATE FUNCTION CustomerSubscriptionPlan	(@ProfileID VARCHAR(50))	RETURNS VARCHAR (30)BEGIN	DECLARE @Tally INT, @PlanName VARCHAR (30) 	SELECT @Tally = COUNT(*)	FROM UserProfile AS UP	WHERE UP.ProfileID = @ProfileID	IF @Tally = 0 		SET @PlanName = 'does not exist'	ELSE		BEGIN			SELECT @PlanName = SP.PlanName			FROM	UserProfile AS UP					INNER JOIN UserAccount AS UA 						ON UP.EmailAddress = UA.EmailAddress					INNER JOIN SubscriptionPlan AS SP						ON SP.PlanID = UA.PlanID			WHERE UP.ProfileID = @ProfileID		END;	RETURN @PlanNameEND;--Test the FunctionSELECT dbo.CustomerSubscriptionPlan('aladin') AS 'CustomerSubscriptionPlan'

