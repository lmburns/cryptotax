### Case 1
#### Buy: $10,000 -> 0.5 BTC
   - **BTC cost basis**: $20,000

#### Handle: Buy = nothing
   1. **amount left** = 0.5

### Case 2
#### Trade: 0.25 BTC -> 7.5 ETH
   - **BTC cost basis**: $22000
   - **ETH cost basis**: $733

#### Handle: Trade = find tax on it
   1. Calculate cost basis
         - **amount left** = 0.5
         - From = Trans1
         - Paid = $10,000 for 0.5 BTC
         - Use = 0.25 BTC
         - Cost basis = $5000
         - Spent $5000 for 0.25 BTC on Trans1
   2. Calculate how much we sold the .25 for
         - BTC cost basis: $22,000.
         - .25 BTC = $5500.
         - Gained $5500 for 0.25 BTC on Trans2
         - **amount left** = 0.25 (0.5 - 0.25)
   3. Buy 7.5 ETH
         - **toal cost**: $5497.5 ($733 * 7.5)
         - Technically a buy, even though it’s a trade.
         - Keep cost basis and total cost for note.
   5. **Capital gains: $500 (5500 - 5000)**


### Case 3
#### Sell: 0.25 BTC -> $7000
   - **BTC cost basis**: $28,000

#### Handle: Flat-out sell. Very easy
   1. Calculate cost basis
         - **amount left** = 0.25
         - From = Trans1
         - Paid = $10,000 for 0.5 BTC
         - Use = 0.25 BTC
         - Cost basis = $5000
         - Spent $5000 for 0.25 BTC on Trans1
   3. Calculate how much we sold the .25 for
         - Gained $7000 for 0.25 BTC on Trans3
         - **amount left** = 0.0 BTC
   4. **Capital gains: $2000 (7000 - 5000)**


### Case 4
#### Sell: 6 ETH -> $6000
   - **ETH cost basis**: $1000

#### Handle: Flat-out sell. Very easy
   1. Calculate cost basis
         - **amount left** =
         - From = Trans2
         - Paid = $5497.5 for 7.5 ETH
         - Use = 6 ETH
         - Cost basis = $733
         - 6 ETH * $733 = $4398
         - Spent $4398 for 6 ETH on Trans2
   3. Calculate how much we sold the 6 eth for. Easy!
         - Gained $6000 for 6 ETH on Trans4
         - NOTE: “amount_left:1.5” on Trans2
   4. **Capital Gains: $1602 (6000 - 4398)**
