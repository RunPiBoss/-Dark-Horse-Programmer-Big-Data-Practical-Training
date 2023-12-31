create database if not exists myhive6;
use myhive6;

-- todo 1 创建外部表 t_score_3(s_id, c_id, score), 指定分区名为 day,  指定分隔符为'\t', 指定保存在 /scoredatas 目录下
create external table tb_score_3(
    student_id int,
    course_id int,
    score int
)
partitioned by (day string)
row format delimited fields terminated by '\t'
location '/scoredatas'
;

-- todo 2 在hdfs系统 创建目录 /scoredatas/day=20210101
hdfs dfs -mkdir -p /scoredatas/day=20210101
hdfs dfs -mkdir -p /scoredatas/day=20210102

-- todo 3 在hdfs系统 向指定目录 /scoredatas/day=20210101 增加文件 f_score.csv
hdfs dfs -put /root/data/f_score.csv /scoredatas/day=20210101
hdfs dfs -put /root/data/f_score.csv /scoredatas/day=20210102

;
-- todo 4 建立目录和分区的关系, 增加分区
alter table tb_score_3 add partition(day='20210101');
alter table tb_score_3 add partition(day='20210102');

-- todo 5 删除表 观察数据是否存在
select * from tb_score_3;

show partitions tb_score_3;