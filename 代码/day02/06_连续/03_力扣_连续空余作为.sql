drop database if exists db_1;
create database db_1;
use db_1;


Create table If Not Exists Cinema (seat_id int primary key auto_increment, free bool);
Truncate table Cinema;
insert into Cinema (seat_id, free) values ('1', '1');
insert into Cinema (seat_id, free) values ('2', '0');
insert into Cinema (seat_id, free) values ('3', '1');
insert into Cinema (seat_id, free) values ('4', '1');
insert into Cinema (seat_id, free) values ('5', '1');

select * from cinema;

# todo 查找电影院所有连续可用的座位。
# todo 返回按 seat_id 升序排序 的结果表。
# todo 测试用例的生成使得两个以上的座位连续可用。

with t1 as (
    select
        seat_id, free,
        lead(seat_id, 1) over (order by seat_id) as lead_1,
        lag(seat_id, 1) over (order by seat_id) as lag_1
    from cinema
    where free=1
)
select
    seat_id
from t1
where seat_id+1=lead_1 or seat_id-1=lag_1
;
;
