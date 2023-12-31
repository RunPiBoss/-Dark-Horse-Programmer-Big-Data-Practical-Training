drop database if exists db_1;
create database db_1;
use db_1;

Create table If Not Exists Logs (id int, num int);
Truncate table Logs;
insert into Logs (id, num) values ('1', '1');
insert into Logs (id, num) values ('2', '1');
insert into Logs (id, num) values ('3', '1');
insert into Logs (id, num) values ('4', '2');
insert into Logs (id, num) values ('5', '1');
insert into Logs (id, num) values ('6', '2');
insert into Logs (id, num) values ('7', '2');
insert into Logs (id, num) values ('8', '1');
insert into Logs (id, num) values ('9', '1');
insert into Logs (id, num) values ('10', '1');
insert into Logs (id, num) values ('11', '1');

select * from logs;

# todo 需求: 找出所有至少连续出现三次的数字。
# todo 返回的结果表中的数据可以按 任意顺序 排列。

with t1 as (
    # 1 向下取一个 向下取两个
    select
        id, num,
        lead(num, 1) over (order by id) lead_1,
        lead(num, 2) over (order by id) lead_2
    from logs
)
select
     num as ConsecutiveNums
from t1
where num=lead_1 and num=lead_2
group by num
;

-- lead和lag都是开窗函数，lead表示逐行向下取n行，lag表示向上取n行
with t1 as (
    # 1 向下取一个 向下取两个
    select
        id, num,
        lead(num, 1) over (order by id) lead_1,
        lead(num, 2) over (order by id) lead_2
    from logs
)
select
     distinct num as ConsecutiveNums
from t1
where num=lead_1 and num=lead_2
;


with t1 as (
    # 1 向下取一个 向下取两个
    select
        id, num,
        lead(num, 1) over (order by id) lead_1,
        lead(num, 2) over (order by id) lead_2,
        lead(num, 3) over (order by id) lead_3,
        lead(num, 4) over (order by id) lead_4,
        lead(num, 5) over (order by id) lead_5
        # ... ...
    from logs
)
select
     distinct num as ConsecutiveNums
from t1
where num=lead_1 and num=lead_2 and num=lead_3  and num=lead_4  and num=lead_5 # ... ...
;




