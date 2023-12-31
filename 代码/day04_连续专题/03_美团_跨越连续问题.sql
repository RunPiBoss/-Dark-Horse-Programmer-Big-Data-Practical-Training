-- todo 1 准备工作
drop database if exists db_1;

create database db_1;

use db_1;

create table tb_user_login(
    user_id varchar(32),
    login_date varchar(32)
)
;

insert into db_1.tb_user_login
values
('1', '2023-01-03'),
('1', '2023-01-04'),
('1', '2023-01-05'),
('1', '2023-01-08'),
('1', '2023-01-09'),
('1', '2023-02-16'),
('1', '2023-02-17'),
('1', '2023-02-27'),
('2', '2023-01-10'),
('2', '2023-01-11'),
('2', '2023-03-08'),
('2', '2023-03-09'),
('3', '2023-02-08'),
('3', '2023-02-09'),
('3', '2023-02-10'),
('3', '2023-02-15'),
('3', '2023-03-09'),
('3', '2023-03-19')
;

select * from db_1.tb_user_login;


# todo 【问题】查询2023年每个⽉，连续2天都有登陆的⽤⼾名单。
with t1 as (
    select
        user_id,
        login_date
    from tb_user_login
    where login_date between '2023-01-01' and '2023-12-31'
    group by user_id, login_date
)
, t2 as (
    select
        user_id,
        date_format(login_date, '%Y-%m') y_m,
        login_date,
        row_number() over (partition by user_id, date_format(login_date, '%Y-%m') order by login_date)  as rn,
        date_sub(login_date, interval (row_number() over (partition by user_id, date_format(login_date, '%Y-%m') order by login_date)) day) as diff_dt
    from t1
)
select
    distinct y_m y_month, user_id
from t2
group by user_id, y_m, diff_dt
having count(*)>=2
;

