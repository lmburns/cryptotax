CREATE TABLE crypto.cryptoUsers (
  ID INT NOT NULL AUTO_INCREMENT,
  documentID INT NOT NULL,
  platform TEXT NOT NULL,
  date DATETIME NOT NULL,
  type TEXT NOT NULL,
  asset TEXT NOT NULL,
  quantity TEXT NOT NULL,
  costBasis TEXT NOT NULL,
  subtotal TEXT NOT NULL,
  total TEXT NOT NULL,
  amountLeft TEXT NOT NULL,
  PRIMARY KEY (ID)
) ENGINE = InnoDB;
