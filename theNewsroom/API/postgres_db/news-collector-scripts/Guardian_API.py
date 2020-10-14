#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct  7 17:37:11 2020

@author: z5079346
"""

import requests
import json, sys
from psycopg2 import connect, Error
from os import makedirs
from os.path import join, exists
from datetime import date, timedelta
import enum

schema_name = "NewsCollectorInfo"
table_name = "ArticleInfo"

media_outlet = 'Guardian'
api_key = '08efafef-c5c0-43c6-a00e-b67880b448b2'
url = 'https://content.guardianapis.com/search?'


params = {
    'q'                 : 'coronavirus',
    'from-date'         :  "2020-10-01",
    'to-date'           :  "2020-10-02",
    'api-key'           :       api_key,
    'page-size'         :             3,
    'show-editors-picks':        'true',
    'show-elements'     :       'image',
    'show-fields'       :         'all'
}

# Retrieve data from the media outlet
response = requests.get(url, params=params)
data = response.json()
all_results = []
all_results.extend(data['response']['results'])

# Remove unwanted attributes from all_results 
for article in all_results:
    for info in list(article):
        if info not in ['webTitle', 'webUrl', 'sectionName', 'type', 'webPublicationDate']:
            del article[info]

# Enumerate the article_type attribute (required for thenewsroom_database)
article_enum = {'type': 'Opinion'}  # PLACEHOLDER. NEEDS FIXING
for article in all_results:
    article.update(article_enum)
         

# Create a list of thenewsroom_database attributes to later be INSERTed  
# corresponding to the news API's attributes and their attribute order     
columns = [ 'web_content_url','api_given_category','web_title','publication_date','article_type','media_outlet_id']


#------------  Convert API results into an SQL query -------------#

# create a nested list of the articles
articles = [list(x.values()) for x in all_results] 

# value string for the SQL string
info_str = ""

# enumerate over the article lists
for i, article in enumerate(articles):

    # declare empty list for values
    info = []
   
    # append each value to a new list of values
    for v, info_value in enumerate(article):
        # if type(val) == str:
        #     val = str(json(val)).replace('"', '')
        info += [ "'" + str(info_value) + "'" ]
    
    if media_outlet == 'Guardian':
        info += ['3']
    
    # put parenthesis around each record string
    info_str += "(" + ', '.join( info ) + "),\n"
    
    
# remove the last comma and end SQL with a semicolon
info_str = info_str[:-2] + ";"

#concatenate the SQL string
sql_string = "INSERT INTO %s.%s (%s)\nVALUES %s" % (
    schema_name, table_name,
    ', '.join(columns),
    info_str
)

#------  Connect to thenewsroom_database and execute SQL INSERT  ------#

try:
    # declare a new PostgreSQL connection object
    conn = connect(
        dbname = "thenewsroom_database",
        user = "postgres",
        host = "127.0.0.1",
        password = "password",
        # attempt to connect for 3 seconds then raise exception
        connect_timeout = 3
    )

    cur = conn.cursor()
    print ("\ncreated cursor object:", cur)

except (Exception, Error) as err:
    print ("\npsycopg2 connect error:", err)
    conn = None
    cur = None


# only attempt to execute SQL if cursor is valid
if cur != None:

    try:
        cur.execute( sql_string )
        conn.commit()

        print ('\nfinished INSERT INTO execution')

    except (Exception, Error) as error:
        print("\nexecute_sql() error:", error)
        conn.rollback()

    # close the cursor and connection
    cur.close()
    conn.close()



