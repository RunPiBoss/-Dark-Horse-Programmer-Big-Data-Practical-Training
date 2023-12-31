drop database if exists db_1;
create database db_1;
use db_1;

-- 创建员工表，列名包含注释
CREATE TABLE tb_employee (
    employeeID INT COMMENT '雇员编号',
    departmentID INT COMMENT '部门编号',
    salary INT COMMENT '薪水'
);

-- 插入数据
INSERT INTO tb_employee (employeeID, departmentID, salary) VALUES
(10001, 1, 60117),
(10002, 2, 92102),
(10003, 2, 86074),
(10004, 1, 66596),
(10005, 1, 66961),
(10006, 2, 81046),
(10007, 2, 94333),
(10008, 1, 75286),
(10009, 2, 85994),
(10010, 1, 76884);

select * from tb_employee;

# todo 需求: 现在公司要找出每个部门低于平均薪水的雇员，然后进行培训来提高雇员工作效率，从而提高雇员薪水。
# 1 求每个部门的平均薪水
with t1 as (
    select
        employeeID, departmentID, salary,
        avg(salary) over(partition by departmentID) as avg_salary
    from tb_employee
)
select
    employeeID 雇员编号,
    departmentID 部门编号,
    salary 薪资
from t1
# 2 判断 个人薪资 小于 每个部门的平均薪水
where salary < avg_salary
;




