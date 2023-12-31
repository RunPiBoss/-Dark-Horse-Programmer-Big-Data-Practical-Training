CREATE DATABASE IF NOT EXISTS itcast_dwd;

create table if not exists itcast_dwd.visit_consult_dwd(
  session_id STRING comment '七陌sessionId',
  sid STRING comment '访客id',
  create_time bigint comment '会话创建时间',
  seo_source STRING comment '搜索来源',
  ip STRING comment 'IP地址',
  area STRING comment '地域',
  msg_count int comment '客户发送消息数',
  origin_channel STRING COMMENT '来源渠道',
  referrer STRING comment '上级来源页面',
  from_url STRING comment '会话来源页面',
  landing_page_url STRING comment '访客着陆页面',
  url_title STRING comment '咨询页面title',
  platform_description STRING comment '客户平台信息',
  other_params STRING comment '扩展字段中数据',
  history STRING comment '历史访问记录',
  hourinfo string comment '小时'
)
comment '访问咨询DWD表'
partitioned by(yearinfo String,quarterinfo string, monthinfo String, dayinfo string)
row format delimited fields terminated by '\t'
stored as orc
tblproperties ('orc.compress'='SNAPPY');

set hive.exec.dynamic.partition.mode=nonstrict;

insert into itcast_dwd.visit_consult_dwd
partition(yearinfo, quarterinfo, monthinfo, dayinfo)
select
    session_id,
    sid,
    unix_timestamp(a.create_time) as create_time,
    seo_source,
    ip,
    area,
    coalesce(msg_count, 0) as msg_count,
    origin_channel,
    referrer,
    from_url,
    landing_page_url,
    url_title,
    platform_description,
    other_params,
    history,
    substr(create_time, 12, 2) as hourinfo,
    substr(create_time, 1, 4) as yearinfo,
    quarter(create_time) as quarterinfo,
    substr(create_time, 6, 2) as monthinfo,
    substr(create_time, 9, 2) as dayinfo
from itcast_ods.web_chat_ems a join itcast_ods.web_chat_text_ems
;