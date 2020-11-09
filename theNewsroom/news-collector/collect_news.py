#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct  7 17:37:11 2020

@author: z5079346

This script retrieve's data from select news API's
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

    def __init__(self):
        
        self.name = "Guardian"
        self.id = 1
        self.page_limit = 200
        self.url = 'https://content.guardianapis.com/search?'
        self.api_key_liam = '08efafef-c5c0-43c6-a00e-b67880b448b2'
        self.api_key_jono = '450f355e-ac29-4a67-88d0-b72275c1c8c8'

        # Hashmap maps (ourSQLSchemaColumnName, GuardianAPIField)
        self.HashMap = collections.OrderedDict([ 
                            ('article_type'      , 'type' ),   
                            ('publication_date'  , 'webPublicationDate'),
                            #('api_given_topic'   , 'sectionName'),
                            ('title'             , 'webTitle'),
                            ('web_content_url'   , 'webUrl'),
                            ('media_outlet_id'   , self.id      ),
                            ('content_id'        , 0      ) # 0 is a placeholder
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
        'from-date'         :    "2020-04-01",
        'to-date'           :    "2020-05-01",
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
    
    # Extract the article content (text) and given Topic
    article_content = []
    article_topics = []
    for article in all_results:
        article_content.append(article['fields']['bodyText'])
        article_topics.append(article['sectionName'])
    
    # Convert webPublicationDate from unicode to datetime type
    if API.name == 'Guardian':
        for article in all_results:
            article['webPublicationDate'] = datetime.strptime(article['webPublicationDate'], '%Y-%m-%dT%H:%M:%SZ').date()


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

    
    # https://stackoverflow.com/questions/5247685/python-postgres-psycopg2-getting-id-of-row-just-inserted
    # Articles Table
    column_names = ", ".join(API.HashMap.keys())
    value_format_string = ("%s," * len(API.HashMap))[:-1]
    articles_row_format_string = """INSERT INTO NewsCollectorInfo.Articles 
                                        ({}) 
                                    VALUES 
                                        ({}) 
                                    RETURNING id;""".format(column_names, value_format_string)
    
    # ArticleContent Table
    content_row_format_string = """INSERT INTO NewsCollectorInfo.ArticleContent 
                                        (content) 
                                    VALUES 
                                        (%s)
                                    RETURNING id;"""
    
    # Topics Table
    topic_row_format_string = """INSERT INTO NewsCollectorInfo.Topics 
                                        (name) 
                                    VALUES 
                                        (%s)
                                    RETURNING id;"""

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
           
            # Insert each article into the appropiate tables
            for article, content, topic in zip(articles, article_content, article_topics):
                
                # insert article contents
                cur.execute(content_row_format_string, (content,)) # Formatting: Needs to be a tuple (or list)
                # added RETURNING to statements
                content_id = cur.fetchone()[0]
                         
                article.append(content_id)
                
                # insert article
                cur.execute(articles_row_format_string, article)
                article_id = cur.fetchone()[0]
                
                # insert article topic 
                # need to check if it already exists
                cur.execute(""" SELECT * 
                                    FROM NewsCollectorInfo.Topics 
                                    WHERE (name LIKE %s);               
                            """, (topic,))

                topic_id = cur.fetchone()
                if not topic_id:
                    cur.execute(topic_row_format_string, (topic,))
                    topic_id = cur.fetchone()[0]
                else:
                    topic_id = topic_id[0]
                    
                # insert ids as foreign keys into topicofarticle table
                topicofarticle_format_string = """INSERT INTO NewsCollectorInfo.TopicOfArticle (topic_id, article_id) VALUES (%s, %s)"""
                cur.execute(topicofarticle_format_string, (topic_id, article_id))
                
            conn.commit()
    
            print ('INSERT SUCCESS' )
    
        except (Exception, Error) as error:
            print("\nexecute_sql() error:", error)
            conn.rollback()
        
        # close the cursor and connection
        cur.close()
        conn.close()
    
#%%

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

#------------- Retrieve article content for processing ---------------#

# only attempt to execute SQL if cursor is valid
if cur != None:

    try:
        cur.execute(""" SELECT content FROM NewsCollectorInfo.ArticleContent """)
        ArticleContent_All = cur.fetchall()
        
    except (Exception, Error) as error:
        print("\nexecute_sql() error:", error)
        conn.rollback()

# close the cursor and connection
cur.close()
conn.close()

# Convert ArticleContent_All from list of tuples, to list of strings
for i in range(len(ArticleContent_All)):
    ArticleContent_All[i] = ArticleContent_All[i][0]    

import pprint # for pretty printing
from gensim import corpora, similarities

text_corpus = ArticleContent_All

#%%

text_corpus = [
    "Human machine interface for lab abc computer applications",
    "A survey of user opinion of computer system response time",
    "The EPS user interface management system",
    "System and human system engineering testing of EPS",
    "Relation of user perceived response time to error measurement",
    "The generation of random binary unordered trees",
    "The intersection graph of paths in trees",
    "Graph minors IV Widths of trees and well quasi ordering",
    "Graph minors A survey",
]

# Create a set of frequent words
stoplist = set('for a of the and to in'.split(' '))
# Lowercase each document, split it by white space and filter out stopwords
texts = [[word for word in document.lower().split() if word not in stoplist]
         for document in text_corpus]

# Count word frequencies
from collections import defaultdict
frequency = defaultdict(int)
for text in texts:
    for token in text:
        frequency[token] += 1

# Only keep words that appear more than once
processed_corpus = [[token for token in text if frequency[token] > 1] for text in texts]

# Assign each word a unique ID
dictionary = corpora.Dictionary(processed_corpus)

# Use the bag-of-words model to determine the frequency of each word
# and put words in the format (ID, frequency)
bow_corpus = [dictionary.doc2bow(text) for text in processed_corpus]

from gensim import models
import gensim


NUM_TOPICS = 10
ldamodel = gensim.models.ldamodel.LdaModel(bow_corpus, num_topics = NUM_TOPICS, id2word=dictionary, passes=15)
ldamodel.save('model5.gensim')

topics = ldamodel.print_topics(num_words=5)
for topic in topics:
    print(topic)



## More complex analysis to compare article similarity ##

# train the model
tfidf = models.TfidfModel(bow_corpus)

# test a phrase with the model
#words = "third british".lower().split()
#print(tfidf[dictionary.doc2bow(words)])


# num_features must be the number of features (dimensions) in the corpus
index = similarities.SparseMatrixSimilarity(tfidf[bow_corpus], num_features = len(dictionary)) 

query_document = 'third british'.split()
query_bow = dictionary.doc2bow(query_document)

sims = index[tfidf[query_bow]]

print(list(enumerate(sims)))

sims = sorted(enumerate(sims), key=lambda item: -item[1])

for doc_position, doc_score in sims:
    print(doc_score, text_corpus[doc_position])


# for document_number, score in sorted(enumerate(sims), key=lambda x: x[1], reverse=True):
#     print(document_number, score)


# Transform the corpus

corpus_tfidf = tfidf[bow_corpus]

lsi_model = models.LsiModel(corpus_tfidf, id2word=dictionary, num_topics=4)  # initialize an LSI transformation
corpus_lsi = lsi_model[corpus_tfidf]  # create a double wrapper over the original corpus: bow->tfidf->fold-in-ls
lsi_model.print_topics(4)




#%%

# import logging

# from Giveme5W1H.extractor.document import Document
# from Giveme5W1H.extractor.extractor import MasterExtractor

# """
# This is a simple example how to use the extractor in combination with a dict in news-please format.

# - Nothing is cached

# """

# # don`t forget to start up core_nlp_host
# # giveme5w1h-corenlp

# #title = "Martian rock named for Rolling StonesRolling Stones get name on little Martian rock that rolled. "
# title = article[2]

# lead = "" 

# #text = article_content[0]

# date_publish = '2019-08-24'

# if __name__ == '__main__':
#     # logger setup
#     log = logging.getLogger('GiveMe5W')
#     log.setLevel(logging.DEBUG)
#     sh = logging.StreamHandler()
#     sh.setLevel(logging.DEBUG)
#     log.addHandler(sh)

#     print("Creating extractor instance...")
#     # giveme5w setup - with defaults
#     extractor = MasterExtractor()
#     doc = Document.from_text(title + lead + text, date_publish)

#     print("Passing text to the extractor...")
#     doc = extractor.parse(doc)

#     print("Retrieving individual elements from returned object...")
#     top_who_answer = doc.get_top_answer('who').get_parts_as_text()
#     top_what_answer = doc.get_top_answer('what').get_parts_as_text()
#     top_when_answer = doc.get_top_answer('when').get_parts_as_text()
#     top_where_answer = doc.get_top_answer('where').get_parts_as_text()
#     top_why_answer = doc.get_top_answer('why').get_parts_as_text()
#     top_how_answer = doc.get_top_answer('how').get_parts_as_text()

#     print(top_who_answer)
#     print(top_what_answer)
#     print(top_when_answer)
#     print(top_where_answer)
#     print(top_why_answer)
#     print(top_how_answer)


