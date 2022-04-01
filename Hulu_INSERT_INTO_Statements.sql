

USE HULU



INSERT INTO Genre (GenreName)
VALUES ('Action'),
	   ('Comedy'),
	   ('Romance'),
	   ('Drama'),
	   ('Horror'),
	   ('Fantasy'),
	   ('Thriller'),
	   ('Family'),
	   ('Science Fiction'),
	   ('Crime');


INSERT INTO Network (NetworkName, NetworkType, Vendor)
VALUES	('Lionsgate Films', 'Film', 'Lionsgate'),
		('Warner Bros', 'Film', 'WarnerMedia'),
		('Columbia Pictures', 'Film', 'Sony Pictures'),
		('DreamWorks Animation', 'Film', 'DreamWorks Pictures'),
		('Nelvana', 'Dramatic TV', 'Nelvana International'),
		('20th Century Fox Television', 'Dramatic TV', 'Fox Entertainment'),
		('Thruline Entertainment', 'Dramatic TV', 'Paramount Television Studios'),
		('Walt Disney Pictures', 'Film', 'Buena Vista Pictures');


INSERT INTO Program (Title, Runtime, UserRating, Franchise, ProgDescription, ReleaseYear, Country, NetworkName)
VALUES ('The Hunger Games', 181, 4.1, 'Tuhe Hunger Games', 'Every year in the ruins of what was once North America, the nation of Panem forces each of its twelve districts to send a teenage boy and girl to compete in the Hunger Games.', 2012, 'USA', 'Lionsgate Films'),
	   ('QUEEN OF THE DAMNED', 101, 3.3, NULL, 'After a decades-long slumber, the vampire Lestat becomes a rock star whose music awakens the queen of all vampires, Akasha, who embarks on a mission to make Lestat her king.', 2002, 'USA', 'Warner Bros'),
	   ('Grown Ups', 97, 4.4, NULL, 'After their high school basketball coach passes away, five good friendsand former teammates reunite for a Fourth of July holiday weekend.', 2010, 'USA', 'Columbia Pictures'),
	   ('Shark Tale', 90, 4.8, NULL, 'A young fish`s false reputation as a "shark slayer" earns him fame...and gets him fitted for cement fins in this animated tale.', 2004, 'USA', 'DreamWorks Animation'),
	   ('SHREK', 120, 4.5, 'SHREK', 'Once upon a time, in a far away swamp, there lived an ornery ogre named Shrek whose precious solitude is suddenly shattered by an invasion of annoying fairy tale characters.', 2001, 'USA', 'DreamWorks Animation'),
	   ('SHREK 2', 120, 4.1, 'SHREK', 'After battling a fire-breathing dragon and the evil Lord Farquaad to win the hand of Princess Fiona, Shrek now faces his greatest challenge: the in-laws.', 2004, 'USA', 'DreamWorks Animation'),
	   ('Welcome to Your Life', 47, 4.0, 'The Hardy Boys', 'Frank and Joe Hardy move to the small town of Bridgeport for the summer and set out to uncover the truth behind a recent family tragedy.', 2020, 'USA', 'Nelvana' ),
	   ('Who Is Tim Kono?', 29, 3.2, 'Only Murders in the Building', 'The group begins researching the victim. Meanwhile, Mabel’s secretive past starts to be unraveled.', 2021, 'USA', '20th Century Fox Television'),
	   ('Moscow Mule', 52, 4.2, 'The Great', 'Catherine tries to manage her reputation at court and her relationship with Leo. An influential Patriarch of the church dies. Orlo tries to influence Peter`s decision for a replacement.', 2020, 'USA', 'Thruline Entertainment'),
	   ('Remember the Titans', 113, 4.2, NULL, 'The true story of a newly appointed African-American coach and his high school team on their first season as a racially integrated unit.', 2000, 'USA', 'Walt Disney Pictures');



	  
	  
	 

INSERT INTO Episode (ProgramID, EpisodeMaturityRating, Season, Show)    
VALUES  (7, 'PG-13', 1, 'The Hardy Boys'),
		(8, 'PG-13', 1, 'Only Murders in the Building' ),
        (9, 'PG-13', 1, 'The Great')



INSERT INTO Movie (ProgramID, MovieMaturityRating )
VALUES  (1, 'PG-13'),
        (2, 'R'),
        (3, 'PG-13'),
        (4, 'PG'),
        (5, 'PG'),
        (6, 'PG'),
        (10, 'PG');


