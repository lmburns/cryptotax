-- master table
CREATE TABLE crypto.mega (
  user_id INTEGER AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  pass VARCHAR(255) NOT NULL,
  date_created TIMESTAMP DEFAULT NOW()
);

-- first table to have data inserted
-- one line, one user

-- expanded documents table
CREATE TABLE crypto.documents (
  trans_id INTEGER AUTO_INCREMENT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  doc_id INTEGER NOT NULL,
  exchange VARCHAR(255),
  trans_date DATETIME,
  trans_type VARCHAR(50),
  asset VARCHAR(10),
  quantity DECIMAL(16,10),
  cost_basis DECIMAL(8,2),
  subtotal DECIMAL(10,2),
  total DECIMAL(8,2),
  amount_left INTEGER
  /* amount_left DECIMAL(16, 10), */
);

-- amount_left used as integer for now (will be changed)

-- all users & documents table
CREATE TABLE crypto.users (
  user_id INTEGER NOT NULL,
  doc_id INTEGER NOT NULL,
  filename VARCHAR(255) NOT NULL,
  exchange VARCHAR(255) NOT NULL,
  date_uploaded TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY(doc_id)
);
-- one line per document
-- one user can have several entries

-- sync documents.exchange, users.exchange
-- sync documents.doc_id, users.doc_id

-- method to create trans_id = 000000001 (integers)
-- method to create doc_id = 000000001 (integers)

-- TODO AT SOME POINT:
-- change database and table names when going public
-- password hasing algorithm (SHA256+)
-- ip
-- filesize
