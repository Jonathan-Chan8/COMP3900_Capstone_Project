#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct  7 17:37:11 2020

@author: z5079346

This script retrieve'es data from select news API's
and inserts the data into thenewsroom_database (postgreSQL)

"""

import requests
import json, sys
from psycopg2 import connect, Error
from os import makedirs
from os.path import join, exists
from datetime import date, timedelta
import enum
import collections
from datetime import datetime

schema_name = "NewsCollectorInfo"
table_name = "ArticleInfo"

#--------------------------- API HashMap's ---------------------------#

class Guardian():
#                  thenewsroom_database   Guardian API
    def __init__(self):
        
        self.name = "Guardian"
        self.id = 3
        self.page_limit = 5
        self.url = 'https://content.guardianapis.com/search?'
        self.api_key_liam = '08efafef-c5c0-43c6-a00e-b67880b448b2'
        self.api_key_jono = '450f355e-ac29-4a67-88d0-b72275c1c8c8'
        self.HashMap = collections.OrderedDict([ 
                            ('web_content_url'   , 'webUrl'),
                            ('api_given_category', 'sectionName'),
                            ('web_title'         , 'webTitle'),
                            ('publication_date'  , 'webPublicationDate'),
                            ('article_type'      , 'type' ),   
                            ('media_outlet_id'   , 3      )
                            ])

#------------------------- Retrieve API Data -------------------------#

# Create instances of each API class
Guardian_test = Guardian()

# List containing all the instances of API's
APIs = [Guardian_test]

# For each API, retrieve data
for API in APIs:

    print("Collecting " + str(API.page_limit) + " pages from the " + API.name +" API")
    
    params = {
        #'q'                 : 'trump',
        'from-date'         :    "2018-10-01",
        'to-date'           :    "2018-10-01",
        'api-key'           :API.api_key_liam,
        'page-size'         :  API.page_limit,     # 200 = max page size for Guardian
        'show-editors-picks':          'true',
        'show-elements'     :         'image',
        'show-fields'       :           'all',
    }

    # Retrieve data from the media outlet
    response = requests.get(API.url, params=params)
    data = response.json()
    all_results = []
    all_results.extend(data['response']['results'])
    
    # Convert webPublicationDate from unicode to datetime type
    # if API.name == 'Guardian':
    #     for article in all_results:
    #         date_updated = datetime.strptime(article['webPublicationDate'],'%Y-%m-%dT%H:%M:%SZ')
            
            
    # Remove unwanted attributes from all_results 
    for article in all_results:
        for info in list(article):
            if info not in API.HashMap.values():
                del article[info]
    
    # Enumerate the article_type attribute (required for thenewsroom_database)
    article_enum = {'type': 'Opinion'}  # PLACEHOLDER. NEEDS FIXING
    
    for article in all_results:
        article.update(article_enum)
             
        
#--------------  Convert API results into an SQL query ---------------#
    
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
            
            # Make all occurences of single qoutation mark as double qoutation mark   
            info_value = str(info_value.encode('utf-8','ignore')).replace("'", '"')
            #info_value = str(info_value.replace("'", '"'))
            
            
            # Then wrap the values in single qoutation marks
            info += [ "'" + info_value + "'" ]
        
        info += [str(API.id)]
        #info += [date_updated]
        #print(info)
        # put parenthesis around each record string
        #info_str += "(" + ', '.join( info ) + "),\n"
        info_str += "(" + ', '.join( info ) + "),\n"
        
    # remove the last comma and end SQL with a semicolon
    info_str = info_str[:-2] + ";"
    
    #concatenate the SQL string
    sql_string = "INSERT INTO %s.%s (%s)\nVALUES %s" % (
        schema_name, table_name,
        ', '.join(API.HashMap.keys()),
        info_str
    )



#------------------ Connect to thenewsroom_database ------------------#

    print ('Connecting to thenewsroom_database')
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
        
except (Exception, Error) as err:
    print ("Failed to connect to thenewsroom_database \npsycopg2 connect error:", err)
    conn = None
    cur = None
    
    
#------------------------- Execute SQL INSERT ------------------------#

# only attempt to execute SQL if cursor is valid
if cur != None:

    try:
        cur.execute( sql_string )
        conn.commit()

        print ('INSERT SUCCESS' )

    except (Exception, Error) as error:
        print("\nexecute_sql() error:", error)
        conn.rollback()
    
    # close the cursor and connection
    cur.close()
    conn.close()



