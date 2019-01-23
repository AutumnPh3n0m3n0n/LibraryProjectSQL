--USE [db_library]
--GO
--/****** Object:  StoredProcedure [dbo].[Populate_db_zoo]    Script Date: 3/27/2017 9:37:11 AM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO

--CREATE PROCEDURE [dbo].[Populate_db_library]
--AS
--BEGIN

USE MASTER
Go
DROP DATABASE db_library
GO
CREATE DATABASE db_library
GO
USE db_library
GO


	CREATE TABLE library_branch (
		branch_id BIGINT PRIMARY KEY NOT NULL,
		branch_name VARCHAR(30) NOT NULL,
		branch_address VARCHAR(60)
	);



	CREATE TABLE publishers (
		publisher_name VARCHAR(50) PRIMARY KEY NOT NULL,
		publisher_contact BIGINT NOT NULL
	);


	CREATE TABLE books (
		book_id BIGINT PRIMARY KEY NOT NULL,
		book_title VARCHAR(50) NOT NULL,
		book_genre VARCHAR(30) NOT NULL,
		publisher_name VARCHAR(50) NOT NULL CONSTRAINT fk_publisher_id FOREIGN KEY REFERENCES publishers(publisher_name) ON UPDATE CASCADE ON DELETE CASCADE
	);

	CREATE TABLE book_authors (
		book_id BIGINT NOT NULL CONSTRAINT fk_book_id FOREIGN KEY REFERENCES books(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
		author_fname VARCHAR(30) NOT NULL,
		author_lname VARCHAR(30) NOT NULL
	);

	CREATE TABLE book_copies (
		book_id BIGINT NOT NULL CONSTRAINT fk_copy_id FOREIGN KEY REFERENCES books(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
		branch_id BIGINT NOT NULL CONSTRAINT fk_branch_id FOREIGN KEY REFERENCES library_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
		num_of_copies INT NOT NULL
	);

	CREATE TABLE borrowers (
		card_number BIGINT PRIMARY KEY NOT NULL,
		person_fname VARCHAR(30) NOT NULL,
		person_lname VARCHAR(30) NOT NULL,
		person_address VARCHAR(60) NOT NULL,
		person_contact BIGINT NOT NULL
	);

	CREATE TABLE book_loans (
		--loan_id BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
		book_id BIGINT NOT NULL CONSTRAINT fk_title_id FOREIGN KEY REFERENCES books(book_id) ON UPDATE CASCADE ON DELETE CASCADE, 
		branch_id BIGINT NOT NULL CONSTRAINT fk_library_id FOREIGN KEY REFERENCES library_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
		card_number BIGINT NOT NULL CONSTRAINT fk_borrower_id FOREIGN KEY REFERENCES borrowers(card_number) ON UPDATE CASCADE ON DELETE CASCADE,
		checkOut_date VARCHAR(20) NOT NULL,
		checkIn_date VARCHAR(20) NOT NULL
	);

--Changing some columns in book loans since I'm making changes
	/*
	ALTER TABLE book_loans
		DROP COLUMN out_month, out_day, out_year, due_month, due_day, due_year;

	UPDATE book_loans 
	SET checkOut_date  

	ALTER TABLE book_loans
		ADD checkOut_date VARCHAR(20) NOT NULL, checkIn_date VARCHAR(20) NOT NULL;
	*/


	/*****************************************************
	 * Inserting into the data tables
	 ******************************************************/

	INSERT INTO library_branch
		(branch_id, branch_name, branch_address)
		VALUES 
		(654354345,'Central', '3333 W 2nd Ave'),
		(382618493,'North', '1234 NE Adams St'),
		(749271502,'South', '54321 SW Washington Blvd'),
		(902384218,'East', '22222 SE Walker Rd'),
		(029428949,'West', '13579 NW Anderson Dr'),
		(539874590,'Sharpstown', '9876 N York St')
	;
	SELECT * FROM library_branch;

	INSERT INTO publishers
		(publisher_name, publisher_contact)
		VALUES
		('New York Writing Co', 7183047294),
		('Chicago Writing Co', 3128562839),
		('San Francisco Writing Co', 4152475917),
		('Los Angeles Writing Co', 3234129472),
		('DC Writing Co', 2028462947),
		('Toronto Writing Co', 4165264927),
		('Atlanta Writing Co', 4048261847),
		('Boston Writing Co', 6172936492)
	;
	SELECT * FROM publishers;


	INSERT INTO books
		(book_id, book_title, book_genre, publisher_name)
		VALUES
		(111, 'Harry Potter', 'Fantasy', 'New York Writing Co'),
		(222, 'Game of Thrones', 'Fantasy', 'Los Angeles Writing Co'),
		(333, 'Chronicles of Narnia', 'Fantasy', 'Chicago Writing Co'),
		(444, 'Lord of the Rings', 'Fantasy', 'Toronto Writing Co'),
		(555, 'Star Wars', 'Science Fiction', 'Los Angeles Writing Co'),
		(666, 'The Lost Tribe', 'Adventure', 'Atlanta Writing Co'),
		(777, 'The Demigod Chronicles', 'Fantasy', 'San Francisco Writing Co'),
		(888, 'The Hunger Games', 'Young Adult', 'Chicago Writing Co'),
		(999, 'Misery', 'Horror', 'Boston Writing Co'),
		(1110, 'The Cursed Child', 'Fantasy', 'New York Writing Co'),
		(1221, 'Pet Cemetary', 'Horror', 'Chicago Writing Co'),
		(1332, 'Twilight', 'Fantasy', 'San Francisco Writing Co'),
		(1443, 'The Shining', 'Horror', 'Los Angeles Writing Co'),
		(1554, 'The Veldt', 'Science Fiction', 'Toronto Writing Co'),
		(1665, 'Fahrenheight 451', 'Science Fiction', 'Chicago Writing Co'),
		(1776, 'Great Expectations', 'History', 'San Francisco Writing Co'),
		(1887, 'Oliver Twist','History', 'Los Angeles Writing Co'),
		(1998, 'Slaughterhouse Five', 'Science Fiction', 'Atlanta Writing Co'),
		(2109, 'James and the Giant Peach', 'Fantasy', 'Los Angeles Writing Co'),
		(2220, 'Charlie and the Chocolate Factory', 'Fantasy', 'Boston Writing Co')
	;
	SELECT * FROM books;

	INSERT INTO book_authors
		(book_id, author_fname, author_lname)
		VALUES
		(1221, 'Stephen', 'King'),
		(999, 'Stephen', 'King'),
		(1443, 'Stephen', 'King'),
		(111, 'Joanne', 'Rowling'),
		(1110, 'Joanne', 'Rowling'),
		(222, 'George', 'Martin'),
		(333, 'Clive', 'Lewis'),
		(777, 'Rick','Riordan'),
		(555, 'George', 'Lucas'),
		(666, 'Mark', 'Lee'),
		(1332, 'Stephenie', 'Meyer'),
		(888, 'Suzanne', 'Collins'),
		(1554, 'Ray', 'Bradbury'),
		(1665, 'Ray', 'Bradbury'),
		(1998, 'Kurt', 'Vonnegut'),
		(444, 'John', 'Tolkien'),
		(1776, 'Charles', 'Dickens'),
		(1887, 'Charles', 'Dickens'),
		(2109, 'Roald', 'Dahl'),
		(2220, 'Roald', 'Dahl')
	;
	SELECT * FROM book_authors;

	INSERT INTO book_copies
		(book_id, branch_id, num_of_copies)
		VALUES
		/*Central Library*/
		(666, 654354345, 4),
		(555, 654354345, 3),
		(333, 654354345, 3),
		(888, 654354345, 3),
		(1443, 654354345, 3),
		(1332, 654354345, 4),
		(999, 654354345, 3),
		(1110, 654354345, 3),
		(1776, 654354345, 3),
		(1998, 654354345, 3),
		/*North Library*/
		(666, 382618493, 5),
		(777, 382618493, 3),
		(111, 382618493, 3),
		(222, 382618493, 4),
		(1221, 382618493, 2),
		(1332, 382618493, 5),
		(1887, 382618493, 3),
		(2220, 382618493, 3),
		(2109, 382618493, 4),
		(444, 382618493, 2),
		/*South Library*/
		(666, 749271502, 5),
		(1332, 749271502, 3),
		(1443, 749271502, 3),
		(1665, 749271502, 4),
		(2220, 749271502, 4),
		(777, 749271502, 5),
		(222, 749271502, 3),
		(888, 749271502, 3),
		(1221, 749271502, 4),
		(2109, 749271502, 4),
		/*East Library*/
		(666, 902384218, 5),
		(333, 902384218, 3),
		(1665, 902384218, 3),
		(1443, 902384218, 4),
		(1998, 902384218, 4),
		(222, 902384218, 5),
		(111, 902384218, 3),
		(999, 902384218, 3),
		(777, 902384218, 4),
		(1776, 902384218, 4),
		/*West Library*/
		(666, 029428949, 5),
		(444, 029428949, 3),
		(555, 029428949, 3),
		(1887, 029428949, 4),
		(1554, 029428949, 4),
		(1332, 029428949, 5),
		(1221, 029428949, 3),
		(1110, 029428949, 3),
		(2220, 029428949, 4),
		(888, 029428949, 4),
		/*Sharpstown Library*/
		(777, 539874590, 5),
		(666, 539874590, 3),
		(222, 539874590, 3),
		(1887, 539874590, 4),
		(2109, 539874590, 4),
		(333, 539874590, 5),
		(444, 539874590, 3),
		(1554, 539874590, 3),
		(1665, 539874590, 4),
		(999, 539874590, 4)
	;
	SELECT * FROM book_copies;


	INSERT INTO borrowers
		(card_number, person_fname, person_lname, person_address, person_contact)
		VALUES
		(32868423764, 'Alex','Anderson', '213 W Andy Warhohl Ave', 2876416827),
		(39482795062, 'Brian','Benson', '345 NW Bill Gates St', 4782917263),
		(75937294753, 'David','Dawson', '456 E David Beckham St', 4729164832),
		(43872475945, 'Gareth', 'Gifford', '55555 S George Bush St', 5839472983), --does not have any books checked out
		(49435782391, 'James','Jakobs', '128 S Justin Bieber St', 5821836253),
		(94378522353, 'Karl','Killingsworth', '22222 E Kanye West St', 3947205837),
		(78345983289, 'Liam', 'Lawrence', '4321 N Lebron James St' , 6292749271),
		(87359483278, 'Morgan','Matthews', '456 E Michael Jordan St', 3892719473),
		(23458975784, 'Nate', 'Norris', '234 N Natalie Portman Ave', 23984723476), --does not have any books checked out
		(18537389456, 'Rick','Randall', '333 SE Roger Federer Blvd', 3274916492),
		(04389453756, 'Sam','Smith', '8888 N Selena Gomez Ave', 1749362859),
		(62958934569, 'Timothy','Torres', '789 S Taylor Swift Dr', 5726184381),
		(17593289453, 'Victor','Valenzuela', '54321 NE Vin Diesel Blvd', 2748263743),
		(51895435782, 'Walter', 'White', '4444 SW Will Smith Dr', 5739273843)
	;
	SELECT * FROM borrowers;



	INSERT INTO book_loans
		(book_id, branch_id, card_number, checkOut_date, checkIn_date)
		VALUES
		(111, 654354345, 32868423764, '1-3-19', '1-17-19'),
		(333, 654354345, 87359483278, '1-4-19', '1-18-19'),
		(555, 654354345, 04389453756, '1-5-19', '1-20-19'),
		(777, 654354345, 04389453756, '1-7-19', '1-23-19'),
		(999, 654354345, 94378522353, '1-8-19', '1-22-19'),
		(1221, 654354345, 62958934569, '1-9-19', '1-21-19'),
		(1443, 654354345, 87359483278, '1-10-19', '1-25-19'),
		(1665, 654354345, 32868423764, '1-11-19', '1-24-19'),
		(1887, 654354345, 04389453756, '1-12-19', '1-26-19'),
		(2109, 382618493, 62958934569, '1-3-19', '1-25-19'),
		(222, 382618493, 17593289453, '1-4-19', '1-19-19'),
		(444, 654354345, 51895435782, '1-6-19', '1-16-19'),
		(666, 382618493, 32868423764, '1-5-19', '1-17-19'),
		(888, 382618493, 78345983289, '1-6-19', '2-2-19'),
		(1110, 382618493, 75937294753, '1-7-19', '2-3-19'),
		(1332, 382618493, 49435782391, '1-8-19', '2-1-19'),
		(1554, 382618493, 94378522353, '1-9-19', '1-31-19'),
		(1776, 382618493, 78345983289, '1-10-19', '1-20-19'),
		(1998, 382618493, 87359483278, '1-11-19', '2-5-19'),
		(2220, 382618493, 04389453756, '1-12-19', '2-6-19'),
		(111, 749271502, 18537389456, '1-3-19', '1-15-19'),
		(333, 749271502, 62958934569, '1-4-19', '1-16-19'),
		(555, 749271502, 17593289453, '1-5-19', '1-17-19'),
		(777, 749271502, 51895435782, '1-6-19', '1-18-19'),
		(999, 749271502, 32868423764, '1-7-19', '1-19-19'),
		(1221, 749271502, 39482795062, '1-8-19', '1-20-19'),
		(1443, 749271502, 75937294753, '1-9-19', '1-29-19'),
		(1665, 749271502, 49435782391, '1-10-19', '1-18-19'),
		(1887, 749271502, 94378522353, '1-11-19', '1-19-19'),
		(2109, 749271502, 78345983289, '1-12-19', '1-29-19'),
		(222, 902384218, 87359483278, '1-4-19', '1-11-19'),
		(444, 902384218, 62958934569, '1-5-19', '1-12-19'),
		(666, 902384218, 04389453756, '1-6-19', '2-2-19'),
		(888, 902384218, 62958934569, '1-7-19', '2-2-19'),
		(1110, 902384218, 17593289453, '1-8-19', '2-2-19'),
		(1332, 902384218, 32868423764, '1-9-19', '2-9-19'),
		(1554, 902384218, 32868423764, '1-10-19', '2-7-19'),
		(1776, 902384218, 39482795062, '1-11-19', '2-8-19'),
		(1998, 902384218, 75937294753, '1-12-19', '2-9-19'),
		(2220, 902384218, 49435782391, '1-13-19', '2-6-19'),
		(111, 029428949, 94378522353, '1-5-19', '1-20-19'),
		(222, 029428949, 78345983289, '1-6-19', '1-21-19'),
		(333, 029428949, 87359483278, '1-7-19', '1-22-19'),
		(444, 029428949, 18537389456, '1-8-19', '1-23-19'),
		(555, 029428949, 04389453756, '1-9-19', '1-24-19'),
		(666, 029428949, 62958934569, '1-1-19', '1-25-19'),
		(777, 029428949, 17593289453, '1-2-19', '1-19-19'),
		(888, 029428949, 51895435782, '1-3-19', '1-18-19'),
		(999, 029428949, 32868423764, '1-4-19', '1-17-19'),
		(1110, 029428949, 39482795062, '1-5-19', '1-22-19'),
		(1221, 539874590, 75937294753, '1-6-19', '1-23-19'),
		(1332, 539874590, 49435782391, '1-7-19', '1-24-19'),
		(1443, 539874590, 94378522353, '1-8-19', '1-22-19'),
		(1554, 539874590, 78345983289, '1-9-19', '1-23-19'),
		(1665, 539874590, 87359483278, '1-10-19', '1-24-19'),
		(1776, 539874590, 18537389456, '1-12-19', '1-22-19'),
		(1887, 539874590, 04389453756, '1-13-19', '1-23-19'),
		(1998, 539874590, 62958934569, '1-14-19', '1-24-19'),
		(2109, 539874590, 17593289453, '1-15-19', '1-22-19'),
		(2220, 539874590, 51895435782, '1-6-19', '1-23-19')
	;
	SELECT * FROM book_loans;

