drop database if exists db_1;
create database db_1;
use db_1;


-- 创建成绩表
CREATE TABLE tb_score (
    student_name VARCHAR(20),
    course_name VARCHAR(20),
    score INT
);

-- 插入数据
INSERT INTO tb_score (student_name, course_name, score) VALUES
('张三', '语文', 90),
('李四', '语文', 81),
('王朝', '语文', 79),
('马汉', '语文', 88),
('张三', '数学', 85),
('李四', '数学', 86),
('王朝', '数学', 92),
('马汉', '数学', 83),
('张三', '英语', 87),
('李四', '英语', 98),
('王朝', '英语', 93),
('马汉', '英语', 95);

select * from tb_score;

# todo 1 求每个科目的平均成绩
select
    student_name, course_name, score,
    avg(score) over(partition by course_name order by score) as avg_score # 增加排序之后, 默认的范围 第一行到当前行
from tb_score
;


# todo “成绩表”，记录了每个学生各科的成绩。现在要查找单科成绩高于该科目平均成绩的学生名单。
with t1 as (
    # todo 1 求每个科目的平均成绩
    select
        student_name, course_name, score,
        avg(score) over(partition by course_name) as avg_score
    from tb_score
)
select
    course_name 科目,
    student_name 姓名
from t1
# 过滤 查找单科成绩高于该科目平均成绩的学生名单
where score > avg_score