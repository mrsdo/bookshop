# bookshop
https://w3schools.com/sql/
What is a table in SQL? 
A blueprint for data, like a person may have a name, age, date of birth, etc.
Consists of one primary key (id as integer + auto increment)

sqlite3> sqlite3 database_name.db

CREATE TABLE tablename(
    id INTEGER PRIMARY KEY,
    title TEXT,
    pages INTEGER
);

DROP TABLE table_name

### ALTER TABLE
// ADD To Table
- Adds columns to the table

Syntax:

ALTER TABLE books ADD COLUMN publishing_date TEXT;

// Drop table column ???
# Not available in sqlite3...

### INSERT
- Adding record, represents instances of the data
- Adding multiple column data
- Primary key is autogenerated
Syntax
  INSERT INTO books (title, pages) VALUES("Name of the Wind", 325);
- Record Queries
- Use Column Pretty:
  .mode column 
  .headers on
  .width auto
**Presents:**
  id          title             pages
----------  ----------------  ----------
    1       Name of the Wind     325  

 ### SELECT
SELECT column or * FROM table_name;

### FILE SYNTAX
touch filename.ext  
use sequential filenames to manually engage sql syntax and tools, .etc., 
touch 001_create_books.sql
touch 002_inseert_books.sql

001_create_books.sql has the CREATE TABLE syntax
002_insert_books.sql contains the INSERT INTO syntax

From the command line, use:

sqlite3 database_name < 001_create_books.sql <enter>
library.db is auto-generated
sqlite3 database_name < 002_insert_books.sql <enter>
INSERT INTO generates books titles with pages

id          title             pages
----------  ----------------  ----------
1           Name of the Wind  325       
2           LOTR              425       
3           Harry Potter      525       
4           Goldfinch         227       
5           Into the Woods    187 

### WHERE (AND | OR)
- Conditional
- Takes =, <, > <=, >=, > or <
- SELECT * FROM books WHERE pages > 190;
  SELECT * FROM books WHERE pages > 190 AND pages < 425;
### ORDER
- Works well with GROUP and LIMIT
  Order by column ASC or DESC
  Limits the query by a number, return the top value(s)
- examples:
sqlite> SELECT * FROM books ORDER BY pages ASC;
id          title           pages
----------  --------------  ----------
5           Into the Woods  187       
4           Goldfinch       227       
1           Name of the Wi  325       
2           LOTR            425       
3           Harry Potter    525

SELECT * FROM books ORDER BY title ASC;
id          title       pages
----------  ----------  ----------
4           Goldfinch   227       
3           Harry Pott  525       
5           Into the W  187       
2           LOTR        425       
1           Name of th  325
SELECT * FROM books ORDER BY pages DESC LIMIT 1;
id          title         pages
----------  ------------  ----------
3           Harry Potter  525
Returns the book with the most pages
### GROUP
- Base the query on the column
  Sample Queries:
  sqlite> SELECT genre, COUNT(genre) from books GROUP BY genre ORDER BY COUNT(genre);
  genre       COUNT(genre)
----------  ------------
Fantasy     2           
Fiction     3           
sqlite> SELECT genre, COUNT(genre) from books GROUP BY genre ORDER BY COUNT(genre) DESC;
genre       COUNT(genre)
----------  ------------
Fiction     3           
Fantasy     2

### UPDATE
- Updating records after adding a new column
- Where new data is inserted into the new column
- Syntax
  UPDATE books
  SET genre = "Fiction"
  WHERE id = 1;

UPDATE books
SET genre = "Fantasy"
WHERE id = 2;

UPDATE books
SET genre = "Fantasy"
WHERE id = 3;

UPDATE books
SET genre = "Fiction"
WHERE id = 4;

UPDATE books
SET genre = "Fiction"
WHERE id = 5;

-- INSERT INTO books (title, pages) VALUES("Name of the Wind", 325);
-- INSERT INTO books (title, pages) VALUES("LOTR", 425);
-- INSERT INTO books (title, pages) VALUES("Harry Potter", 525);
-- INSERT INTO books (title, pages) VALUES("Goldfinch", 227);
-- INSERT INTO books (title, pages) VALUES("Into the Woods", 187);

run this command: sqlite3 library.db < 004_update_books.sql    

Can also use this example to update multiple records:
UPDATE books
SET genre = "Fiction"
WHERE id = 1 OR id = 4 OR id = 5;

sqlite> SELECT * FROM books;
id          title             pages       genre
----------  ----------------  ----------  ----------
1           Name of the Wind  325         Fiction   
2           LOTR              425         Fantasy   
3           Harry Potter      525         Fantasy   
4           Goldfinch         227         Fiction   
5           Into the Woods    187         Fiction  

### Having
-- Used queries requiring on aggregate conditions (min or max)
-- Requires GROUP BY

Syntax:
sqlite> SELECT books.* FROM books GROUP BY books.title HAVING MAX(books.pages) > 180;
id          title       pages       genre
----------  ----------  ----------  ----------
4           Goldfinch   227         Fiction   
3           Harry Pott  525         Fantasy   
5           Into the W  187         Fiction   
2           LOTR        425         Fantasy   
1           Name of th  325         Fiction

