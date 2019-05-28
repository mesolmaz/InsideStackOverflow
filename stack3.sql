-- Top 10000 Posts and Answers given a tag
SELECT TOP 10000
    q.Id AS [Post Link],
    q.Title as Post_Title,
    q.Score as Score,
    q.Body as QuestionBody,
    a.Body as AnswerBody
FROM
    Posts q
    inner Join Posts as a ON a.ParentId = q.Id
WHERE
    LOWER(q.Tags) LIKE LOWER('%##tag##%') and q.AnswerCount > 20 and a.posttypeid = 2
ORDER BY
    Score DESC;