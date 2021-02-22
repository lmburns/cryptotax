-- master table
CREATE TABLE crypto.mega (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  user_id INTEGER NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL,
  pass VARCHAR(255) NOT NULL,
  signed_up TIMESTAMP DEFAULT NOW()
);

-- first table to have data inserted
-- one line, one user

-- all users & documents table
CREATE TABLE crypto.users (
  user_id INTEGER NOT NULL,
  doc_id INTEGER NOT NULL PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  exchange VARCHAR(255) NOT NULL,
  FOREIGN KEY(user_id) REFERENCES mega(id)
);

-- one line per document
-- one user can have several entries

-- expanded documents table
CREATE TABLE crypto.documents (
  trans_id INTEGER NOT NULL,
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

-- trans_id to keep track of every line of every document
-- amount_left used as integer for now (will be changed)

-- COMMENTS:
-- no need for a table for each user
-- no usernames here, account based on email
-- user_id or email is our way to track

-- CONNECTED THROUGH ORIGINALLY:
-- mega.doc_id -> username.doc_id
-- users.user_id -> mega.user_id

-- TODO AT SOME POINT:
-- change database and table names when going public
-- password hasing algorithm (SHA256+)
-- method to create user_id = user_00000001
-- method to create trans_id = trans_000000001

-- QUESTIONS:
-- unique filename to prevent clashes?

-- REFERENCE: tutorials/sql/ig-data-orig.sql to help get an idea of how we structure

-----------------------------------------------------------------

-- ENGINE:
-- default storage engine is already InnoDB
-- 1) if you feel the need, can be invoked via: mysql -u root -p password --defualt-storage-engine
-- 2) set it in your configuration file
-- 3) use the command below

SET default_storage_engine=INNODB;
