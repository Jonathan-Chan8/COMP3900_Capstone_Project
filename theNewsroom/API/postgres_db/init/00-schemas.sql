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
	API_source_id 		INT 			GENERATED ALWAYS AS IDENTITY,
	name 				VARCHAR(50) 	NOT NULL,
	endpoint_URL		URL 			NOT NULL,
	PRIMARY KEY(API_source_id)
);

CREATE TABLE NewsCollectorInfo.MediaOutlets (
	media_outlet_id 	INT 			GENERATED ALWAYS AS IDENTITY,
	name 				VARCHAR(50)		NOT NULL,
	PRIMARY KEY(media_outlet_id)
);

CREATE TABLE NewsCollectorInfo.ArticleContent (
	content_id 			INT 			GENERATED ALWAYS AS IDENTITY,
	content 			TEXT,
	PRIMARY KEY(content_id)
);

-- timestamptz is short for timestamp with timezone
CREATE TABLE NewsCollectorInfo.ArticleInfo (
	article_id 			INT 			GENERATED ALWAYS AS IDENTITY,
	created_at			TIMESTAMPTZ 	NOT NULL DEFAULT NOW(),
	web_title 			VARCHAR(100)	NOT NULL, 
	web_content_url		URL,
	api_content_url		URL,
	api_given_category 	VARCHAR(50),
	article_type 		TYPEOFARTICLE 	NOT NULL,
	publication_date 	TIMESTAMP 		NOT NULL DEFAULT NOW(), 
	author				VARCHAR(50),
	media_outlet_id 	INT    			NOT NULL,
	content_id 			INT,
	PRIMARY KEY(article_id),
	CONSTRAINT foreign_key_media_outlet FOREIGN KEY(media_outlet_id) REFERENCES NewsCollectorInfo.MediaOutlets(media_outlet_id),
	CONSTRAINT foreign_key_content 		FOREIGN KEY(content_id) REFERENCES NewsCollectorInfo.ArticleContent(content_id)
);

-- Comments on Tables. This will automately be collected by the GraphQL API
COMMENT ON TABLE NewsCollectorInfo.PublicNewsAPISources IS 'Record of the API used where the article information was gather from';

COMMENT ON TABLE NewsCollectorInfo.MediaOutlets IS 'All the media outlets that articles have been collected from';

COMMENT ON TABLE NewsCollectorInfo.ArticleContent IS 'Contains the text from the article. Stored separately because of its size';

COMMENT ON TABLE NewsCollectorInfo.ArticleInfo IS 'Contains general information about the article. Does not store the contents.';
COMMENT ON COLUMN NewsCollectorInfo.ArticleInfo.created_at IS 'When was this db record created';
COMMENT ON COLUMN NewsCollectorInfo.ArticleInfo.web_title IS 'Title of the article';
COMMENT ON COLUMN NewsCollectorInfo.ArticleInfo.web_content_url IS 'The URL to the article via the web';
COMMENT ON COLUMN NewsCollectorInfo.ArticleInfo.api_content_url IS 'The URL to the article via an api';
COMMENT ON COLUMN NewsCollectorInfo.ArticleInfo.api_given_category IS 'Sometimes, the API will categorise the article into a topic. Collect that info here.';
COMMENT ON COLUMN NewsCollectorInfo.ArticleInfo.article_type IS 'Generalisation of the type of article it is (eg. News, Opinion, etc.)';
COMMENT ON COLUMN NewsCollectorInfo.ArticleInfo.publication_date IS 'Supposed to store the date in which the article was publish (CURRENTLY DOES NOT)';