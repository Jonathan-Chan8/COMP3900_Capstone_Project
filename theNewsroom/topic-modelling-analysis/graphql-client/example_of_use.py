from .graphQL_client import graphQLClient

exampleQuery = """
              query {
                allTopics {
                  totalCount
                  nodes {
                    name
                  }
                }
              }"""

print(graphQLclient.executeQuery(exampleQuery))