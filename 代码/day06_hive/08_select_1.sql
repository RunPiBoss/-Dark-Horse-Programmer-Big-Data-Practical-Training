-- limit
select
    *
from myhive4.tb_student
-- limit 0, 3 -- 第一页
-- limit 3, 3 -- 第二页
limit 6, 3 -- 第三页
-- limit 开始的下标, 长度
;

-- todo 1 查询分数等于80的所有的数据
select
    *
from myhive7.t_score_1
where score=80
;

-- todo 2 查询分数在80到100的所有数据
select
    *
from myhive7.t_score_1
-- where score>=80 and score<=100
where score between 80 and 100
;
-- todo 3 查询成绩为空的所有数据
select
    *
from t_score_1
where score is null
;

-- todo 4 查询成绩是80或90的数据
select
    *
from t_score_1
-- where score=80 or score=90
where score in (80, 90)
;

-- 需求1: 查找以8开头的所有成绩
select
    *
from t_score_1
where score like '8%'
;
-- 需求2: 查找第二个数值为9的所有成绩数据
select
    *
from t_score_1
where score like '_9%'
;

-- 需求3: 查找学生编号 s_id 中含3或6的, 显示所有
select
    *
from t_score_1
where s_id rlike '[36]'
;

-- todo 需求1: 查询成绩大于80，并且s_id是01的数据
select * from t_score_1
where score>80 and s_id='01';
-- todo 需求2: 查询成绩大于80，或者s_id  是01的数
select * from t_score_1
where score>80 or s_id='01'

-- todo 需求3: 查询s_id  不是 01和02的学生
select
    *
from t_score_1
where s_id not in ('01', '02');


-- todo 需求1: 计算每个学生的平均分数
select
    s_id,
    avg(score) as avg_score_1,
    round(avg(score), 2) as avg_score_2,
    cast(avg(score) as decimal(20, 2)) as avg_score_3
from t_score_1
group by s_id
;


-- todo 需求2: 计算每个学生最高成绩
select
    s_id,
    max(score) as max_score
from t_score_1
group by s_id
;


-- 需求1: 求每个学生的平均分数
select
    s_id,
    avg(score) as avg_score_1,
    round(avg(score), 2) as avg_score_2,
    cast(avg(score) as decimal(20, 2)) as avg_score_3
from t_score_1
group by s_id
;

-- 需求2: 求每个学生平均分数大于85的人
select
    s_id,
    avg(score) as avg_score_1,
    round(avg(score), 2) as avg_score_2,
    cast(avg(score) as decimal(20, 2)) as avg_score_3
from t_score_1
group by s_id
having avg_score_1>85
;












