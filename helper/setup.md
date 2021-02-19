### Coinbase raw
- **Date**
  - Date (obviously)
- **Transaction Type**
  - Buy / Send / Sell, Coinbase Earn, Rewards Income
- **Asset**
  - Crypto
- **Quantity Transacted**
  - Amount in crypto
- **USD Spot Price at Transaction**
  - Amount in USD
- **Subtotal**
  - Only for buy and sell
  - Total raw
- **Total Inclusive with Fees**
  - Total with fees
- **Notes**
  - Unnecessary


=============================================================

### Gemini raw
- **Event ID**
- **Event Date**
- **Event Time**
  - Unnecessary
- **Event Millisecond**
  - Completely unnecessary
- **Order ID**
  - Unnecessary
- **Execution Options**
  - Unnecessary
- **Event Type**
  - Unnecessary
- **Symbol**
- **Order Type**
- **Side**
  - Buy / Sell
- **Limit Price (USD)**
- **Original Quantity**
- **Gross National Value**
  - Unnecessary
- **Fill Price (USD)**
- **Fill Quantity (BTC)**
- **Quantity Remaining**
- **Avg Price (USD)**

=============================================================

### Process
1. CSV > TXT
2. TXT > SQL
3. User confirms/edits SQL data in browser
4. SQL > PDF

### SQL Database

- [ID]
- [documentID]
- [platform]
- [date]
- [type]
- [asset]
- [quantity]
- [costBasis]
- [subtotal]
- [total]
- [amountLeft]
  - quanity
  - manipulated when we calculate cost basis

### Table 1: Uploads
- This will be a master table for every file uploaded. We can see when it was uploaded, who uploaded it, the original filename, and the exchange(e.g., Coinbase)

TODO: Use `exchange` as a category

```plain
| [documentID] | [user]  | [fname]           | [exchange] |
| :----------- | :------ | :---------------- | :--------- |
| 00001        | lmburns | 2020coinbase.csv  | Coinbase   |
```

### Table 2: Users
- This is for logging in and payment - First/Last name, email/pass, and date the account was created, with an auto-increment ID

```plain
| [ID]      | [fname]          | [email]        | [pass]    | [signedUp] |
| :-------- | :--------------- | :------------- | :-------- | :--------  |
| 1         | 2020coinbase.csv | burnsac@me.com | ********  | 2021-02-17 |
```


### Table 3: tthudium
- This is my own personal table (assume I'm a user) which has all of my transactions. If you want to see where one transaction came from, you can look at the DocumentID column and use that to see the specific file it got the data from. It has all the other data needed to do longterm shortterm calculations

```plain
| [ID]    | [documentID] | [date]     | [type]  | [asset] | [quantity] | [costBasis] | [subtotal] | [total]  | [amountLeft] |
| :------ | :----------  | :--------- | :------ | :------ | :--------- | :---------- | :--------- | :------- | :----------- |
| 1       | 00001        | 2021-02-18 | Buy     | BTC     | 0.523276   | 9166.63     | 18.51      | 20.00    | 0.00201928   |
```
