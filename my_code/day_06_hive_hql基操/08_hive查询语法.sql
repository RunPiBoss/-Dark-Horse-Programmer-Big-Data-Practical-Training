-- 579. 查询员工的累计薪水
drop database if exists db_1;
create database db_1;
use db_1;

Create table If Not Exists Employee (id int, month int, salary int);
Truncate table Employee;
insert into Employee (id, month, salary) values ('1', '1', '20');
insert into Employee (id, month, salary) values ('2', '1', '20');
insert into Employee (id, month, salary) values ('1', '2', '30');
insert into Employee (id, month, salary) values ('2', '2', '30');
insert into Employee (id, month, salary) values ('3', '2', '40');
insert into Employee (id, month, salary) values ('1', '3', '40');
insert into Employee (id, month, salary) values ('3', '3', '60');
insert into Employee (id, month, salary) values ('1', '4', '60');
insert into Employee (id, month, salary) values ('3', '4', '70');
insert into Employee (id, month, salary) values ('1', '7', '90');
insert into Employee (id, month, salary) values ('1', '8', '90');

select * from Employee order by id, month desc;


select *
from Employee
where id not in ('1', '2');

select *
from Employee
where salary like '_0';

select *
from Employee
where salary rlike '[20]';