--todo 需求1: 将查询结果 导出本地, 使用默认格式
insert overwrite local directory '/export/data/hive_data/exporthive'
select * from score5;

--todo 需求2: 将查询结果 导出本地, 指定分隔符为 '\t', 且制定 集合分隔符为 '#'
insert overwrite local directory '/export/data/hive_data/exporthive'
row format delimited
fields terminated by '\t'
collection items terminated by '#'
select *
from score5;
--todo 需求3: 将查询结果 导出到 hdfs,
insert overwrite directory '/export/data/hive_data/exporthive'
row format delimited
fields terminated by '\t'
select * from score5;
--todo 需求4: 使用 hive shell命令 导出到文件中
bin/hive -e "selec * from myhive.soore5;" > /export/data/hive_data/exporthive/score.txt
--todo 需求5: 使用 export导出到 hdfs中
export table score5 to '/export/exporthive/score';