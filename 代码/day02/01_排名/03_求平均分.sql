drop database if exists db_1;
create database db_1;
use db_1;

CREATE TABLE tb_score (
    student_id INT,
    score INT
);

INSERT INTO tb_score (student_id, score)
VALUES
    (1, 85),
    (2, 78),
    (3, 92),
    (4, 90),
    (5, 80),
    (6, 88);

select * from tb_score;

# todo 题目要求: “成绩表”记录了学号和成绩，计算该6名同学的成绩中去除最高分、最低分后的平均分数。
with t1 as (
    select
        student_id, score,
        # row_number() over (partition by null order by score) as rn1
        row_number() over (order by score) as rn1,
        row_number() over (order by score desc) as rn2
    from tb_score
)
select
    round(avg(score), 2) as avg_score
from t1
where rn1>1 and rn2>1
;


