-- all users table
CREATE TABLE crypto.mega (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  email VARCHAR(255) NOT NULL,
  pass VARCHAR(255) NOT NULL,
  signed_up TIMESTAMP DEFAULT NOW()
);

-- username will have several of repeating doc id lines
-- this will be first table to have data inserted

-- master table
CREATE TABLE crypto.users (
  user_id INTEGER NOT NULL,
  doc_id INTEGER NOT NULL,
  fname VARCHAR(255) NOT NULL,
  exchange VARCHAR(255) NOT NULL,
  FOREIGN KEY(user_id) REFERENCES mega(id),
  PRIMARY KEY(user_id)
);

-- not sure if id is needed

-- individual user table
CREATE TABLE crypto.username (
  trans_id INTEGER AUTO_INCREMENT,
  user_id INTEGER NOT NULL,
  doc_id INTEGER NOT NULL,
  exchange VARCHAR(255) NOT NULL,
  trans_date DATETIME NOT NULL,
  trans_type VARCHAR(50) NOT NULL,
  asset VARCHAR(10) NOT NULL,
  quantity DECIMAL(16,10) NOT NULL,
  cost_basis DECIMAL(8,2) NOT NULL,
  subtotal DECIMAL(8,2) NOT NULL,
  total DECIMAL(8,2) NOT NULL,
  amount_left INTEGER NOT NULL,
  FOREIGN KEY(user_id) REFERENCES mega(user_id),
  FOREIGN KEY(doc_id) REFERENCES users(doc_id),
  PRIMARY KEY(user_id, doc_id)
  /* amount_left DECIMAL(8,2) NOT NULL */
);

-- id here can be seen as transaction id since all will be unique
-- amount_left used as integer for now (will be changed)
-- dynamically create table names

-- COMMENTS:
-- Think that tables are fine they way they are, no need for a table for each user
-- No usernames here, account based on email
-- user_id is our way to track

-- CONNECTED THROUGH ORIGINALLY:
-- mega.doc_id -> username.doc_id
-- users.user_id -> mega.user_id

-- TODO AT SOME POINT:
-- categorical variables?
-- change database and table names when going public to prevent SQL injection
-- password hasing algorithm (SHA256+)

-- QUESTIONS:
-- link users and username || link mega back to users?
-- unique filename to prevent clashes?

-- doc_id or user_id or both as primary key for mega?
-- mega -> username, have to figure out dynamic reference (1 user 1 table)

-- username vs userid?
-- add username to username table?
-- email not unique because users table will have multiple entries for one person?

-- REFERENCE: tutorials/sql/ig-data-orig.sql to help get an idea of how we structure

-----------------------------------------------------------------

-- ENGINE:
-- default storage engine is already InnoDB
-- 1) if you feel the need, can be invoked via: mysql -u root -p password --defualt-storage-engine
-- 2) set it in your configuration file
-- 3) use the command below

SET default_storage_engine=INNODB;
