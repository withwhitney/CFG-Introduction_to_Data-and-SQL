#Create relational DB of your choice with minimum 5 tables
#Set Primary and Foreign Key constraints to create relations between the tables
#Using any type of the joins create a view that combines multiple tales in a logical way
#In your database, create a stored function that can be applied to a query in your DB
#Prepare an example query with a subquery to demonstrate how to extract data from your DB for analysis
#Create DB diagram where all table relatoins are shown


#This database is created for an imanginary bookstore that has both online and in-store sale.
#The assumptions are as follow:
#There is only one store per city

DROP DATABASE Bookstore;
CREATE DATABASE Bookstore;

USE Bookstore;

#Create a table of genres
CREATE TABLE Genres(
GenreID INTEGER PRIMARY KEY,
GenreName VARCHAR(255) NOT NULL
);

#Create a table of authors
CREATE TABLE Authors(
AuthorID INTEGER PRIMARY KEY,
FirstName VARCHAR(255) NOT NULL,
LastName VARCHAR(255)
);

#Create a table of books, here we will introduce authors and genres from the preivous tables created, 
#and they will be the foreign key of this table.
CREATE TABLE Books(
BookID INTEGER PRIMARY KEY,
Title VARCHAR(255) NOT NULL,
AuthorID INTEGER NOT NULL,
FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
GenreID INTEGER,
FOREIGN KEY (GenreID) REFERENCES Genres(GenreID),
Price FLOAT,
Stock INTEGER
);

#In order to improve the query performance, concept of index is introduced to this database,
#for columns like author and genre, which are frequently used in WHERE clauses, index will be added.
CREATE INDEX ind_AuthorID ON Books(AuthorID);
CREATE INDEX ind_GenreID ON Books(GenreID);


CREATE TABLE Stores(
StoreID INTEGER PRIMARY KEY,
StoreName VARCHAR(60) NOT NULL
);

CREATE TABLE Staffs(
StaffID INTEGER PRIMARY KEY,
StoreID INTEGER NOT NULL,
FOREIGN KEY (StoreID) REFERENCES Stores(StoreID),
FirstName VARCHAR(255),
LastName VARCHAR(255) NOT NULL
);

CREATE TABLE StoreSales(
SalesID INTEGER PRIMARY KEY,
StoreID INTEGER NOT NULL,
FOREIGN KEY (StoreID) REFERENCES Stores(StoreID),
StaffID INTEGER NOT NULL,
FOREIGN KEY (StaffID) REFERENCES Staffs(StaffID),
BookID INTEGER NOT NULL,
FOREIGN KEY (BookID) REFERENCES Books(BookID),
OrderDate DATE
);

CREATE TABLE Customers(
CustomerID INTEGER PRIMARY KEY,
FirstName VARCHAR(99),
LastName VARCHAR(99) NOT NULL,
BirthMonth VARCHAR(20),
Telephone VARCHAR(22) NOT NULL
);

CREATE TABLE Addresses(
AddressID INTEGER PRIMARY KEY,
CustomerID INTEGER,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
Street VARCHAR(255),
City VARCHAR(50),
Postcode VARCHAR(20)
);

CREATE TABLE OnlineOrders(
OrderID INTEGER PRIMARY KEY,
BookID INTEGER NOT NULL,
FOREIGN KEY (BookID) REFERENCES Books(BookID),
CustomerID INTEGER NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
AddressID INTEGER NOT NULL,
FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID),
OrderDate DATE
);

INSERT INTO
Genres
(GenreID, GenreName)
VALUES
(1, 'Mystery'),
(2, 'Romance'),
(3, 'Contemporary'),
(4, 'Fantasy'),
(5, 'Thrillers'),
(6, 'Biography'),
(7, 'Psychology'),
(8, 'Classic');

#For checking that data entry is correct.
SELECT *
FROM Genres;

INSERT INTO 
Authors
(AuthorID, FirstName, LastName)
VALUES
(1, 'Richard', 'Osman'),
(2, 'Tom', 'Hindle'),
(3, 'Emily', 'Henry'),
(4, 'Sally', 'Ronney'),
(5, 'R. F.', 'Kuang'),
(6, 'Michelle', 'Obama'),
(7, 'Britney', 'Spears'),
(8, 'Cassie', 'Homles'),
(9, 'Jane', 'Austin'),
(10, 'Louisa May', 'Alcott'),
(11, 'Charlotte', 'Bronte');

#For checking that data entry is correct.
SELECT *
FROM Authors;

INSERT INTO
Books
(BookID, Title, AuthorID, GenreID, Price, Stock)
VALUES   
(1, 'The Last Devil to Die', 1, 1, 11.00, 70),
(2, 'The Thursday Murder Club', 1, 1, 7.99, 100),
(3, 'The Murder Game', 2, 1, 7.49, 40),
(4, 'Book Lovers', 3, 2, 8.99, 200),
(5, 'A Million Junes', 3, 3, 9.99, 30),
(6, 'Normal People', 4, 3, 7.99, 90),
(7, 'Babel', 5, 4, 8.49, 100),
(8, 'Yellowface', 5, 5, 16.99, 200),
(9, 'Becoming', 6, 6, 12.99, 350),
(10, 'The Women in Me', 7, 6, 12.50, 300),
(11, 'Happier Hour', 8, 7, 10.99, 70),
(12, 'Pride and Prejudice', 9, 8, 40.95, 80),
(13, 'Little Women', 10, 8, 16.99, 50),
(14, 'Jane Eyre', 11, 8, 16.99, 80);

#For checking that data entry is correct.
SELECT *
FROM Books;

