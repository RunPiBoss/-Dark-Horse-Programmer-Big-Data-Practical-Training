drop database if exists db_1;
create database db_1;
use db_1;

CREATE TABLE tb_score (
    course_id INT,
    student_id INT,
    score int
);

INSERT INTO tb_score (course_id, student_id, score)
VALUES
    (1, 1, 85),
    (1, 2, 78),
    (1, 3, 92),
    (1, 4, 90),
    (1, 5, 80),
    (1, 6, 92),
    (1, 7, 78),
    (1, 8, 92),
    (1, 9, 85),
    (2, 1, 88),
    (2, 2, 82),
    (2, 3, 90),
    (2, 4, 85),
    (2, 5, 78),
    (2, 6, 88),
    (2, 7, 82),
    (2, 8, 90),
    (2, 9, 82);

select * from tb_score;

# todo 题目要求: “成绩表”中记录了学生选修的课程号、学生的学号，以及对应课程的成绩。为了对学生成绩进行考核，现需要查询每门课程前三名学生的成绩。
# todo 注意：如果出现同样的成绩，则视为同一个名次。

# 1 查询每门课程前三名学生的成绩。
# 每门课程 --> 分组
with t1 as (
    select
        course_id, student_id, score,
        dense_rank() over (partition by course_id order by score desc) as rn
    from tb_score
)
select
    course_id, student_id, score, rn
from t1
where rn<=3
;

