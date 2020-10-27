-- connect to the correct db 
-- this name is determined in the docker-compose file
\connect thenewsroom_database

-- Clean up
DROP SCHEMA IF EXISTS NewsCollectorInfo CASCADE;

-- Create schema
CREATE SCHEMA NewsCollectorInfo;

-- Create user-defined data type with constraints for URLs 
CREATE DOMAIN URL AS VARCHAR(250);

-- create enumeration type of types of articles and media outlets
CREATE TYPE TYPEOFARTICLE AS ENUM ('Opinion', 'News');

CREATE TABLE NewsCollectorInfo.PublicNewsAPISources (
	id 					INT 			GENERATED ALWAYS AS IDENTITY,
	name 				VARCHAR(50) 	NOT NULL,
	endpoint_URL		URL 			NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE NewsCollectorInfo.ArticleContent (
	id 					INT 			GENERATED ALWAYS AS IDENTITY,
	content 			TEXT,
	PRIMARY KEY(id)
);

CREATE TABLE NewsCollectorInfo.MediaOutlets (
	id 					INT 			GENERATED ALWAYS AS IDENTITY,
	name				VARCHAR(50)		NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE NewsCollectorInfo.Topics (
	id					INT 			GENERATED ALWAYS AS IDENTITY,
	name				VARCHAR(100) 	NOT NULL,
	PRIMARY KEY(id)
);

-- timestamptz is short for timestamp with timezone
CREATE TABLE NewsCollectorInfo.Articles (
	id 					INT 			GENERATED ALWAYS AS IDENTITY,
	created_at			TIMESTAMPTZ 	NOT NULL DEFAULT NOW(),
	title 				VARCHAR(100)	NOT NULL, 
	web_content_url		URL,
	api_content_url		URL,
	article_type 		TYPEOFARTICLE 	NOT NULL,
	publication_date 	TIMESTAMP 		NOT NULL, 
	author				VARCHAR(50),
	media_outlet_id	 	INT    			NOT NULL,
	content_id			INT,
	PRIMARY KEY(id),
	CONSTRAINT foreign_key_content 		FOREIGN KEY(content_id) 	REFERENCES NewsCollectorInfo.ArticleContent(id),
	CONSTRAINT foreign_key_media_outlet FOREIGN KEY(media_outlet_id) REFERENCES NewsCollectorInfo.MediaOutlets(id)
);

CREATE TABLE NewsCollectorInfo.TopicOfArticle (
	id					INT 			GENERATED ALWAYS AS IDENTITY,
	topic_id			INT 			NOT NULL,
	article_id			INT 			NOT NULL,
	PRIMARY KEY(id),
	CONSTRAINT foreign_key_topic 		FOREIGN KEY(topic_id)				REFERENCES NewsCollectorInfo.Topics(id),
	CONSTRAINT foreign_key_article		FOREIGN KEY(article_id)				REFERENCES NewsCollectorInfo.Articles(id)
);


-- Smart Comments relied on by the Postgraphile GraphQL API engine
--COMMENT ON COLUMN NewsCollectorInfo.ArticleInfo.topic IS E'@forwardExtension';
--COMMENT ON COlUMN NewsCollectorInfo.ArticleInfo.media_outlet IS E'@forwardExtension';


-- CONSIDER ADDING INDEXES TO IMPROVE PERFORMANCE