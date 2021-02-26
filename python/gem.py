# gemini csv script

import os
import requests

from sspipe import p, px
import re
import pandas as pd
import numpy as np

from exchangeratesapi import Api

df = pd.read_csv('../inputs/gemini.csv', index_col=0)
df.columns = df.columns.str.replace(' ', '_').str.lower()

api = Api()

##############################################################
# exchange            # filename
# trans_date          # event_date + event_time + ?event_millis
# trans_type          # side
# trans_buy_curr      # symbol
# trans_buy_quant     # fill_quantity
# trans_buy_cb_USD    # fill price (USD)
# trans_sell_curr     # symbol
# trans_sell_quant    # fill_quantity
# trans_sell_cb_USD   # fill_price (USD)
# amount left
##############################################################

### testing the regex for 3765 cryptocurrencies
# cusd = pd.read_table('cryptosusd')
# cusd.columns = ['col1']
# cusd['col1'].str.extract(r'(.+?(?=(USD)))')[0]

# supported currencies
# print(api.supported_currencies)


# limit price

ndf = pd.DataFrame()

ndf['trans_date'] = pd.to_datetime(df['event_date'] + ' ' + df['event_time'])
ndf['trans_type'] = df['side']

# temporary column to get buy_curr & sell_curr
ndf['temp_curr'] = df['symbol']
# buy_curr = BTC where trans_type == 'buy' else USD
ndf['trans_buy_curr'] = np.where(ndf['trans_type'] == 'buy',
                             ndf['temp_curr'].str.extract(r'(.+?(?=(USD)))')[0],
                             ndf['temp_curr'].str.extract(r'(.+?(?=(USD)))')[1]
                        )

ndf['trans_buy_quantity'] = df['fill_quantity_(btc)']
ndf['trans_buy_cb_USD'] = df['fill_price_(usd)']

ndf['trans_sell_curr'] = np.where(ndf['trans_type'] == 'sell',
                             ndf['temp_curr'].str.extract(r'(.+?(?=(USD)))')[0],
                             ndf['temp_curr'].str.extract(r'(.+?(?=(USD)))')[1]
                        )

ndf['trans_sell_quantity'] = df['fill_quantity_(btc)']

ndf['trans_sell_cb_USD'] = df['fill_price_(usd)']
####################################################
ndf['orig_quantity_btc'] = df['original_quantity_(btc)']
ndf['tot_exec_quant_btc'] = df['total_exec_quantity_(btc)']     # total_exec_quantity is only different from fill_quantity on sells
# ndf['orig_quantity_btc'] - ndf['tot_exec_quant_btc']
ndf['remain_quant'] = df['remaining_quantity_(btc)']


ndf = ndf.drop(['trans_type', 'temp_curr'], axis=1)

ndf = ndf.reset_index(drop=True)

ndf.loc[3,:]

##########################################
########### exchange function ###########
##########################################

# Somewhat working on it for the dataframe, I think that there are several spots that are messed up in original and am too confused
def crypt(j, amount_sold):
    trans = ndf.iloc[:, np.r_[1:7, 9]]
    temp = trans.iloc[j,:]
    for i in range(trans.shape[0]):
        if trans.iloc[i,0] == temp[3]: # b_curr == s_curr
            if float(trans.iloc[i,6]) > 0: # amount left > 0
                buy_amount = float(trans.iloc[i,2]) * float(trans.iloc[i,3]) | p(str) # gained = b_quant * b_cost_basis (buying)
                sell_amount = float(trans.iloc[i,1]) * float(trans.iloc[i,2]) | p(str) # spent = s_quant * s_cost_basisc (selling)
                profit = float(buy_amount) - float(sell_amount) | p(str) # gained - spent
                print(f"Bought {trans.iloc[i,1]} {trans.iloc[i,0]} for {buy_amount} and sold {trans.iloc[i,4]} {trans.iloc[i,3]} for {sell_amount} leaving a profit of {profit}")
                trans.iloc[i,6] = float(trans.iloc[i,7]) - float(trans.iloc[j,4])

##########################################
#### testing exchange rate conversion ####
##########################################

# ndf['trans_buy_curr'].replace('CAD', 'USD', inplace=True)

ndf.loc[
    ndf.query('trans_buy_curr == "USD"').sample(frac=0.1).index,
    'trans_buy_curr'
] = 'CAD'

for x in ndf[['trans_buy_curr', 'trans_date']].itertuples(index=False):
    if x[0] != 'USD' and x[0] != 'BTC':
        print(api.get_rate(target=x[0],
                           start_date=str(x[1].date()),
                           end_date=str(x[1].date())))
