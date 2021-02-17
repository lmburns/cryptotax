### Coinbase
**Transaction Type**
- Buy / Send / Sell, Coinbase Earn, Rewards Income

**Asset**
- Crypto

**Quantity Transacted**
- Amount in crypto

**USD Spot Price at Transaction**
- Amount in USD

**Subtotal**
- Only for buy and sell
- Total raw

**Total Inclusive with Fees**
- Total with fees

**Notes**
- Not necessary

========================================================================

### Process
1. CSV > TXT
2. TXT > SQL
3. User confirms/edits SQL data in browser
4. SQL > PDF

### SQL Database

[ID][documentID][date][type][asset][quantity][USD spot price (cost basis)][subtotal][total][amount left]

amount left = quanity (amount left is a column that will be manipulated when we calculate cost basis)
