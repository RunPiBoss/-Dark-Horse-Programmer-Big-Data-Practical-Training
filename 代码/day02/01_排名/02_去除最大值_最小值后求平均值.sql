drop database if exists db_1;
create database db_1;
use db_1;

CREATE TABLE tb_salary_table (
    employee_id INT,
    department_id INT,
    salary INT
);


INSERT INTO tb_salary_table (employee_id, department_id, salary)
VALUES
    (1, 1, 50000),
    (2, 1, 52000),
    (3, 1, 48000),
    (4, 1, 51000),
    (5, 1, 49000),
    (6, 2, 60000),
    (7, 2, 58000),
    (8, 2, 62000),
    (9, 2, 59000),
    (10, 2, 61000);

select * from tb_salary_table;

# todo 题目要求: “薪水表”中记录了雇员编号、部门编号和薪水。要求查询出每个部门去除最高、最低薪水后的平均薪水。
# 1 每个部门 --> 分组 --> 1 group by 2 partition by
select
    employee_id, department_id, salary,
    row_number() over (partition by department_id order by salary asc) rn1
from tb_salary_table
;
# 将第一步的结果 包一下
# 方案一 子查询
select *
from (select
            employee_id, department_id, salary,
            row_number() over (partition by department_id order by salary asc) rn1
      from tb_salary_table) t1
;

# 方案二
with t1 as (
    select
        employee_id, department_id, salary,
        row_number() over (partition by department_id order by salary asc) rn1
    from tb_salary_table
)
select * from t1
;
# 2 去掉薪水最低的
with t1 as (
    select
        employee_id, department_id, salary,
        row_number() over (partition by department_id order by salary asc) rn1,
        row_number() over (partition by department_id order by salary desc) rn2
    from tb_salary_table
)
select
    department_id,
    # 四舍五入保留2为小数 round(数字, 保留的位数)
    # round(avg(salary), 1) as 平均薪水
    # 四舍五入保留整数 round(数字)
    round(avg(salary)) as 平均薪水
from t1
where rn1>1 and rn2>1
# 求每个部门的平均薪水
group by department_id
;

;