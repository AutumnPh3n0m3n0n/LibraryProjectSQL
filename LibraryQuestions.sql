USE [db_library]
GO

--Step 1: Find how many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"
	SELECT
		dbo.books.book_title as 'Title:', dbo.book_copies.num_of_copies as 'Copies:', 
		dbo.library_branch.branch_name as 'Branch:', dbo.library_branch.branch_address as 'Branch Address:'
		FROM book_copies
		INNER JOIN dbo.books ON dbo.books.book_id = dbo.book_copies.book_id
		INNER JOIN dbo.library_branch ON dbo.library_branch.branch_id = dbo.book_copies.branch_id
		WHERE book_title = 'The Lost Tribe' AND branch_name = 'Sharpstown'
	;


--Step 2: Find how many copies of the book titled "The Lost Tribe" are owned by each library branch?
	SELECT 
		dbo.books.book_title as 'Title:', dbo.book_copies.num_of_copies as 'Copies:',
		dbo.library_branch.branch_name as 'Branch:'
		FROM book_copies
		INNER JOIN dbo.books ON dbo.books.book_id = dbo.book_copies.book_id
		INNER JOIN dbo.library_branch ON dbo.library_branch.branch_id = dbo.book_copies.branch_id
		WHERE book_title = 'The Lost Tribe'


--Step 3: Retrieve the names of all borrowers who do not have any books checked out.
	SELECT dbo.borrowers.person_fname as 'First Name:', dbo.borrowers.person_lname as 'Last Name:',
		dbo.borrowers.person_address as 'Address:', dbo.book_loans.card_number as 'Card Number:'
		FROM book_loans
		RIGHT JOIN dbo.borrowers ON dbo.borrowers.card_number = dbo.book_loans.card_number
		WHERE book_loans.card_number IS NULL

--Step 4: For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.
		SELECT 
			dbo.borrowers.person_fname as 'First Name:', dbo.borrowers.person_lname as 'Last Name:',
			dbo.books.book_title as 'Book Checked Out:', dbo.book_loans.checkIn_date as 'Day Due:',
			dbo.borrowers.person_address as 'Home Adress:', dbo.borrowers.person_contact as 'Contact Number:'
			FROM book_loans
			INNER JOIN dbo.books ON dbo.books.book_id = dbo.book_loans.book_id
			INNER JOIN dbo.library_branch ON dbo.library_branch.branch_id = dbo.book_loans.branch_id
			INNER JOIN dbo.borrowers ON dbo.borrowers.card_number = dbo.book_loans.card_number
			WHERE branch_name = 'Sharpstown' AND checkIn_date = '1-23-19'


--Step 5: For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
		SELECT dbo.library_branch.branch_name as 'Branch:', SUM(dbo.book_copies.num_of_copies) as 'Total Number of Books:'
			FROM dbo.book_copies
			INNER JOIN dbo.library_branch ON dbo.library_branch.branch_id = dbo.book_copies.branch_id
			GROUP BY dbo.library_branch.branch_name



--Step 6: Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out.
	SELECT dbo.borrowers.person_fname as 'First Name:', dbo.borrowers.person_lname as 'Last Name:',
		dbo.borrowers.person_address as 'Address:',COUNT(*) as 'Number of Loans'
		FROM dbo.book_loans
		INNER JOIN dbo.borrowers ON dbo.borrowers.card_number = dbo.book_loans.card_number
		GROUP BY dbo.borrowers.person_fname, dbo.borrowers.person_lname, dbo.borrowers.person_address 
		HAVING COUNT(*) > 5


--Step 7: For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

	SELECT
		dbo.books.book_title as 'Title:', dbo.books.book_genre as 'Genre:',
		dbo.book_authors.author_fname as 'Author First Name:',
		dbo.book_authors.author_lname as 'Author Last Name:', dbo.library_branch.branch_name as 'Branch:',
		dbo.book_copies.num_of_copies as 'Number of Copies:'
		FROM book_copies
		INNER JOIN dbo.books ON dbo.books.book_id = dbo.book_copies.book_id
		INNER JOIN dbo.book_authors ON dbo.book_authors.book_id = dbo.books.book_id
		INNER JOIN dbo.library_branch ON dbo.library_branch.branch_id = dbo.book_copies.branch_id
		WHERE author_fname = 'Stephen' AND author_lname = 'King' AND branch_name = 'Central'
