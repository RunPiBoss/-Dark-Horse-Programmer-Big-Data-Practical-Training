-- 需求1: 将查询结果 导出本地, 使用默认格式
insert overwrite local directory '/root/export_test/score_1'
select * from myhive7.t_score_1;

-- 需求2: 将查询结果 导出本地, 指定分隔符为 '\t', 且制定 集合分隔符为 '#'
insert overwrite local directory '/root/export_test/score_2'
row format delimited fields terminated by '\t'
select * from myhive7.t_score_1;

-- 需求3: 将查询结果 导出到 hdfs,
insert overwrite directory '/root/export_test/score_3'
row format delimited fields terminated by '\t'
select * from myhive7.t_score_1;

-- 需求4: 使用 hive shell命令 导出到文件中
hive -e "select * from myhive7.t_score_1;" > /root/export_test/score_4

;
-- 需求5: 使用 export导出到 hdfs中
export table myhive7.t_score_1 to '/export/_test/score_5'