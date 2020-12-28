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


-- Select the genre with the most books : Use Group By because of 'genre'
-- SELECT genre FROM books GROUP BY genre ORDER BY COUNT(genre) DESC LIMIT 1;*
-- * Counts the column genre
