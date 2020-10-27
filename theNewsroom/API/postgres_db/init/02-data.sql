-- DATA INSERTING
INSERT INTO NewsCollectorInfo.PublicNewsAPISources(name, endpoint_URL) VALUES ('GuardiaAPI', 'http://guardian.com');
INSERT INTO NewsCollectorInfo.PublicNewsAPISources(name, endpoint_URL) VALUES ('NewsAPI', 'http://newsAPI.io');

INSERT INTO NewsCollectorInfo.ArticleContent(content) VALUES ('This is some article content.');
INSERT INTO NewsCollectorInfo.ArticleContent(content) VALUES ('This is some MORE article content.');
INSERT INTO NewsCollectorInfo.ArticleContent(content) VALUES ('This is some EVEN MORE article content.');

INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('Australian');
INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('The Sydney Morning Herald');

INSERT INTO NewsCollectorInfo.Topics(name) VALUES ('Coronavirus');
INSERT INTO NewsCollectorInfo.Topics(name) VALUES ('Crime');

INSERT INTO NewsCollectorInfo.Articles(title, publication_date, article_type, media_outlet_id, content_id) VALUES ('TEAM ROCKET IS BACK...AGAIN!!!', '2019-10-11 10:10:25', 'News', 1, 1);
INSERT INTO NewsCollectorInfo.Articles(title, publication_date, article_type, media_outlet_id, content_id) VALUES ('THE BECONS ARE LIT! GONDOR CALLS FOR AID', '2020-01-01 10:10:25', 'News', 1, 2);
INSERT INTO NewsCollectorInfo.Articles(title, publication_date, article_type, media_outlet_id, content_id) VALUES ('TOP 5 REASONS WHY YOU SHOULD PICK THE BLUE PILL', '2020-01-11 10:10:25', 'Opinion', 2, 3);

INSERT INTO NewsCollectorInfo.TopicOfArticle(topic_id, article_id) VALUES (1, 1);
INSERT INTO NewsCollectorInfo.TopicOfArticle(topic_id, article_id) VALUES (2, 2);
INSERT INTO NewsCollectorInfo.TopicOfArticle(topic_id, article_id) VALUES (2, 3);