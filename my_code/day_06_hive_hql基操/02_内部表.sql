-- todo 3.2.3.1.hive建表初体验

create database myhive;

use myhive;

create table stu(id int, name string);

insert into stu values (1, "鬼谷子");

select *
from stu;


-- todo 3.2.3.2.创建表并指定字段之间的分隔符

create table if not exists stu2(id int, name string)

row format delimited

fields terminated by '\t'

stored as textfile

location '/user/stu2';

-- todo 3.2.3.3.根据查询结果创建表
create table stu3 as select * from stu2;

insert into stu2 values (1, '李四');
select *
from stu3;

create table  stu4 like stu2;

select *
from stu4;

desc formatted stu2;

desc stu2;

drop table stu3;