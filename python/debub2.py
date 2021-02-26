transactions = [
    ["BTC", ".5", "20000", "USD", "10000", "1", ".5"],
    ["ETH", "7.5", "733", "BTC", ".25", "22000", "7.5"],
    ["USD", "7000", "1", "BTC", ".25", "28000", "0"],
    ["USD", "6000", "1", "ETH", "6", "1000", "0"],

#["BTC", ".5", "20000", "USD", "10000", "1", ".5"],
#["BTC", ".5", "20000", "USD", "10000", "1", ".5"],
#["USD", "25000", "1", "BTC", ".6", "25000", "0"]
]
transactionID =0


def printlog(increase):
    global transactionID
    if (increase):
        beforeOrAfter = "After"
    else:
        beforeOrAfter = "Before"
    print("\n\n" + beforeOrAfter + " Transaction # " + " ---" + str(transactionID))
    print('\n'.join([''.join(['{:8}'.format(item) for item in row])
          for row in transactions]))
    if(increase):
        transactionID += 1
        print("\n\n\n\n\n")



def Sell(j,amountToSell):
    array = transactions[j]
    for i in range(len(transactions)):
        if(transactions[i][0] == array[3]): # if we found a matching buy entry to match our sell entry
            if(float(transactions[i][6]) > 0): # make sure we have some left to use
                if(transactions[i][6] >= array[4]): # we only need to subtract then we are done
                    printlog(0)
                    transactionAmount = str( float(array[4]) * float(array[5])) #How much cash they gained
                    buyingPrice = str(float(transactions[i][2]) * float(array[4])) #How much cash they spent
                    profit = str(float(transactionAmount) - float(buyingPrice)) # Cash gained - cash spent

                    print("You bought " + transactions[i][1] + " " + transactions[i][0] + " for " + buyingPrice + "  and sold " + array[4] + " " + array[3] + " for " + transactionAmount + " leaving you a profit of " + profit)

                    transactions[i][6] = str(float(transactions[i][6]) -float(transactions[j][4])) # reduce the "amount_left" column by how much we calculated
                    printlog(1)
                    break #we are done
                else:
                    print("test" + str(amountToSell) + "-" + transactions[i][6] + ":" + array[5])
                    amountToSell = float(amountToSell) - float(transactions[i][4])
                    #transactions[j][6] = float(transactions[j][6]) - float(transactions[i][4])

                    #Sell(j,amountToSell)


                    #this part is a trainwreck
                    #Imagine this:
                    #buy 1 btc for 10k
                    #buy 1 btc for 15k
                    #sell 1.5 btc for 20k
                    #sell .5 btc for 3k
                    #now you have to do recursion, calling the Sell() function again, because you're selling 1.5, but the first entry only has 1 to give, so you have to search for the second entry



for i in range (len(transactions)):
    if(transactions[i][3] != "USD"): #if we are doing anything other than buying something with cash (ie sell or trade)
        Sell(i, transactions[i][4])