INSERT INTO KeyContributor (FirstName, MiddleName, LastName, Gender, Race, Ethnicity)
VALUES ('Jennifer', 'Shrader', 'Lawrence', 'F', 'White', 'American'),
	   ('Andrew', 'Ralph', 'Adamson', 'M', 'White', 'NZ'),
	   ('Thomas', '', 'Cruise', 'M', 'White', 'American'),
	   ('Thomas', 'Jeffrey', 'Hanks', 'M', 'White', 'American'),
	   ('Jackie', '', 'Chan', 'M', 'Asian', 'Chinese'),
	   ('Eva', '', 'Mendes', 'F', 'Hispanic', 'American'),
	   ('Morgan', '', 'Freeman', 'M', 'Black', 'American'),
	   ('Sofia', 'Margarita', 'Vergara', 'F', 'Hispanic', 'Colombian'),
	   ('Benedict', 'Timothy', 'Cumberbatch', 'M', 'White', 'British'),
	   ('Letitia', 'Michelle', 'Wright', 'F', 'Black', 'African');


	   
INSERT INTO SubGenre (GenreID, SubGenreName)
VALUES (1, 'Supernatural'),
	   (2, 'Sitcoms'),
	   (3, 'Trending Romance'),
	   (4, 'Medical Dramas'),
	   (5, 'Trending Horror'),
	   (6, 'Most Liked Fantasy'),
	   (7, 'Trending Thriller'),
	   (8, 'Animation'),
	   (9, 'Trending Science Fiction'),
	   (10, 'Detective Dramas');


INSERT INTO SubscriptionPlan (PlanID, Price, PlanName)
VALUES (1, 5.99, 'Hulu'),
		(2, 12.99, 'Hulu (No Ads)'),
		(3, 64.99,'Hulu + Live TV'),
		(4, 70.99,'Hulu + Live TV (No Ads)');




INSERT INTO PlugIn (PlugInID, PlanID, PlugInName, PlugInPrice, AnnualDiscountPrice)
VALUES  (1, 1, 'HBO Max', 14.99, 13.99),
		(1, 2, 'HBO Max', 14.99, 13.99),
		(1, 3, 'HBO Max', 14.99, 13.99),
		(1, 4, 'HBO Max', 14.99, 13.99),
		(2, 1, 'Cinemax', 9.99, 8.99),
		(2, 2, 'Cinemax', 9.99, 8.99),
		(2, 3, 'Cinemax', 9.99, 8.99),
		(2, 4, 'Cinemax', 9.99, 8.99),
		(3, 1, 'Starz', 8.99, 7.99),
		(3, 2, 'Starz', 8.99, 7.99);






INSERT INTO ProgramSubGenre (ProgramID, SubGenreID)
VALUES (1, 1),
	   (2, 2),
	   (3, 3),
	   (4, 4),
	   (5, 5),
	   (6, 6),
	   (7, 7),
	   (8, 8),
	   (9, 9),
	   (10, 10);

	
INSERT INTO ProgramKeyContributor  ( ProgramID, ContributorID)
VALUES  (1, 1),
        (2, 2),
        (3, 3),
        (4, 4),
        (5, 5),
        (6, 6),
        (7, 7),
        (8, 8),
        (9, 9),
        (10, 10);


INSERT INTO ProgramPlan (ProgramID, PlanID)
VALUES	(1, 1),
		(2, 2),
		(3, 3),
		(4, 1),
		(5, 3),
		(6, 1),
		(7, 2),
		(8, 3),
		(9, 1),
		(10, 2);




INSERT INTO ProgramRole ( ProgramID, ContributorID, RoleName)
VALUES	(1, 1, 'Actor'),
		(2, 2, 'Director'),
		(3, 3, 'Actor'),
		(4, 4, 'Director'),
		(5, 5, 'Actor'),
		(6, 6, 'Director'),
		(7, 7, 'Actor'),
		(8, 8, 'Director'),
		(9, 9, 'Actor'),
		(10, 10, 'Director');


ALTER TABLE UserAccount 
DROP CONSTRAINT FK_UserAccount_PaymentID

ALTER TABLE UserAccount 
DROP CONSTRAINT FK_UserAccount_PlanID

