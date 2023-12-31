-- todo 1 创建库 myhive3, 切换到myhive3
create database if not exists myhive3;
use myhive3;

-- todo 2 创建teacher表包含id和name列
create table tb_teacher(
    id int,
    name string
)
;
-- todo 3 向teacher表插入数据
insert into tb_teacher values(1, '鬼谷子');
insert into tb_teacher values(2, '孔子');
insert into tb_teacher values(3, '孟子');

-- todo 4 查看teacher表内容
select * from tb_teacher;

-- todo 5 创建教师表teacher2, 包含id和name, 指定列分隔符为'\t', 指定文件存储格式为teaxfile, 指定文件存储位置为 /user/teacher2,
create table tb_teacher_2 (
    id int,
    name string
)
row format delimited fields terminated by '\t'
stored as textfile
location '/test/teacher2'
;


-- todo 6 根据查询结果 先创建新表teacher3, 再把数据导入到新表中
create table tb_teacher_3 as
select * from tb_teacher
;

select * from tb_teacher_3;

-- todo 7 根据查询结果 仅创建新表 teacher4, 不复制数据
create table tb_teacher_4 like tb_teacher;

select * from tb_teacher_4;

-- todo 8 查看表 teacher2 的简单信息
desc tb_teacher_2;

-- todo 9 查看表 teacher2 的详细信息
desc formatted tb_teacher_2;

-- todo 10 删除表 teacher4
drop table if exists tb_teacher_4;


drop table if exists tb_teacher_3;