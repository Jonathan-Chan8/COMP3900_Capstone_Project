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
