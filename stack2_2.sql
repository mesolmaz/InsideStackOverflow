-- Post tags of top 1000 most reputable users given a tag
SELECT Users.DisplayName, Tags.tagname, sum(Answers.Score) as Score

FROM Users
    JOIN Posts as Answers ON Answers.OwnerUserId = Users.Id
    JOIN Posts ON Posts.Id = Answers.ParentId
    JOIN PostTags ON PostTags.PostId = Posts.Id
    JOIN Tags ON Tags.Id = PostTags.TagId
WHERE
    Users.DisplayName IN (
    SELECT TOP 1000
    Users.DisplayName
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
    sum(Answers.Score) DESC
    )
Group By
    Users.DisplayName, Tags.tagname
ORDER BY 
    sum(Answers.Score) DESC;