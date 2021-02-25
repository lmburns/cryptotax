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

print(api.get_rates('USD'))

df.columns.values

ndf = pd.DataFrame()

# TODO:
    # regex conditional selection
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

# sell_curr = USD where trans_type == 'sell' else BTC
ndf['trans_sell_curr'] = np.where(ndf['trans_type'] == 'sell',
                             ndf['temp_curr'].str.extract(r'(.+?(?=(USD)))')[1],
                             ndf['temp_curr'].str.extract(r'(.+?(?=(USD)))')[0])
                        )

ndf['trans_sell_quantity'] = df['fill_quantity_(btc)']
ndf['trans_sell_cb_USD'] = df['fill_price_(usd)']

ndf = ndf.drop(['trans_type', 'temp_curr'], axis=1)

ndf = ndf.reset_index(drop=True)
ndf
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
