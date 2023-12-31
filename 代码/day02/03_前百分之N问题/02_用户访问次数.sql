drop database if exists db_1;
create database db_1;
use db_1;

CREATE TABLE user_access_table (
    user_id INT,
    user_type VARCHAR(50),
    access_count INT
);

INSERT INTO user_access_table (user_id, user_type, access_count)
VALUES
    (1, '普通用户', 50),
    (2, '管理员', 120),
    (3, 'VIP用户', 80),
    (4, '普通用户', 60),
    (5, '管理员', 150),
    (6, 'VIP用户', 100),
    (7, '普通用户', 70),
    (8, '管理员', 130),
    (9, 'VIP用户', 90),
    (10, '普通用户', 40);

select * from user_access_table;

# todo “用户访问次数表”含有 用户编号、用户类型、访问次数。
# todo 要求在剔除访问次数前20%的用户后得到每类用户的平均访问次数。
# todo 方案一
with t1 as (
    select
        user_id, user_type, access_count,
        percent_rank() over (order by access_count desc) as p_rk
    from user_access_table
)
, t2 as (
    select * from t1
    where p_rk>0.2
)
select
    user_type,
    round(avg(access_count)) as avg_count
from t2
group by user_type
;

with t1 as (
    select
        user_id, user_type, access_count,
        percent_rank() over (order by access_count desc) as p_rk
    from user_access_table
)
select
    user_type,
    round(avg(access_count)) as avg_count
from t1
where p_rk>0.2
group by user_type
;


# todo 方案二
with t1 as (
    select
        user_id, user_type, access_count,
        count(*) over() as rs,
        rank() over (order by access_count desc) rk,
        (rank() over (order by access_count desc) - 1) / (count(*) over() - 1) per_rk
    from user_access_table
)
select
    user_type,
    round(avg(access_count)) as avg_count
from t1
where per_rk>0.2
group by user_type
;



