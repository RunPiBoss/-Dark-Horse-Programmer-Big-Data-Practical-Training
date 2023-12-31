-- todo 需求1: 创建myhive库 使用默认位置
create database myhive;
create database if not exists myhive;

-- todo 需求2: 创建myhive2库 指定在hdfs中的库位置
create database if not exists myhive2 location '/test/myhive2';

-- todo 需求3: 切换myhive库中
use myhive;

-- todo 需求4: 查看当前正在使用哪个库?
select current_database();

-- todo 需求5: 查看 myhive 和 myhive2库 的 结构
desc database myhive;

desc database  myhive2;

-- todo 需求6: 给myhive库中增加一张表
create table tb_student(
    id int,
    name string
);

desc formatted tb_student;

-- todo 需求6: 删除没有内容myhive2库
drop database myhive2;

-- todo 需求7: 删除有内容myhive库
drop database myhive cascade;