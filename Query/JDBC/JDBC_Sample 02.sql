USE jdbc;

CREATE TABLE members (
	id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    isbn VARCHAR(20) PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    publish_year INT,
    genre VARCHAR(50)
);

INSERT INTO books (isbn, title, author, publish_year, genre) VALUES
	('978-0-131-18493-8', 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Classic'),
	('978-0-142-07652-6', '1984', 'George Orwell', 1949, 'Dystopian'),
	('978-0-152-06871-4', 'To Kill a Mockingbird', 'Harper Lee', 1960, 'Drama'),
	('978-0-684-84328-5', 'Brave New World', 'Aldous Huxley', 1932, 'Science Fiction'),
	('978-0-141-43948-7', 'Animal Farm', 'George Orwell', 1945, 'Political Satire'),
	('978-0-679-74531-9', 'Lolita', 'Vladimir Nabokov', 1955, 'Novel'),
	('978-0-143-14483-8', '1984', 'George Orwell', 1949, 'Dystopian'),
	('978-0-553-21478-0', 'Fahrenheit 451', 'Ray Bradbury', 1953, 'Dystopian'),
	('978-0-394-58639-2', 'Catch-22', 'Joseph Heller', 1961, 'Satire'),
	('978-0-679-73256-2', 'Beloved', 'Toni Morrison', 1987, 'Historical Fiction'),
	('978-0-451-52493-5', 'Crime and Punishment', 'Fyodor Dostoevsky', 1866, 'Psychological Fiction'),
	('978-0-143-03483-5', 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Classic'),
	('978-0-375-75910-1', 'The Catcher in the Rye', 'J.D. Salinger', 1951, 'Novel'),
	('978-0-316-76948-3', 'The Da Vinci Code', 'Dan Brown', 2003, 'Mystery'),
	('978-0-099-28391-9', 'The Shining', 'Stephen King', 1977, 'Horror'),
	('978-0-679-74656-9', 'The Road', 'Cormac McCarthy', 2006, 'Post-apocalyptic'),
	('978-0-618-00220-3', 'Life of Pi', 'Yann Martel', 2001, 'Adventure Fiction'),
	('978-0-141-43948-6', 'The Hobbit', 'J.R.R. Tolkien', 1937, 'Fantasy'),
	('978-0-679-74532-6', 'The Handmaid\'s Tale', 'Margaret Atwood', 1985, 'Dystopian'),
	('978-0-553-21311-9', 'Lord of the Flies', 'William Golding', 1954, 'Allegorical Novel');

SELECT * FROM members;
SELECT * FROM books;