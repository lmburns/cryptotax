### TERMINAL
`mysql -u root -p`

##########---------- MYSQL COMMANDS ----------##########

#### SHOW COMMANDS
- `SHOW databases;` = shows databases available
- `SHOW tables;`
- `SHOW COLUMNS FROM <tablename>;` == `DESC <tablename>;`
- `SHOW WARNINGS;`


#### CREATE / DROP COMMANDS
- `CREATE DATABASE <name>;`
- `DROP DATABASE <name>;`
- `DROP TABLE <tablename>;`


#### WHICH DATABASE YOU WILL AFFECT
- `USE <name>;` = selecting database you want to affect
- `SELECT <database_name>` = says name of db you're working with


#### CREATE TABLE
- `CREATE TABLE tablename
	(
		column_name data_type,
		column_name data_type
	);`


#### CREATE TABLE - EG
- `CREATE TABLE cats
	(
		name VARCHAR(100) NOT NULL,
		age INT
	);`


**#################### ADD / DELETE COLUMN ####################**
- `ALTER TABLE <tablename>`
 `ADD COLUMN <column_name> <data_type> [FIRST|AFTER] <column_name>;`

- `ALTER TABLE tableName DROP COLUMN colName;`

#### INSERT COMMANDS
- `INSERT INTO cats(name, age)` # column names
  `VALUES ('Jetson', 7);` # values entered into those column names

- Can enter more than one row as well by adding commas


#### SELECT COMMANDS
- `SELECT * FROM <table_name>;` = shows you all the columns
- `SELECT database();` = tells you which database you're using


#### SET DEFAULT VALUES
- `CREATE TABLE <table_name>
	(
		<column_name> VARCHAR(100) DEFAULT 'unnamed',
		<column_name> INT DEFAULT 99
	);`


#### PRIMARY KEYS
- `CREATE TABLE <table_name>
	(cats_id INT NOT NULL AUTO_INCREMENT,
	 name VARCHAR(100),
	 age INT,
	 PRIMARY KEY (cat_id));`

