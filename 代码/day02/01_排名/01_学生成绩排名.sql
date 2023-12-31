drop database if exists db_1;
create database db_1;
use db_1;

CREATE TABLE tb_score (
    student_name VARCHAR(50),
    course_name VARCHAR(50),
    score INT
);

INSERT INTO tb_score (student_name, course_name, score)
VALUES
    ('小明', '数学', 85),
    ('小明', '英语', 78),
    ('小明', '物理', 92),
    ('小红', '数学', 90),
    ('小红', '英语', 80),
    ('小李', '数学', 90),
    ('小李', '数学', 60),
    ('小李', '英语', 85),
    ('小李', '物理', 85)
;

select * from tb_score;

# todo 题目要求: 现有“成绩表”，需要我们取得每名学生不同课程的成绩排名.
-- 1 每名学生 --> 分组 --> 1 group by 2 开窗排名分组 partition by
select
    student_name, course_name, score,
    -- 2 成绩排名
    row_number() over (partition by student_name order by score desc) rn, # row_number 排名函数, 不会考虑并列问题
    rank() over (partition by student_name order by score desc) rk, # rank 排名函数 会考虑并列问题, 排名不是连续的
    dense_rank() over (partition by student_name order by score desc) d_rk # dense_rank 排名函数, 会考虑并列问题, 排名是连续的
from tb_score
;


select
    student_name, course_name, score
from tb_score
group by student_name
order by score


SELECT
    student_name, course_name, MAX(score) AS max_score
FROM tb_score
GROUP BY student_name
ORDER BY max_score desc;


梅西 大罗  小罗 内马尔       51  1    1
C罗 哈兰德 姆巴佩          50球  4    2

