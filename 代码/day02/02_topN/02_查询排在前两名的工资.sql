drop database if exists db_1;
create database db_1;
use db_1;

CREATE TABLE tb_employee (
    emp_id INT,
    emp_name VARCHAR(50),
    salary INT,
    department_id INT
);

INSERT INTO tb_employee (emp_id, emp_name, salary, department_id)
VALUES
    (1, '小明', 50000, 1),
    (2, '小红', 52000, 1),
    (3, '小李', 48000, 1),
    (4, '小张', 60000, 1),
    (5, '小王', 58000, 1),
    (6, '小刚', 62000, 1),
    (7, '小丽', 45000, 2),
    (8, '小芳', 47000, 2),
    (9, '小晓', 49000, 2),
    (10, '小华', 52000, 2),
    (11, '小雷', 52000, 2);

select * from tb_employee;

# todo “雇员表”中是公司雇员的信息，每个雇员有其对应的工号、姓名、工资和部门编号。
# todo 现在要查找每个部门工资排在前两名的雇员信息，若雇员工资一样，则并列获取。

with t1 as (
    # 1 每个部门 ==> 分组
    select
        emp_id, emp_name, salary, department_id,
        dense_rank() over (partition by department_id order by salary desc) as rn
    from tb_employee
)
select * from t1
where rn<=2
;
;