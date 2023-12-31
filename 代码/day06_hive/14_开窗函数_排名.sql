create database myhive10;

use myhive10;

-- 创建表
CREATE TABLE itcast_t2 (
    cookieid string,
    createtime string,   --day
    pv INT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

-- 加载数据：
load data local inpath '/root/data/i_cookies.txt' into table itcast_t2;

-- 测试：
select * from itcast_t2;

-- todo 排名: 根据 cookieid 分组, 再根据 pv 排名
with t1 as (
    select
        cookieid, createtime, pv,
        row_number() over (partition by cookieid order by pv desc) as rn,
        rank() over (partition by cookieid order by pv desc) as rn2,
        dense_rank() over (partition by cookieid order by pv desc) as rn3
    from itcast_t2
)
select * from t1
where rn3<=3
;


-- todo 排名: 平分成几份
-- todo  8 平分成2分, 1~4, 5~8
-- todo  8 平分成3分, 1~3, 4~6, 7~8
with t1 as (
    select
        cookieid, createtime, pv,
        ntile(3) over (partition by cookieid order by pv desc) as nt
    from itcast_t2
)
select * from t1
where nt=3
;