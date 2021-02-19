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
- [USD spot price (cost basis)]
- [subtotal]
- [total]
- [amount left]

**amount left**
- quanity
- manipulated when we calculate cost basis
