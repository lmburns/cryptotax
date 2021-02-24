-- master table
CREATE TABLE crypto.mega (
  user_id INTEGER AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  pass VARCHAR(255) NOT NULL,
  date_created TIMESTAMP DEFAULT NOW(),
  ip_addr VARCHAR(32) NOT NULL
);

-- expanded documents table
CREATE TABLE crypto.transactions(
  trans_id INTEGER AUTO_INCREMENT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  doc_id INTEGER NOT NULL,
  exchange VARCHAR(255),
  trans_date DATETIME,
  trans_buy_curr VARCHAR(255),
  trans_buy_quant DECIMAL(16,10),
  trans_buy_cb_USD DECIMAL(16,8),
  trans_sell_curr VARCHAR(255),
  trans_sell_quant DECIMAL(16,10),
  trans_sell_cb_USD DECIMAL(16,10),
  subtotal DECIMAL(12,3),
  total DECIMAL(12,3),
  amount_left INTEGER
  /* amount_left DECIMAL(16, 10), */
);

-- amount_left used as integer for now (will be changed)

-- all users & documents table
CREATE TABLE crypto.documents(
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  exchange VARCHAR(255) NOT NULL,
  date_uploaded TIMESTAMP DEFAULT NOW(),
  filename VARCHAR(255) NOT NULL,
  filesize DECIMAL(10,2) NOT NULL
);

-- one line per document
-- one user can have several entries

-- sync documents.exchange, users.exchange
-- sync documents.doc_id, mega.doc_id

-- method to create doc_id = 000000001 (integers)

-- TODO AT SOME POINT:
-- change database and table names when going public
-- password hasing algorithm (SHA256+)
