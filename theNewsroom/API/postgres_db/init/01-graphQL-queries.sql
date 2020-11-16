-- Responsible for declaring functions that contain business logic
-- Thereby, handing the responsibility of computation closer to database and not solely on the client

-- To adhere to the condition set by Postgraphile (https://www.graphile.org/postgraphile/custom-queries/)
-- For returning SETOF's with multiple columns, you need to declare a new type

CREATE TYPE ArticleCountByDate AS (
    x    DATE,
    y    BIGINT
);

-- Given a start and end date and a topic Id, return the number of articles under each day
CREATE OR REPLACE FUNCTION NewsCollectorInfo.AggregateArticleCountByDays(topicId int, startDate date, endDate date)
RETURNS SETOF ArticleCountByDate AS $$
    -- The inner query is required to type cast the publication date to DATE to
    -- allow for the group by logic to function as required    
    SELECT publication_date, COUNT(*)
        FROM newscollectorinfo.topicofarticle as topicInfo
        INNER JOIN (SELECT id, CAST(publication_date AS DATE)
                        FROM newscollectorinfo.Articles) as articleInfo
            ON topicInfo.article_id = articleInfo.id
        WHERE topic_id = topicId
            AND publication_date >= startDate
            AND publication_date <= endDate
        GROUP BY publication_date
        ORDER BY publication_date ASC;
$$ LANGUAGE sql STABLE;


CREATE TYPE TopTopic AS (
    id          INT,
    topicName   VARCHAR(100),
    num         INT
)

CREATE OR REPLACE FUNCTION NewsCollectorInfo.GetTopTopic(startDate date, endDate date)
RETURNS SETOF TopTopic AS $$
    SELECT * 
        FROM 
$$ LANGUAGE sql STABLE;
