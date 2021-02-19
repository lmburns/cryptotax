### Process
1. CSV > TXT
2. TXT > SQL
3. User confirms/edits SQL data in browser
4. SQL > PDF

### SQL Database

### Table 1: mega
- This will be a master table for every file uploaded. We can see when it was uploaded, who uploaded it, the original filename, and the exchange(e.g., Coinbase)

TODO: Use `exchange` as a category

```plain
| [documentID] | [user]  | [fname]           | [exchange] |
| :----------- | :------ | :---------------- | :--------- |
| 00001        | lmburns | 2020coinbase.csv  | Coinbase   |
```

### Table 2: users
- This is for logging in and payment - First/Last name, email/pass, and date the account was created, with an auto-increment ID

```plain
| [ID]      | [fname]          | [email]        | [pass]    | [signedUp] |
| :-------- | :--------------- | :------------- | :-------- | :--------  |
| 1         | 2020coinbase.csv | burnsac@me.com | ********  | 2021-02-17 |
```


### Table 3: username
- This is my own personal table (assume I'm a user) which has all of my transactions. If you want to see where one transaction came from, you can look at the DocumentID column and use that to see the specific file it got the data from. It has all the other data needed to do longterm shortterm calculations

```plain
| [ID]    | [documentID] | [date]     | [type]  | [asset] | [quantity] | [costBasis] | [subtotal] | [total]  | [amountLeft] |
| :------ | :----------  | :--------- | :------ | :------ | :--------- | :---------- | :--------- | :------- | :----------- |
| 1       | 00001        | 2021-02-18 | Buy     | BTC     | 0.523276   | 9166.63     | 18.51      | 20.00    | 0.00201928   |
```
