-- 创建库
create database scrm_bi default character set utf8mb4 collate utf8mb4_general_ci;
-- 切换库
use scrm_bi;
-- 创建表
CREATE TABLE `itcast_visit` (
  sid_total int(11) COMMENT '根据sid去重求count',
  sessionid_total int(11) COMMENT '根据sessionid去重求count',
  ip_total int(11) COMMENT '根据IP去重求count',
  area varchar(32) COMMENT '区域信息',
  seo_source varchar(32) COMMENT '搜索来源',
  origin_channel varchar(32) COMMENT '来源渠道',
  hourinfo varchar(32) COMMENT '小时信息',
  time_str varchar(32) COMMENT '时间明细',
  from_url varchar(32) comment '会话来源页面',
  groupType varchar(32) COMMENT '产品属性类型：1.地区；2.搜索来源；3.来源渠道；4.会话来源页面；5.总访问量',
  time_type varchar(32) COMMENT '时间聚合类型：1、按小时聚合；2、按天聚合；3、按月聚合；4、按季度聚合；5、按年聚合；',
  yearinfo varchar(32) COMMENT '年信息',
  quarterinfo varchar(32) COMMENT '季度',
  monthinfo varchar(32) COMMENT '月信息',
  dayinfo varchar(32) COMMENT '日信息'
);

insert overwrite directory '/export/visit_data'
row format delimited
fields terminated by ','
select * from itcast_dws.visit_dws;


sqoop export \
--connect 'jdbc:mysql://localhost:3306/scrm_bi?useUnicode=true&characterEncoding=utf-8' \
--username root \
--password 123456 \
--table itcast_visit \
--export-dir /export/visit_data \
--m 1