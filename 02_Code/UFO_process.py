#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan  9 17:08:41 2019

@author: Manita
"""

import numpy as np
import pandas as pd
pd.set_option('display.expand_frame_repr', False)

ufo = pd.read_csv('/Users/Manita/OneDrive - NOVAIMS/DV/UFO/scrubbed.csv')

ufo.isnull().sum()
ufo.dropna(inplace=True)

len(ufo['shape'].unique())

ufo['shape'].replace({
   'changed': 'changing',
   'egg': 'oval',
   'round': 'circle',
   'delta': 'triangle',
   'other': 'unknown',
   'flash': 'light',
   'cigar': 'cylinder',
   'crescent': 'changing',
   'chevron': 'triangle',
   'fireball': 'flare'},inplace=True)

len(ufo['shape'].unique())

# delete useless columns

ufo.drop(columns = ['duration (hours/min)','date posted'],inplace=True)


# split datetime

#ufo[['datetime', 'hours']] = ufo.datetime.str.split(' ', expand = True)


# rename

ufo.rename(index=str, columns={"duration (seconds)": "duration"},inplace=True)

ufo.columns
# export csv

ufo.to_csv('/Users/Manita/OneDrive - NOVAIMS/DV/UFO/ufo_processed.csv')

