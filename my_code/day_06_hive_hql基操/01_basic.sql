-- todo 3.1.2.创建数据库并指定hdfs存储位置

-- todo
create database myhive1;
create database myhive2 location '/myhive2';
use myhive2;

-- 查看当前使用表
select current_database();

desc database myhive1;


create table test (
    id int,
    name string
);
show  tables;

select * from test;
insert into test values (1, "川哥");


drop database myhive2;
