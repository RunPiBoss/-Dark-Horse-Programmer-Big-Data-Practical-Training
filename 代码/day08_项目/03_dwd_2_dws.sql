drop database if exists itcast_dws cascade;
CREATE DATABASE IF NOT EXISTS itcast_dws;

--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;

-- 访问量DWS层表:
CREATE TABLE IF NOT EXISTS itcast_dws.visit_dws (
  sid_total INT COMMENT '根据sid去重求count',
  sessionid_total INT COMMENT '根据sessionid去重求count',
  ip_total INT COMMENT '根据IP去重求count',
  area STRING COMMENT '区域信息',
  seo_source STRING COMMENT '搜索来源',
  origin_channel STRING COMMENT '来源渠道',
  hourinfo STRING COMMENT '创建时间，统计至小时',
  time_str STRING COMMENT '时间明细',
  from_url STRING comment '会话来源页面',
  groupType STRING COMMENT '产品属性类型：1.地区；2.搜索来源；3.来源渠道；4.会话来源页面；5.总访问量',
  time_type STRING COMMENT '时间聚合类型：1、按小时聚合；2、按天聚合；3、按月聚合；4、按季度聚合；5、按年聚合；')
comment 'EMS访客日志dws表'
PARTITIONED BY(yearinfo STRING,quarterinfo STRING,monthinfo STRING,dayinfo STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
stored as orc
TBLPROPERTIES ('orc.compress'='SNAPPY');

set hive.exec.dynamic.partition.mode=nonstrict;

-- todo 1 根据 年维度 统计 总访问量
insert into itcast_dws.visit_dws partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    count(distinct sid) as sid_total,
    count(distinct session_id) as sessionid_total,
    count(distinct ip) as ip_total,
    '-1' as area,
    '-1' as seo_source,
    '-1' as origin_channel,
    '-1' as hourinfo,
    yearinfo as time_str,
    '-1' as from_url,
    '5' as grouptype,
    '5' as time_type,
    yearinfo,
    '-1' as quarterinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo
;

-- todo 2 根据 季度维度 统计 总访问量
insert into itcast_dws.visit_dws partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    count(distinct sid) as sid_total,
    count(distinct session_id) as sessionid_total,
    count(distinct ip) as ip_total,
    '-1' as area,
    '-1' as seo_source,
    '-1' as origin_channel,
    '-1' as hourinfo,
    concat(yearinfo, '-', quarterinfo) as time_str,
    '-1' as from_url,
    '5' as grouptype,
    '4' as time_type,
    yearinfo,
    quarterinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo
;

-- todo 1 根据 月维度 统计 总访问量
insert into itcast_dws.visit_dws partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    count(distinct sid) as sid_total,
    count(distinct session_id) as sessionid_total,
    count(distinct ip) as ip_total,
    '-1' as area,
    '-1' as seo_source,
    '-1' as origin_channel,
    '-1' as hourinfo,
    concat(yearinfo, '-', monthinfo) as time_str,
    '-1' as from_url,
    '5' as grouptype,
    '3' as time_type,
    yearinfo,
    quarterinfo,
    monthinfo,
    '-1' as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo
;

-- todo 1 根据 日维度 统计 总访问量
insert into itcast_dws.visit_dws partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    count(distinct sid) as sid_total,
    count(distinct session_id) as sessionid_total,
    count(distinct ip) as ip_total,
    '-1' as area,
    '-1' as seo_source,
    '-1' as origin_channel,
    '-1' as hourinfo,
    concat(yearinfo, '-', monthinfo, '-', dayinfo) as time_str,
    '-1' as from_url,
    '5' as grouptype,
    '2' as time_type,
    yearinfo,
    quarterinfo,
    monthinfo,
    dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo, dayinfo
;


-- todo 1 根据 小时维度 统计 总访问量
insert into itcast_dws.visit_dws partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    count(distinct sid) as sid_total,
    count(distinct session_id) as sessionid_total,
    count(distinct ip) as ip_total,
    '-1' as area,
    '-1' as seo_source,
    '-1' as origin_channel,
    hourinfo,
    concat(yearinfo, '-', monthinfo, '-', dayinfo, ' ', hourinfo) as time_str,
    '-1' as from_url,
    '5' as grouptype,
    '1' as time_type,
    yearinfo,
    quarterinfo,
    monthinfo,
    dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo, dayinfo, hourinfo
;

-- todo 2 根据 区域 和 年维度 统计 总访问量
insert into itcast_dws.visit_dws partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    count(distinct sid) as sid_total,
    count(distinct session_id) as sessionid_total,
    count(distinct ip) as ip_total,
    area,
    '-1' as seo_source,
    '-1' as origin_channel,
    '-1' as hourinfo,
    yearinfo as time_str,
    '-1' as from_url,
    '1' as grouptype,
    '5' as time_type,
    yearinfo,
    '-1' as quarterinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, area
;

-- todo 2 根据 区域 和 季度维度 统计 总访问量
insert into itcast_dws.visit_dws partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    count(distinct sid) as sid_total,
    count(distinct session_id) as sessionid_total,
    count(distinct ip) as ip_total,
    area,
    '-1' as seo_source,
    '-1' as origin_channel,
    '-1' as hourinfo,
    concat(yearinfo, '-', quarterinfo) as time_str,
    '-1' as from_url,
    '1' as grouptype,
    '4' as time_type,
    yearinfo,
    quarterinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, area
;

-- todo 2 根据 区域 和 月维度 统计 总访问量
insert into itcast_dws.visit_dws partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    count(distinct sid) as sid_total,
    count(distinct session_id) as sessionid_total,
    count(distinct ip) as ip_total,
    area,
    '-1' as seo_source,
    '-1' as origin_channel,
    '-1' as hourinfo,
    concat(yearinfo, '-', monthinfo) as time_str,
    '-1' as from_url,
    '1' as grouptype,
    '3' as time_type,
    yearinfo,
    quarterinfo,
    monthinfo,
    '-1' as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo, area
;

-- todo 2 根据 区域 和 日维度 统计 总访问量
insert into itcast_dws.visit_dws partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    count(distinct sid) as sid_total,
    count(distinct session_id) as sessionid_total,
    count(distinct ip) as ip_total,
    area,
    '-1' as seo_source,
    '-1' as origin_channel,
    '-1' as hourinfo,
    concat(yearinfo, '-', monthinfo, '-', dayinfo) as time_str,
    '-1' as from_url,
    '1' as grouptype,
    '2' as time_type,
    yearinfo,
    quarterinfo,
    monthinfo,
    dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo, dayinfo, area
;


-- todo 2 根据 区域 和 小时维度 统计 总访问量
insert into itcast_dws.visit_dws partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    count(distinct sid) as sid_total,
    count(distinct session_id) as sessionid_total,
    count(distinct ip) as ip_total,
    area,
    '-1' as seo_source,
    '-1' as origin_channel,
    hourinfo,
    concat(yearinfo, '-', monthinfo, '-', dayinfo, ' ', hourinfo) as time_str,
    '-1' as from_url,
    '1' as grouptype,
    '1' as time_type,
    yearinfo,
    quarterinfo,
    monthinfo,
    dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo, dayinfo, hourinfo, area
;

-- todo 3 按时间 和 搜索来源 统计
-- todo 4 按时间 和 来源渠道 统计
-- todo 5 按时间 和 受访页面 统计


