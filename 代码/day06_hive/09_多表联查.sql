create database myhive8;

use  myhive8;

create external table student
(
    s_id    string,
    s_name  string,
    s_birth string,
    s_sex   string
) row format delimited fields terminated by '\t';


create external table score
(
    s_id    string,
    c_id    string,
    s_score int
) row format delimited fields terminated by '\t';

create external table teacher
(
    t_id   string,
    t_name string
) row format delimited fields terminated by '\t';

create external table course
(
    c_id   string,
    c_name string,
    t_id   string
) row format delimited fields terminated by '\t';

load data local inpath '/root/data/f_course.csv' into table course;
load data local inpath '/root/data/f_score.csv' into table score;
load data local inpath '/root/data/f_student.csv' into table student;
load data local inpath '/root/data/f_teacher.csv' into table teacher;


-- 1 右外连接
学生表
id  name
101 张三
102 李四
105 王五

分数表
student_id  course_id
101         201
102         202
103         203

学生表(左表) 关联 分数表(右表)
右外连接: 右边能关联上的显示, 右边关联不上的也要显示
学生表         分数表
id  name        student_id  course_id
101 张三          101         201
102 李四          102         202
null null         103         203

-- 2 左外连接
学生表
id  name
101 张三
102 李四
105 王五

分数表
student_id  course_id
101         201
102         202
103         203

学生表(左表) 关联 分数表(右表)
左外连接: 左边能关联上的显示, 左边关联不上的也要显示
学生表         分数表
id  name        student_id  course_id
101 张三          101         201
102 李四          102         202
105 王五          null        null

-- 3 内连接
学生表
id  name
101 张三
102 李四
105 王五

分数表
student_id  course_id
101         201
102         202
103         203

学生表(左表) 关联 分数表(右表)
内连接: 能关联上显示
学生表         分数表
id  name        student_id  course_id
101 张三          101         201
102 李四          102         202

-- 4 全连接
学生表
id  name
101 张三
102 李四
105 王五

分数表
student_id  course_id
101         201
102         202
103         203

学生表(左表) 关联 分数表(右表)
全连接: 能关联上显示, 关联不上的 也要显示
学生表         分数表
id  name        student_id  course_id
101 张三          101         201
102 李四          102         202
null null        103         203
105 王五          null        null



-- 右外连接
select
    *
from student right join score on student.s_id = score.s_id
;


-- 左外连接
select
    *
from student left join score on student.s_id = score.s_id
;

-- 内连接
select
    *
from student join score on student.s_id = score.s_id
;

-- 全连接
select
    *
from student full join score on student.s_id = score.s_id
;


学生表
id  name
101 张三
102 李四
105 王五

分数表
student_id  course_id
101         201
102         202
103         203

drop table if exists tb_student;
create table tb_student(
    s_id int,
    s_name string
);

insert into tb_student
values
    (101, '张三'),
    (102, '李四'),
    (105, '王五');

create table tb_score(
    student_id int,
    course_id int
);

insert into tb_score
values
    (101, 201),
    (102, 202),
    (103, 203);

-- 内连接
select * from tb_student a inner join tb_score b on a.s_id=b.student_id;
-- 左连接
select * from tb_student a left join tb_score b on a.s_id=b.student_id;

-- 右连接
select * from tb_student a right join tb_score b on a.s_id=b.student_id;

-- 全连接
select * from tb_student a full join tb_score b on a.s_id=b.student_id;
