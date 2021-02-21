## Setup

### Process
1. CSV > TXT
2. TXT > SQL
3. User confirms/edits SQL data in browser
4. SQL > PDF

### Using Tables
```plain
register --------> [user accounts] --------> login

upload file --------> [uploads] --------> view your documents
     |
     |
     v
    bash
    process --------> [user_0001] --------> edit transations
                                                 |
                                                 |
                                                 v
                                              create IRS
                                               document
```


### SQL Database
```plain
=========================================================================
```
### Table 1: mega
- This will be a master table for every file uploaded. We can see when it was uploaded, who uploaded it, the original filename, and the exchange(e.g., Coinbase)

--TODO: Use `exchange` as a category--

```plain
+--------+---------+------------------+----------+
| doc_id | user_id | fname            | exchange |
| ====== | ======= | ================ | ======== |
| 00001  | lmburns | 2020coinbase.csv | Coinbase |
+--------+---------+------------------+----------+
```

### Table 2: users
- This is for logging in and payment - First/Last name, email/pass, and date the account was created, with an auto-increment ID


```plain
+----+---------+------------------+----------------+------------+------------+
| id | user_id | fname            | email          | pass       | signed_up  |
| == | ======= | ================ | ============== | ========== | =========  |
| 1  | lmburns | 2020coinbase.csv | burnsac@me.com | ********** | 2021-02-17 |
+----+---------+------------------+----------------+------------+------------+
```


### Table 3: username
- This is my own personal table (assume I'm a user) which has all of my transactions. If you want to see where one transaction came from, you can look at the DocumentID column and use that to see the specific file it got the data from. It has all the other data needed to do longterm shortterm calculations

```plain
+----+--------+----------+------------+------------+-------+----------+------------+----------+-------+-------------+
| id | doc_id | exchange | trans_date | trans_type | asset | quantity | cost_basis | subtotal | total | amount_left |
| == | ====== | ======== | ========== | ========== | ===== | ======== | ========== | ======== | ===== | =========== |
| 1  | 00001  | Coinbase | 2021-02-18 | Buy        | BTC   | 0.523276 | 9166.63    | 18;51    | 20.00 | 0.00201928  |
+----+--------+----------+------------+------------+-------+----------+------------+----------+-------+-------------+
```
