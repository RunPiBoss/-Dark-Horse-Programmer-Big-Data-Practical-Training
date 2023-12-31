create database if not exists myhive4;
use myhive4;

-- todo 1 创建教师外部表
create external table tb_teacher(
    id int,
    name string
)
row format delimited fields terminated by '\t'
;

-- todo 2 创建学生外部表
create external table tb_student(
    s_id int,
    s_name string,
    s_birthday date,
    sex string
)
row format delimited fields terminated by '\t';

select * from tb_student;

-- todo 3 从本地文件系统向表中加载数据 且 演示追加效果
load data local inpath '/root/data/a_teacher.txt' into table tb_teacher;
load data local inpath '/root/data/a_teacher.txt' into table tb_teacher;
load data local inpath '/root/data/a_teacher.txt' into table tb_teacher;

-- todo 4 从本地文件系统向表中加载数据 且 演示覆盖效果
load data local inpath '/root/data/a_teacher.txt' overwrite into table tb_teacher;

-- todo 5 从hdfs系统向表加载数据
-- todo 5.1 在hdfs系统中创建目录
hdfs dfs -mkdir -p /hivedata

-- todo 5.2 将数据文件上传到 hdfs目录中
hdfs dfs -put /root/data/a_student.txt /hivedata

-- todo 5.3 加载数据
load data inpath '/hivedata/a_student.txt' into table tb_student;

select * from tb_student;

drop table tb_student;