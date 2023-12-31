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

# todo 编写一个解决方案，在一个统一的表中计算出每个员工的 累计工资汇总 。
# todo
# todo 员工的 累计工资汇总 可以计算如下:
# todo     对于该员工工作的每个月，将 该月 和 前两个月 的工资 加 起来。这是他们当月的 3 个月总工资和 。如果员工在前几个月没有为公司工作，那么他们在前几个月的有效工资为 0 。
# todo     不要 在摘要中包括员工 最近一个月 的 3 个月总工资和。
# todo     不要 包括雇员 没有工作 的任何一个月的 3 个月总工资和。
# todo     返回按 id 升序排序 的结果表。如果 id 相等，请按 month 降序排序。


with t1 as (
    # 第一步: 求每个雇员 月份的排名
    select
        id, month, salary,
        row_number() over (partition by id order by month desc) as rn
    from Employee
)
select
    id,
    month,
    sum(salary) over(
                        partition by id
                        order by month
                        # rows between 2 preceding and current row  # 按行 间断
                        range between 2 preceding and current row  # 按行 连续

                    ) salary
from t1
where rn>1
order by id asc, month desc
;
