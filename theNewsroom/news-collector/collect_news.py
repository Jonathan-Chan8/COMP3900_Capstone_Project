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


#--------------------------- API HashMap's ---------------------------#

class Guardian():
#                  thenewsroom_database   Guardian API
    def __init__(self):
        
        self.name = "Guardian"
        self.id = 1
        self.page_limit = 200
        self.url = 'https://content.guardianapis.com/search?'
        self.api_key_liam = '08efafef-c5c0-43c6-a00e-b67880b448b2'
        self.api_key_jono = '450f355e-ac29-4a67-88d0-b72275c1c8c8'
        self.HashMap = collections.OrderedDict([ 
                            ('article_type'      , 'type' ),   
                            #('api_given_category', 'sectionName'),
                            ('publication_date'  , 'webPublicationDate'),
                            ('title'         , 'webTitle'),
                            ('web_content_url'   , 'webUrl'),
                            ('media_outlet_id'   , 1      ),
                            ('content_id'        ,  0      ) # 0 is a placeholder
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
        'from-date'         :    "2019-10-01",
        'to-date'           :    "2019-10-01",
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
    
    # Extract the article content (text) 
    article_content = []
    article_topic = []
    for article in all_results:
        article_content.append(article['fields']['bodyText'])
        article_topic.append(article['sectionName'])
    
    
    # Convert webPublicationDate from unicode to datetime type
    if API.name == 'Guardian':
        for article in all_results:
            article['webPublicationDate'] = datetime.strptime(article['webPublicationDate'],'%Y-%m-%dT%H:%M:%SZ')


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
    
    # Append the API id to each article 
    for article in articles:
        article.append(API.id)    
           

    # Create queries to be INSERT'ed into the postgres database
    
    # Articles Table
    info_string = "INSERT INTO NewsCollectorInfo.Articles (%s) VALUES " % (
         ', '.join(API.HashMap.keys()))   
    info_string += "("
    for x in range(len(API.HashMap)):
        info_string += """%s,"""
    info_string = info_string[:-1]
    info_string += ")"
    
    # ArticleContent Table
    content_string = """INSERT INTO NewsCollectorInfo.ArticleContent (content) VALUES (%s)"""
    
    # Topics Table
    topic_string = """INSERT INTO NewsCollectorInfo.Topics (name) VALUES (%s)"""

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
            
            # if len(articles) == len(article_content):
            #     zip_tables = zip(articles, article_content, article_topic)
               
            # for article, content, topic in zip_tables:

            # Insert each article into the appropiate tables
            for article, content, topic in zip(articles, article_content, article_topic):
                
                # insert article contents
                cur.execute(content_string, (content,)) # Formatting: Needs to be a tuple (or list)
                         
                # retrieve content_id and append to article as a foreign key
                cur.execute("SELECT MAX(id) FROM NewsCollectorInfo.ArticleContent")
                content_id = cur.fetchone()
                article.append(content_id)
                
                # insert article
                cur.execute(info_string, article)
                
                # insert article topic 
                cur.execute(topic_string, (topic,))
                
                # retrieve topic and article id (foreign keys) 
                # and insert into topicofarticle table
                cur.execute("SELECT MAX(T.id), MAX(a.id) FROM NewsCollectorInfo.Topics as T, NewsCollectorInfo.articles as a;")
                foreign_keys = cur.fetchone()
                topicofarticle_string = """INSERT INTO NewsCollectorInfo.topicofarticle (topic_id, article_id) VALUES (%s, %s)"""
                cur.execute(topicofarticle_string, foreign_keys)
                
            conn.commit()
    
            print ('INSERT SUCCESS' )
    
        except (Exception, Error) as error:
            print("\nexecute_sql() error:", error)
            conn.rollback()
        
        # close the cursor and connection
        cur.close()
        conn.close()
    
    

