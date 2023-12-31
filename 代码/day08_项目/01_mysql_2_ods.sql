CREATE DATABASE IF NOT EXISTS itcast_ods;

-- 再linux系统中运行 作用: 建表
sqoop create-hive-table \
--connect jdbc:mysql://localhost:3306/nev \
--table web_chat_ems_2019_07 \
--username root \
--password 123456 \
--hive-table itcast_ods.web_chat_ems

sqoop create-hive-table \
--connect jdbc:mysql://localhost:3306/nev \
--table web_chat_text_ems_2019_07 \
--username root \
--password 123456 \
--hive-table itcast_ods.web_chat_text_ems