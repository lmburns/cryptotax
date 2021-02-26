transactions = [
    ["BTC", ".5", "20000", "USD", "10000", "1", ".5"],      # Buy
    ["ETH", "7.5", "733", "BTC", ".25", "22000", "7.5"],    # Trade
    ["USD", "7000", "1", "BTC", ".25", "28000", "0"],       # Sell
    ["USD", "6000", "1", "ETH", "6", "1000", "0"],          # Sell
]

10000 USD -> 0.5 BTC    0.5 BTC
0.25 BTC -> 7.5 ETH     0.25 BTC + 7.5 ETH
0.25 BTC -> 6000 USD    7.5 ETH + 6000 USD
6000 USD -> 6 ETH       13.5 ETH

| b_curr | b_quant | b_cb  | s_curr | s_quant | s_cb  | amt_lft     |
|--------|---------|-------|--------|---------|-------|-------------|
| BTC    | 0.5     | 20000 | USD    | 10000   | 10000 | 0.5         |
| ETH    | 7.5     | 733   | BTC    | 0.25    | 22000 | 0.25 or 7.5 |
| USD    | 7000    | 7000  | BTC    | 0.25    | 28000 | 0           |
| USD    | 6000    | 6000  | ETH    | 6.0     | 1000  | ???         |
---------------------------------------------------------

# How capital gains
# Cost basis currency
# Amount left currency
# How to tell which are trades
# Buy doesn't mean pay (buy = what you get, sell = what you spend)


def Sell(j,amountToSell):
    array = transactions[j]
    for i in range(len(transactions)):
        if(transactions[i][0] == array[3]): # if we found a matching buy entry to match our sell entry
            if(float(transactions[i][6]) > 0): # make sure we have some left to use if(transactions[i][6] >= array[4]): # we only need to subtract then we a done
                    transactionAmount = str( float(array[4]) * float(array[5])) #How much cash they gained
                    buyingPrice = str(float(transactions[i][2]) * float(array[4])) #How much cash they spent
                    profit = str(float(transactionAmount) - float(buyingPrice)) # Cash gained - cash spent

                    print("You bought " + transactions[i][1] + " " + transactions[i][0] + " for " + buyingPrice + "  and sold " + array[4] + " " + array[3] + " for " + transactionAmount + " leaving you a profit of " + profit)

                    transactions[i][6] = str(float(transactions[i][7]) -float(transactions[j][4])) # reduce the "amount_left" column by how much we calculated
                    break #we are done
            else:
                    print("test" + str(amountToSell) + "-" + transactions[i][6] + ":" + array[5])
                    amountToSell = float(amountToSell) - float(transactions[i][4])


for i in range (len(transactions)):
    if(transactions[i][3] != "USD"): #if we are doing anything other than buying something with cash (ie sell or trade)
        Sell(i, transactions[i][4])

print("\n\nNotice the values left in each category")

print('\n'.join([''.join(['{:8}'.format(item) for item in row])
      for row in transactions]))
e
