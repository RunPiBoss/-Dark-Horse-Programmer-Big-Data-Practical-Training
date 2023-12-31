-- todo 需求1: 查询学生的成绩，并按照分数降序排列
select
    *
from myhive8.score
order by s_score desc;

select
    *
from myhive8.score
order by s_score desc
limit 10
;


-- todo 需求2: 按照每个学生的平均成绩排序
select
    s_id,
    cast(avg(s_score) as decimal(32, 2)) as avg_score
from myhive8.score
group by s_id
order by avg_score
;

-- todo 需求3: 按照学生id和平均成绩进行排序
select
    s_id,
    cast(avg(s_score) as decimal(32, 2)) as avg_score
from myhive8.score
group by s_id
order by s_id, avg_score
;