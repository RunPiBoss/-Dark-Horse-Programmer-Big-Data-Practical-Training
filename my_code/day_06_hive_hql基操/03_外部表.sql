-- todo 1 创建教师外部表
drop table if exists teacher;
create external table teacher(t_id string, t_name string)
row format delimited
fields terminated by '\t'; //使用tab分割

-- todo 2 创建学生外部表
drop table if exists student;
create external table student(s_id string, s_name string, s_birth string, s_sex string)
row format delimited
fields terminated by '\t'; //使用tab分割

-- todo 3 从本地文件系统向表中加载数据 且 演示追加效果
load data local inpath '/root/data/a_student.txt' into table student;
-- todo 4 从本地文件系统向表中加载数据 且 演示覆盖效果
load data local inpath '/root/data/a_student.txt' overwrite into table student;

select *
from student;
-- todo 5 从hdfs系统向表加载数据
load data inpath '/hivedatas/a_teacher.txt' into table teacher;

select *
from teacher;
-- todo 5.1 在hdfs系统中创建目录
-- hdfs dfs -mkfir -p /hivedatas
-- todo 5.2 将数据文件上传到 hdfs目录中
-- hdfs dfs -put /root/data/a_student.txt /hivedatas
-- todo 5.3 加载数据
load data inpath '/hivedatas/a_techer.txt' into table teacher;