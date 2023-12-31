drop database if exists myhive9 cascade;
create database myhive9;
use myhive9;

create table emp(
    deptno int,
    ename string
)
row format delimited fields terminated by ' ';

load data local inpath '/root/data/g_collect_set.csv' into table emp;

select * from emp;


select
    collect_list(concat_ws('-->', cast(deptno as string), ename))
from emp
;


select
    deptno,
    collect_list(concat_ws('-->', cast(deptno as string), ename))
from emp
group by deptno
;


create table emp2(
    deptno int,
    names array<string>
)
row format delimited fields terminated by ' '
collection items terminated by '|';

load data local inpath '/root/data/h_explode.txt' into table emp2;

select * from emp2;


select
    explode(names) as name
from emp2;


select
    deptno,
    name
from emp2 lateral view explode(names) tb_temp as name
;

