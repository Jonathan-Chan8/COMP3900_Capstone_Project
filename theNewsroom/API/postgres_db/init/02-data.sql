-- DATA INSERTING
INSERT INTO NewsCollectorInfo.PublicNewsAPISources(name, endpoint_URL) VALUES ('GuardiaAPI', 'http://guardian.com');
INSERT INTO NewsCollectorInfo.PublicNewsAPISources(name, endpoint_URL) VALUES ('NewsAPI', 'http://newsAPI.io');

INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('Sydney Morning Herald');
INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('Australian');
INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('The Morning Telegraph');

INSERT INTO NewsCollectorInfo.ArticleContent(content) VALUES ('This is some article content.');
INSERT INTO NewsCollectorInfo.ArticleContent(content) VALUES ('This is some MORE article content.');
INSERT INTO NewsCollectorInfo.ArticleContent(content) VALUES ('This is some EVEN MORE article content.');

INSERT INTO NewsCollectorInfo.ArticleInfo(web_title, publication_date, article_type, api_given_category, media_outlet_id, content_id) VALUES ('TEAM ROCKET IS BACK...AGAIN!!!', '2019-10-11 10:10:25', 'News', 'Foreign Politics', 1, 1);
INSERT INTO NewsCollectorInfo.ArticleInfo(web_title, publication_date, article_type, api_given_category, media_outlet_id, content_id) VALUES ('THE BECONS ARE LIT! GONDOR CALLS FOR AID', '2020-01-01 10:10:25', 'News', 'Foreign Politics', 2, 2);
INSERT INTO NewsCollectorInfo.ArticleInfo(web_title, publication_date, article_type, api_given_category, media_outlet_id, content_id) VALUES ('TOP 5 REASONS WHY YOU SHOULD PICK THE BLUE PILL', '2020-01-11 10:10:25', 'Opinion', 'Health and Wellbeing', 3, 3);

