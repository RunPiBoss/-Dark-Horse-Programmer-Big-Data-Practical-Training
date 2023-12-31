-- todo 1、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
use myhive8;

select
    student.s_id,
    student.s_name,
    avg(score.s_score) as avg_score
from student join score on student.s_id = score.s_id
group by student.s_id, student.s_name
having avg_score>=60
;

-- todo 2、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
select
    student.s_id,
    student.s_name,
    count(score.c_id) as `选课总数`,
    sum(coalesce(score.s_score, 0)) as `总成绩`
from student left join score on student.s_id=score.s_id
group by student.s_id, student.s_name
;


-- todo 3、查询"李"姓老师的数量
select
    count(1) as cnt
from teacher
where t_name like '李%'
;
-- todo 4、查询学过"张三"老师授课的同学的信息
select
    s2.s_id,
    s2.s_name
from teacher t
join course c on t.t_id = c.t_id
join score s on c.c_id = s.c_id
join student s2 on s.s_id = s2.s_id
where t.t_name = '张三'
;

-- todo 5、查询没学过"张三"老师授课的同学的信息
with t1 as (
    select
        s.s_id
    from teacher t
    join course c on t.t_id = c.t_id
    join score s on c.c_id = s.c_id
    where t.t_name = '张三'
)
select * from student
where s_id not in (select t1.s_id from t1)
;
set key=val;
select * from myhive8.student;