INSERT INTO UserAccount (EmailAddress, FirstName, MiddleName, LastName, UserPassword, PlanID, PaymentID)
VALUES	('asdf@gmail.com', 'Michael', 'Steve', 'Scott', 'BossMan123', 3, 1),
		('JHalpert@gmail.com', 'Jim', 'John', 'Halpert', 'Philip02', 1, 2),
		('Schrute.Farms@live.com', 'Dwight', 'Rainn', 'Schrute', 'BattleStar01', 1, 3),
		('Pam.Beesly01@gmail.com', 'Pam', 'Jenna', 'Beesly', 'Cece01', 2, 4),
		('CornellBonerChanmp@yahoo.com', 'Andy', 'Edward', 'Bernard', 'NardDog27', 3, 5),
		('E.Hannon@gmail.com', 'Kelly', 'Erin', 'Hannon', 'DunderEl8', 1, 06),
		('ScrantonStrangler@hotmail.com', 'Toby', 'Paul', 'Flenderson', 'strangle25', 3, 7),
		('KCelebsK@gmail.com', 'Kelly', 'Mindy', 'Kapoor', 'Angelina56', 3, 8),
		('MnM123@gmail.com', 'Kevin','Brian', 'Malone', 'Skittles79', 2, 9),
		('TheStanMan@gmail.com', 'Stanley', 'Leslie', 'Hudson', 'FloridaMan46', 2, 10);


INSERT INTO  Payment (PaymentID, EmailAddress, CardNum, Cardholder, ExpMonth, ExpYear, SecurityCode, Nickname)
VALUES	(1, 'asdf@gmail.com', 5555555555554444, 'Michael Scott', 01, 24, 123, 'MasterCard'),
		(2, 'JHalpert@gmail.com', 5105105105105100, 'Jim Halpert', 02, 24, 234, 'MC'),
		(3, 'Schrute.Farms@live.com', 4111111111111111, 'Dwight Schrute', 03, 24, 345, 'Visa'),
		(4, 'Pam.Beesly01@gmail.com', 4012888888881881, 'Pamela Beesly', 04, 24, 456, 'Entertainment'),
		(5, 'CornellBonerChanmp@yahoo.com', 378282246310005, 'Andrew Bernard', 05, 24, 5678, 'Amex'),
		(6, 'E.Hannon@gmail.com', 371449635398431, 'Kelly Hannon', 06, 24, 6789, 'American Express'),
		(7, 'ScrantonStrangler@hotmail.com', 6011111111111117, 'Tobias Flenderson',  07, 24, 789, 'Discover'),
		(8, 'KCelebsK@gmail.com', 6011000990139424, 'Kelly Kapoor', 08, 24, 891, 'Home'),
		(9, 'MnM123@gmail.com', 370000000100018, 'Joe Malone', 09, 24, 910, 'Joe`s'),
		(10, 'TheStanMan@gmail.com', 6011601160116611, 'Stanley L Hudson', 10, 24, 101, 'Citibank');


ALTER TABLE UserAccount
ADD CONSTRAINT FK_UserAccount_PaymentID FOREIGN KEY ( PaymentID ) REFERENCES Payment ( PaymentID ),
CONSTRAINT FK_UserAccount_PlanID FOREIGN KEY ( PlanID ) REFERENCES SubscriptionPlan ( PlanID ) ;

INSERT INTO UserProfile ( ProfileID, EmailAddress, ProfileName, PIN, Gender, Birthdate, ProfilePicture )
VALUES ( 'booger123', 'asdf@gmail.com', 'King', 1234, NULL, '1980-09-28', NULL ),
	   ( 'jo3', 'asdf@gmail.com', 'Son', 4387, 'F', '1960-05-08', NULL),
	   ( 'bob494', 'JHalpert@gmail.com', 'Dad', 4092, 'M', '1980-01-17', NULL),
	   ( 'david', 'JHalpert@gmail.com', 'Uncle', 4831, 'M', '1993-11-20', NULL),
	   ( 'sonny', 'MnM123@gmail.com', 'Mom', 3485, 'F', '1960-07-30', NULL),
	   ( 'rachel', 'MnM123@gmail.com', 'Sister', 0921, 'F', '1989-06-03', NULL),
	   ( 'mickey', 'MnM123@gmail.com', 'Baby', 1301, 'F', '1987-12-05', NULL),
	   ( 'mouse', 'KCelebsK@gmail.com', 'Teacher', 4895, 'M', '1990-01-29', NULL),
	   ( 'aladin', 'E.Hannon@gmail.com', 'Nanny', 9874, 'M', '2000-08-14', NULL),
	   ( 'fiona', 'asdf@gmail.com', 'Servant', 8022, 'M', '1973-05-11', NULL);







