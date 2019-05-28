-- Top 100 Most Reputable Users (Top Answerers) for a Given Tag

SELECT TOP 100
    Users.DisplayName,
    Users.Id as [User Link],
    max(Reputation) as Reputation,
    Count(Answers.Id) as Answers,
    sum(Answers.Score) as Score,
    CAST(AVG(CAST(Answers.Score AS float)) as numeric(6,1)) as [Avg]
FROM Tags    
    JOIN PostTags ON PostTags.TagId = Tags.Id
    JOIN Posts ON Posts.Id = PostTags.PostId 
    JOIN Posts as Answers ON Answers.ParentId = Posts.Id
    JOIN Users ON Users.Id = Answers.OwnerUserId
WHERE    
    Tags.TagName = '##TagName##'
GROUP BY 
    Users.Id, DisplayName
ORDER BY 
    sum(Answers.Score) DESC;