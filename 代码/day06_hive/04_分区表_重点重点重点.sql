create database if not exists myhive5;
use myhive5;

-- todo 1 创建只有一个分区的表 t_score_1(s_id, c_id, score), 指定分区为 month(目录), 指定字段之间的分隔符为 '\t'
create table t_score_1(
    student_id int,
    course_id int,
    score int
)
partitioned by (month string)
row format delimited fields terminated by '\t'
;


-- todo 2  创建只有一个分区的表 t_score_2(s_id, c_id, score), 指定分区为 year,month,day(多级目录), 指定字段之间的分隔符为 '\t'
create table t_score_2(
    student_id int,
    course_id int,
    score int
)
partitioned by (year string, month string, day string)
row format delimited fields terminated by '\t'
;

-- todo 3 加载数据到分区表中 /export/data/hive_data/f_score.csv
load data local inpath '/root/data/f_score.csv' into table t_score_1 partition(month='202312');

load data local inpath '/root/data/f_score.csv' into table t_score_2 partition(year='2023', month='12', day='01');

-- todo 4 查看分区
show partitions t_score_1;


show partitions t_score_2;

-- todo 5 添加一个分区
alter table t_score_1 add partition(month='202401');

-- todo 6 添加多个分区
alter table t_score_1 add partition(month='202404')  partition(month='202402')  partition(month='202403') ;

-- todo 7 删除分区
alter table t_score_1 drop if exists partition(month='202404');

show partitions t_score_1;
