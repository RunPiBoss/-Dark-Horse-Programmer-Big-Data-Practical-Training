drop database if exists db_1;
create database db_1;
use db_1;

drop table if exists author_tb;
CREATE TABLE author_tb
(
    author_id    int(10) NOT NULL,
    author_level int(10) NOT NULL,
    sex          char(10) NOT NULL
);
INSERT INTO author_tb
VALUES
    (101, 6, 'm'),
    (102, 1, 'f'),
    (103, 1, 'm'),
    (104, 3, 'm'),
    (105, 4, 'f'),
    (106, 2, 'f'),
    (107, 2, 'm'),
    (108, 5, 'f'),
    (109, 6, 'f'),
    (110, 5, 'm');

drop table if exists answer_tb;
CREATE TABLE answer_tb
(
    answer_date date     NOT NULL,
    author_id   int(10) NOT NULL,
    issue_id    char(10) NOT NULL,
    char_len    int(10) NOT NULL
);

INSERT INTO answer_tb
VALUES
    ('2021-11-1', 101, 'E001', 150),
    ('2021-11-1', 101, 'E002', 200),
    ('2021-11-1', 102, 'C003', 50),
    ('2021-11-1', 103, 'P001', 35),
    ('2021-11-1', 104, 'C003', 120),
    ('2021-11-1', 105, 'P001', 125),
    ('2021-11-1', 102, 'P002', 105),
    ('2021-11-2', 101, 'P001', 201),
    ('2021-11-2', 110, 'C002', 200),
    ('2021-11-2', 110, 'C001', 225),
    ('2021-11-2', 110, 'C002', 220),
    ('2021-11-3', 101, 'C002', 180),
    ('2021-11-4', 109, 'E003', 130),
    ('2021-11-4', 109, 'E001', 123),
    ('2021-11-5', 108, 'C001', 160),
    ('2021-11-5', 108, 'C002', 120),
    ('2021-11-5', 110, 'P001', 180),
    ('2021-11-5', 106, 'P002', 45),
    ('2021-11-5', 107, 'E003', 56);

select * from author_tb;

select * from answer_tb;

with t1 as (
    # 使用group去重
select
    author_id,
    # 等差数列1
    answer_date,
    # 等差数列2：排名 根据 作者id分组，再根据日期排序
    row_number() over (partition by author_id order by answer_date) as rn,
    # 差 = 等差数列1 -  等差数列2
    date_sub(answer_date, interval (row_number() over (partition by author_id order by answer_date)) day ) as rn2
from answer_tb
group by author_id, answer_date
)
,t2 as(
    select author_id,rn2,
       count(*) as days
from t1
# 求每个人连续登录的天数 每个 --> 分组
group by author_id, rn2
# 连续回答的天数>=3
having days>= 3
)
, t3 as (
    select
    author_id,
    max(days) as days_cnt
from t2
# 一个人可能存在多次连续回答天数，求每个人连续回答的最大天数
group by author_id
)
select
    a.author_id,
    b.author_level,
    a.days_cnt
from t3 a join author_tb b on a.author_id = b.author_id
;


# 碰到连续模板
# 1 是否去重
# 2 等差数列2 在哪？
# 3 等差数列2 在哪？
# 4 差 = 等差数列1 - 等差数列2
# 5 如果等差数列是连续的，差是相同的；反过来 如果差是相同的，前面的数据肯定是连续的