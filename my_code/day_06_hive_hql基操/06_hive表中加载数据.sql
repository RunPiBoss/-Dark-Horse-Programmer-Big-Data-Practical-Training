-- 创建 db_myhive_5
create database db_myhive_5;

use db_myhive_5;

-- 创建表
create table tb_score(
    s_id string,
    c_id string,
    score int
)
partitioned by (month string)
row format delimited fields terminated by '\t';

-- todo 方式一: 通过load方式加载数据
load data local inpath '/root/data/f_score.csv' overwrite into table tb_score partition (month='202026');
select *
from tb_score;

-- todo 方式二: 直接向分区表中插入数据
-- todo 通过insert into方式加载数据
create table score3 like tb_score;

insert into table score3 partition (month='202007')values ('001','002','100');

-- todo 通过查询方式加载数据
create table score4 like tb_score;
insert overwrite table score4 partition (month = '202006') select s_id,c_id,score from tb_score;
select *
from score4;


-- todo 方式三： 查询语句中创建表并加载数据（as select）
create table score5 as select * from tb_score
select *
from score5;

-- todo 方式四：创建表时通过location指定加载数据路径
