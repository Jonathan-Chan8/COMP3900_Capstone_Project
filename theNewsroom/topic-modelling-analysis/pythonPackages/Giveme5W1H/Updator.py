from ..GraphqlClient.GraphQLClient import GraphQLClient
from Giveme5W1H.extractor.document import Document
from Giveme5W1H.extractor.extractor import MasterExtractor  
    

class Giveme5W1HUpdator():
    _client = None
    results = None

    def __init__(self):
        if (GraphQLClient is None):
            exit("GraphQLClient was not provided to the Giveme5W1HUpdator")
        self._client = GraphQLClient()

    
    def fetchTextSummaryOfArticles(self):
        returnedJson = self._client.executeQuery(self.allArticlesGQL())
        self.results = returnedJson['allArticles']['nodes']
        print(f"Successfully fetched {len(self.results)} articles. Storing data for later use")

    def allArticlesGQL(self):
        return """
            query {
                allArticles {
                    nodes {
                        id
                        title
                        textSummary
                        articlecontentByContentId {
                            content
                        }
                    }
                }
            }
        """
    
'''
if __name__ == '__main__':
    # logger setup
    log = logging.getLogger('GiveMe5W')
    log.setLevel(logging.DEBUG)
    sh = logging.StreamHandler()
    sh.setLevel(logging.DEBUG)
    log.addHandler(sh)

    # giveme5w setup - with defaults
    extractor = MasterExtractor()
    doc = Document.from_text(titleshort, date_publish)

    doc = extractor.parse(doc)

    top_who_answer = doc.get_top_answer('who').get_parts_as_text()
    top_what_answer = doc.get_top_answer('what').get_parts_as_text()
    top_when_answer = doc.get_top_answer('when').get_parts_as_text()
    top_where_answer = doc.get_top_answer('where').get_parts_as_text()
    top_why_answer = doc.get_top_answer('why').get_parts_as_text()
    top_how_answer = doc.get_top_answer('how').get_parts_as_text()

    print(top_who_answer)
    print(top_what_answer)
    print(top_when_answer)
    print(top_where_answer)
    print(top_why_answer)
    print(top_how_answer)
    
'''



