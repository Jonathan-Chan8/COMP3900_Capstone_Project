-- Create a schema to host tables just on the content
DROP TABLE IF EXISTS PublicNewsAPISource;
DROP TABLE IF EXISTS MediaOutlet;
DROP TABLE IF EXISTS ArticleContent;
DROP TABLE IF EXISTS ArticleInfo;

CREATE TABLE PublicNewsAPISources (
	API_source_id 		INT 			GENERATED ALWAYS AS IDENTITY,
	name 				TEXT 		NOT NULL,
	endpoint_URL		TEXT		NOT NULL,
	PRIMARY KEY(API_source_id)
);

CREATE TABLE MediaOutlets (
	media_outlet_id 	INT 			GENERATED ALWAYS AS IDENTITY,
	name 				TEXT			NOT NULL,
	PRIMARY KEY(media_outlet_id)
);

CREATE TABLE ArticleContent (
	content_id 			INT 			GENERATED ALWAYS AS IDENTITY,
	content 			TEXT,
	PRIMARY KEY(content_id)
);

-- create enumeration type of types of articles and media outlets
CREATE TYPE TYPEOFARTICLE AS ENUM ('Opinion', 'News');

-- timestamptz is short for timestamp with timezone
CREATE TABLE ArticleInfo (
	article_id 			INT 			GENERATED ALWAYS AS IDENTITY,
	created_at			TIMESTAMPTZ 	NOT NULL DEFAULT NOW(),
	web_title 			TEXT			NOT NULL, 
	web_content_url		TEXT,
	api_content_url		TEXT,
	api_given_category 	TEXT,
	article_type 		TYPEOFARTICLE 	NOT NULL,
	publication_date 	TIMESTAMP 		NOT NULL DEFAULT NOW(), 
	author				TEXT,
	media_outlet_id 	INT    			NOT NULL,
	content_id 			INT,
	PRIMARY KEY(article_id),
	CONSTRAINT foreign_key_media_outlet FOREIGN KEY(media_outlet_id) REFERENCES MediaOutlets(media_outlet_id),
	CONSTRAINT foreign_key_content 		FOREIGN KEY(content_id) REFERENCES ArticleContent(content_id)
);


-- DATA INSERTING
INSERT INTO PublicNewsAPISources(name, endpoint_URL) VALUES ('GuardiaAPI', 'http://guardian.com');
INSERT INTO PublicNewsAPISources(name, endpoint_URL) VALUES ('NewsAPI', 'http://newsAPI.io');

INSERT INTO MediaOutlets(name) VALUES ('Sydney Morning Herald');
INSERT INTO MediaOutlets(name) VALUES ('Australian');
INSERT INTO MediaOutlets(name) VALUES ('The Morning Telegraph');

INSERT INTO ArticleInfo(web_title, article_type, media_outlet_id) VALUES ('TEAM ROCKET IS BACK...AGAIN!!!', 'News', 1);
INSERT INTO ArticleInfo(web_title, article_type, media_outlet_id) VALUES ('THE BECONS ARE LIT! GONDOR CALLS FOR AID', 'News', 2);
INSERT INTO ArticleInfo(web_title, article_type, media_outlet_id) VALUES ('TOP 5 REASONS WHY YOU SHOULD PICK THE BLUE PILL', 'Opinion', 3);
