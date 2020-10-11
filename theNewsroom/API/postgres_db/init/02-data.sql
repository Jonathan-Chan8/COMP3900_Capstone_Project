-- DATA INSERTING
INSERT INTO NewsCollectorInfo.PublicNewsAPISources(name, endpoint_URL) VALUES ('GuardiaAPI', 'http://guardian.com');
INSERT INTO NewsCollectorInfo.PublicNewsAPISources(name, endpoint_URL) VALUES ('NewsAPI', 'http://newsAPI.io');

INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('Sydney Morning Herald');
INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('Australian');
INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('The Morning Telegraph');

INSERT INTO NewsCollectorInfo.ArticleInfo(web_title, article_type, media_outlet_id) VALUES ('TEAM ROCKET IS BACK...AGAIN!!!', 'News', 1);
INSERT INTO NewsCollectorInfo.ArticleInfo(web_title, article_type, media_outlet_id) VALUES ('THE BECONS ARE LIT! GONDOR CALLS FOR AID', 'News', 2);
INSERT INTO NewsCollectorInfo.ArticleInfo(web_title, article_type, media_outlet_id) VALUES ('TOP 5 REASONS WHY YOU SHOULD PICK THE BLUE PILL', 'Opinion', 3);
