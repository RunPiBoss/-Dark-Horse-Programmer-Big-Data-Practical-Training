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
    # 1 对 作者的id和回答日期去重
    select
        author_id,
        answer_date,
        # 2 排名 根据作者分组 再根据回答的日期排序
        row_number() over (partition by author_id order by answer_date) as rn,
        # 3 求日期差 = 回答日期 - 排名
        date_sub(answer_date, interval (row_number() over (partition by author_id order by answer_date)) day) as dt2
    from answer_tb
    group by answer_date, author_id
)
, t2 as (
    # 4 求每个人连续登录的天数
    select
        author_id,
        dt2,
        count(*) as days
    from t1
    group by author_id, dt2
)
, t3 as (
    # 5 求每个人连续登录的最大天数
    select
        author_id,
        max(days) as max_days
    from t2
    group by author_id
    # 6 过滤 最大连续回答天数 >= 3
    having max_days>=3
)
select
    a.author_id,
    b.author_level,
    a.max_days as days_cnt
from t3 a join author_tb b on a.author_id=b.author_id
order by author_id
;

with t1 as (
    # 1 对 作者的id和回答日期去重
    select
        author_id,
        answer_date,
        # 2 排名 根据作者分组 再根据回答的日期排序
        row_number() over (partition by author_id order by answer_date) as rn,
        # 3 求日期差 = 回答日期 - 排名
        date_sub(answer_date, interval (row_number() over (partition by author_id order by answer_date)) day) as dt2
    from answer_tb
    group by answer_date, author_id
)
, t2 as (
    # 4 求每个人连续登录的天数
    select
        author_id,
        dt2,
        count(*) as days
    from t1
    group by author_id, dt2
)
# 5 求每个人连续登录的最大天数
select
    a.author_id,
    b.author_level,
    max(a.days) as days_cnt
from t2 a join author_tb b on a.author_id=b.author_id
group by a.author_id, b.author_level
# 6 过滤 大于等于 3天
having days_cnt>=3
;

# 1 去重
# 2 排名(等差数列1 公差是1)
#       等差数列2 连续登录的日期 公差是1天
# 3 求 两个等差数列的差值 (公差一样的等差数列, 相减的差是一样的, 如果一样就是连续登录的)
# 4 分组聚合 得到 每个人连续登录的天数
# 5 再分组聚合 得到 每个人连续登录的最大天数