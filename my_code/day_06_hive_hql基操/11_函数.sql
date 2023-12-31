--- 字符串截取
select '2023-02-20 10:20:30' dt;

with t1 as (
    select '2023-02-20 10:20:30' dt
    union
    select '2023-05-21 01:20:30' dt
)
select
    *,
    month(dt) as m,
    substr(dt, 1, 4) y,
    substr(dt, 2, 3) test,
    substr(dt, 6, 2) m2,
    substr(dt, 9, 2) d,
    substr(dt, 12, 2) h
from t1;

select
    '   abc bbb    ',
    length('   abc bbb   '),
    length(trim('   abc  bbb '))
;

--  获取链接的路径
select parse_url('http://facebook.com/path1/p.php?k1=v1&k2=v2#Ref1', 'HOST');
select parse_url('http://facebook.com/path1/p.php?k1=v1&k2=v2#Ref1', 'PATH');
select parse_url('http://facebook.com/path1/p.php?k1=v1&k2=v2#Ref1', 'QUERY', 'k1');

select
    split('张三,李四,王五,赵六', ',')
;

select
    explode(split('张三,李四,王五,赵六', ','))
;

-- 将时间戳转化为日期
select
    from_unixtime(1703038830),
    from_unixtime(1703038830, 'yyyy/MM/dd')
;

-- 将日期转化为时间戳
select
    '2023-12-20 10:20:30' dt1,
    unix_timestamp() dt2,
    unix_timestamp('2023-12-20 10:20:30') dt2
;

-- 增加日期
select date_add('2023-12-20', -1);
select date_add('2023-12-20', 1);