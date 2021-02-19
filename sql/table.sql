-- default storage engine is already InnoDB
-- 1) if you feel the need, can be invoked via: mysql -u root -p password --defualt-storage-engine
-- 2) set it in your configuration file
-- 3) use the command below

SET default_storage_engine=INNODB;

-- individual user table
CREATE TABLE crypto.username (
  user_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  document_id INTEGER UNIQUE NOT NULL,
  exchange VARCHAR(255) NOT NULL,
  date DATETIME NOT NULL,
  type VARCHAR(10) NOT NULL,
  asset VARCHAR(10) NOT NULL,
  quantity DECIMAL(16,10) NOT NULL,
  cost_basis DECIMAL(8,2) NOT NULL,
  subtotal DECIMAL(8,2) NOT NULL,
  total DECIMAL(8,2) NOT NULL,
  amount_left DECIMAL(8,2) NOT NULL
)

-- all users table
CREATE TABLE crypto.users (
  id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fname VARCHAR(255) UNIQUE NOT NULL,
  email VARCHAR(255) NOT NULL,
  pass VARCHAR(255) NOT NULL,
  signed_up DATETIME NOT NULL,
  FOREIGN KEY(id) REFERENCES mega(user)
)

-- master table with exchange
CREATE TABLE crypto.mega (
  document_id INTEGER NOT NULL,
  user VARCHAR(100) UNIQUE NOT NULL,
  fname VARCHAR(255) NOT NULL,
  exchange VARCHAR(255) NOT NULL,
  FOREIGN KEY(document_id) REFERENCES username(document_id),
  FOREIGN KEY(fname) REFERENCES users(fname),
  FOREIGN KEY(exchange) REFERENCES username(exchange),
  PRIMARY KEY(user, document_id)
)

-- users.id -> mega.user
-- mega.docid -> username.docid

-- TODO:
-- type = set to category (if there is one)
-- change these when we go public to prevent SQL injection attack
-- password hashing algorithm

-- QUESTIONS:
-- need link between users and username (i believe)
-- does filename have to be unique to avoid clashes?

-- docid or username as primary key for mega?
-- user = username for mega table?
-- if mega table references username, have to figure out dynamic reference since there will be a table for each person

-- add username to users table?
-- email not unique in users table because there will be multiple entries?

-- REFERENCE: tutorials/sql/ig-data-orig.sql to help get an idea of how we structure

-- HELP:
-- use to generate document / user id's
create table seed ( i int not null auto_increment primary key );
insert into seed values (NULL),(NULL),(NULL),(NULL),(NULL),
                        (NULL),(NULL),(NULL),(NULL),(NULL);

insert into seed select NULL from seed s1, seed s2, seed s3, seed s4, seed s5, seed s6;
delete from seed where i < 100000;

create table idmap ( n int not null auto_increment primary key, id int not null );
insert into idmap select NULL, i from seed order by rand();

drop table seed;

select * from idmap limit 10;
