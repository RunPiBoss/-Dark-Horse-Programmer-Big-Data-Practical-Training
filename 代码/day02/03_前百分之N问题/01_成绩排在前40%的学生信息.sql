drop database if exists db_1;
create database db_1;
use db_1;

CREATE TABLE tb_grade (
    student_id INT,
    class_id INT,
    score int
);

INSERT INTO tb_grade (student_id, class_id, score)
VALUES
    (1, 1, 85),
    (2, 1, 78),
    (3, 1, 92),
    (4, 1, 90),
    (5, 1, 80),
    (6, 2, 88),
    (7, 2, 82),
    (8, 2, 90),
    (9, 2, 90);

select * from tb_grade;

# todo 题目要求: “成绩表”记录了学号、班级和成绩，现在查询每个班级成绩排在前40%的学生信息。
# todo 方案一
with t1 as (
    select
        student_id, class_id, score,
        percent_rank() over (partition by class_id order by score desc) as p_rn
    from tb_grade
)
select *
from t1
where p_rn<=0.4
;

# todo 方案二
with t1 as (
    select
        student_id, class_id, score,
        count(student_id) over(partition by class_id) rs,
        rank() over(partition by class_id order by score desc) as rk
    from tb_grade
)
select
    student_id, class_id, score
    # rs, rk,
    # (rk - 1) / (rs - 1) as aaa
from t1
where (rk - 1) / (rs - 1)<=0.4
;
;

