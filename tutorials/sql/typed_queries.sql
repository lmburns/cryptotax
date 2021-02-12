# Typing SQL

SELECT name, birthdt FROM people
	WHERE birthdt BETWEEN CAST('1990-01-01' AS DATETIME)
					  AND CAST('2000-01-01' AS DATETIME);


SELECT title, author_lname FROM books
	WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');


SELECT title, released_year FROM books
	WHERE released_year >= 2000 AND released_year % 2 = 0;


SELECT title, released_year,
		  CASE
	  		WHEN released_year >= 2000 THEN 'Modern Lit'
	  		ELSE '20th Century Lit'
	  	  END AS Genre
   FROM books;


SELECT title, stock_quantity,
		  CASE
		  	WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
		  	WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
		  	ELSE '***'
		  END AS stock
  FROM books;


  UPDATE TABLE books,
  	SET stock = (
  		CASE
		  	WHEN stock_quantity <= 50 THEN '*'
		  	WHEN stock_quantity <= 100 THEN '**'
		  	ELSE '***'
		  END)
  	FROM books;


  	SELECT title, author_lname,
  		CASE
  			WHEN title LIKE '%stories%' THEN 'Short Stories'
  			WHEN title = 'Just Kids' OR title = 'A Heartbreaking Work' THEN 'Memior'
  			ELSE 'Novel'
  		END as TYPE
  	FROM books;


SELECT author_lname,
	CASE
		WHEN COUNT(*) = 1 THEN '1 book'
		ELSE CONCAT(COUNT(*), ' books')
	END AS COUNT
FROM books
GROUP BY author_lname, author_fname;


SELECT first_name, last_name, SUM(amount) as total_spent
FROM customers
JOIN orders
	ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent;


CREATE TABLE students(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100));

CREATE TABLE papers(
	title VARCHAR(100),
	grade DECIMAL(4,2),
	student_id INT,
	FOREIGN KEY(student_id) REFERENCES students(id));

-- Section 12 // Video 22 // Problem 4
SELECT first_name, IFNULL(AVG(grade), 0) AS average
FROM students LEFT JOIN papers
	ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;


-- Section 12 // Video 22 // Problem 5
SELECT first_name,
IFNULL(AVG(grade), 0) AS average,
CASE
	WHEN AVG(grade) IS NULL THEN 'FAILING'
	WHEN AVG(grade) >= 75 THEN 'PASSING'
	ELSE 'FAILING'
END AS passing_status
FROM students
LEFT JOIN papers
	ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;


-- Section 13 // Video 5 // Problem 1
SELECT title, rating FROM series
RIGHT JOIN reviews
	ON series.id = reviews.series_id;


-- Section 13 // Video 6 // Problem 2
SELECT title, AVG(rating) AS rating FROM series
RIGHT JOIN reviews
	ON series.id = reviews.series_id
GROUP BY series.id
ORDER BY rating ASC;


-- Section 13 // Video 7 // Problem 3
SELECT first_name, last_name, rating FROM reviewers
JOIN reviews
	ON reviewers.id = reviews.reviewer_id;


-- Section 13 // Video 8 // Problem 4
SELECT * FROM series
LEFT JOIN reviews
	ON series.id = reviews.series_id;

SELECT title, IFNULL(rating, 'Unreviewed') AS unreviewed_series FROM series
LEFT JOIN reviews
	ON series.id = reviews.series_id
WHERE rating IS NULL;


-- Section 13 // Video 9 // Problem 5
SELECT genre, ROUND(AVG(rating), 2) AS avg_rating FROM series
INNER JOIN reviews
	ON series.id = reviews.series_id
GROUP BY series.genre;


-- Section 13 // Video 10 // Problem 6
SELECT
	first_name,
	last_name,
	COUNT(reviews.id) AS COUNT,
	IFNULL(MIN(reviews.rating), 0) AS MIN,
	IFNULL(MAX(reviews.rating), 0) AS MAX,
	ROUND(IFNULL(AVG(reviews.rating), 0), 2) AS AVG,
	IF(COUNT(reviews.id) >= 1, 'ACTIVE', 'INACTIVE') AS STATUS
FROM reviewers
LEFT JOIN reviews
	ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;


