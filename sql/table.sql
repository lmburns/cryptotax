CREATE TABLE crypto.cryptousers
  (
     id         INT NOT NULL auto_increment,
     documentid INT NOT NULL,
     platform   TEXT NOT NULL,
     date       DATETIME NOT NULL,
     type       TEXT NOT NULL,
     asset      TEXT NOT NULL,
     quantity   TEXT NOT NULL,
     costbasis  TEXT NOT NULL,
     subtotal   TEXT NOT NULL,
     total      TEXT NOT NULL,
     amountleft TEXT NOT NULL,
     PRIMARY KEY (id)
  )
engine = innodb;
