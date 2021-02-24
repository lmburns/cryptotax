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

# api.get_rates()

df.columns.values

ndf = pd.DataFrame()

# OTHER:
    # df['c2'] = df['c1'].apply(lambda x: 10 if x == 'Value' else x)

# TODO:
    # regex conditional selection
ndf['trans_date'] = df['event_date'] + ' ' + df['event_time']
ndf['trans_type'] = df['side']

ndf['temp_curr'] = df['symbol']
ndf['trans_buy_curr'] = np.where(ndf['trans_type'] == 'buy',
                             ndf['temp_curr'].str.extract(r'(.+?(?=(USD)))')[1],
                             ndf['temp_curr'].str.extract(r'(.+?(?=(USD)))')[0])


ndf['trans_buy_quantity'] = df['fill_quantity_(btc)']
ndf['trans_buy_cb_USD'] = df['fill_price_(usd)']

ndf['trans_sell_curr'] = df['symbol'].str.extract(r'(.+?(?=(USD)))')[1]
ndf['trans_sell_quantity'] = df['fill_quantity_(btc)']
ndf['trans_sell_cb_USD'] = df['fill_price_(usd)']

ndf = ndf.drop(['trans_type', 'temp_curr'], axis=1)

ndf['subtotal'] = ndf['quantity'] * ndf['cost_basis'] | px.astype(float)
ndf['total'] = ndf['quantity'] * ndf['cost_basis'] | px.astype(float)


ndf.reset_index(drop=True)