-- Section 13 // Video 11 // Problem 7
SELECT title, rating, CONCAT(first_name, ' ', last_name) AS NAME FROM reviewers
INNER JOIN reviews
	ON reviewers.id = reviews.reviewer_id
INNER JOIN series
	ON series.id = reviews.series_id
ORDER BY title;

#############################################################

-- INSTAGRAM
CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW());


CREATE TABLE photos(
	id INT AUTO_INCREMENT PRIMARY KEY,
	image_url VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id));


CREATE TABLE comments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(photo_id) REFERENCES photos(id));


CREATE TABLE likes(
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	PRIMARY KEY(user_id, photo_id));


CREATE TABLE follows(
	follower_id INT NOT NULL,
	followee_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(follower_id) REFERENCES users(id),
	FOREIGN KEY(followee_id) REFERENCES users(id),
	PRIMARY KEY(follower_id, followee_id));


CREATE TABLE tags(
	id INT AUTO_INCREMENT PRIMARY KEY,
	tag_name VARCHAR(255) UNIQUE,
	created_at TIMESTAMP DEFAULT NOW());


CREATE TABLE photo_tags(
	photo_id INT NOT NULL,
	tag_id INT NOT NULL,
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	FOREIGN KEY(tag_id) REFERENCES tags(id),
	PRIMARY KEY(photo_id, tag_id));


-- KNOWING HOW THESE TABLES GET STUFF INSERTED #####################
INSERT INTO users (username) VALUES
	('JacksonTheCat'),
	('CharlieBrown'),
	('LucasBurns');

INSERT INTO photos(image_url, user_id) VALUES
	('/asdfjkl', 1),
	('/lkkjfda', 2),
	('/qweqru9p', 3);

INSERT INTO comments (comment_text, user_id, photo_id) VALUES
	('Meow', 1, 2),
	('Hey man', 2, 1),
	('Tyler sup', 3, 1);

INSERT INTO likes (user_id, photo_id) VALUES
	(1, 1),
	(2, 1),
	(1, 2),
	(1, 3),
	(3, 3);

INSERT INTO follows (follower_id, followee_id) VALUES
	(1, 2),
	(1, 3),
	(3, 1),
	(2, 3);

INSERT INTO tags (tag_name) VALUES
	('adorable'),
	('cute'),
	('skateboard');

INSERT INTO photo_tags (photo_id, tag_id) VALUES
	(1, 1),
	(1, 2),
	(2, 3),
	(3, 2);


#################################################################

-- ############ INSTAGRAM QUESTIONS ##################

-- Section 15 // Video 6 // Problem 2
-- What day of the week do most users register on?

SELECT COUNT(*) as total, DAYNAME(created_at) as day
	FROM users
	GROUP BY DAYNAME1
	ORDER BY total DESC;


-- Section 15 // Video 7 // Problem 3
-- Find the users who have never posted a photo

SELECT users.username, photos.image_url FROM users
	LEFT JOIN photos
	ON users.id = photos.user_id
	WHERE photos.id IS NULL;


-- Section 15 // Video 8 // Problem 4
-- Who got the most likes on a photo amd what photo is it

SELECT photos.id, photos.image_url, COUNT(*), users.username FROM photos
INNER JOIN likes
	ON likes.photo_id = photos.id
INNER JOIN users
	ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY COUNT(*) DESC LIMIT 1;


-- Section 15 // Video 9 // Problem 5
-- How many times does the average user post?

-- Total number of photos / total number of users
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS average;


-- Section 15 // Video 10 // Problem 6
-- What are the top 5 most commonly used hastags?

### MINE
SELECT tags.tag_name, COUNT(photo_tags.tag_id) AS popularity FROM tags
INNER JOIN photo_tags
	ON tags.id = photo_tags.tag_id
GROUP BY tag_name
ORDER BY popularity DESC LIMIT 5;

### HIS
SELECT tags.tag_name, COUNT(*) AS total FROM photo_tags
INNER JOIN tags
	ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC LIMIT 5;



-- Section 15 // Video 11 // Problem 7
-- Find users who have liked every single photo on the site

SELECT username, user_id, COUNT(*) as num_likes FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);
