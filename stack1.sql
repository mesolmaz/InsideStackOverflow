-- Top 20 StackOverflow tags in since 2015-01-01, having at least 10000 posts
-- https://data.stackexchange.com/stackoverflow/query/new
select top 20
       num.TagName as Tag,
       row_number() over (order by rate.Rate desc) as RankLast5Years,
       row_number() over (order by num.Num desc) as TotalRank,
       rate.Rate as QuestionsSince2015,
       num.Num as QuestionsTotal

from

(select count(PostId) as Rate, TagName
from
  Tags, PostTags, Posts
where Tags.Id = PostTags.TagId and Posts.Id = PostId
and Posts.CreationDate > '2015-01-01'
group by TagName) as rate

INNER JOIN

(select count(PostId) as Num, TagName
from
  Tags, PostTags, Posts
where Tags.Id = PostTags.TagId and Posts.Id = PostId
group by TagName
having count(PostId) > 10000)
as num ON rate.TagName = num.TagName
order by rate.rate desc;
