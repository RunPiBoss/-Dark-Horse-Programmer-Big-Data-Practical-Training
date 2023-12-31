-- 小鹏充电
drop database if exists db_1;
create database if not exists db_1;
use db_1;


CREATE TABLE charging_data (
    id VARCHAR(50),
    charge_time DATETIME,
    charge_type VARCHAR(10)
);

INSERT INTO charging_data (id, charge_time, charge_type)
VALUES
    ('XP1001', '2023-11-20 08:45:00', '快充'),
    ('XP1001', '2023-11-21 20:45:00', '快充'),
    ('XP1001', '2023-11-22 08:45:00', '快充'),
    ('XP1001', '2023-11-23 08:45:00', '慢充'),
    ('XP1001', '2023-11-25 08:45:00', '快充'),
    ('XP1002', '2023-11-25 08:45:00', '快充'),
    ('XP1002', '2023-11-25 12:45:00', '快充'),
    ('XP1002', '2023-11-25 23:45:00', '慢充'),
    ('XP1003', '2023-11-25 23:45:00', '慢充'),
    ('XP1003', '2023-11-26 23:45:00', '慢充')
;

# todo 需求: 小鹏汽车充电每辆车连续快充最大次数

select * from charging_data;

select
    id,
    charge_time,
    charge_time,
    row_number() over (partition by id order by charge_time) as rn1
from charging_data;