**OR**
- `CREATE TABLE <table_name>`
	`(cats_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,`
	 name VARCHAR(100),
	 age INT);`


**#################### UPDATE KEYS ####################**
- `UPDATE <table_name>`
	`SET <column_name> = <value>`
	`WHERE <column_name> = <value>;`

- `UPDATE tableName`
	`SET columnName = column2Name / value;` or whatever


#### ALIASES
- `SELECT columnName AS aliasName, column2Name FROM tableNAME;`


#### DELETE
- `DELETE FROM tableName where columnName = value;`
- `DELETE FROM cats;` = deletes the values, not the table
Deleting based on id's for example
- `DELETE from tableName WHERE columnName IN (1, 2, 3, etc.);`
- `DELETE from tableName WHERE columnName BETWEEN num1 AND num2;`


##########---------- STRING FUNCTIONS ----------##########

#### CONCAT
- `SELECT CONCAT(columName, 'text', anotherColumn, 'more_text') AS 'text'`
   ` bFROM tableName;`


#### CONCAT_WS
- `SELECT CONCAT_WS('separator', columnName, column2name, column3name)`
   `FROM tableName;`


#### SUBSTRING / SUBSTR is a shortcut
- `SELECT SUBSTRING(columnName, startingIndice, endingIndince)`
   `FROM tableName;`

- `SELECT SUBSTRING(columnName, startingIndice)`
   `FROM tableName;` = like index[5:] in python

- `SELECT SUBSTRING(columnName, -startingIndice)`
   `FROM tableName;` = starts from end, not reversed though


#### COMBINING CONCAT / SUBSTRING
 - `SELECT CONCAT`
	 `(SUBSTRING(title, 1, 10), '...') AS 'shortened_title'`
	`FROM books;`


#### REPLACE
- `SELECT REPLACE(columnName, replacing, replacer) FROM tableName;`


#### REVERSE
- `SELECT REVERSE(columnName) from tableName;`


#### CHAR_LENGTH
- `SELECT CHAR_LENGTH(columnName) from tableName;`


#### UPPER() / LOWER()
- `SELECT UPPER(columnName) from tableName;`
- `SELECT LOWER(columnName) from tableName;`


##########---------- REFINING OUR SELECTION ----------##########

#### DISTINCT
- `SELECT DISTINCT columnName FROM tableName;` = like a set/unique
- `SELECT DISTINCT CONCAT(colName, ' ', col2Name) from tableName;`
- `SELECT DISTINCT colName, col2Name from tableName;` = does same as above


#### ORDER BY
- `SELECT colName FROM tableName ORDER BY colName;` = ascending by default
- `SELECT colName FROM tableName ORDER BY colName DESC;` = descending
- `SELECT colName FROM tableName ORDER BY colName ASC;`= ascending explicit
- `SELECT col1, col2, col3 FROM table ORDER BY 2;` = 2 = shortcut for col2


#### LIMIT
- `SELECT columnName from tableName LIMIT num;`
- `SELECT colname, col2name FROM tableName`
	`ORDER BY colName DESC LIMIT num;`
Specify starting point (row starts at 0 / string starts at 1)
- `SELECT colname, col2name FROM tableName`
	`ORDER BY colName DESC LIMIT num, num2;`
- `SELECT colName FROM tableName LIMIT 5, 10001029309;` = everything after 5


#### LIKE
% = a wildcard // e.g., '%da%' = anything da anything
_ = a wildcard but for 1 character
- `SELECT colName FROM tableName WHERE colName LIKE '%string%';`
- `SELECT title, released_year`
	`FROM books WHERE released_year LIKE '20%%';`
Search for stock quantity where it is 4 digits long
- `SELECT stock_quantity FROM books WHERE stock_quanity LIKE '____';`
Search for something with '%' or _ in the name
- `SELECT colName FROM tableName WHERE colName LIKE '\%';`


##########---------- AGGREGATE FUNCTIONS ----------##########
#### COUNT FUNCTION
- `SELECT COUNT(* / or colName) FROM tableName;` = check rows in tables
- `SELECT COUNT(DISTINCT colName) FROM tableName;` = nunique
- `SELECT COUNT(DISTINCT colName, col2Name) FROM tableName;`
- `SELECT COUNT(*) FROM tableName WHERE colName LIKE '%the%';`


#### GROUP BY
- `SELECT colName, col2Name FROM tableName GROUP BY colName;`
- `SELECT colName, COUNT(*) FROM tableName GROUP BY colName;`
This does not show unique first and last name
- `SELECT title, author_fname, author_lname, COUNT(*)`
	`FROM books GROUP BY author_lname;`
This shows unique based on first and last name
- `SELECT author_fname, author_lname, COUNT(*)`
	`FROM books GROUP BY author_lname, author_fname;`
Using SELECT, CONCAT, COUNT
- `SELECT CONCAT('In ', released_year, ' ',  COUNT(*), ' book(s)`
	`released') AS YEAR	FROM books GROUP BY released_year;`


#### MIN / MAX
- `SELECT MIN(released_year) FROM books;`
- `SELECT MAX(released_year) FROM books;`
To select max pages and book that goes with it / SLOW query
- `SELECT title, pages FROM books`
	`WHERE pages = (SELECT MIN(pages) FROM books);`
Faster way to do it
- `SELECT title, pages FROM books`
	`ORDER BY pages ASC LIMIT 1;` = min / `DESC LIMIT 1;` = max

#### MIN / MAX GROUP BY
- `SELECT author_fname, author_lname, MIN(released_year) FROM books`
	`GROUP BY author_lname, author_fname;` = shows 1st release yr for each auth

Using CONCAT, MAX, GROUP BY
- `SELECT CONCAT(author_fname, ' ', author_lname) AS author,`
	`MAX(pages) as 'longest book' FROM books`
	`GROUP BY author_fname, author_lname;`


#### SUM
- `SELECT SUM(colName) from tableName;`


#### AVG
- `SELECT AVG(colName) FROM tableName;`
- `SELECT released_year, AVG(stock_quantity) AS stock FROM books`
	`GROUP BY released_year ORDER BY released_year DESC;`


**#################### ONLY PRINT COLUMNS ####################**
- `select COLUMN_NAME from information_schema.COLUMNS where TABLE_NAME='student';`



##########---------- DATATYPES ----------##########
- **varchar** = variable length (1 - 255) — `varchar(100)`
- **char** = fixed length (10 for e.g.)


#### DECIMAL
- `DECIMAL(5,2)`
	- 5 digits max (including after decimal), 2 digits after decimal
	- 999.99 // exact


#### FLOAT
- `FLOAT;`
	- approximate // store larger numbers with less space
	- has precision issues after 7 digiits
- `DOUBLE;`
	- take up double the space as a float
	- precise up to 15 digits


#### DATES / TIMES
- `DATE;` = YYYY-MM-DD Format // Date, no time
- `TIME;` = time, no date // used the least
- `DATETIME;` = YYYY-MM-DD-HH:MM:SS
- `CURDATE;` = gives current date
- `CURTIME;` = gives current time
- `CURRENT_TIMESTAMP;` = pretty much same as NOW
- `NOW;` = gives current datetime
- `DAY()`, `DAYNAME();`, `DAYOFMONTH();`, `DAYOFWEEK;`, `DAYOFYEAR();`
	- birthdate = date object
	- `DAYNAME(birthdate);`, etc
- `HOUR();`, `MINUTE();`, `MONTHNAME();`,
- `DATE_FORMAT();` = %special symbols
	+ %M = month name // %m = month number
	+ %W = weekday name // %w = weekday number
	+ `SELECT DATE_FORMAT(colName, '%W-%M-%Y') from tableName;`


#### DATE MATH
- `DATEDIFF(expr1, expr2);` = tells number of days
- `DATE_ADD(dt-ob, INTERVAL # unit_value);` // `DATE_SUB();`
	+ `SELECT birthdt, DATE_ADD(birthdt, INTERVAL 1 MONTH) from people;`
	+ `SELECT birthdt, birthdt + INTERVAL 1 MONTH from people;`
	+ `SELECT birthdt, birthdt + INTERVAL 1 MONTH + INTERVAL 10 HOUR from people;`


#### TIMESTAMPS
- Only ranges from 1970 - 2038
- Creating a table using `TIMESTAMP DEFAULT NOW();`

- Keep track of when something was changed
- `TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP);`


##########---------- LOGICAL OPERATORS ----------##########

#### NOT EQUAL
- `SELECT colName FROM tableName WHERE cond != value;`


#### NOT LIKE
- `SELECT colName FROM tableName WHERE colName NOT LIKE '%value%';`


#### GREATER THAN / LESS THAN (OR EQUAL TO)
- `SELECT colName FROM tableName WHERE colName > number;`


#### LOGICAL AND (&&)
- `SELECT colName FROM table WHERE colName='string' && col2Name > number;`
- `SELECT colName FROM table WHERE colName='string' AND col2Name > number;`


#### LOGICAL OR (||)
- `SELECT colName FROM table WHERE colName='string' || col2Name > number;`
- `SELECT colName FROM table WHERE colName='string' OR col2Name > number;`


#### LOGICAL XOR
- Logical XOR. Returns NULL if either operand is NULL. For non-NULL operands, evaluates to 1 if an odd number of operands is nonzero, otherwise 0 is returned.
- `SELECT colname FROM table WHERE colName='string' XOR col2Name > number;`


#### BETWEEN // NOT BETWEEN
- `SELECT colName FROM table WHERE colName BETWEEN num1 AND num2;`
- `SELECT colName FROM table WHERE colName NOT BETWEEN num1 AND num2;`


**#################### CASTING ####################**
- `SELECT CAST('2017-05-07' AS DATETIME);` = converts to datetime object
- Useful to use for comparing dates to make sure all are same format
- `SELECT name, birthdt FROM people`
	`WHERE birthdt BETWEEN CAST('1990-01-01' AS DATETIME)`
					  `AND CAST('2000-01-01' AS DATETIME);`


#### IN // NOT IN
- `SELECT title, author_lname FROM books`
	`WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');` = concatenated OR'S

- `SELECT title, released_year FROM books`
	`WHERE released_year NOT IN(2000, 2002, 2004, 2006, ...);` = concatented AND'S

- `SELECT title, released_year FROM books`
	`WHERE released_year >= 2000 AND released_year % 2 != 0;`


#### CASE STATEMENTS (CASE WHEN ELSE END)
- `SELECT title, released_year,`
		  `CASE`
	  		`WHEN released_year >= 2000 THEN 'Modern Lit'`
	  		`ELSE '20th Century Lit'`
	  	  `END AS Genre` = 'AS Genre' = alias
   `FROM books;`

- `SELECT title, stock_quantity,`
		  `CASE`
		  	`WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'`
		  	`WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'`
		  	`ELSE '***'`
		  `END AS stock`
  `FROM books;`

Quicker and Succinct way (they run line by line)
  - `SELECT title, stock_quantity,`
		  `CASE`
		  	`WHEN stock_quantity <= 50 THEN '*'`
		  	`WHEN stock_quantity <=100 THEN '**'`
		  	`ELSE '***'`
		  `END AS stock`
  `FROM books;`


#### QUIZ FROM SECTION 11
#### COMBINING CASE, COUNT, CONCAT
- `SELECT author_lname,`
	`CASE`
		`WHEN COUNT(*) = 1 THEN '1 book'`
		`ELSE CONCAT(COUNT(*), ' books')`
	`END AS COUNT`
`FROM books`
`GROUP BY author_lname, author_fname;`



##########---------- RELATIONSHIPS // JOINS ----------##########

#### RELATIONSHIPS // FOREGIN KEYS

- `id INT AUTO_INCREMENT PRIMARY KEY`
	+ this table called customers

- `customer_id INT,`
    `FOREIGN KEY(customer_id) REFERENCES customers(id);`
    	- this table called orders
    	- customers(id) = from another table
    	- can't insert into 'orders' an id that doesn't exist in 'customers'


#### CROSS JOIN
- `SELECT * FROM customers WHERE last_name = 'George';`
- `SELECT * from orders WHERE customer_id = 1;`

COMBINED: (inner most runs first)
- `SELECT * FROM orders WHERE customer_id = (`
 	`SELECT id FROM customers WHERE last_name = 'George')`

- `SELECT * FROM customers, orders;`
	+ Takes every customer and puts it next to every customer_id
	+ Multiplies the rows in the tables


#### IMPLICIT INNER JOIN
- Where the tables overlap (a union set)
- `SELECT * FROM customers, orders WHERE customers.id = orders.customer_id;`

#### EXPLICIT INNER JOIN
- `SELECT * FROM customers`
	`JOIN orders`
		`ON customers.id = orders.customer_id;`

- `SELECT * FROM customers`
  `JOIN orders`
		`ON customers.id = orders.customer_id`
  `ORDER BY order_date;`

- `SELECT first_name, last_name, SUM(amount) AS total_spent`
  `FROM customers`
  `JOIN orders`
		`ON customers.id = orders.customer_id`
  `GROUP BY orders.customer_id`
  `ORDER BY total_spent DESC;`


#### LEFT JOIN
- Select everything from A along with any matching records in B
- Venn Diagram: All of A + overlap
- Example: Want to see highest spenders and people who haven't spent
- `SELECT first_name, last_name, order_date, amount FROM customers`
  `LEFT JOIN orders`
		`ON customers.id = orders.customer_id;`

- **IFNULL(replacing, replacer)**

- `SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS total_spent`
  `FROM customers`
  `LEFT JOIN orders`
		`ON customers.id = orders.customer_id`
  `GROUP BY customers.id`
  `ORDER BY total_spent;`


#### RIGHT JOIN
- `SELECT * FROM customers`
  `RIGHT JOIN orders`
  		`ON customers.id = orders.customer_id;`

- **On Delete Cascade**
	+ `customer_id INT,`
      `FOREIGN KEY(customer_id)`
      		`REFERENCES customers(id)`
      		`ON DELETE CASCADE;`
- When a customer who has an order is deleted, delete the order as well


#### EMULATING FULL OUTER JOIN
SELECT * FROM t1
LEFT JOIN t2 ON t1.id = t2.id
UNION
SELECT * FROM t1
RIGHT JOIN t2 ON t1.id = t2.id



##########---------- MANY TO MANY ----------##########
- TV Shows and Reviewers
	+ Series Data <---> Reviews Data <---> Reviewers Data
		* Series (TV Shows) exist on their own
		* Reviewers exist on their own

- Reviewers = id, first_name, last_name
- Reviews = id, rating, series_id, reviewer_id
- Series = id, title, released_year, genre

- Add **UNIQUE** when creating a table
- **ROUND()**  = rounds decimals
- **IF(COUNT(reviews.id) >= 1, 'ACTIVE', 'INACTIVE') AS STATUS**
	+ = statement, if statment result, else result


#### JOINING MORE THAN 2 TABLES
`SELECT title, rating, CONCAT(first_name, ' ', last_name) AS NAME`
`FROM reviewers`
`INNER JOIN reviews`
	`ON reviewers.id = reviews.reviewer_id`
`INNER JOIN series`
	`ON series.id = reviews.series_id`
`ORDER BY title;`



##########---------- INSTAGRAM CLONE ----------##########
- Users = id, username, created_at
- Photos = id, image_url, user_id, created_at
- Comments = id, comment_text, user_id, photo_id, created_at
- Likes = user_id, photo_id, created_at
- Follows = follower_id, followee_id, created_at
- Tags = id, tag_name, created_at
- Photo_Tags = photo_id, tag_id

#### HASHTAGS
- Multiple solutions to this
- **Solution 1** = id, image_url, caption, tags
	+ `tags` = #hash1#hash2#hash3
	+ Easy to implement
	+ Limited number of tags can be store
	+ Cannot store additional info (Not storing with time)
	+ Have to be careful with searching

- **Solution 2** = 2 tables
	+ Table 1: Photos = id, image_url, caption
	+ Table 2: Tags = tag_name, photo_id
		* Unlimited number of tags
		* Slower than solution above (updating / deleting)

- **Solution 3** = 3 tables
	+ Table 1: Photos = id, image_url, caption
	+ Table 2: Tags = id, tag_name, created at
	+ Table 3: Photo_Tags = photo_id, tag_id
		* Unlimited number of tags
		* Can add additional info
		* More work when inserting / updating
		* Have to worry about orphans

- To prevent multiple likes on the same photo by the same person
	+ `PRIMARY KEY(user_id, photo_id)` = **UNIQUE COMBINATION**

**########### HAVING ###########**
- Allows us to take a grouped query and filter based on a having clause
- It is similar to `WHERE` but it comes before the `GROUP BY`
	+ It tells us what data you'd like to select to group
	+ Rather than what you'd like to select from the grouped data
		* Which is what `HAVING` does
		* **It takes an end result and allows us to filter**

#### EXAMPLE
SELECT username, user_id, COUNT(*) as num_likes FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);
