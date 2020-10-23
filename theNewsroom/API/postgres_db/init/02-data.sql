-- DATA INSERTING
INSERT INTO NewsCollectorInfo.PublicNewsAPISources(name, endpoint_URL) VALUES ('GuardiaAPI', 'http://guardian.com');
INSERT INTO NewsCollectorInfo.PublicNewsAPISources(name, endpoint_URL) VALUES ('NewsAPI', 'http://newsAPI.io');

INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('Sydney Morning Herald');
INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('Australian');
INSERT INTO NewsCollectorInfo.MediaOutlets(name) VALUES ('The Morning Telegraph');

INSERT INTO NewsCollectorInfo.ArticleContent(content) VALUES ('This is some article content.');
INSERT INTO NewsCollectorInfo.ArticleContent(content) VALUES ('This is some MORE article content.');
INSERT INTO NewsCollectorInfo.ArticleContent(content) VALUES ('This is some EVEN MORE article content.');

