

-- todo 需求1: 创建新库 myhive6, 切换库 myhive6
-- 创建 db_myhive_5
create database myhive7;

use myhive7;

-- todo 需求2: 创建 t_score_1(s_id, c_id, score) 按月指定分区 month, 指定字段分隔符为 '\t'
-- 创建表
create table t_score_1(
    s_id string,
    c_id string,
    score int
)
partitioned by (month string)
row format delimited fields terminated by '\t';

-- todo 需求3: 通过 load data 方式加载文件中数据
load data local inpath '/root/data/f_score.csv' into table t_score_1 partition(month='202312');
select * from t_score_1;

-- todo 需求4: 创建表  t_score_2 依据 表 t_score_1 的结构
create table t_score_2 like t_score_1;
select * from t_score_2;

-- todo 需求5: 通过insert into 添加一行数据
insert into t_score_2 partition(month='202401') values('101', '201', 30);
insert into t_score_2 partition(month='202401') values('102', '202', 40);

-- todo 需求6: 创建表  t_score_3 依据 表 t_score_1的结构
create table t_score_3 like t_score_1;

-- todo 需求7: 通过 select 添加n条记录
insert into t_score_3 partition(month='202402') -- 静态加载
select s_id, c_id, score from t_score_1;

set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table t_score_3 partition(month) -- 动态加载
select s_id, c_id, score, month from t_score_1;


-- todo 1 创建表 t_score_6(s_id, c_id, score), 指定分隔符为'\t', 指定保存位置为 '/hivedatas/t_score_6';
create table t_score_6(
    s_id string,
    c_id string,
    score int
)
row format delimited fields terminated by '\t'
location '/hivedatas/t_score_6'
;

select * from t_score_6;

-- todo 2 将分数信息文件 上传到 hdfs的目录下  '/hivedatas/t_score_6'
hdfs dfs -put /root/data/f_score.csv  /hivedatas/t_score_6

-- todo 3 查看表中的数据
select * from t_score_6;



-- todo 1 创建非分区教师表
drop table if exists tb_teacher;

create table tb_teacher(
    s_id string,
    c_id string,
    score int
)
row format delimited fields terminated by '\t'
;
-- todo 2 加载数据
load data local inpath '/root/data/f_score.csv' into table tb_teacher;

select * from tb_teacher;

-- todo 3 创建教师表2
create table tb_teacher_2 (
    s_id string,
    c_id string,
    score int
)
row format delimited fields terminated by '\t'
;
-- todo 4 导出数据
export table tb_teacher to '/export/teacher';
select * from tb_teacher;

-- todo 5 导入数据
import table tb_teacher_2 from '/export/teacher'

-- todo 6 测试
select * from myhive7.tb_teacher_2;