INSERT INTO
Stores
(StoreID, StoreName)
VALUES
(1, 'London'),
(2, 'Bristol'), 
(3, 'Manchester'),
(4, 'Exeter'),
(5, 'York'),
(6, 'Newcastle'),
(7, 'Edinburgh');

#For checking that data entry is correct.
SELECT *
FROM Stores;

INSERT INTO 
Staffs
(StaffID, FirstName, LastName)
VALUES
(1, 'Nicole', 'Rafiee'),
(2, 'Jimmie', 'Lovel'),
(3, 'Jenae', 'Goodman'),
(4, 'Mitchell', 'Carman'),
(5, 'Lenard', 'Farnham'),
(6, 'Joselyn', 'Eldridge'),
(7, 'Pamela', 'Kerr'),
(8, 'Clemence', 'Holland'),
(9, 'Grier', 'Sheppard'),
(10, 'Oaklee', 'Travis'),
(11, 'Alicia', 'Rider'),
(12, 'Avril', 'Swanson'),
(13, 'Zeke', 'Bond'),
(14, 'Liz', 'Mynatt'),
(15, 'Lou', 'Baker'),
(16, 'Brooks', 'Samson'),
(17, 'Bertina', 'Quincey'),
(18, 'Blaire', 'Royle'),
(19, 'Gerard', 'Wood');


#For checking that data entry is correct.
SELECT *
FROM Staffs;

INSERT INTO
StoreSales
(SalesID, StoreID, StaffID, BookID, OrderDate)
VALUES
(1, 4, 11, 7, '2023-12-20'),
(2, 1, 4, 2, '2023-12-20'),
(3, 2, 6, 9, '2023-12-20'),
(4, 5, 13, 9, '2023-12-20'),
(5, 7, 16, 1, '2023-12-20'),
(6, 1, 2, 3, '2023-12-20'),
(7, 3, 9, 8, '2023-12-20'),
(8, 3, 9, 6, '2023-12-20'),
(9, 6, 14, 5, '2023-12-21'),
(10, 7, 18, 4, '2023-12-21'),
(11, 7, 19, 8, '2023-12-21'),
(12, 4, 10, 13, '2023-12-21'),
(13, 1, 3, 14, '2023-12-21'),
(14, 1, 2, 8, '2023-12-21'),
(15, 2, 6, 7, '2023-12-21'),
(16, 2, 7, 5, '2023-12-21'),
(17, 2, 7, 7, '2023-12-21'),
(18, 5, 13, 1, '2023-12-21'),
(19, 1, 1, 2, '2023-12-21'),
(20, 1, 1, 5, '2023-12-21'),
(21, 7, 19, 12, '2023-12-21'),
(22, 7, 18, 2, '2023-12-21'),
(23, 6, 15, 6, '2023-12-22'),
(24, 6, 14, 2, '2023-12-22'),
(25, 5, 13, 1, '2023-12-22'),
(26, 3, 7, 8, '2023-12-22'),
(27, 2, 6, 10, '2023-12-22');

#For checking that data entry is correct.
SELECT *
FROM StoreSales;

INSERT INTO 
Customers
(CustomerID, FirstName, LastName, BirthMonth, Telephone)
VALUES
(1, 'Duncan', 'Bowie', 'Jan', 07788123456),
(2, 'Deborha', 'Swift', 'Feb', 07788234567),
(3, 'Vanessa', 'Kate', 'Mar', 077883456789),
(4, 'Whitney', 'Lee', 'Apr', 07766123456),
(5, 'Ronald', 'Style', 'May', 07766234567),
(6, 'Darwin', 'Cleveland', 'Jun', 077663456789),
(7, 'Emily', 'Stianer', 'Jul', 07799123456),
(8, 'Tiffany', 'Blue', 'Aug', 07799234567);

SELECT *
FROM Customers;

INSERT INTO 
Addresses
(AddressID, Street, City, Postcode)
VALUES
(1, 'Exeter Street', 'Exeter', 'EX1 2PT'),
(2, 'Market Street', 'Newcastle', 'NE1 6AN'),
(3, 'Verney Street', 'Exeter', 'EX1 2ZT'),
(4, 'Verulam Road', 'St Albans', 'AL3 4DA'),
(5, 'Atlantic Crescent', 'Wembley', 'HA9 0UF'),
(6, 'London Street', 'Reading', 'RG1 4AF');

SELECT *
FROM Addresses;

INSERT INTO 
OnlineOrders
(OrderID, BookID, CustomerID, AddressID, OrderDate)
VALUE
(1, 5, 2, 4, '2023-12-21'),
(2, 8, 2, 4, '2023-12-21'),
(3, 14, 2, 4, '2023-12-21'),
(4, 3, 7, 1, '2023-12-21'),
(5, 6, 1, 6, '2023-12-21'),
(6, 8, 5, 5, '2023-12-21'),
(7, 4, 6, 5, '2023-12-21'),
(8, 2, 4, 2, '2023-12-22'),
(9, 1, 4, 2, '2023-12-22');

SELECT *
FROM OnlineOrders;

#Using Joins to find staffs that work for London store
SELECT DISTINCT FirstName, LastName
FROM Staffs AS s1
LEFT JOIN StoreSales AS s2
ON s1.StaffID = s2.StaffID
LEFT JOIN Stores AS s3
ON s2.StoreID = s3.StoreID
WHERE StoreName = 'London';

#Using subquery to find Deborha's address
SELECT *
FROM Addresses
WHERE AddressID IN 
	(SELECT AddressID 
    FROM OnlineOrders
		WHERE CustomerID IN
			(SELECT CustomerID 
            FROM Customers
            WHERE FirstName = 'Deborha'));
