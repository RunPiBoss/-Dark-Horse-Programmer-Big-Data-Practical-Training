drop database if exists db_1;
create database db_1;
use db_1;

create table if not exists user_login(
    id int,
    dt varchar(32)
);

insert into user_login
values
    (1001, '2021-12-12'),
    (1002, '2021-12-12'),
    (1001, '2021-12-13'),
    (1001, '2021-12-14'),
    (1001, '2021-12-16'),
    (1002, '2021-12-16'),
    (1001, '2021-12-19'),
    (1002, '2021-12-17'),
    (1001, '2021-12-20')
;

select * from user_login;

with t1 as (
    select id,dt,
           # 上一条记录的日期
       lag(dt, 1, '1970-01-01') over (partition by id order by dt) lage_1,
        # 日期差 = 当前行日期 - 上一行日期
        datediff(dt, lag(dt, 1, '1970-01-01') over (partition by id order by dt)) lag_t1,
        # 判断
        if((datediff(dt, lag(dt, 1, '1970-01-01') over (partition by id order by dt)))>2, 1, 0) as diff_dt_if
    from user_login
# 去重
group by id,dt
)
, t2 as (select id,
                dt,
                lage_1,
                lag_t1,
                diff_dt_if,
                sum(diff_dt_if) over (partition by id order by dt) as sum_2

         from t1
         ),
   t3 as (
       select
    id,
    sum_2,
    min(dt) as start_dt,
    max(dt) as end_dit,
    datediff(max(dt), min(dt)) + 1 as days
from t2
group by id, sum_2
   )
select
    id,
    max(days) as max_days
from t3
group by id