sqlite> SELECT books.* FROM books GROUP BY books.title HAVING MAX(books.pages) > 200;
id          title       pages       genre
----------  ----------  ----------  ----------
4           Goldfinch   227         Fiction   
3           Harry Pott  525         Fantasy   
2           LOTR        425         Fantasy   
1           Name of th  325         Fiction

- This query contains a query inside a query.  Where # of pages above averages but less than max
  sqlite> SELECT books.* FROM books GROUP BY books.title HAVING MAX(books.pages) > (SELECT AVG(books.pages) FROM books GROUP BY pages);
  id          title       pages       genre
----------  ----------  ----------  ----------
4           Goldfinch   227         Fiction   
3           Harry Pott  525         Fantasy   
2           LOTR        425         Fantasy   
1           Name of th  325         Fiction

### Joins
-- Connects relational table data
3 relationships (belongs_to, has_many, many_to_many)
-- belongs_to is the only one that uses a foreign key : Using the primary key of another table as the foreign key

Joins Syntax and example
-- Created 005_create_authors and 006_add_author_id

Martiniqu@devbox bookshop % touch 005_create_authors.sql
Martiniqu@devbox bookshop % touch 006_add_author_id_to_books.sql
Martiniqu@devbox bookshop % sqlite3 library.db < 005_create_authors.sql
Martiniqu@devbox bookshop % sqlite3 library.db < 006_add_author_id_to_books.sql
Martiniqu@devbox bookshop % sqlite3 library.db                                 
SQLite version 3.32.3 2020-06-18 14:16:19
Enter ".help" for usage hints.
sqlite> .schema
CREATE TABLE books(
id INTEGER PRIMARY KEY,
title TEXT,
pages INTEGER
, genre TEXT, author_id INTEGER);
CREATE TABLE authors (
id INTEGER PRIMARY KEY,
name TEXT
);

Now, we need to add the author_id's to each one of our books:

INSERT INTO books (title, pages) VALUES("Name of the Wind", 325);
INSERT INTO books (title, pages) VALUES("LOTR", 425);
INSERT INTO books (title, pages) VALUES("Harry Potter", 525);
INSERT INTO books (title, pages) VALUES("Goldfinch", 227);
INSERT INTO books (title, pages) VALUES("Into the Woods", 187);

Syntax: 
007_insert_authors.sql
INSERT INTO authors (name) values
("Patrick Rolflith"),
("J.R.R. Tolkein"),
("JK Rowling"),
("Donna Tartt"),
("Tana French")

Now we update books with author data
Created 008_update_books_with_author_id.sql to add new authors
UPDATE books
SET author_id = 1
WHERE books.id = 1;
-- Sets foreign key to the primary key of author

UPDATE books
SET author_id = 2
WHERE books.id = 2;

UPDATE books
SET author_id = 3
WHERE books.id = 3;

UPDATE books
SET author_id = 4
WHERE books.id = 4;

UPDATE books
SET author_id = 5
WHERE books.id = 5;

*****

This is where JOINS works best.  

id          title             pages       genre       author_id
----------  ----------------  ----------  ----------  ----------
1           Name of the Wind  325         Fiction     1         
2           LOTR              425         Fantasy     2         
3           Harry Potter      525         Fantasy     3         
4           Goldfinch         227         Fiction     4         
5           Into the Woods    187         Fiction     5

We need to map the books.author_id to author.id

sqlite> SELECT * FROM books JOIN authors ON books.author_id = authors.id;
id          title             pages       genre       author_id   id          name
----------  ----------------  ----------  ----------  ----------  ----------  ----------------
1           Name of the Wind  325         Fiction     1           1           Patrick Rolflith
2           LOTR              425         Fantasy     2           2           J.R.R. Tolkein  
3           Harry Potter      525         Fantasy     3           3           JK Rowling      
4           Goldfinch         227         Fiction     4           4           Donna Tartt     
5           Into the Woods    187         Fiction     5           5           Tana French

To simplify the query:

sqlite> SELECT books.title, authors.name AS authors_name FROM books JOIN authors ON books.author_id = authors.id;
title             authors_name
----------------  ----------------
Name of the Wind  Patrick Rolflith
LOTR              J.R.R. Tolkein  
Harry Potter      JK Rowling      
Goldfinch         Donna Tartt     
Into the Woods    Tana French

sqlite> SELECT books.title book_title, authors.name authors_name FROM books JOIN authors ON books.author_id = authors.id;
book_title        authors_name
----------------  ----------------
Name of the Wind  Patrick Rolflith
LOTR              J.R.R. Tolkein  
Harry Potter      JK Rowling      
Goldfinch         Donna Tartt     
Into the Woods    Tana French

Let's add another book for JRR Tolkien, The Hobbit

Syntax:

sqlite> INSERT INTO books (title, pages, author_id) VALUES ("The Hobbitt", 357, 2);
sqlite> SELECT books.title book_title, authors.name authors_name FROM books JOIN authors ON books.author_id = authors.id;
book_title        authors_name
----------------  ----------------
Name of the Wind  Patrick Rolflith
LOTR              J.R.R. Tolkein  
Harry Potter      JK Rowling      
Goldfinch         Donna Tartt     
Into the Woods    Tana French     
The Hobbitt       J.R.R. Tolkein  
sqlite>


This is setup as a belongs_to, has_many relationship

### Advanced Query Practice
  